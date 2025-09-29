-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/gameplay/gamestate/IRogueGameState.lua

module("logic.extensions.roguelike.gameplay.gamestate.IRogueGameState", package.seeall)

local M = class("IRogueGameState")

function M:ctor()
	self._gameState = RoguelikeConst.ROGUE_GAME_STATE.NONE
end

function M:getGameState()
	return self._gameState
end

function M:onStateEnter(lastState)
	return
end

function M:onStateExit(newState)
	return
end

function M:update()
	return
end

function M:init(gamePlay)
	self._gamePlay = gamePlay

	self:onInit()
end

function M:onInit()
	return
end

function M:release()
	self._gamePlay = nil

	self:onRelease()
end

function M:onRelease()
	return
end

return M
