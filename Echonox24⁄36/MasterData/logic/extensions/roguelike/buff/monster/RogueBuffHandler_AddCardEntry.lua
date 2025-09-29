-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_AddCardEntry.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_AddCardEntry", package.seeall)

local M = class("RogueBuffHandler_AddCardEntry", RogueBaseBuffHandler)
local PATTERN = RoguelikeConst.DICE_PATTERN

function M:ctor()
	return
end

function M:onAdd(entity, buffMO)
	local params = string.split(buffMO:getParams(), "|")
	local entryId = tonumber(params[1])
	local count = tonumber(params[2]) or 1

	for i = 1, count do
		RogueMgr.instance:getRogueFlow().stateMgr:addContinueCardEntries(entryId)
	end
end

function M:onEffectTrigger(diceCount, param)
	return
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		-- block empty
	end
end

function M:onRemove(entity, buffMO)
	return
end

return M
