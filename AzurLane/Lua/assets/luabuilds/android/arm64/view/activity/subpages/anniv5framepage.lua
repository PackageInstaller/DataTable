local var_0_0 = class("AnniV5FramePage", import(".TemplatePage.NewFrameTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.bar = arg_1_0._tf:Find("AD/switcher/phase2/barContent")
	arg_1_0.cur = arg_1_0._tf:Find("AD/switcher/phase2/progress/step")
	arg_1_0.target = arg_1_0._tf:Find("AD/switcher/phase2/progress/all")
	arg_1_0.getTag = arg_1_0._tf:Find("AD/switcher/phase2/get")
	arg_1_0.gotTag = arg_1_0._tf:Find("AD/switcher/phase2/got")
	arg_1_0.titles = {
		arg_1_0.switchBtn:Find("2"),
		arg_1_0.switchBtn:Find("1")
	}

	return
end

function var_0_0.OnUpdateFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity.data1
	local var_2_1 = arg_2_0.avatarConfig.target
	local var_2_2, var_2_3

	if arg_2_0.avatarConfig.target < arg_2_0.activity.data1 and not var_2_1 then
		var_2_2 = setText
		var_2_3 = arg_2_0.cur
	end

	local var_2_4 = var_2_0 / var_2_1 >= 1 and setColorStr(var_2_0, COLOR_GREEN) or var_2_0

	var_2_2(var_2_3, var_2_4)
	setText(arg_2_0.target, "/" .. var_2_1)
	setSlider(arg_2_0.bar, 0, var_2_1, var_2_0)

	local var_2_5 = var_2_1 <= var_2_0
	local var_2_6 = arg_2_0.activity.data2 >= 1
	local var_2_8 = arg_2_0.inPhase2 and not var_2_5

	var_2_7(arg_2_0.battleBtn, var_2_8)

	local var_2_9 = arg_2_0.inPhase2 and not var_2_6 and var_2_5

	setActive(arg_2_0.getBtn, var_2_9)

	local var_2_10 = arg_2_0.inPhase2 and var_2_6

	setActive(arg_2_0.gotBtn, var_2_10)

	local var_2_11 = arg_2_0.inPhase2 and not var_2_6 and var_2_5

	setActive(arg_2_0.getTag, var_2_11)

	local var_2_12 = arg_2_0.inPhase2 and var_2_6

	setActive(arg_2_0.gotTag, var_2_12)
	setActive(arg_2_0._tf:Find("AD/switcher/phase2/progress"), not var_2_6)

	return
end

function var_0_0.Switch(arg_3_0, arg_3_1)
	arg_3_0.isSwitching = true

	setToggleEnabled(arg_3_0.switchBtn, false)

	for iter_3_0, iter_3_1 in ipairs({
		arg_3_0.phases,
		arg_3_0.titles
	}) do
		local var_3_0, var_3_1 = unpack(iter_3_1)

		if arg_3_1 then
			var_3_1 = var_3_0
			var_3_0 = var_3_1
		end

		LeanTween.cancel(go(var_3_0))

		local var_3_2 = GetOrAddComponent(var_3_0, "CanvasGroup")

		var_3_2.alpha = 0

		table.insert({}, function(arg_4_0)
			LeanTween.alphaCanvas(var_3_2, 1, 0.4):setOnComplete(System.Action(arg_4_0))

			return
		end)
		LeanTween.cancel(go(var_3_1))

		local var_3_3 = GetOrAddComponent(var_3_1, "CanvasGroup")

		var_3_3.alpha = 1

		table.insert({}, function(arg_5_0)
			LeanTween.alphaCanvas(var_3_3, 0, 0.4):setOnComplete(System.Action(arg_5_0))

			return
		end)
	end

	parallelAsync({}, function()
		arg_3_0.isSwitching = nil

		setToggleEnabled(arg_3_0.switchBtn, true)

		return
	end)

	return
end

return var_0_0
