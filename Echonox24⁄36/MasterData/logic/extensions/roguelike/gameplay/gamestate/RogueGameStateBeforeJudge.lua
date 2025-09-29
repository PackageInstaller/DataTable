-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/gameplay/gamestate/RogueGameStateBeforeJudge.lua

module("logic.extensions.roguelike.gameplay.gamestate.RogueGameStateBeforeJudge", package.seeall)

local M = class("RogueGameStateBeforeJudge", IRogueGameState)

function M:ctor()
	self._gameState = RoguelikeConst.ROGUE_GAME_STATE.BEFORE_JUDGE
end

function M:onStateEnter(lastState)
	local selectProp = RogueMgr.instance:getRogueFlow().model:getSelectProp()

	if not selectProp then
		RogueMgr.instance:getRogueFlow().model:setSelectProp(1)
		self._gamePlay:changeState(RoguelikeConst.ROGUE_GAME_STATE.ROLLING)
	else
		self._gamePlay:changeState(RoguelikeConst.ROGUE_GAME_STATE.ROLLING)
	end
end

function M:onStateExit(newState)
	return
end

function M:update()
	return
end

function M:onInit()
	return
end

function M:onRelease()
	return
end

return M
