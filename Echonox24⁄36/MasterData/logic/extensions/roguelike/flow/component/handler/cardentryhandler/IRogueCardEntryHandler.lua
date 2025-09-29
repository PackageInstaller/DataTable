-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/cardentryhandler/IRogueCardEntryHandler.lua

module("logic.extensions.roguelike.flow.component.handler.cardentryhandler.IRogueCardEntryHandler", package.seeall)

local M = class("IRogueCardEntryHandler")

function M:ctor(judgeMgr)
	self._effectTime = RoguelikeConst.CARD_ENTRY_EFFECT_TIME.JUDGE_RESULT

	self:onInit()
end

function M:onInit()
	return
end

function M:execAction(effectTime, entryCo, judgeHandler)
	if effectTime == self._effectTime and entryCo then
		RogueMgr.instance:getRogueFlow().stateMgr:removeClientNextCardEntry(entryCo.id)

		return self:execEntry(entryCo, judgeHandler)
	end
end

function M:execEntry(entryCo, judgeHandler)
	return
end

function M:getEffectParam(entryCo)
	return
end

return M
