-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/gameplay/RogueGamePlay.lua

module("logic.extensions.roguelike.gameplay.RogueGamePlay", package.seeall)

local M = class("RogueGamePlay")
local StateType = RoguelikeConst.ROGUE_GAME_STATE
local GameStateMap = {
	[StateType.INIT] = RogueGameStateInit,
	[StateType.BEFORE_JUDGE] = RogueGameStateBeforeJudge,
	[StateType.ROLLING] = RogueGameStateRolling,
	[StateType.ROLLING_END] = RogueGameStateRollingEnd,
	[StateType.ROLE_CHANGE] = RogueGameStateRoleChange,
	[StateType.RESULT] = RogueGameStateResult
}

function M:ctor()
	self._curState = nil
	self._lastState = nil
	self._allStates = nil
end

function M:getCurState()
	return self._curState
end

function M:getLastState()
	return self._lastState
end

function M:init()
	self:initGameStates()
end

function M:initGameStates()
	self._allStates = {}

	for k, v in pairs(GameStateMap) do
		local state = v.New()

		state:init(self)

		self._allStates[k] = state
	end
end

function M:isGameState(gameState)
	if not self._curState then
		return false
	end

	return gameState == self._curState:getGameState()
end

function M:getGameState(gameState)
	return self._allStates[gameState]
end

function M:changeState(newState)
	local state = self._allStates[newState]

	if state == nil then
		print("没有对应状态", newState)

		return
	end

	if self._curState == nil or self._curState ~= state then
		self._lastState = self._curState

		if self._lastState ~= nil then
			self._lastState:onStateExit(state)
		end

		self._curState = state

		state:onStateEnter(self._lastState)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_STATE_CHANGE_EVENT, {
			curState = self._curState:getGameState(),
			lastState = self._lastState ~= nil and self._lastState:getGameState() or nil
		})
	end
end

function M:update()
	if self._curState ~= nil then
		self._curState:update()
	end
end

function M:release()
	for k, v in pairs(self._allStates) do
		v:release()
	end
end

return M
