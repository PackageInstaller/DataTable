-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterResultView.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterResultView", package.seeall)

local BreachFormMasterResultView = class("BreachFormMasterResultView", ViewComponent)

function BreachFormMasterResultView:ctor()
	BreachFormMasterResultView.super.ctor(self)
end

function BreachFormMasterResultView:unbindEvents()
	BreachFormMasterResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function BreachFormMasterResultView:bindEvents()
	BreachFormMasterResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function BreachFormMasterResultView:buildUI()
	BreachFormMasterResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtAlive = self:getTxt("txtAlive")
	self._txtHistoryScore = self:getTxt("txtHistoryScore")
	self._txtZdl = self:getTxt("txtZdl")
	self._txtCurScore = self:getTxt("txtCurScore")
	self._txtWin = self:getTxt("txtWin")
	self._txtRace = self:getTxt("txtRace")
	self._txtRound = self:getTxt("txtRound")
end

function BreachFormMasterResultView:onExit()
	BreachFormMasterResultView.super.onExit(self)
end

function BreachFormMasterResultView:onEnter()
	BreachFormMasterResultView.super.onEnter(self)

	local battleResult = BreachFormMasterModel.instance:getBattleResult()

	if not battleResult then
		self:close()
		BattleController.instance:endBattle()

		return
	end

	self._txtAlive.text = BreachFormMasterController.instance:calcAttackActivePetScore(battleResult.activityId, battleResult.activePetCount)
	self._txtZdl.text = checknumber(battleResult.formZdlScore)
	self._txtRace.text = checknumber(battleResult.specifyPetScore)
	self._txtWin.text = checknumber(battleResult.breachSocre)
	self._txtRound.text = checknumber(battleResult.circleScore)

	local hisoryMaxScore = checknumber(battleResult.hisoryMaxScore)
	local curScore = checknumber(battleResult.curScore)

	self._txtCurScore.text = langPara("本次积分：<color=%s>%s</color>", (hisoryMaxScore < curScore or nil) and "#148757FF", curScore)

	local maxScore = curScore < hisoryMaxScore and hisoryMaxScore or curScore

	self._txtHistoryScore.text = langPara("历史最高：%s", maxScore)
end

function BreachFormMasterResultView:_onClickSure()
	self:close()
	BreachFormMasterModel.instance:resetBattleResult()
	BattleController.instance:endBattle()
end

return BreachFormMasterResultView
