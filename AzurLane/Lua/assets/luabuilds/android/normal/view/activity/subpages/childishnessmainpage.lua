class = var_0_10000

local var_0_0 = "ChildishnessMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PreviewTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	arg_1_0.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.btnList

	var_1(var_1_0, var_3.Find(var_1_1, "fight"), function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_2_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_2_1(var_2_0, var_2_2, var_2_10003.KINDERGARTEN)

		return
	end)

	onButton = var_1

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.btnList

	var_1(var_1_2, var_3.Find(var_1_3, "shop"), function()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_3_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_3_1(var_3_0, var_3_2, var_2_10003.SKINSHOP)

		return
	end)

	return
end

return var_0_1
