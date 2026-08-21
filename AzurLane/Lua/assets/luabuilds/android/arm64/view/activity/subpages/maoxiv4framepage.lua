local var_0_0 = class("MaoxiV4FramePage", import(".TemplatePage.NewFrameTemplatePage"))

var_0_0.COLOR = "#1895ff"

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.switchBtns = {
		arg_1_0.switchBtn:Find("switch_btn_1"),
		arg_1_0.switchBtn:Find("switch_btn_2")
	}

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	setActive(arg_2_0.switchBtns[1], false)
	setActive(arg_2_0.switchBtns[2], true)

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	local var_3_0 = arg_3_0.activity.data1
	local var_3_1 = arg_3_0.avatarConfig.target

	var_3_0 = arg_3_0.avatarConfig.target < arg_3_0.activity.data1 and var_3_1 or var_3_0

	local var_3_2 = var_3_0 / var_3_1
	local var_3_3 = var_3_0 / var_3_1 >= 1 and setColorStr(var_3_0, var_0_0.COLOR) or var_3_0

	setText(arg_3_0.cur, var_3_3)
	setText(arg_3_0.target, "/" .. var_3_1)
	setFillAmount(arg_3_0.bar, var_3_2)

	local var_3_4 = var_3_1 <= var_3_0
	local var_3_5 = arg_3_0.activity.data2 >= 1
	local var_3_7 = arg_3_0.inPhase2 and not var_3_4

	var_3_6(arg_3_0.battleBtn, var_3_7)

	local var_3_8 = arg_3_0.inPhase2 and not var_3_5 and var_3_4

	setActive(arg_3_0.getBtn, var_3_8)

	local var_3_9 = arg_3_0.inPhase2 and var_3_5

	setActive(arg_3_0.gotBtn, var_3_9)

	local var_3_10 = arg_3_0.inPhase2 and var_3_5

	setActive(arg_3_0.gotTag, var_3_10)
	setActive(arg_3_0.cur, not var_3_5 and arg_3_0.inPhase2)
	setActive(arg_3_0.target, not var_3_5 and arg_3_0.inPhase2)

	return
end

function var_0_0.Switch(arg_4_0, arg_4_1)
	arg_4_0.isSwitching = true

	setToggleEnabled(arg_4_0.switchBtn, false)
	setActive(arg_4_0.switchBtns[1], true)
	setActive(arg_4_0.switchBtns[2], false)

	arg_4_0.switchBtns[1], arg_4_0.switchBtns[2] = arg_4_0.switchBtns[2], arg_4_0.switchBtns[1]

	local var_4_0
	local var_4_1

	if arg_4_1 then
		var_4_1 = arg_4_0.phases[2]
		var_4_0 = arg_4_0.phases[1]

		goto label_4_0

		var_4_1 = arg_4_0.phases[1]
	end

	var_4_0 = arg_4_0.phases[2]

	::label_4_0::

	local var_4_2 = GetOrAddComponent(var_4_0, typeof(CanvasGroup))

	var_4_1:SetAsLastSibling()
	setActive(var_4_0:Find("Image"), false)
	LeanTween.moveLocal(go(var_4_0), var_4_1.localPosition, 0.4):setOnComplete(System.Action(function()
		setActive(var_4_0:Find("label"), true)

		return
	end))
	LeanTween.value(go(var_4_0), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_6_0)
		var_4_2.alpha = arg_6_0

		return
	end))
	setActive(var_4_1:Find("Image"), true)

	local var_4_3 = GetOrAddComponent(var_4_1, typeof(CanvasGroup))

	LeanTween.value(go(var_4_1), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_7_0)
		var_4_3.alpha = arg_7_0

		return
	end))
	setActive(var_4_1:Find("label"), false)
	LeanTween.moveLocal(go(var_4_1), var_4_0.localPosition, 0.4):setOnComplete(System.Action(function()
		arg_4_0.isSwitching = nil

		setToggleEnabled(arg_4_0.switchBtn, true)

		return
	end))

	return
end

return var_0_0
