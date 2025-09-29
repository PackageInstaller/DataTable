-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/cardentryhandler/RogueCardDiceEclipseHandler.lua

module("logic.extensions.roguelike.flow.component.handler.cardentryhandler.RogueCardDiceEclipseHandler", package.seeall)

local M = class("RogueCardDiceEclipseHandler", IRogueCardEntryHandler)

function M:onInit()
	self._effectTime = RoguelikeConst.CARD_ENTRY_EFFECT_TIME.CREATE_DICE
end

function M:execEntry(entryCo, judgeHandler)
	local params = string.split(entryCo.effect, "#")
	local msg = entryCo.desc

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)

	return {
		RoguelikeConst.DICE_PATTERN.REDUCE_WISDOM,
		tonumber(params[2])
	}
end

function M:getEffectParam(entryCo)
	local params = string.split(entryCo.effect, "#")

	return {
		1,
		RoguelikeConst.DICE_PATTERN.REDUCE_WISDOM,
		tonumber(params[2])
	}
end

return M
