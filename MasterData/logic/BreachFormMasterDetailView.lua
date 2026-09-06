-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterDetailView.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterDetailView", package.seeall)

local BreachFormMasterDetailView = class("BreachFormMasterDetailView", ViewComponent)

function BreachFormMasterDetailView:ctor()
	BreachFormMasterDetailView.super.ctor(self)
end

function BreachFormMasterDetailView:unbindEvents()
	BreachFormMasterDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function BreachFormMasterDetailView:bindEvents()
	BreachFormMasterDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function BreachFormMasterDetailView:buildUI()
	BreachFormMasterDetailView.super.buildUI(self)

	self._txtAlive = self:getTxt("txtAlive")
	self._txtRound = self:getTxt("txtRound")
	self._txtZdl = self:getTxt("txtZdl")
	self._txtCurScore = self:getTxt("txtCurScore")
	self._txtWin = self:getTxt("txtWin")
	self._btnSure = self:getGo("btnSure")
end

function BreachFormMasterDetailView:onExit()
	BreachFormMasterDetailView.super.onExit(self)
end

function BreachFormMasterDetailView:onEnter()
	BreachFormMasterDetailView.super.onEnter(self)

	local params = self:getOpenParam()
	local activityId = checknumber(params[1])
	local data = params[2]

	self._txtAlive.text = checknumber(data.activePetCount)
	self._txtZdl.text = data.zdlDiffScore
	self._txtRound.text = data.circleCount
	self._txtWin.text = data.defenseScore

	local totalScore = data.defenseScore + data.zdlDiffScore + data.activePetCount + data.circleCount

	self._txtCurScore.text = langPara("本次积分:<color=#148757FF>%s</color>", totalScore)
end

return BreachFormMasterDetailView
