class = var_0_10000

local var_0_0 = "GhostSkinStoryActPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PreviewTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	arg_1_0.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.btnList

	var_1(var_1_0, var_4.Find(var_1_1, "activity"), function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_2_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_2_1(var_2_0, var_2_2, var_2_10004.GHOSTSKINPAGE)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1

	var_3_1, setActive = var_1.Find(var_3_0, "AD/redDot"), var_1_10002
	GhostSkinPageLayer = var_1_10005

	var_1_10002(var_3_1, var_1_10005.IsShowRed())

	return
end

return var_0_1
