class = var_0_10000

local var_0_0 = "BannerScrollRect4IslandDrawAward"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.newMain.page.BannerScrollRect"))

function var_0_1.UpdateDotPosition(arg_1_0, arg_1_1, arg_1_2)
	return
end

function var_0_1.TriggerDot(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2 and 26 or 8
	local var_2_1 = arg_2_1
	local var_2_2 = arg_2_1.GetComponent

	typeof = var_1_10006
	LayoutElement = var_1_10007

	local var_2_3 = var_2_2(var_2_1, var_1_10006(var_1_10007))

	var_2_3.preferredWidth = var_2_0
	setActive = var_2_3

	var_2_3(arg_2_1:Find("dot"), not arg_2_2)

	setActive = var_2_3

	var_2_3(arg_2_1:Find("line"), arg_2_2)

	if arg_2_2 then
		existCall = var_2_3

		var_2_3(arg_2_0.triggerDotCall, arg_2_0.index)
	end

	return
end

function var_0_1.SetUp(arg_3_0, arg_3_1)
	var_0_1.super.SetUp(arg_3_0)

	if arg_3_1 and arg_3_1 > 0 then
		arg_3_0:Pause()

		LeanTween = var_2

		local var_3_0 = var_2.delayedCall
		local var_3_1 = arg_3_1

		System = var_1_10004
		arg_3_0.uniqueLT = var_3_0(var_3_1, var_1_10004.Action(function()
			local var_4_0 = arg_3_0

			var_0.Resume(var_4_0)

			return
		end))
	end

	return
end

function var_0_1.SetTriggerDotCall(arg_5_0, arg_5_1)
	arg_5_0.triggerDotCall = arg_5_1

	return
end

function var_0_1.Reset(arg_6_0)
	var_0_1.super.Reset(arg_6_0)

	arg_6_0.triggerDotCall = nil

	return
end

function var_0_1.Dispose(arg_7_0)
	var_0_1.super.Dispose(arg_7_0)

	return
end

return var_0_1
