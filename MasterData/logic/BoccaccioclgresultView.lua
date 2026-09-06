-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccaccioclg/view/BoccaccioclgresultView.lua

module("logic.extensions.boccaccioclg.view.BoccaccioclgresultView", package.seeall)

local BoccaccioclgresultView = class("BoccaccioclgresultView", ViewComponent)

function BoccaccioclgresultView:ctor()
	BoccaccioclgresultView.super.ctor(self)
end

function BoccaccioclgresultView:unbindEvents()
	BoccaccioclgresultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function BoccaccioclgresultView:bindEvents()
	BoccaccioclgresultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function BoccaccioclgresultView:buildUI()
	BoccaccioclgresultView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._cellGo = self:getGo("cell")
	self._cellconhistoryGo = self:getGo("cellconhistory")
	self._cellconcurrGo = self:getGo("cellconcurr")

	GameUtil.SetActive(self._cellGo, false)

	self._singleLineCellconcurr = self:getGo("cellconcurr"):GetComponent(ComponentType.UILayoutSingleLine)
	self._singleLineCellconhistory = self:getGo("cellconhistory"):GetComponent(ComponentType.UILayoutSingleLine)
	self._txtScoreHistory = self:getTxt("txtScoreHistory")
	self._txtScoreCurr = self:getTxt("txtScoreCurr")
	self._txtPreTotalScore = self:getTxt("txtPreTotalScore")
	self._txtCurTotalScore = self:getTxt("txtCurTotalScore")
end

function BoccaccioclgresultView:onExit()
	BoccaccioclgresultView.super.onExit(self)
end

function BoccaccioclgresultView:onEnter()
	BoccaccioclgresultView.super.onEnter(self)

	self._msg = self:getFirstParam()
	self._activityId = self._msg.activityId

	self:_updateUI()
end

function BoccaccioclgresultView:_onClickbtnSure()
	BattleFacade.instance:endBattle()
end

function BoccaccioclgresultView:_updateUI()
	local currBuffType2Value = {}

	for i, v in ipairs(self._msg.curValueList or {}) do
		currBuffType2Value[v.buffType] = checknumber(v.value)
	end

	local oldBuffType2Value = {}

	for i, v in ipairs(self._msg.oldValueList or {}) do
		oldBuffType2Value[v.buffType] = checknumber(v.value)
	end

	self:_updateCurr(currBuffType2Value, oldBuffType2Value)
	self:_updateHistory(currBuffType2Value, oldBuffType2Value)
	self._singleLineCellconcurr:Layout()
	self._singleLineCellconhistory:Layout()
end

function BoccaccioclgresultView:_updateCurr(currBuffType2Value, oldBuffType2Value)
	local buffCfgs = BoccaccioclgConfig.instance:getSignBuffCfgs(self._activityId)
	local childCount = self._cellconcurrGo.transform.childCount
	local scoreCurr = 0
	local scoreOld = 0

	for i = 1, childCount do
		local go = self._cellconcurrGo.transform:GetChild(i - 1)

		GameUtil.SetActive(go, false)
	end

	for i, v in ipairs(buffCfgs) do
		local go = i <= childCount and self._cellconcurrGo.transform:GetChild(i - 1)

		go = go or goutil.cloneAndSetParent(self._cellGo, self._cellconcurrGo.transform)

		GameUtil.SetActive(go, true)
		self:_updateCurrItem(go, v, currBuffType2Value[v.buffType], oldBuffType2Value[v.buffType])

		scoreCurr = scoreCurr + self:_value2Score(v.buffType, currBuffType2Value[v.buffType])
		scoreOld = scoreOld + self:_value2Score(v.buffType, oldBuffType2Value[v.buffType])
	end

	self._txtCurTotalScore.text = string.format("总积分：<color=#41d5ff>%s</color>", scoreCurr)
end

function BoccaccioclgresultView:_updateCurrItem(go, buffCfg, currValue, oldValue)
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtCurr = goutil.findChildTextComponent(go, "txtCurr")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")

	currValue = checknumber(currValue)
	oldValue = checknumber(oldValue)

	local oldScore = self:_value2Score(buffCfg.buffType, oldValue)
	local currScore = self:_value2Score(buffCfg.buffType, currValue)
	local isUp = oldScore < currScore
	local isSame = currScore == oldScore
	local color = isSame and "#466887" or isUp and "green" or "red"

	txtName.text = string.format("%s属性 ：", buffCfg.name)
	txtCurr.text = string.format("%s", currValue)
	txtScore.text = string.format("<color=%s>%s</color>", color, currScore)
end

function BoccaccioclgresultView:_updateHistory(currBuffType2Value, oldBuffType2Value)
	local buffCfgs = BoccaccioclgConfig.instance:getSignBuffCfgs(self._activityId)
	local childCount = self._cellconhistoryGo.transform.childCount

	for i = 1, childCount do
		local go = self._cellconhistoryGo.transform:GetChild(i - 1)

		GameUtil.SetActive(go, false)
	end

	local scoreCurr = 0
	local scoreOld = 0

	for i, v in ipairs(currBuffType2Value) do
		scoreCurr = scoreCurr + self:_value2Score(i, v)
	end

	for i, v in ipairs(oldBuffType2Value) do
		scoreOld = scoreOld + self:_value2Score(i, v)
	end

	local showBuffType2Value = {}

	showBuffType2Value = scoreOld < scoreCurr and currBuffType2Value or oldBuffType2Value

	for i, v in ipairs(buffCfgs) do
		local go = i <= childCount and self._cellconhistoryGo.transform:GetChild(i - 1)

		go = go or goutil.cloneAndSetParent(self._cellGo, self._cellconhistoryGo.transform)

		GameUtil.SetActive(go, true)
		self:_updateHistoryItem(go, v, showBuffType2Value[v.buffType])
	end

	self._txtPreTotalScore.text = string.format("总积分：<color=#41d5ff>%s</color>", math.max(scoreCurr, scoreOld))
end

function BoccaccioclgresultView:_updateHistoryItem(go, buffCfg, showValue)
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtCurr = goutil.findChildTextComponent(go, "txtCurr")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local goArrow = goutil.findChild(go, "arrow")

	showValue = checknumber(showValue)

	local currScore = self:_value2Score(buffCfg.buffType, showValue)
	local color = "#466887"

	txtName.text = string.format("%s属性 ：", buffCfg.name)
	txtCurr.text = string.format("%s", showValue)
	txtScore.text = string.format("<color=%s>%s</color>", color, currScore)

	GameUtil.SetActive(goArrow, false)
end

function BoccaccioclgresultView:_value2Score(buffType, value)
	return BoccaccioclgController.instance:value2Score(self._activityId, buffType, value)
end

return BoccaccioclgresultView
