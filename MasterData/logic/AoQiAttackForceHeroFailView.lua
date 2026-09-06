-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceHeroFailView.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceHeroFailView", package.seeall)

local AoQiAttackForceHeroFailView = class("AoQiAttackForceHeroFailView", ViewComponent)

function AoQiAttackForceHeroFailView:ctor()
	AoQiAttackForceHeroFailView.super.ctor(self)
end

function AoQiAttackForceHeroFailView:unbindEvents()
	AoQiAttackForceHeroFailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRestart)
	GameUtil.rmClickHandler(self._btnFinish)
end

function AoQiAttackForceHeroFailView:bindEvents()
	AoQiAttackForceHeroFailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRestart, self._onClickRestart, self)
	GameUtil.addClickHandler(self._btnFinish, self._onClickFinish, self)
end

function AoQiAttackForceHeroFailView:buildUI()
	AoQiAttackForceHeroFailView.super.buildUI(self)

	self._btnFinish = self:getGo("btnFinish")
	self._btnRestart = self:getGo("btnRestart")
	self._txtTime = self:getTxt("txtTime")
	self._txtContent = self:getTxt("txtContent")
end

function AoQiAttackForceHeroFailView:onExit()
	AoQiAttackForceHeroFailView.super.onExit(self)
end

function AoQiAttackForceHeroFailView:onEnter()
	AoQiAttackForceHeroFailView.super.onEnter(self)

	local curWaveId = AoQiAttackForceModel.instance:getCurWaveId()
	local prizeWaveId = curWaveId - 1
	local actCfg = AoQiAttackForceModel.instance:getCurActCfg()
	local matType, matId, _ = MaterialMgr.getMatParams(actCfg.heroPrizeKey)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local prizeWaveCfg = AoQiAttackForceConfig.instance:getHeroChallengeWaveClg(actCfg.activityId, prizeWaveId)

	self._txtContent.text = langPara("战斗失败，是否重试？\n若结算退出，可领取%s波次奖励\n获得【%s】×%s", prizeWaveId, matName, (prizeWaveCfg or nil) and prizeWaveCfg.prize)

	local infoCfg = AoQiAttackForceConfig.instance:getHeroChallengeInfoClg(actCfg.activityId)
	local restartTime = AoQiAttackForceModel.instance:getRestartTime()

	self._txtTime.text = langPara("剩余次数：%s/%s", infoCfg.restartTime - restartTime, infoCfg.restartTime)

	GameUtil.SetGray(self._btnRestart, infoCfg.restartTime - restartTime <= 0)
end

function AoQiAttackForceHeroFailView:_onClickRestart()
	local actCfg = AoQiAttackForceModel.instance:getCurActCfg()
	local infoCfg = AoQiAttackForceConfig.instance:getHeroChallengeInfoClg(actCfg.activityId)
	local restartTime = AoQiAttackForceModel.instance:getRestartTime()

	if infoCfg.restartTime - restartTime > 0 then
		self:close()
		AoQiAttackForceModel.instance:restartGame()
		UIStateManager.instance:push(ViewName.AoqiattackbackpackView)
		UIStateManager.instance:popByName(ViewName.AoQiAttackForceGameView)
	else
		FloatWordMgr.instance:show(lang("已无可重试次数"))
	end
end

function AoQiAttackForceHeroFailView:_onClickFinish()
	self:close()
	AoQiAttackForceController.instance:endHeroClg(false)
	UIStateManager.instance:popByName(ViewName.AoQiAttackForceGameView)
end

return AoQiAttackForceHeroFailView
