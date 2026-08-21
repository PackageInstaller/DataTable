local var_0_0 = class("BannerScrollRect4IslandDrawAward", import("view.newMain.page.BannerScrollRect"))

function var_0_0.UpdateDotPosition(arg_1_0, arg_1_1, arg_1_2)
	return
end

function var_0_0.TriggerDot(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1:GetComponent(typeof(LayoutElement)).preferredWidth = arg_2_2 and 26 or 8

	setActive(arg_2_1:Find("dot"), not arg_2_2)
	setActive(arg_2_1:Find("line"), arg_2_2)

	if arg_2_2 then
		existCall(arg_2_0.triggerDotCall, arg_2_0.index)
	end

	return
end

function var_0_0.SetUp(arg_3_0, arg_3_1)
	var_0_0.super.SetUp(arg_3_0)

	if arg_3_1 and arg_3_1 > 0 then
		arg_3_0:Pause()

		arg_3_0.uniqueLT = LeanTween.delayedCall(arg_3_1, System.Action(function()
			arg_3_0:Resume()

			return
		end))
	end

	return
end

function var_0_0.SetTriggerDotCall(arg_5_0, arg_5_1)
	arg_5_0.triggerDotCall = arg_5_1

	return
end

function var_0_0.Reset(arg_6_0)
	var_0_0.super.Reset(arg_6_0)

	arg_6_0.triggerDotCall = nil

	return
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	return
end

return var_0_0
