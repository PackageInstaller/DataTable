local var_0_0 = {}
local var_0_1 = {}

var_0_1["zh%-Hans"] = "zh-CHS"
var_0_1["zh%-Hant"] = "zh-CHT"
var_0_1["zh%-TW"] = "zh-CHT"
var_0_1["zh%-HK"] = "zh-CHT"
var_0_1.ja = "ja"
var_0_1.en = "en"
var_0_1.id = "id"
var_0_1.th = "th"
var_0_1.ko = "ko"
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
		return "zh-CHS"
	end

	return "en"
end

return var_0_0
