class = var_0_10000

local var_0_0 = "GhostSkinStoryActPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PreviewTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	arg_1_0.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.btnList

	var_1(var_1_0, var_3.Find(var_1_1, "activity"), function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_2_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_2_1(var_2_0, var_2_2, var_2_10003.GHOSTSKINPAGE)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1

	var_3_1, setActive = var_1.Find(var_3_0, "AD/redDot"), var_3_0
	GhostSkinPageLayer = var_1_10004

	var_3_0(var_3_1, var_1_10004.IsShowRed())

	return
end

return var_0_1
