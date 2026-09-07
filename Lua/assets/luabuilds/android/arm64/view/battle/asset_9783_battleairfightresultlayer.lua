local BattleAirFightResultLayer = class("BattleAirFightResultLayer", import(".BattleResultLayer"))

function BattleAirFightResultLayer:getUIName()
	return "BattleAirFightResultUI"
end

function BattleAirFightResultLayer:init()
	self._grade = self._tf:Find("grade")
	self._levelText = self._grade:Find("chapterName/Text22")
	self._main = self._tf:Find("main")
	self._blurConatiner = self._tf:Find("blur_container")
	self._bg = self._tf:Find("main/jiesuanbeijing")
	self._painting = self._blurConatiner:Find("painting")
	self._chat = self._painting:Find("chat")
	self._rightBottomPanel = self._blurConatiner:Find("rightBottomPanel")
	self._confirmBtn = self._rightBottomPanel:Find("confirmBtn")

	setText(self._confirmBtn:Find("Text"), i18n("text_confirm"))

	self._statisticsBtn = self._rightBottomPanel:Find("statisticsBtn")
	self._skipBtn = self._tf:Find("skipLayer")
	self._conditions = self._tf:Find("main/conditions")
	self._conditionContainer = self._conditions:Find("bg16/list")
	self._conditionTpl = self._conditions:Find("bg16/conditionTpl")
	self._conditionSubTpl = self._conditions:Find("bg16/conditionSubTpl")
	self._conditionContributeTpl = self._conditions:Find("bg16/conditionContributeTpl")
	self._conditionBGContribute = self._conditions:Find("bg16/bg_contribute")

	self:setGradeLabel()
	SetActive(self._levelText, false)

	self._delayLeanList = {}

	return
end

function BattleAirFightResultLayer:setPlayer()
	return
end

function BattleAirFightResultLayer:setGradeLabel()
	local var_4_0 = {
		"d",
		"c",
		"b",
		"a",
		"s"
	}
	local var_4_1 = self._tf:Find("grade/Xyz/bg13")
	local var_4_2 = self._tf:Find("grade/Xyz/bg14")
	local var_4_5 = self.contextData.score
	local var_4_6 = self.contextData.score > ys.Battle.BattleConst.BattleScore.C

	setActive(self._bg:Find("jieuan01/BG/bg_victory"), self.contextData.score > ys.Battle.BattleConst.BattleScore.C)
	setActive(self._bg:Find("jieuan01/BG/bg_fail"), not var_4_6)
	LoadImageSpriteAsync("battlescore/battle_score_" .. var_4_0[var_4_5 + 1] .. "/letter_" .. var_4_0[var_4_5 + 1], var_4_1, false)
	LoadImageSpriteAsync("battlescore/battle_score_" .. var_4_0[var_4_5 + 1] .. "/label_" .. var_4_0[var_4_5 + 1], var_4_2, false)

	return
end

function BattleAirFightResultLayer:didEnter()
	self:setStageName()

	local var_5_0 = rtf(self._grade)

	self._gradeUpperLeftPos = var_5_0.localPosition
	var_5_0.localPosition = Vector3(0, 25, 0)

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self._grade.transform.localScale = Vector3(1.5, 1.5, 0)

	LeanTween.scale(self._grade, Vector3(0.88, 0.88, 1), BattleAirFightResultLayer.DURATION_WIN_SCALE):setOnComplete(System.Action(function()
		SetActive(self._levelText, true)
		self:rankAnimaFinish()

		return
	end))

	self._tf:GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 0.5)
	self._stateFlag = BattleResultLayer.STATE_RANK_ANIMA

	onButton(self, self._skipBtn, function()
		self:skip()

		return
	end, SFX_CONFIRM)

	return
end

function BattleAirFightResultLayer:rankAnimaFinish()
	SetActive(self._tf:Find("main/conditions"), true)
	self:setCondition(i18n("fighterplane_destroy_tip") .. self.contextData.statistics._airFightStatistics.kill, self.contextData.statistics._airFightStatistics.score, COLOR_BLUE)
	self:setCondition(i18n("fighterplane_hit_tip") .. self.contextData.statistics._airFightStatistics.hit, -self.contextData.statistics._airFightStatistics.lose, COLOR_BLUE)
	self:setCondition(i18n("fighterplane_score_tip"), self.contextData.statistics._airFightStatistics.total, COLOR_YELLOW)
	table.insert(self._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
		self._stateFlag = BattleAirFightResultLayer.STATE_REPORTED

		SetActive(self._bg:Find("jieuan01/tips"), true)

		return
	end)).id)

	self._stateFlag = BattleAirFightResultLayer.STATE_REPORT

	return
end

function BattleAirFightResultLayer:setCondition(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = cloneTplTo(self._conditionContributeTpl, self._conditionContainer)

	setActive(var_10_0, false)

	var_10_0:Find("text"):GetComponent(typeof(Text)).text = setColorStr(arg_10_1, "#FFFFFFFF")
	var_10_0:Find("value"):GetComponent(typeof(Text)).text = setColorStr(arg_10_2, arg_10_3)

	if self._conditionContainer.childCount - 1 > 0 then
		table.insert(self._delayLeanList, LeanTween.delayedCall(BattleAirFightResultLayer.CONDITIONS_FREQUENCE * (self._conditionContainer.childCount - 1), System.Action(function()
			setActive(var_10_0, true)

			return
		end)).id)
	else
		setActive(var_10_0, true)
	end

	return
end

function BattleAirFightResultLayer:displayBG()
	LeanTween.moveX(rtf(self._conditions), 1300, BattleAirFightResultLayer.DURATION_MOVE)
	LeanTween.scale(self._grade, Vector3(0.6, 0.6, 0), BattleAirFightResultLayer.DURATION_MOVE)
	LeanTween.moveLocal(go((rtf(self._grade))), self._gradeUpperLeftPos, BattleAirFightResultLayer.DURATION_MOVE):setOnComplete(System.Action(function()
		self._stateFlag = BattleAirFightResultLayer.STATE_DISPLAY

		self:showPainting()

		self._stateFlag = BattleAirFightResultLayer.STATE_DISPLAYED

		return
	end))
	setActive(self._bg:Find("jieuan01/Bomb"), false)

	return
end

function BattleAirFightResultLayer:showPainting()
	SetActive(self._painting, true)

	self.paintingName = "yanzhan"

	setPaintingPrefabAsync(self._painting, self.paintingName, "jiesuan", function()
		if findTF(self._painting, "fitter").childCount > 0 then
			ShipExpressionHelper.SetExpression(findTF(self._painting, "fitter"):GetChild(0), self.paintingName, "win_mvp")
		end

		return
	end)

	local var_14_0, var_14_1, var_14_2 = ShipWordHelper.GetWordAndCV(205020, (self.contextData.score > 1 or nil) and (ShipWordHelper.WORD_TYPE_MVP or ShipWordHelper.WORD_TYPE_LOSE))

	setText(self._chat:Find("Text"), var_14_2)

	local var_14_3 = self._chat:Find("Text"):GetComponent(typeof(Text))

	var_14_3.alignment = #var_14_3.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

	SetActive(self._chat, true)

	self._chat.transform.localScale = Vector3.New(0, 0, 0)

	LeanTween.moveX(rtf(self._painting), 50, 0.1):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(self._chat.gameObject), Vector3.New(1, 1, 1), 0.1):setEase(LeanTweenType.easeOutBack)

		return
	end))

	return
end

function BattleAirFightResultLayer:skip()
	if self._stateFlag == BattleResultLayer.STATE_REPORTED then
		self:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)
	end

	return
end

function BattleAirFightResultLayer:showRightBottomPanel()
	SetActive(self._skipBtn, false)
	SetActive(self._rightBottomPanel, true)
	SetActive(self._subToggle, false)
	onButton(self, self._confirmBtn, function()
		self:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)

		return
	end, SFX_CONFIRM)

	self._stateFlag = nil

	return
end

function BattleAirFightResultLayer:onBackPressed()
	triggerButton(self._skipBtn)

	return
end

function BattleAirFightResultLayer:willExit()
	LeanTween.cancel(go(self._tf))
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return BattleAirFightResultLayer
