-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_RoundEndAddBleed.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_RoundEndAddBleed", package.seeall)

local M = class("RogueBuffHandler_RoundEndAddBleed", RogueBaseBuffHandler)

function M:ctor()
	self._triggerEvent = EventType.ROGUE_ROUND_END
	self._curAddRound = 0
end

function M:onAdd(entity, buffMO)
	return
end

function M:updatePatterns(entity, buffMO, isRoundEnd)
	local additionRound = RogueMgr.instance:getStateMgr():getRoundIndex() - 1

	if isRoundEnd then
		additionRound = additionRound + 1
	end

	if self._curAddRound == additionRound then
		return
	end

	local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
	local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)

	local count = additionRound
	local patterns = {}

	for i = 1, count do
		table.insert(patterns, RoguelikeConst.DICE_PATTERN.BLEEDING)
	end

	RogueMgr.instance:getStateMgr():addTempExtraPattern(patterns)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_EXTRA_PATTERN)

	self._curAddRound = additionRound
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		self:updatePatterns(entity, buffMO, true)
	end
end

function M:onRemove(entity, buffMO)
	RogueMgr.instance:getStateMgr():removeTempExtraPattern()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_EXTRA_PATTERN)

	self._curAddRound = 0
end

return M
