local var_0_0 = class("DexiV4FramePage", import(".TemplatePage.FrameTemplatePage"))

function var_0_0.Switch(arg_1_0, arg_1_1)
	arg_1_0.isSwitching = true

	local var_1_0 = GetOrAddComponent(arg_1_0.phases[1], typeof(CanvasGroup))

	arg_1_0.phases[2]:SetAsLastSibling()
	setActive(arg_1_0.phases[1]:Find("Image"), false)
	setLocalPosition(go(arg_1_0.phases[1]), arg_1_0.phases[2].localPosition)
	setActive(arg_1_0.phases[1]:Find("label"), true)
	LeanTween.value(go(arg_1_0.phases[1]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_2_0)
		var_1_0.alpha = arg_2_0

		return
	end))
	setActive(arg_1_0.phases[2]:Find("Image"), true)

	local var_1_1 = GetOrAddComponent(arg_1_0.phases[2], typeof(CanvasGroup))

	LeanTween.value(go(arg_1_0.phases[2]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_3_0)
		var_1_1.alpha = arg_3_0

		return
	end))
	setActive(arg_1_0.phases[2]:Find("label"), false)
	setLocalPosition(go(arg_1_0.phases[2]), arg_1_0.phases[1].localPosition)

	arg_1_0.isSwitching = nil
	arg_1_0.phases[1], arg_1_0.phases[2] = arg_1_0.phases[2], arg_1_0.phases[1]

	arg_1_0:UpdateAwardGot()

	return
end

return var_0_0
