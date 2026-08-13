class = var_0_10000

local var_0_0 = "BattleRewardRerformResultLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BattleResultLayer"))

function var_0_1.didEnter(arg_1_0)
	local var_1_0 = arg_1_0.contextData.stageId

	pg = var_1_10002

	local var_1_1 = var_1_10002.expedition_data_template[var_1_0]

	setText = var_1_10003

	var_1_10003(arg_1_0._levelText, var_1_1.name)

	rtf = var_1_10003
	arg_1_0._gradeUpperLeftPos = var_1_10003(arg_1_0._grade).localPosition
	Vector3 = var_4
	var_3.localPosition = var_4(0, 25, 0)
	pg = var_4

	local var_1_2 = var_4.UIMgr.GetInstance()

	var_4.BlurPanel(var_1_2, arg_1_0._tf)

	local var_1_3 = arg_1_0._grade.transform

	Vector3 = var_5
	var_1_3.localScale = var_5(1.5, 1.5, 0)
	LeanTween = var_1_3

	local var_1_4 = var_1_3.scale
	local var_1_5 = arg_1_0._grade

	Vector3 = var_7

	local var_1_6 = var_1_4(var_1_5, var_7(0.88, 0.88, 1), var_0_1.DURATION_WIN_SCALE)
	local var_1_7 = var_4.setOnComplete

	System = var_7

	var_1_7(var_1_6, var_7.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_1_0._levelText, true)

		local var_2_0 = arg_1_0

		var_0.rankAnimaFinish(var_2_0)

		return
	end))

	local var_1_8 = arg_1_0._tf
	local var_1_9 = var_4.GetComponent

	typeof = var_7
	Image = var_9

	local var_1_10 = var_1_9(var_1_8, var_7(var_9))

	Color = var_5
	var_1_10.color = var_5.New(0, 0, 0, 0.5)
	BattleResultLayer = var_1_10
	arg_1_0._stateFlag = var_1_10.STATE_RANK_ANIMA
	onButton = var_4

	local var_1_11 = arg_1_0
	local var_1_12 = arg_1_0._skipBtn

	local function var_1_13()
		local var_3_0 = arg_1_0

		var_0.skip(var_3_0)

		return
	end

	SFX_CONFIRM = var_9

	var_4(var_1_11, var_1_12, var_1_13, var_9)

	return
end

function var_0_1.skip(arg_4_0)
	local var_4_0 = arg_4_0._stateFlag

	BattleResultLayer = var_1_10002

	if var_4_0 == var_1_10002.STATE_REPORTED then
		local var_4_1 = arg_4_0
		local var_4_2 = arg_4_0.emit

		BattleResultMediator = var_1_10004

		var_4_2(var_4_1, var_1_10004.ON_BACK_TO_LEVEL_SCENE)
	end

	return
end

function var_0_1.onBackPressed(arg_5_0)
	triggerButton = var_1_10001

	var_1_10001(arg_5_0._skipBtn)

	return
end

function var_0_1.willExit(arg_6_0)
	LeanTween = var_1_10001

	local var_6_0 = var_1_10001.cancel

	go = var_1_10003

	var_6_0(var_1_10003(arg_6_0._tf))

	pg = var_6_0

	local var_6_1 = var_6_0.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_6_1, arg_6_0._tf)

	return
end

return var_0_1
