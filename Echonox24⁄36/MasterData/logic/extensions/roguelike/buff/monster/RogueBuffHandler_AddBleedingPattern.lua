-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_AddBleedingPattern.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_AddBleedingPattern", package.seeall)

local M = class("RogueBuffHandler_AddBleedingPattern", RogueBaseBuffHandler)
local PATTERN = RoguelikeConst.DICE_PATTERN

function M:ctor()
	return
end

function M:onAdd(entity, buffMO)
	local params = string.split(buffMO:getParams(), "|")
	local count = tonumber(params[1])
	local level = tonumber(params[2])

	self._count = count
	self._level = level or 1

	local isFirst = RogueMgr.instance:getModel():getIsFirstRondRoleIndex()
	local hadArchivePattern = #RogueMgr.instance:getStateMgr():getArchivePattern() > 0

	if not isFirst or hadArchivePattern then
		return
	end

	local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
	local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)

	local patterns = {}

	for j = 1, count do
		table.insert(patterns, self:getPatternByLevel(self._level))
	end

	RogueMgr.instance:getStateMgr():addTempExtraPattern(patterns)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_EXTRA_PATTERN)
end

function M:onEffectTrigger(diceCount, param)
	local patterns = {}

	for j = 1, param do
		table.insert(patterns, self:getPatternByLevel(self._level))
	end

	RogueMgr.instance:getStateMgr():addTempExtraPattern(patterns)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_EXTRA_PATTERN)
end

function M:getPatternByLevel(level)
	if level == 1 then
		return PATTERN.BLEEDING
	elseif level == 2 then
		return PATTERN.BLEEDING_2
	elseif level == 3 then
		return PATTERN.BLEEDING_3
	elseif level == 4 then
		return PATTERN.BLEEDING_4
	elseif level == 5 then
		return PATTERN.BLEEDING_5
	elseif level == 6 then
		return PATTERN.BLEEDING_6
	end
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
		local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)

		local patterns = {}

		for j = 1, self._count do
			table.insert(patterns, self:getPatternByLevel(self._level))
		end

		RogueMgr.instance:getStateMgr():addTempExtraPattern(patterns)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_EXTRA_PATTERN)
	end
end

function M:onRemove(entity, buffMO)
	RogueMgr.instance:getStateMgr():removeTempExtraPattern()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_EXTRA_PATTERN)
end

return M
