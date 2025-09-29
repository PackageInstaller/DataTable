-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/cardentryhandler/RogueCardThrowResultHandler.lua

module("logic.extensions.roguelike.flow.component.handler.cardentryhandler.RogueCardThrowResultHandler", package.seeall)

local M = class("RogueCardThrowResultHandler", IRogueCardEntryHandler)

function M:onInit()
	self._effectTime = RoguelikeConst.CARD_ENTRY_EFFECT_TIME.DICE_RESULT
end

function M:execEntry(entryCo, judgeHandler)
	local params = string.split(entryCo.effect, "#")
	local msg = entryCo.desc

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)

	return tonumber(params[2])
end

function M:getEffectParam(entryCo)
	local params = string.split(entryCo.effect, "#")

	return {
		2,
		params[1],
		tonumber(params[2])
	}
end

return M
