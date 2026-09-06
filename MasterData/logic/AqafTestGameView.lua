-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AqafTestGameView.lua

module("logic.extensions.aoqiattackforce.view.AqafTestGameView", package.seeall)

local AqafTestGameView = class("AqafTestGameView", ViewComponent)

function AqafTestGameView:ctor()
	AqafTestGameView.super.ctor(self)
end

function AqafTestGameView:unbindEvents()
	AqafTestGameView.super.unbindEvents(self)
end

function AqafTestGameView:bindEvents()
	AqafTestGameView.super.bindEvents(self)
end

function AqafTestGameView:buildUI()
	AqafTestGameView.super.buildUI(self)

	self._gameMgrGo = self:getGo("gameMgr")
	self._gameMgr = AQAFGameMgr.Get(self._gameMgrGo)
	self._player = self:getGo("gameMgr/player")

	local param = {
		playerGo = self._player
	}

	self._gameMgr:initGameData(param)

	self._txtCurShield = self:getTxt("txtCurShield")
	self._txtCurHp = self:getTxt("txtCurHp")
	self._sldCurShield = self:getSlider("sldCurShield")
	self._sldCurHp = self:getSlider("sldCurHp")
	self._txtCurWave = self:getTxt("txtCurWave")
end

function AqafTestGameView:onExit()
	AqafTestGameView.super.onExit(self)
	self._gameMgr:destroyGame()
end

function AqafTestGameView:onEnter()
	AqafTestGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.AQAFGameSwitchState, self._onSwitchState, self)
	self.addGEvent(self, GlobalNotify.AQAFPlayerGameInfoUpdate, self._updatePlayerInfo, self)
	self._gameMgr:initStageData()
	self._gameMgr:startGame()
	self:_updatePlayerInfo()

	if AoQiAttackForceModel.instance:getIsEndlessState() then
		self._txtCurWave.text = ""
	else
		local curClgCfg = AoQiAttackForceModel.instance:getCurClgCfg()
		local curWaveId = AoQiAttackForceModel.instance:getCurWaveId()
		local totalWaveNum = AoQiAttackForceConfig.instance:getChallengeWaveTotalNums(curClgCfg.activityId, curClgCfg.challengeId)

		self._txtCurWave.text = string.format("第%s/%s波", curWaveId, totalWaveNum)
	end
end

function AqafTestGameView:_updatePlayerInfo()
	local curHP = self._gameMgr.playerUnit:getCurHp()
	local curShield = self._gameMgr.playerUnit:getCurShield()
	local curHpMax = self._gameMgr.playerUnit:getCurHpMax()

	self._txtCurHp.text = curHP
	self._txtCurShield.text = curShield

	self._sldCurShield:SetValue(curShield / curHpMax)
	self._sldCurHp:SetValue(curHP / curHpMax)
end

function AqafTestGameView:_onSwitchState(state)
	if state == AQAFGameEnum.GameState.End then
		AoQiAttackForceModel.instance:calculateAndSaveMaxHP(self._gameMgr.playerUnit:getCurHp(), self._gameMgr.playerUnit:getCurHp())
		AoQiAttackForceController:onEndFight(self._gameMgr:getIsWin())
	end
end

return AqafTestGameView
