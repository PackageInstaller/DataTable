class = var_0_10000

local var_0_0 = "BossSingleContinuousOperationPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BossSingleContinuousOperationUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.btnOn = var_1.Find(var_2_0, "Panel/On")

	local var_2_1 = arg_2_0._tf

	arg_2_0.btnOff = var_1.Find(var_2_1, "Panel/Off")

	local var_2_2 = arg_2_0._tf

	arg_2_0.slider = var_1.Find(var_2_2, "Panel/Slider")
	GetComponent = var_1

	local var_2_3 = arg_2_0._tf

	typeof = var_4
	AspectRatioFitter = var_1_10006
	arg_2_0._ratioFitter = var_1(var_2_3, var_4(var_1_10006))
	setText = var_1

	local var_2_4 = arg_2_0.btnOff
	local var_2_5 = var_3.Find(var_2_4, "common/Text")

	i18n = var_4

	var_1(var_2_5, var_4("multiple_sorties_stopped"))

	return
end

function var_0_1.UpdateAutoFightMark(arg_3_0)
	local var_3_0 = arg_3_0.contextData.autoFlag

	setActive = var_1_10002

	var_1_10002(arg_3_0.btnOn, var_3_0)

	setActive = var_1_10002

	var_1_10002(arg_3_0.btnOff, not var_3_0)

	return
end

function var_0_1.didEnter(arg_4_0)
	local var_4_0 = arg_4_0.contextData

	defaultValue = var_1_10002
	var_4_0.autoFlag = var_1_10002(arg_4_0.contextData.autoFlag, true)
	onButton = var_4_0

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.btnOn

	local function var_4_3()
		arg_4_0.contextData.autoFlag = false

		local var_5_0 = arg_4_0

		var_0.UpdateAutoFightMark(var_5_0)

		pg = var_0

		local var_5_1 = var_0.TipsMgr.GetInstance()
		local var_5_2 = var_0.ShowTips

		i18n = var_2_10003

		var_5_2(var_5_1, var_2_10003("multiple_sorties_stop_tip"))

		local var_5_3 = arg_4_0
		local var_5_4 = var_0.emit

		BattleMediator = var_3

		var_5_4(var_5_3, var_3.HIDE_ALL_BUTTONS, true)

		return
	end

	SFX_PANEL = var_1_10006

	var_4_0(var_4_1, var_4_2, var_4_3, var_1_10006)

	onButton = var_4_0

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.btnOff

	local function var_4_6()
		arg_4_0.contextData.autoFlag = true

		local var_6_0 = arg_4_0

		var_0.UpdateAutoFightMark(var_6_0)

		pg = var_0

		local var_6_1 = var_0.TipsMgr.GetInstance()
		local var_6_2 = var_0.ShowTips

		i18n = var_2_10003

		var_6_2(var_6_1, var_2_10003("multiple_sorties_resume_tip"))

		local var_6_3 = arg_4_0
		local var_6_4 = var_0.emit

		BattleMediator = var_3

		var_6_4(var_6_3, var_3.HIDE_ALL_BUTTONS, false)

		return
	end

	SFX_PANEL = var_1_10006

	var_4_0(var_4_4, var_4_5, var_4_6, var_1_10006)

	local var_4_7 = arg_4_0._ratioFitter

	pg = var_2

	local var_4_8 = var_2.CameraFixMgr.GetInstance()

	var_4_7.aspectRatio = var_2.GetBattleUIRatio(var_4_8)

	arg_4_0:UpdateAutoFightMark()
	arg_4_0:UpdateBattleTimes()

	pg = var_1

	local var_4_9 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_4_9, arg_4_0._tf)

	return
end

function var_0_1.UpdateBattleTimes(arg_7_0)
	local var_7_0 = arg_7_0.contextData.continuousBattleTimes
	local var_7_1 = arg_7_0.contextData.totalBattleTimes

	setText = var_1_10003

	local var_7_2 = arg_7_0.btnOn

	var_1_10003(var_5.Find(var_7_2, "Text"), var_7_1 - var_7_0 + 1 .. "/" .. var_7_1)

	setActive = var_1_10003

	var_1_10003(arg_7_0.slider, false)

	setActive = var_1_10003

	local var_7_3 = arg_7_0.btnOff

	var_1_10003(var_5.Find(var_7_3, "small"), true)

	setActive = var_1_10003

	local var_7_4 = arg_7_0.btnOff

	var_1_10003(var_5.Find(var_7_4, "common"), false)

	return
end

function var_0_1.OnEnterBattleResult(arg_8_0)
	setActive = var_1_10001

	local var_8_0 = arg_8_0.btnOff

	var_1_10001(var_3.Find(var_8_0, "small"), false)

	setActive = var_1_10001

	local var_8_1 = arg_8_0.btnOff

	var_1_10001(var_3.Find(var_8_1, "common"), true)

	return
end

function var_0_1.AnimatingSlider(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.slider, true)

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.managedTween

	LeanTween = var_4

	local var_9_2 = var_4.value

	local function var_9_3()
		local var_10_0 = arg_9_0
		local var_10_1 = var_0.emit

		BossSingleContinuousOperationMediator = var_2_10003

		var_10_1(var_10_0, var_2_10003.ON_REENTER)

		return
	end

	go = var_1_10006

	local var_9_4 = var_9_1(var_9_0, var_9_2, var_9_3, var_1_10006(arg_9_0.slider), 1, 0, 5)
	local var_9_5 = var_1.setOnUpdate

	System = var_9_2

	var_9_5(var_9_4, var_9_2.Action_float(function(arg_11_0)
		setSlider = var_2_10001

		var_2_10001(arg_9_0.slider, 0, 1, arg_11_0)

		return
	end))

	return
end

function var_0_1.willExit(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0._tf)

	return
end

function var_0_1.onBackPressed(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.emit

	GAME = var_1_10004

	var_13_1(var_13_0, var_1_10004.PAUSE_BATTLE)

	return
end

return var_0_1
