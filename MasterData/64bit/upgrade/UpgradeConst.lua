local var_0_0 = {
	MICRO_SYNCED_VER = "micro_synced_ver",
	USE_TEST_UPGRADE_URL = "use_test_upgrade_url",
	TEST_UPGRADE_URL = "test_upgrade_url",
	LOCAL_VERSION = "local_version",
	EN_FSM_ST = {
		LANG_INFO = 4,
		UNZIP = 3,
		DOWNLOAD = 2,
		UPGRADE_INFO = 1,
		MICRO_CHECK = 11,
		VERSION_INFO = 0,
		INVALID = -1,
		WHOLE_PKG = 7,
		FINISHED = 6,
		AUTO_LANG = 21,
		LANG_DOWN = 5
	},
	EN_UI_MSG = {
		UNZIP = 3,
		AUTOLANG = 10,
		ERROR = 9,
		WHOLE = 8,
		REBOOT = 6,
		LANGPROG = 5,
		LANGVER = 4,
		PROGRESS = 2,
		START = 1,
		VERSION = 0,
		FINISHED = 7
	},
	EN_UI_SILENT = {
		UNZIP_START = 3,
		START = 1,
		PROGRESS = 2,
		ERROR = 6,
		FINISHED = 5,
		FETCH_URL = 7,
		UNZIP_OK = 4
	}
}
local var_0_1 = {}

var_0_1["zh%-Hans"] = "cn"
var_0_1["zh%-Hant"] = "tw"
var_0_1["zh%-TW"] = "tw"
var_0_1["zh%-HK"] = "tw"
var_0_1.ja = "jp"
var_0_1.en = "en"
var_0_1.id = "id"
var_0_1.th = "th"
var_0_1.kr = "kr"
var_0_1.ko = "kr"
var_0_1.fr = "fr"
var_0_1.es = "es"
var_0_1.de = "de"
var_0_1.pt = "pt"
var_0_1.ru = "ru"
var_0_1["in"] = "id"

function var_0_0.getRealLangName(arg_1_0)
	for iter_1_0, iter_1_1 in pairs(var_0_1) do
		if string.find(arg_1_0, iter_1_0) == 1 then
			return iter_1_1
		end
	end

	if string.find(arg_1_0, "zh") == 1 then
		return "cn"
	end

	return nil
end

return var_0_0
