local var_0_0 = class("SculptureTipPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "SculptureTipUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.tip = arg_2_0._tf:Find("tip")

	return
end

function var_0_0.OnInit(arg_3_0)
	return
end

function var_0_0.Show(arg_4_0)
	var_0_0.super.Show(arg_4_0)
	setActive(arg_4_0.tip, true)
	onDelayTick(function()
		arg_4_0:Hide()

		return
	end, 2)

	return
end

function var_0_0.Hide(arg_6_0)
	var_0_0.super.Hide(arg_6_0)
	setActive(arg_6_0.tip, false)

	return
end

function var_0_0.OnDestroy(arg_7_0)
	return
end

return var_0_0
