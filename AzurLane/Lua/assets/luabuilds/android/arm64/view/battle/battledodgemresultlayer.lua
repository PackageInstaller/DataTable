local var_0_0 = class("BattleDodgemResultLayer", import(".BattleResultLayer"))

function var_0_0.didEnter(arg_1_0)
	setText(arg_1_0._levelText, pg.expedition_data_template[arg_1_0.contextData.stageId].name)
	setText(findTF(arg_1_0._conditions, "bg17"), i18n("battle_result_targets"))

	local var_1_0 = rtf(arg_1_0._grade)

	arg_1_0._gradeUpperLeftPos = var_1_0.localPosition
	var_1_0.localPosition = Vector3(0, 25, 0)

	pg.UIMgr.GetInstance():BlurPanel(arg_1_0._tf)

	arg_1_0._grade.transform.localScale = Vector3(1.5, 1.5, 0)

	LeanTween.scale(arg_1_0._grade, Vector3(0.88, 0.88, 1), var_0_0.DURATION_WIN_SCALE):setOnComplete(System.Action(function()
		SetActive(arg_1_0._levelText, true)
		arg_1_0:rankAnimaFinish()

		return
	end))

	arg_1_0._tf:GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 0.5)
	arg_1_0._stateFlag = BattleResultLayer.STATE_RANK_ANIMA

	onButton(arg_1_0, arg_1_0._skipBtn, function()
		arg_1_0:skip()

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.rankAnimaFinish(arg_4_0)
	SetActive(arg_4_0._tf:Find("main/conditions"), true)
	SetActive(arg_4_0._conditionBGNormal, false)
	SetActive(arg_4_0._conditionBGContribute, true)
	arg_4_0:setCondition(i18n("battle_result_total_score"), arg_4_0.contextData.statistics.dodgemResult.score, COLOR_BLUE)
	arg_4_0:setCondition(i18n("battle_result_max_combo"), arg_4_0.contextData.statistics.dodgemResult.maxCombo, COLOR_YELLOW)
	table.insert(arg_4_0._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
		arg_4_0._stateFlag = var_0_0.STATE_REPORTED

		SetActive(arg_4_0._bg:Find("jieuan01/tips"), true)

		return
	end)).id)

	arg_4_0._stateFlag = var_0_0.STATE_REPORT

	return
end

function var_0_0.displayBG(arg_6_0)
	LeanTween.moveX(rtf(arg_6_0._conditions), 1300, var_0_0.DURATION_MOVE)
	LeanTween.scale(arg_6_0._grade, Vector3(0.6, 0.6, 0), var_0_0.DURATION_MOVE)
	LeanTween.moveLocal(go((rtf(arg_6_0._grade))), arg_6_0._gradeUpperLeftPos, var_0_0.DURATION_MOVE):setOnComplete(System.Action(function()
		arg_6_0:showPainting()

		return
	end))
	setActive(arg_6_0._bg:Find("jieuan01/Bomb"), false)

	return
end

function var_0_0.setCondition(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = cloneTplTo(arg_8_0._conditionContributeTpl, arg_8_0._conditionContainer)

	setActive(var_8_0, false)

	var_8_0:Find("text"):GetComponent(typeof(Text)).text = setColorStr(arg_8_1, "#FFFFFFFF")
	var_8_0:Find("value"):GetComponent(typeof(Text)).text = setColorStr(arg_8_2, arg_8_3)

	if arg_8_0._conditionContainer.childCount - 1 > 0 then
		table.insert(arg_8_0._delayLeanList, LeanTween.delayedCall(var_0_0.CONDITIONS_FREQUENCE * (arg_8_0._conditionContainer.childCount - 1), System.Action(function()
			setActive(var_8_0, true)

			return
		end)).id)
	else
		setActive(var_8_0, true)
	end

	return
end

function var_0_0.showPainting(arg_10_0)
	local var_10_1

	SetActive(arg_10_0._painting, true)

	arg_10_0.paintingName = "yanzhan"

	setPaintingPrefabAsync(arg_10_0._painting, arg_10_0.paintingName, "jiesuan", function()
		if findTF(arg_10_0._painting, "fitter").childCount > 0 then
			ShipExpressionHelper.SetExpression(findTF(arg_10_0._painting, "fitter"):GetChild(0), arg_10_0.paintingName, "win_mvp")
		end

		return
	end)
	SetActive(arg_10_0._failPainting, false)

	if arg_10_0.contextData.score > 1 then
		local var_10_3, var_10_4

		var_10_3, var_10_4, var_10_1 = ShipWordHelper.GetWordAndCV(205020, ShipWordHelper.WORD_TYPE_MVP)
	else
		local var_10_5, var_10_6

		var_10_5, var_10_6, var_10_1 = ShipWordHelper.GetWordAndCV(205020, ShipWordHelper.WORD_TYPE_LOSE)
	end

	setText(arg_10_0._chat:Find("Text"), var_10_1)

	local var_10_7 = arg_10_0._chat:Find("Text"):GetComponent(typeof(Text))

	var_10_7.alignment = #var_10_7.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

	SetActive(arg_10_0._chat, true)

	arg_10_0._chat.transform.localScale = Vector3.New(0, 0, 0)

	LeanTween.moveX(rtf(arg_10_0._painting), 50, 0.1):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(arg_10_0._chat.gameObject), Vector3.New(1, 1, 1), 0.1):setEase(LeanTweenType.easeOutBack)

		return
	end))

	arg_10_0._stateFlag = BattleResultLayer.STATE_DISPLAYED

	return
end

function var_0_0.skip(arg_13_0)
	if arg_13_0._stateFlag == BattleResultLayer.STATE_REPORTED then
		arg_13_0:displayBG()
	elseif arg_13_0._stateFlag == BattleResultLayer.STATE_DISPLAYED then
		arg_13_0:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)
	end

	return
end

function var_0_0.onBackPressed(arg_14_0)
	triggerButton(arg_14_0._skipBtn)

	return
end

function var_0_0.willExit(arg_15_0)
	LeanTween.cancel(go(arg_15_0._tf))
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_15_0._tf)
	pg.CameraFixMgr.GetInstance():disconnect(arg_15_0.camEventId)

	return
end

return var_0_0
