local var_0_0 = class("BattleAirFightResultLayer", import(".BattleResultLayer"))

function var_0_0.getUIName(arg_1_0)
	return "BattleAirFightResultUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0._grade = arg_2_0._tf:Find("grade")
	arg_2_0._levelText = arg_2_0._grade:Find("chapterName/Text22")
	arg_2_0._main = arg_2_0._tf:Find("main")
	arg_2_0._blurConatiner = arg_2_0._tf:Find("blur_container")
	arg_2_0._bg = arg_2_0._tf:Find("main/jiesuanbeijing")
	arg_2_0._painting = arg_2_0._blurConatiner:Find("painting")
	arg_2_0._chat = arg_2_0._painting:Find("chat")
	arg_2_0._rightBottomPanel = arg_2_0._blurConatiner:Find("rightBottomPanel")
	arg_2_0._confirmBtn = arg_2_0._rightBottomPanel:Find("confirmBtn")

	setText(arg_2_0._confirmBtn:Find("Text"), i18n("text_confirm"))

	arg_2_0._statisticsBtn = arg_2_0._rightBottomPanel:Find("statisticsBtn")
	arg_2_0._skipBtn = arg_2_0._tf:Find("skipLayer")
	arg_2_0._conditions = arg_2_0._tf:Find("main/conditions")
	arg_2_0._conditionContainer = arg_2_0._conditions:Find("bg16/list")
	arg_2_0._conditionTpl = arg_2_0._conditions:Find("bg16/conditionTpl")
	arg_2_0._conditionSubTpl = arg_2_0._conditions:Find("bg16/conditionSubTpl")
	arg_2_0._conditionContributeTpl = arg_2_0._conditions:Find("bg16/conditionContributeTpl")
	arg_2_0._conditionBGContribute = arg_2_0._conditions:Find("bg16/bg_contribute")

	arg_2_0:setGradeLabel()
	SetActive(arg_2_0._levelText, false)

	arg_2_0._delayLeanList = {}

	return
end

function var_0_0.setPlayer(arg_3_0)
	return
end

function var_0_0.setGradeLabel(arg_4_0)
	local var_4_0 = arg_4_0._tf:Find("grade/Xyz/bg13")
	local var_4_1 = arg_4_0._tf:Find("grade/Xyz/bg14")
	local var_4_4 = arg_4_0.contextData.score
	local var_4_5 = arg_4_0.contextData.score > ys.Battle.BattleConst.BattleScore.C

	setActive(arg_4_0._bg:Find("jieuan01/BG/bg_victory"), arg_4_0.contextData.score > ys.Battle.BattleConst.BattleScore.C)
	setActive(arg_4_0._bg:Find("jieuan01/BG/bg_fail"), not var_4_5)
	LoadImageSpriteAsync("battlescore/battle_score_" .. ({
		"d",
		"c",
		"b",
		"a",
		"s"
	})[var_4_4 + 1] .. "/letter_" .. ({
		"d",
		"c",
		"b",
		"a",
		"s"
	})[var_4_4 + 1], var_4_0, false)
	LoadImageSpriteAsync("battlescore/battle_score_" .. ({
		"d",
		"c",
		"b",
		"a",
		"s"
	})[var_4_4 + 1] .. "/label_" .. ({
		"d",
		"c",
		"b",
		"a",
		"s"
	})[var_4_4 + 1], var_4_1, false)

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:setStageName()

	local var_5_0 = rtf(arg_5_0._grade)

	arg_5_0._gradeUpperLeftPos = var_5_0.localPosition
	var_5_0.localPosition = Vector3(0, 25, 0)

	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf)

	arg_5_0._grade.transform.localScale = Vector3(1.5, 1.5, 0)

	LeanTween.scale(arg_5_0._grade, Vector3(0.88, 0.88, 1), var_0_0.DURATION_WIN_SCALE):setOnComplete(System.Action(function()
		SetActive(arg_5_0._levelText, true)
		arg_5_0:rankAnimaFinish()

		return
	end))

	arg_5_0._tf:GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 0.5)
	arg_5_0._stateFlag = BattleResultLayer.STATE_RANK_ANIMA

	onButton(arg_5_0, arg_5_0._skipBtn, function()
		arg_5_0:skip()

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.rankAnimaFinish(arg_8_0)
	SetActive(arg_8_0._tf:Find("main/conditions"), true)
	arg_8_0:setCondition(i18n("fighterplane_destroy_tip") .. arg_8_0.contextData.statistics._airFightStatistics.kill, arg_8_0.contextData.statistics._airFightStatistics.score, COLOR_BLUE)
	arg_8_0:setCondition(i18n("fighterplane_hit_tip") .. arg_8_0.contextData.statistics._airFightStatistics.hit, -arg_8_0.contextData.statistics._airFightStatistics.lose, COLOR_BLUE)
	arg_8_0:setCondition(i18n("fighterplane_score_tip"), arg_8_0.contextData.statistics._airFightStatistics.total, COLOR_YELLOW)
	table.insert(arg_8_0._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
		arg_8_0._stateFlag = var_0_0.STATE_REPORTED

		SetActive(arg_8_0._bg:Find("jieuan01/tips"), true)

		return
	end)).id)

	arg_8_0._stateFlag = var_0_0.STATE_REPORT

	return
end

function var_0_0.setCondition(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = cloneTplTo(arg_10_0._conditionContributeTpl, arg_10_0._conditionContainer)

	setActive(var_10_0, false)

	var_10_0:Find("text"):GetComponent(typeof(Text)).text = setColorStr(arg_10_1, "#FFFFFFFF")
	var_10_0:Find("value"):GetComponent(typeof(Text)).text = setColorStr(arg_10_2, arg_10_3)

	if arg_10_0._conditionContainer.childCount - 1 > 0 then
		table.insert(arg_10_0._delayLeanList, LeanTween.delayedCall(var_0_0.CONDITIONS_FREQUENCE * (arg_10_0._conditionContainer.childCount - 1), System.Action(function()
			setActive(var_10_0, true)

			return
		end)).id)
	else
		setActive(var_10_0, true)
	end

	return
end

function var_0_0.displayBG(arg_12_0)
	LeanTween.moveX(rtf(arg_12_0._conditions), 1300, var_0_0.DURATION_MOVE)
	LeanTween.scale(arg_12_0._grade, Vector3(0.6, 0.6, 0), var_0_0.DURATION_MOVE)
	LeanTween.moveLocal(go((rtf(arg_12_0._grade))), arg_12_0._gradeUpperLeftPos, var_0_0.DURATION_MOVE):setOnComplete(System.Action(function()
		arg_12_0._stateFlag = var_0_0.STATE_DISPLAY

		arg_12_0:showPainting()

		arg_12_0._stateFlag = var_0_0.STATE_DISPLAYED

		return
	end))
	setActive(arg_12_0._bg:Find("jieuan01/Bomb"), false)

	return
end

function var_0_0.showPainting(arg_14_0)
	SetActive(arg_14_0._painting, true)

	arg_14_0.paintingName = "yanzhan"

	setPaintingPrefabAsync(arg_14_0._painting, arg_14_0.paintingName, "jiesuan", function()
		if findTF(arg_14_0._painting, "fitter").childCount > 0 then
			ShipExpressionHelper.SetExpression(findTF(arg_14_0._painting, "fitter"):GetChild(0), arg_14_0.paintingName, "win_mvp")
		end

		return
	end)

	if arg_14_0.contextData.score > 1 then
		local var_14_0 = ShipWordHelper.WORD_TYPE_MVP or ShipWordHelper.WORD_TYPE_LOSE
		local var_14_1, var_14_2, var_14_3 = ShipWordHelper.GetWordAndCV(205020, var_14_0)

		setText(arg_14_0._chat:Find("Text"), var_14_3)

		local var_14_4 = arg_14_0._chat:Find("Text"):GetComponent(typeof(Text))

		var_14_4.alignment = #var_14_4.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

		SetActive(arg_14_0._chat, true)

		arg_14_0._chat.transform.localScale = Vector3.New(0, 0, 0)

		LeanTween.moveX(rtf(arg_14_0._painting), 50, 0.1):setOnComplete(System.Action(function()
			LeanTween.scale(rtf(arg_14_0._chat.gameObject), Vector3.New(1, 1, 1), 0.1):setEase(LeanTweenType.easeOutBack)

			return
		end))

		return
	end
end

function var_0_0.skip(arg_17_0)
	if arg_17_0._stateFlag == BattleResultLayer.STATE_REPORTED then
		arg_17_0:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)
	end

	return
end

function var_0_0.showRightBottomPanel(arg_18_0)
	SetActive(arg_18_0._skipBtn, false)
	SetActive(arg_18_0._rightBottomPanel, true)
	SetActive(arg_18_0._subToggle, false)
	onButton(arg_18_0, arg_18_0._confirmBtn, function()
		arg_18_0:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)

		return
	end, SFX_CONFIRM)

	arg_18_0._stateFlag = nil

	return
end

function var_0_0.onBackPressed(arg_20_0)
	triggerButton(arg_20_0._skipBtn)

	return
end

function var_0_0.willExit(arg_21_0)
	LeanTween.cancel(go(arg_21_0._tf))
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_21_0._tf)

	return
end

return var_0_0
