module("bootstrap.const.GameRequestUrl", package.seeall)

HOTUPDATE_ZH_TEST_INTRANET = "http://cc2dhotupdate.tech.test"
HOTUPDATE_ZH_TEST_INTERNET = "https://cc2dhotupdate-test.100bt.com"
HOTUPDATE_ZH_FORMAL_INTERNET = "https://cc2dhotupdate.100bt.com"
HOTUPDATE_ZH_BACKUP = "https://cc2dhotupdate-src.100bt.com"
HOTUPDATE_XM_TEST_INTERNET = "https://cc2dhotupdate-sg-test.madfungame.com"
HOTUPDATE_XM_FORMAL_INTERNET = "https://cc2dhotupdate-sg.madfungame.com"
LOGIN_INTRANET_DEV = "http://10.17.2.93:8080/session/login"
LOGIN_INTRANET_MONTH = "http://10.17.2.93:8880/session/login"
LOGIN_INTRANET_WEEK = "http://10.17.2.142:9080/login/session/login "
LOGIN_INTRANET_XM = "http://10.17.2.142:8080/session/login"
LOGIN_INTRANET_REVIEW = "http://10.17.1.159:8888/session/login"
LOGIN_INTRANET_FORMAL = "http://10.17.2.142:7080/login/session/login"
LOGIN_INTERNET_DEV = "http://120.92.146.28:9005/session/login"
LOGIN_INTERNET_MONTH = "http://120.92.146.28:9081/session/login"
LOGIN_XM_FORMAL_INTERNET = "https://spacex-sg-login.madfungame.com/session/login"
LOGIN_ZH_FORMAL_INTERNET = "https://spacex-cn-login.100bt.com/session/login"
LOGIN_ZH_FORMAL_PRE_INTERNET = "https://spacex-cn-pre-login.100bt.com/session/login"
LOGIN_ZH_REVIEW = "https://spacex-gf-audit-login.100bt.com/session/login"
LOGIN_ZH_IOS_REVIEW = "https://spacex-gf-hk-audit-login.100bt.com/session/login"
LOGIN_XM_BACKUP_INTERNET = "https://spacex-sg-login-bak.madfungame.com/session/login"
LOGIN_ZH_BACKUP_INTERNET = "https://spacex-cn-login-bak.100bt.com/session/login"
LOGIN_ZH_PRE_BACKUP_INTERNET = "https://spacex-cn-pre-login-bak.100bt.com/session/login"
NOTICE_ZH_FORMAL = "https://noticemgr.100bt.com/"
NOTICE_ZH_TEST = "https://noticemgr-zctest.100bt.com/"
NOTICE_XM_FORMAL = "https://noticemgr.madfungame.com/"
NOTICE_ZH_TEST = "https://noticemgr-test.madfungame.com/"
FEEDBACK_ZH_FORMAL = "https://csbgm-fd.100bt.com/"
FEEDBACK_ZH_TEST = "https://csbgm.fdtest.100bt.com/"
FEEDBACK_XM_FORMAL = "https://csbgm-fd.100bt.com/"
FEEDBACK_XM_TEST = "https://csbgm.fdtest.100bt.com/"
FILE_SERVER_URL = "https://spacex-dev-file.100bt.com"
FILE_SERVER_URL_CN = "https://spacex-cn-file.100bt.com"
URL_USER_PROTOCAL = "https://static.100bt.com/yducaccount/wap/html/protocol_game.html?padding=0?t=%s"
URL_USER_PRIVATE = "https://static.100bt.com/yducaccount/wap/html/privacy_game.html?padding=20?t=%s"
URL_USER_PROTOCAL_JP = "https://sdk-file-download.efunjp.com/policy/common/ja_JP/useterms.html?padding=0"
URL_USER_PRIVATE_JP = "https://sdk-file-download.efunjp.com/policy/common/ja_JP/privacypolicy.html?padding=20"
URL_USER_SURVEY = {
	[BootstrapConst.SDKType.Zh] = {
		INTERNAL = "http://survey-user-test.100bt.com/survey/list",
		EXTERNAL = "https://survey.172tt.com/survey/list"
	},
	[BootstrapConst.SDKType.Xm] = {
		INTERNAL = "https://survey-test.madfungame.com/survey/list",
		EXTERNAL = "https://survey.madfungame.com/survey/list"
	}
}
