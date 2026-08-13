class = var_0_10000

local var_0_0 = "BattleSubmarineRoutineResultLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BattleResultLayer"))

function var_0_1.rankAnimaFinish(arg_1_0)
	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_1.Find(var_1_0, "main/conditions")

	SetActive = var_1_10002

	var_1_10002(var_1_1, true)

	SetActive = var_1_10002

	local var_1_2 = var_1_1

	var_1_10002(var_1_1.Find(var_1_2, "bg16/bg_extra"), true)

	local var_1_3 = arg_1_0.contextData.statistics.subRunResult
	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.setCondition

	i18n = var_1_2

	local var_1_6 = var_1_2("battle_result_base_score")
	local var_1_7 = "+" .. var_1_3.basePoint

	COLOR_BLUE = var_8

	var_1_5(var_1_4, var_1_6, var_1_7, var_8, true)

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.setCondition

	i18n = var_1_6

	local var_1_10 = var_1_6("battle_result_dead_score", var_1_3.deadCount)
	local var_1_11 = "-" .. var_1_3.losePoint

	COLOR_BLUE = var_8

	var_1_9(var_1_8, var_1_10, var_1_11, var_8, true)

	local var_1_12 = arg_1_0
	local var_1_13 = arg_1_0.setCondition

	i18n = var_1_10

	local var_1_14 = var_1_10("battle_result_score", var_1_3.score)
	local var_1_15 = "+" .. var_1_3.point

	COLOR_BLUE = var_8

	var_1_13(var_1_12, var_1_14, var_1_15, var_8, true)

	local var_1_16 = arg_1_0
	local var_1_17 = arg_1_0.setCondition

	i18n = var_1_14

	local var_1_18 = var_1_14("battle_result_score_total")
	local var_1_19 = var_1_3.total

	COLOR_YELLOW = var_8

	var_1_17(var_1_16, var_1_18, var_1_19, var_8)

	LeanTween = var_1_17

	local var_1_20 = var_1_17.delayedCall
	local var_1_21 = 1

	System = var_1_18

	local var_1_22 = var_1_20(var_1_21, var_1_18.Action(function()
		local var_2_0 = arg_1_0

		var_2_0._stateFlag = var_0_1.STATE_REPORTED
		SetActive = var_2_0

		local var_2_1 = arg_1_0._bg

		var_2_0(var_2.Find(var_2_1, "jieuan01/tips"), true)

		return
	end))

	table = var_4

	var_4.insert(arg_1_0._delayLeanList, var_1_22.id)

	arg_1_0._stateFlag = var_0_1.STATE_REPORT

	return
end

function var_0_1.setCondition(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	cloneTplTo = var_1_10005

	local var_3_0 = var_1_10005(arg_3_0._conditionSubTpl, arg_3_0._conditionContainer)

	setActive = var_1_10006

	var_1_10006(var_3_0, false)

	local var_3_1
	local var_3_2 = var_3_0:Find("text")
	local var_3_3 = var_7.GetComponent

	typeof = var_10
	Text = var_1_10012

	local var_3_4 = var_3_3(var_3_2, var_10(var_1_10012))

	setColorStr = var_8
	var_3_4.text = var_8(arg_3_1, "#FFFFFFFF")

	local var_3_5 = var_3_0:Find("value")
	local var_3_6 = var_8.GetComponent

	typeof = var_11
	Text = var_1_10013

	local var_3_7 = var_3_6(var_3_5, var_11(var_1_10013))

	setColorStr = var_3_2
	var_3_7.text = var_3_2(arg_3_2, arg_3_3)

	local var_3_9

	if arg_3_4 then
		local var_3_8 = "resources/condition_check"

		var_3_9 = arg_3_0

		arg_3_0.setSpriteTo(var_3_9, var_3_8, var_3_0:Find("checkBox"), true)
	else
		setActive = var_9
		var_1_10013 = var_3_0

		var_9(var_3_0.Find(var_1_10013, "checkBox"), false)
	end

	local var_3_10 = arg_3_0._conditionContainer.childCount - 1
	local var_3_11

	if 0 < var_3_10 then
		LeanTween = var_3_11
		var_3_11 = var_3_11.delayedCall

		local var_3_12 = var_0_1.CONDITIONS_FREQUENCE * var_3_10

		System = var_1_10013
		var_3_11 = var_3_11(var_3_12, var_1_10013.Action(function()
			setActive = var_2_10000

			var_2_10000(var_3_0, true)

			return
		end))
		table = var_3_9

		var_3_9.insert(arg_3_0._delayLeanList, var_3_11.id)
	else
		setActive = var_3_11

		var_3_11(var_3_0, true)
	end

	return
end

function var_0_1.displayBG(arg_5_0)
	rtf = var_1_10001

	local var_5_0 = var_1_10001(arg_5_0._grade)

	LeanTween = var_1_10002

	local var_5_1 = var_1_10002.moveX

	rtf = var_1_10004

	var_5_1(var_1_10004(arg_5_0._conditions), 1300, var_0_1.DURATION_MOVE)

	LeanTween = var_5_1

	local var_5_2 = var_5_1.scale
	local var_5_3 = arg_5_0._grade

	Vector3 = var_5

	var_5_2(var_5_3, var_5(0.6, 0.6, 0), var_0_1.DURATION_MOVE)

	LeanTween = var_5_2

	local var_5_4 = var_5_2.moveLocal

	go = var_5_3

	local var_5_5 = var_5_4(var_5_3(var_5_0), arg_5_0._gradeUpperLeftPos, var_0_1.DURATION_MOVE)
	local var_5_6 = var_2.setOnComplete

	System = var_5

	var_5_6(var_5_5, var_5.Action(function()
		local var_6_0 = arg_5_0

		var_0.displayShips(var_6_0)

		local var_6_1 = arg_5_0

		var_0.displayPlayerInfo(var_6_1)

		local var_6_2 = arg_5_0

		var_0.playSubExEnter(var_6_2)

		return
	end))

	setActive = var_5_6

	local var_5_7 = arg_5_0._bg

	var_5_6(var_4.Find(var_5_7, "jieuan01/Bomb"), false)

	return
end

function var_0_1.showRightBottomPanel(arg_7_0)
	var_0_1.super.showRightBottomPanel(arg_7_0)

	setText = var_1

	var_1(arg_7_0._playerBonusExp, "+" .. arg_7_0:calcPlayerProgress())

	SetActive = var_1

	var_1(arg_7_0._subToggle, false)

	return
end

return var_0_1
