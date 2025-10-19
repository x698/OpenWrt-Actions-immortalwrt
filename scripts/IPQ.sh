# 添加其他仓库的插件 然后去config里添加上对应的插件名

# 修改默认IP
sed -i 's/192.168.1.1/192.168.12.1/g' package/base-files/files/bin/config_generate

# 修改默认主题
rm -rf feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
cp -f $GITHUB_WORKSPACE/scripts/bg1.jpg feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
sed -i "s/luci-theme-bootstrap/luci-theme-argon/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")

# 修改luci首页显示
sed -i 's/ImmortalWrt/OpenWrt/gi' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/gi' include/version.mk
sed -i '/Target Platform/d' feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
rm -rf feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/25_storage.js
rm -rf feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/29_ports.js
rm -rf feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/50_dsl.js
rm -rf feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/60_wifi.js
rm -rf feeds/luci/applications/luci-app-ddns/htdocs/luci-static/resources/view/status/include/70_ddns.js
rm -rf feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/index.js
cp -f $GITHUB_WORKSPACE/scripts/index.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/index.js
sed -i "38,47d" $(find ./feeds/ -type f -name "20_memory.js")
sed -i 's/ECM://g' target/linux/qualcommax/base-files/sbin/cpuusage
sed -i 's/HWE/NPU/g' target/linux/qualcommax/base-files/sbin/cpuusage

# 关闭RFC1918
sed -i 's/option rebind_protection 1/option rebind_protection 0/g' package/network/services/dnsmasq/files/dhcp.conf

# 修改插件位置
sed -i 's/vpn/services/g' feeds/luci/applications/luci-app-zerotier/root/usr/share/luci/menu.d/luci-app-zerotier.json

# etc默认设置
cp -a $GITHUB_WORKSPACE/scripts/etc/* package/base-files/files/etc/

./scripts/feeds update -a
./scripts/feeds install -a
