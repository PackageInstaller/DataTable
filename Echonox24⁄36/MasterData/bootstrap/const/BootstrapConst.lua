module("bootstrap.const.BootstrapConst", package.seeall)

kOpenPcHotdate = "open_pc_hotupdate"
kDeviceType = "h_device_type"
kDomainType = "domain_type"
kHotUpdateDownloadFailResetCount = 3
kHotUpdateRequestRemoteResetCount = 3
HOTUPDATE_SERVER_URLS = {
	"http://cc2dhotupdate.tech.test",
	"http://cc2dhotupdate-test.100bt.com",
	"https://cc2dhotupdate.100bt.com"
}
HOTUPDATE_DEVIVE_TYPE = {
	"0",
	"1",
	"300"
}
SDKType = {
	Default = 0,
	Zh = 1,
	Xm = 2
}
NETWORK_TYPE = {
	WIFI = 2,
	MOBILE = 1
}
BOOTSTRAP_LOADING_PATH = "ui/views/bootstrap/bootstrap_view.prefab"
BOOTSTRAP_MSG_BOX_PATH = "ui/views/bootstrap/message_tips.prefab"
