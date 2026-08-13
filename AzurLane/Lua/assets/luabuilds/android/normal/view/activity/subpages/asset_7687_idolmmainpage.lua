class = var_0_10000

local var_0_0 = "IDOLMMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PreviewTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	local var_1_0 = arg_1_0.btnList

	arg_1_0.mountainBtn = var_1.Find(var_1_0, "mountain")
	onButton = var_1

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.mountainBtn

	local function var_1_3()
		pg = var_2_10000

		local var_2_0 = var_2_10000.m02
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_2_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_2_1(var_2_0, var_2_2, var_2_10003.IMAS_STAGE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_1, var_1_2, var_1_3, var_1_10005)

	return
end

return var_0_1
