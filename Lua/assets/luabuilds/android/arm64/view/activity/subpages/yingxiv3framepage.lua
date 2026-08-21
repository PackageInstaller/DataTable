local var_0_0 = class("YingxiV3FramePage", import(".TemplatePage.NewFrameTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.gotTag = arg_1_0._tf:Find("AD/switcher/phase2/got")

	return
end

function var_0_0.Switch(arg_2_0, arg_2_1)
	arg_2_0.isSwitching = true

	local var_2_0
	local var_2_1

	if arg_2_1 then
		var_2_1 = arg_2_0.phases[2]
		var_2_0 = arg_2_0.phases[1]

		goto label_2_0

		var_2_1 = arg_2_0.phases[1]
	end

	var_2_0 = arg_2_0.phases[2]

	::label_2_0::

	local var_2_2 = GetOrAddComponent(var_2_0, typeof(CanvasGroup))

	var_2_1:SetAsLastSibling()
	setActive(var_2_0:Find("Image"), false)
	setLocalPosition(go(var_2_0), var_2_1.localPosition)
	setActive(var_2_0:Find("label"), true)
	LeanTween.value(go(var_2_0), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_3_0)
		var_2_2.alpha = arg_3_0

		return
	end))
	setActive(var_2_1:Find("Image"), true)

	local var_2_3 = GetOrAddComponent(var_2_1, typeof(CanvasGroup))

	LeanTween.value(go(var_2_1), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_4_0)
		var_2_3.alpha = arg_4_0

		return
	end))
	setActive(var_2_1:Find("label"), false)
	setLocalPosition(go(var_2_1), var_2_0.localPosition)

	arg_2_0.isSwitching = nil

	return
end

return var_0_0
