local BattleSubmarineRoutineResultLayer = class("BattleSubmarineRoutineResultLayer", import(".BattleResultLayer"))

function BattleSubmarineRoutineResultLayer:rankAnimaFinish()
	local var_1_0 = self._tf:Find("main/conditions")

	SetActive(var_1_0, true)
	SetActive(var_1_0:Find("bg16/bg_extra"), true)
	self:setCondition(i18n("battle_result_base_score"), "+" .. self.contextData.statistics.subRunResult.basePoint, COLOR_BLUE, true)
	self:setCondition(i18n("battle_result_dead_score", self.contextData.statistics.subRunResult.deadCount), "-" .. self.contextData.statistics.subRunResult.losePoint, COLOR_BLUE, true)
	self:setCondition(i18n("battle_result_score", self.contextData.statistics.subRunResult.score), "+" .. self.contextData.statistics.subRunResult.point, COLOR_BLUE, true)
	self:setCondition(i18n("battle_result_score_total"), self.contextData.statistics.subRunResult.total, COLOR_YELLOW)
	table.insert(self._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
		self._stateFlag = BattleSubmarineRoutineResultLayer.STATE_REPORTED

		SetActive(self._bg:Find("jieuan01/tips"), true)

		return
	end)).id)

	self._stateFlag = BattleSubmarineRoutineResultLayer.STATE_REPORT

	return
end

function BattleSubmarineRoutineResultLayer:setCondition(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = cloneTplTo(self._conditionSubTpl, self._conditionContainer)

	setActive(var_3_0, false)

	var_3_0:Find("text"):GetComponent(typeof(Text)).text = setColorStr(arg_3_1, "#FFFFFFFF")
	var_3_0:Find("value"):GetComponent(typeof(Text)).text = setColorStr(arg_3_2, arg_3_3)

	if arg_3_4 then
		self:setSpriteTo("resources/condition_check", var_3_0:Find("checkBox"), true)
	else
		setActive(var_3_0:Find("checkBox"), false)
	end

	if self._conditionContainer.childCount - 1 > 0 then
		table.insert(self._delayLeanList, LeanTween.delayedCall(BattleSubmarineRoutineResultLayer.CONDITIONS_FREQUENCE * (self._conditionContainer.childCount - 1), System.Action(function()
			setActive(var_3_0, true)

			return
		end)).id)
	else
		setActive(var_3_0, true)
	end

	return
end

function BattleSubmarineRoutineResultLayer:displayBG()
	LeanTween.moveX(rtf(self._conditions), 1300, BattleSubmarineRoutineResultLayer.DURATION_MOVE)
	LeanTween.scale(self._grade, Vector3(0.6, 0.6, 0), BattleSubmarineRoutineResultLayer.DURATION_MOVE)
	LeanTween.moveLocal(go((rtf(self._grade))), self._gradeUpperLeftPos, BattleSubmarineRoutineResultLayer.DURATION_MOVE):setOnComplete(System.Action(function()
		self:displayShips()
		self:displayPlayerInfo()
		self:playSubExEnter()

		return
	end))
	setActive(self._bg:Find("jieuan01/Bomb"), false)

	return
end

function BattleSubmarineRoutineResultLayer:showRightBottomPanel()
	BattleSubmarineRoutineResultLayer.super.showRightBottomPanel(self)
	setText(self._playerBonusExp, "+" .. self:calcPlayerProgress())
	SetActive(self._subToggle, false)

	return
end

return BattleSubmarineRoutineResultLayer
