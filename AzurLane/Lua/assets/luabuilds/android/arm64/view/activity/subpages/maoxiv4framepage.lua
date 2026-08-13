class = var_0_10000

local var_0_0 = "MaoxiV4FramePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.NewFrameTemplatePage"))

var_0_1.COLOR = "#1895ff"

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = {}
	local var_1_1 = arg_1_0.switchBtn

	var_1_0[1] = var_2.Find(var_1_1, "switch_btn_1")

	local var_1_2 = arg_1_0.switchBtn

	var_1_0[2] = var_2.Find(var_1_2, "switch_btn_2")
	arg_1_0.switchBtns = var_1_0

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	setActive = var_1

	var_1(arg_2_0.switchBtns[1], false)

	setActive = var_1

	var_1(arg_2_0.switchBtns[2], true)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	local var_3_0 = arg_3_0.activity.data1

	var_3_0 = arg_3_0.avatarConfig.target < var_3_0 and var_2 or var_3_0

	local var_3_1 = var_3_0 / var_2

	setText = var_1_10004

	local var_3_2 = arg_3_0.cur

	if 1 <= var_3_1 then
		setColorStr = var_7

		local var_3_3

		if not var_7(var_3_0, var_0_1.COLOR) then
			var_3_3 = var_3_0
		end

		var_1_10004(var_3_2, var_3_3)

		setText = var_1_10004

		var_1_10004(arg_3_0.target, "/" .. var_2)

		setFillAmount = var_1_10004

		var_1_10004(arg_3_0.bar, var_3_1)

		local var_3_4 = var_2 <= var_3_0
		local var_3_5 = arg_3_0.activity.data2
		local var_3_6 = 1 <= var_3_5

		setActive = var_6

		local var_3_7 = arg_3_0.battleBtn
		local var_3_8

		if arg_3_0.inPhase2 then
			var_3_8 = not var_3_4
		end

		var_6(var_3_7, var_3_8)

		setActive = var_6

		local var_3_9 = arg_3_0.getBtn
		local var_3_10

		if arg_3_0.inPhase2 then
			var_3_10 = not var_3_6 and var_3_4
		end

		var_6(var_3_9, var_3_10)

		setActive = var_6

		local var_3_11 = arg_3_0.gotBtn
		local var_3_12

		if arg_3_0.inPhase2 then
			var_3_12 = var_3_6
		end

		var_6(var_3_11, var_3_12)

		setActive = var_6

		local var_3_13 = arg_3_0.gotTag
		local var_3_14

		if arg_3_0.inPhase2 then
			var_3_14 = var_3_6
		end

		var_6(var_3_13, var_3_14)

		setActive = var_6

		var_6(arg_3_0.cur, not var_3_6 and arg_3_0.inPhase2)

		setActive = var_6

		var_6(arg_3_0.target, not var_3_6 and arg_3_0.inPhase2)

		return
	end
end

function var_0_1.Switch(arg_4_0, arg_4_1)
	arg_4_0.isSwitching = true
	setToggleEnabled = var_2

	var_2(arg_4_0.switchBtn, false)

	setActive = var_2

	var_2(arg_4_0.switchBtns[1], true)

	setActive = var_2

	var_2(arg_4_0.switchBtns[2], false)

	local var_4_0 = arg_4_0.switchBtns
	local var_4_1 = arg_4_0.switchBtns
	local var_4_2 = arg_4_0.switchBtns[2]

	var_4_1[2] = arg_4_0.switchBtns[1]
	var_4_0[1] = var_4_2

	local var_4_3
	local var_4_4

	if arg_4_1 then
		var_4_2 = arg_4_0.phases[1]
		var_4_4 = arg_4_0.phases[2]
		var_4_3 = var_4_2
	else
		var_4_2 = arg_4_0.phases[2]
		var_4_4 = arg_4_0.phases[1]
		var_4_3 = var_4_2
	end

	GetOrAddComponent = var_4_2

	local var_4_5 = var_4_3

	typeof = var_1_10007
	CanvasGroup = var_1_10009

	local var_4_6 = var_4_2(var_4_5, var_1_10007(var_1_10009))
	local var_4_7 = var_4_3.localPosition
	local var_4_8 = var_4_4.localPosition

	var_4_4:SetAsLastSibling()

	setActive = var_7

	var_7(var_4_3:Find("Image"), false)

	LeanTween = var_7

	local var_4_9 = var_7.moveLocal

	go = var_9

	local var_4_10 = var_4_9(var_9(var_4_3), var_4_8, 0.4)
	local var_4_11 = var_7.setOnComplete

	System = var_10

	var_4_11(var_4_10, var_10.Action(function()
		setActive = var_2_10000

		local var_5_0 = var_4_3

		var_2_10000(var_2.Find(var_5_0, "label"), true)

		return
	end))

	LeanTween = var_4_11

	local var_4_12 = var_4_11.value

	go = var_4_10

	local var_4_13 = var_4_12(var_4_10(var_4_3), 0, 1, 0.4)
	local var_4_14 = var_7.setOnUpdate

	System = var_10

	var_4_14(var_4_13, var_10.Action_float(function(arg_6_0)
		var_4_6.alpha = arg_6_0

		return
	end))

	setActive = var_4_14

	var_4_14(var_4_4:Find("Image"), true)

	GetOrAddComponent = var_4_14

	local var_4_15 = var_4_4

	typeof = var_10
	CanvasGroup = var_12

	local var_4_16 = var_4_14(var_4_15, var_10(var_12))

	LeanTween = var_1_10008

	local var_4_17 = var_1_10008.value

	go = var_10

	local var_4_18 = var_4_17(var_10(var_4_4), 0, 1, 0.4)
	local var_4_19 = var_8.setOnUpdate

	System = var_11

	var_4_19(var_4_18, var_11.Action_float(function(arg_7_0)
		var_4_16.alpha = arg_7_0

		return
	end))

	setActive = var_4_19

	var_4_19(var_4_4:Find("label"), false)

	LeanTween = var_4_19

	local var_4_20 = var_4_19.moveLocal

	go = var_10

	local var_4_21 = var_4_20(var_10(var_4_4), var_4_7, 0.4)
	local var_4_22 = var_8.setOnComplete

	System = var_11

	var_4_22(var_4_21, var_11.Action(function()
		local var_8_0 = arg_4_0

		var_8_0.isSwitching = nil
		setToggleEnabled = var_8_0

		var_8_0(arg_4_0.switchBtn, true)

		return
	end))

	return
end

return var_0_1
