local var_0_0 = class("MeixiT2FramePage", import(".TemplatePage.NewFrameTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(arg_1_0.phases) do
		setActive(iter_1_1, true)

		GetOrAddComponent(iter_1_1, typeof(CanvasGroup)).alpha = 0
	end

	var_0_0.super.OnFirstFlush(arg_1_0)

	return
end

function var_0_0.Switch(arg_2_0, arg_2_1)
	arg_2_0.isSwitching = true

	setToggleEnabled(arg_2_0.switchBtn, false)

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

	local var_2_2 = var_2_0.localPosition
	local var_2_3 = var_2_1.localPosition

	var_2_1:SetAsLastSibling()
	table.insert({}, function(arg_3_0)
		LeanTween.moveLocal(go(var_2_0), var_2_3, 0.4)
		LeanTween.alphaCanvas(GetOrAddComponent(var_2_0, typeof(CanvasGroup)), 0, 0.4)
		LeanTween.moveLocal(go(var_2_1), var_2_2, 0.4)
		LeanTween.alphaCanvas(GetOrAddComponent(var_2_1, typeof(CanvasGroup)), 1, 0.4):setOnComplete(System.Action(arg_3_0))

		return
	end)
	seriesAsync({}, function()
		arg_2_0.isSwitching = nil

		setToggleEnabled(arg_2_0.switchBtn, true)

		return
	end)

	return
end

return var_0_0
