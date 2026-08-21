local var_0_0 = class("BattleSubmarineRoutineResultLayer", import(".BattleResultLayer"))

function var_0_0.rankAnimaFinish(arg_1_0)
	local var_1_0 = arg_1_0._tf:Find("main/conditions")

	SetActive(var_1_0, true)
	SetActive(var_1_0:Find("bg16/bg_extra"), true)
	arg_1_0:setCondition(i18n("battle_result_base_score"), "+" .. arg_1_0.contextData.statistics.subRunResult.basePoint, COLOR_BLUE, true)
	arg_1_0:setCondition(i18n("battle_result_dead_score", arg_1_0.contextData.statistics.subRunResult.deadCount), "-" .. arg_1_0.contextData.statistics.subRunResult.losePoint, COLOR_BLUE, true)
	arg_1_0:setCondition(i18n("battle_result_score", arg_1_0.contextData.statistics.subRunResult.score), "+" .. arg_1_0.contextData.statistics.subRunResult.point, COLOR_BLUE, true)
	arg_1_0:setCondition(i18n("battle_result_score_total"), arg_1_0.contextData.statistics.subRunResult.total, COLOR_YELLOW)
	table.insert(arg_1_0._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
		arg_1_0._stateFlag = var_0_0.STATE_REPORTED

		SetActive(arg_1_0._bg:Find("jieuan01/tips"), true)

		return
	end)).id)

	arg_1_0._stateFlag = var_0_0.STATE_REPORT

	return
end

function var_0_0.setCondition(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = cloneTplTo(arg_3_0._conditionSubTpl, arg_3_0._conditionContainer)

	setActive(var_3_0, false)

	var_3_0:Find("text"):GetComponent(typeof(Text)).text = setColorStr(arg_3_1, "#FFFFFFFF")
	var_3_0:Find("value"):GetComponent(typeof(Text)).text = setColorStr(arg_3_2, arg_3_3)

	if arg_3_4 then
		arg_3_0:setSpriteTo("resources/condition_check", var_3_0:Find("checkBox"), true)
	else
		setActive(var_3_0:Find("checkBox"), false)
	end

	local var_3_2 = arg_3_0._conditionContainer.childCount - 1

	if arg_3_0._conditionContainer.childCount - 1 > 0 then
		table.insert(arg_3_0._delayLeanList, LeanTween.delayedCall(var_0_0.CONDITIONS_FREQUENCE * var_3_2, System.Action(function()
			setActive(var_3_0, true)

			return
		end)).id)
	else
		setActive(var_3_0, true)
	end

	return
end

function var_0_0.displayBG(arg_5_0)
	LeanTween.moveX(rtf(arg_5_0._conditions), 1300, var_0_0.DURATION_MOVE)
	LeanTween.scale(arg_5_0._grade, Vector3(0.6, 0.6, 0), var_0_0.DURATION_MOVE)
	LeanTween.moveLocal(go((rtf(arg_5_0._grade))), arg_5_0._gradeUpperLeftPos, var_0_0.DURATION_MOVE):setOnComplete(System.Action(function()
		arg_5_0:displayShips()
		arg_5_0:displayPlayerInfo()
		arg_5_0:playSubExEnter()

		return
	end))
	setActive(arg_5_0._bg:Find("jieuan01/Bomb"), false)

	return
end

function var_0_0.showRightBottomPanel(arg_7_0)
	var_0_0.super.showRightBottomPanel(arg_7_0)
	setText(arg_7_0._playerBonusExp, "+" .. arg_7_0:calcPlayerProgress())
	SetActive(arg_7_0._subToggle, false)

	return
end

return var_0_0
