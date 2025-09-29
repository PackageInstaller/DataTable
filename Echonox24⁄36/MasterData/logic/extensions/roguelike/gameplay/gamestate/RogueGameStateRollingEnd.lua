-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/gameplay/gamestate/RogueGameStateRollingEnd.lua

module("logic.extensions.roguelike.gameplay.gamestate.RogueGameStateRollingEnd", package.seeall)

local M = class("RogueGameStateRollingEnd", IRogueGameState)

function M:ctor()
	self._gameState = RoguelikeConst.ROGUE_GAME_STATE.ROLLING_END
	self._gambleTimer = 0
end

function M:onStateEnter(lastState)
	print("ROGUE", "结束滚动")

	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()
	local gambleTime = RogueMgr.instance:getGambleTime()

	self._nextState = RoguelikeConst.ROGUE_GAME_STATE.ROLE_CHANGE

	local extraResult = RogueMgr.instance:getRogueFlow().model:getExtraResult()

	if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT or eventType == RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT then
		if gambleTime > 0 and extraResult == nil then
			self._gambleTimer = 3
			self._inCountdown = true

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_GAMBLE_TIME, self._gambleTimer)
			settimer(1, self._countDownTime, self, true)
		else
			self:nextStateAction()
		end
	else
		self:createFightWork(true)
	end
end

function M:_countDownTime()
	self._gambleTimer = self._gambleTimer - 1

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_GAMBLE_TIME, self._gambleTimer)

	if self._gambleTimer == 0 then
		removetimer(self._countDownTime, self)
		self:nextStateAction()

		self._inCountdown = false
	end
end

function M:onGambleSelect(sender, isCancel)
	if not self._inCountdown then
		return
	end

	removetimer(self._countDownTime, self)

	if isCancel and self._inCountdown then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_GAMBLE_TIME, 0)

		self._inCountdown = false

		self:nextStateAction()

		return
	end

	RogueMgr.instance:setGambleTime(0)

	self._nextState = RoguelikeConst.ROGUE_GAME_STATE.BEFORE_JUDGE

	local judgeMgr = RogueMgr.instance:getRogueFlow().judgeMgr
	local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr

	self._playerDices = judgeMgr:getCurRoundPlayerDice()

	for k, v in pairs(self._playerDices) do
		diceMgr:recoveryDiceObj(v:getGo())
	end

	judgeMgr:clearCurRoundPlayerDice()
	self._gamePlay:changeState(self._nextState)
end

function M:nextStateAction()
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	self._nextState = RoguelikeConst.ROGUE_GAME_STATE.ROLE_CHANGE

	if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT then
		self._nextState = RoguelikeConst.ROGUE_GAME_STATE.RESULT

		self:createFightWork()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT then
		self:createFightWork()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT then
		self:createFightWork()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
		self:createFightWork(true)
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.RECTIFY_EVENT then
		self:createFightWork()
	end
end

function M:createFightWork(isFight)
	local work = self:_createWork()

	work:setDoneCaller(self._onWorkFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkRogueJudgeDice.New(isFight))
	sequence:addChild(WorkRogueRoleRollAction.New())
	work:addChild(sequence)
	work:start(self)
end

function M:_onWorkFinish()
	if RogueMgr.instance:getRogueFlow().model:getRoundFinish() then
		self._nextState = RoguelikeConst.ROGUE_GAME_STATE.RESULT
	end

	self._gamePlay:changeState(self._nextState)
end

function M:onStateExit(newState)
	self:_destroyWork()
end

function M:_createWork()
	self:_destroyWork()

	self._workingWork = WorkFlow.New()

	return self._workingWork
end

function M:_destroyWork()
	if self._workingWork then
		self._workingWork:destroy()

		self._workingWork = false
	end
end

function M:update()
	return
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.ROGUE_GAMBLE_SELECT, self.onGambleSelect, self)
end

function M:onRelease()
	GlobalDispatcher:removeEventListener(EventType.ROGUE_GAMBLE_SELECT, self.onGambleSelect, self)
end

return M
