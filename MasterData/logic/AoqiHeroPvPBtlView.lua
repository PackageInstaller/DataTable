-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroPvPBtlView.lua

module("logic.extensions.aoqihero.view.AoqiHeroPvPBtlView", package.seeall)

local AoqiHeroPvPBtlView = class("AoqiHeroPvPBtlView", AoQiHeroBattleView)
local STATE_GAME_RUNING = 1
local STATE_BIG_ROUND_START = 2
local STATE_CAN_OPERATE = 5
local STATE_BLOCK = 14
local STATE_GAME_END = 15

function AoqiHeroPvPBtlView:ctor()
	AoqiHeroPvPBtlView.super.ctor(self)
end

function AoqiHeroPvPBtlView:unbindEvents()
	AoqiHeroPvPBtlView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnExitRoom)
end

function AoqiHeroPvPBtlView:bindEvents()
	AoqiHeroPvPBtlView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnExitRoom, self._onClickExitRoom, self)
end

function AoqiHeroPvPBtlView:buildUI()
	AoqiHeroPvPBtlView.super.buildUI(self)

	self._waitResult = self:getGo("waitResult")
	self._btnExitRoom = self:getGo("waitResult/btnExitRoom")
end

function AoqiHeroPvPBtlView:onExit()
	AoqiHeroPvPBtlView.super.onExit(self)
end

function AoqiHeroPvPBtlView:onEnter()
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroBattleStartRes, self._PM_AoQiHeroBattleStartRes, self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroSyncBattleRes, self._PM_AoQiHeroSyncBattleRes, self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroPvPLeaveRoomRes, self._PM_AoQiHeroPvPLeaveRoomRes, self)
	self._stateMachine:startTimer()

	self._activityId = checknumber(self:getFirstParam())

	local opponentInfo = AoQiHeroModel.instance:getPvPOpInfo()

	self._creepsMasterId = opponentInfo.opDefCreepsMasterId
	self._petEffect = {}
	self._petBuffTableDir = {}

	self._stateMachine:gotoState(STATE_GAME_RUNING)
	GameUtil.SetActive(self._gridCell, false)
	GameUtil.SetActive(self._enemyCell, false)
	GameUtil.SetActive(self._damagesText, false)
	GameUtil.SetActive(self._damageTextCell, false)
	GameUtil.SetActive(self._waitResult, false)
end

function AoqiHeroPvPBtlView:initMgr()
	AoQiHeroBuffMgr.instance:initData(self._activityId)
	AoQiHeroBattleModel.instance:initMapData(self._activityId, self._creepsMasterId)
	AoQiHeroEntityMgr.instance:initPvPData(self._activityId, self._creepsMasterId)
	AoQiHeroSkillMgr.instance:initData(self._activityId)
	AoQiHeroRoundMgr.instance:initData(self._activityId)
	AoQiHeroBattleModel.instance:initMapSet()

	local teamCfg = AoQiHeroConfig.instance:getTeamCfg(self._activityId, self._creepsMasterId)

	self._roundTime = teamCfg.roundTime
	self._maxRoundLimit = teamCfg.roundLimit
end

function AoqiHeroPvPBtlView:_initBlock()
	if self:_checkGameEnd() then
		if self._isMidLeave == true then
			local towerMo = AoQiHeroEntityMgr.instance:getPet(AoQiHeroConst.TowerEntityId)

			towerMo.curHp = 0
		end

		AoQiHeroController.instance:sendPM_AoQiHeroSyncBattleReq(self._activityId, AoQiHeroRoundMgr.instance:getBigRound(), self._winner == AoQiHeroConst.AttackTeam)
	else
		AoQiHeroController.instance:sendPM_AoQiHeroSyncBattleReq(self._activityId, AoQiHeroRoundMgr.instance:getBigRound())
	end
end

function AoqiHeroPvPBtlView:_initGameEnd()
	local winner = self._winner

	if winner then
		self:_checkBattleEnd()
		self:_onGameEnd()
	end
end

function AoqiHeroPvPBtlView:_checkBattleEnd()
	GameUtil.SetActive(self._waitResult, true)
end

function AoqiHeroPvPBtlView:_onClickClose()
	if self._isPlaying == true or self._stateMachine.currStateName ~= STATE_CAN_OPERATE and self._stateMachine.currStateName ~= STATE_GAME_END then
		return
	end

	TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否中途退出，视作战斗失败"), function()
		if self._isPlaying == true or self._stateMachine.currStateName ~= STATE_CAN_OPERATE and self._stateMachine.currStateName ~= STATE_GAME_END then
			FloatWordMgr.instance:show(lang("正在回合中，请在可操作时间内退出"))

			return
		end

		self._isMidLeave = true

		self._stateMachine:gotoState(STATE_BLOCK)
	end)
end

function AoqiHeroPvPBtlView:_onClickExitRoom()
	GameUtil.SetActive(self._waitResult, false)
	AoQiHeroAgent.instance:sendPM_AoQiHeroPvPLeaveRoomReq()
	AoQiHeroController.instance:endBattle()
end

function AoqiHeroPvPBtlView:_onClickTips()
	local ruleCfgs = AoQiHeroConfig.instance:getImageRuleCfg(3)
	local list = {}

	for i, v in ipairs(ruleCfgs) do
		table.insert(list, {
			url = v.resName,
			desc = v.desc
		})
	end

	TipsFacade.instance:openImageRuleView(list, ruleCfgs[1].title)
end

function AoqiHeroPvPBtlView:_PM_AoQiHeroPvPLeaveRoomRes()
	self._stateMachine:gotoState(STATE_GAME_END)
	AoQiHeroController.instance:endBattle()
end

function AoqiHeroPvPBtlView:_PM_AoQiHeroSyncBattleRes()
	if self._winner then
		self._stateMachine:gotoState(STATE_GAME_END)
	else
		self._stateMachine:gotoState(STATE_BIG_ROUND_START)
	end
end

return AoqiHeroPvPBtlView
