local md5 = require("cocos.framework.extends.md5")
local TranslateProxy = class("TranslateProxy")
local TranslateConst = require("app.core.translate.TranslateConst")

function TranslateProxy:ctor()
	return
end

function TranslateProxy:getNetTranslate(arg_2_1, arg_2_2, arg_2_3)
	g.core.network.GameHttpProxy:sendHttpRequest(self:splicingTranslateUrl(arg_2_1), "GET", {
		success = function(arg_3_0)
			if arg_2_2 then
				arg_2_2(json.decode(arg_3_0))
			end
		end,
		fail = function(arg_4_0)
			g.core.module.ModuleManager:tip(g.core.lang:get(2501))

			if arg_2_3 then
				arg_2_3(json.decode(arg_4_0))
			end
		end,
		cancel = function(arg_5_0)
			if arg_2_3 then
				arg_2_3(json.decode(arg_5_0))
			end
		end
	}, self)
end

function TranslateProxy:splicingTranslateUrl(arg_6_1)
	return "https://translator-api.gtarcade.com/translator" .. "?" .. self:encryptionParams(arg_6_1)
end

function TranslateProxy:encryptionParams(arg_7_1)
	local var_7_0 = g.core.platform.PlatformProxy:getLanguage() or "en"
	local var_7_1 = {
		client_id = config.TRANS_APP_ID,
		to = TranslateConst.getRealLangName(var_7_0),
		text = arg_7_1,
		time = os.time()
	}
	local var_7_2 = {}

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		var_7_2[#var_7_2 + 1] = iter_7_0
	end

	table.sort(var_7_2)

	local var_7_3 = ""

	for iter_7_2 = 1, #var_7_2 do
		var_7_3 = iter_7_2 < #var_7_2 and var_7_3 .. var_7_2[iter_7_2] .. "=" .. string.urlencode(var_7_1[var_7_2[iter_7_2]]) .. "&" or var_7_3 .. var_7_2[iter_7_2] .. "=" .. string.urlencode(var_7_1[var_7_2[iter_7_2]])
	end

	local var_7_4 = md5.new()

	var_7_4:update(var_7_3 .. config.TRANS_APP_KEY)

	return var_7_3 .. "&" .. "verify=" .. md5.tohex(var_7_4:finish())
end

return TranslateProxy
