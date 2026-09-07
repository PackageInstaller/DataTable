local BattleDodgemResultLayer = class("BattleDodgemResultLayer", import(".BattleResultLayer"))

function BattleDodgemResultLayer:didEnter()
	setText(self._levelText, pg.expedition_data_template[self.contextData.stageId].name)
	setText(findTF(self._conditions, "bg17"), i18n("battle_result_targets"))

	local var_1_0 = rtf(self._grade)

	self._gradeUpperLeftPos = var_1_0.localPosition
	var_1_0.localPosition = Vector3(0, 25, 0)

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self._grade.transform.localScale = Vector3(1.5, 1.5, 0)

	LeanTween.scale(self._grade, Vector3(0.88, 0.88, 1), BattleDodgemResultLayer.DURATION_WIN_SCALE):setOnComplete(System.Action(function()
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

function BattleDodgemResultLayer:rankAnimaFinish()
	SetActive(self._tf:Find("main/conditions"), true)
	SetActive(self._conditionBGNormal, false)
	SetActive(self._conditionBGContribute, true)
	self:setCondition(i18n("battle_result_total_score"), self.contextData.statistics.dodgemResult.score, COLOR_BLUE)
	self:setCondition(i18n("battle_result_max_combo"), self.contextData.statistics.dodgemResult.maxCombo, COLOR_YELLOW)
	table.insert(self._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
		self._stateFlag = BattleDodgemResultLayer.STATE_REPORTED

		SetActive(self._bg:Find("jieuan01/tips"), true)

		return
	end)).id)

	self._stateFlag = BattleDodgemResultLayer.STATE_REPORT

	return
end

function BattleDodgemResultLayer:displayBG()
	LeanTween.moveX(rtf(self._conditions), 1300, BattleDodgemResultLayer.DURATION_MOVE)
	LeanTween.scale(self._grade, Vector3(0.6, 0.6, 0), BattleDodgemResultLayer.DURATION_MOVE)
	LeanTween.moveLocal(go((rtf(self._grade))), self._gradeUpperLeftPos, BattleDodgemResultLayer.DURATION_MOVE):setOnComplete(System.Action(function()
		self:showPainting()

		return
	end))
	setActive(self._bg:Find("jieuan01/Bomb"), false)

	return
end

function BattleDodgemResultLayer:setCondition(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = cloneTplTo(self._conditionContributeTpl, self._conditionContainer)

	setActive(var_8_0, false)

	var_8_0:Find("text"):GetComponent(typeof(Text)).text = setColorStr(arg_8_1, "#FFFFFFFF")
	var_8_0:Find("value"):GetComponent(typeof(Text)).text = setColorStr(arg_8_2, arg_8_3)

	if self._conditionContainer.childCount - 1 > 0 then
		table.insert(self._delayLeanList, LeanTween.delayedCall(BattleDodgemResultLayer.CONDITIONS_FREQUENCE * (self._conditionContainer.childCount - 1), System.Action(function()
			setActive(var_8_0, true)

			return
		end)).id)
	else
		setActive(var_8_0, true)
	end

	return
end

function BattleDodgemResultLayer:showPainting()
	local var_10_1

	SetActive(self._painting, true)

	self.paintingName = "yanzhan"

	setPaintingPrefabAsync(self._painting, self.paintingName, "jiesuan", function()
		if findTF(self._painting, "fitter").childCount > 0 then
			ShipExpressionHelper.SetExpression(findTF(self._painting, "fitter"):GetChild(0), self.paintingName, "win_mvp")
		end

		return
	end)
	SetActive(self._failPainting, false)

	if self.contextData.score > 1 then
		local var_10_3, var_10_4

		var_10_3, var_10_4, var_10_1 = ShipWordHelper.GetWordAndCV(205020, ShipWordHelper.WORD_TYPE_MVP)
	else
		local var_10_5, var_10_6

		var_10_5, var_10_6, var_10_1 = ShipWordHelper.GetWordAndCV(205020, ShipWordHelper.WORD_TYPE_LOSE)
	end

	setText(self._chat:Find("Text"), var_10_1)

	local var_10_7 = self._chat:Find("Text"):GetComponent(typeof(Text))

	var_10_7.alignment = #var_10_7.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

	SetActive(self._chat, true)

	self._chat.transform.localScale = Vector3.New(0, 0, 0)

	LeanTween.moveX(rtf(self._painting), 50, 0.1):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(self._chat.gameObject), Vector3.New(1, 1, 1), 0.1):setEase(LeanTweenType.easeOutBack)

		return
	end))

	self._stateFlag = BattleResultLayer.STATE_DISPLAYED

	return
end

function BattleDodgemResultLayer:skip()
	if self._stateFlag == BattleResultLayer.STATE_REPORTED then
		self:displayBG()
	elseif self._stateFlag == BattleResultLayer.STATE_DISPLAYED then
		self:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)
	end

	return
end

function BattleDodgemResultLayer:onBackPressed()
	triggerButton(self._skipBtn)

	return
end

function BattleDodgemResultLayer:willExit()
	LeanTween.cancel(go(self._tf))
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

	return
end

return BattleDodgemResultLayer
