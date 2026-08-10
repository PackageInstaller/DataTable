local var_0_0 = require("cjson")
local var_0_1 = {}
local var_0_2 = {
	kr = "SendMessageKR",
	zh_cn = "SendMessageCN",
	jp = "SendMessageJPUS",
	tw = "SendMessageTC",
	en = "SendMessageJPUS"
}

var_0_1.typeToFunction = {}

function SendMessageManagerToSDK(arg_1_0, arg_1_1)
	local var_1_0 = require("game/tools/SendMessage/" .. var_0_2[GameToSDK.CURRENT_SERVER])

	if var_1_0 == nil then
		var_1_0 = var_0_1
	end

	if var_0_1.typeToFunction[arg_1_0] then
		var_0_1.typeToFunction[arg_1_0](arg_1_1)
	elseif var_1_0.typeToFunction[arg_1_0] then
		var_1_0.typeToFunction[arg_1_0](arg_1_1)
	end
end

function var_0_1.SendMessageToSDK(arg_2_0, arg_2_1)
	SDKAction.SendMessageToSDK(arg_2_0, arg_2_1)
end

return var_0_1
