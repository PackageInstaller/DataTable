-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_RoundEndAddAttr.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_RoundEndAddAttr", package.seeall)

local M = class("RogueBuffHandler_RoundEndAddAttr", RogueBaseBuffHandler)

function M:ctor()
	self._triggerEvent = EventType.ROGUE_ROUND_END
	self._curAddRound = 0
end

function M:onAdd(entity, buffMO)
	self:updatePatterns(entity, buffMO)
end

function M:updatePatterns(entity, buffMO, isRoundEnd)
	local additionRound = RogueMgr.instance:getStateMgr():getRoundIndex()

	additionRound = isRoundEnd and additionRound or additionRound - 1

	local curAttr = RogueMgr.instance:getStateMgr():getMonsterAttrBase()
	local maxCount = tonumber(buffMO:getParams())

	additionRound = math.min(additionRound, maxCount)

	if curAttr ~= additionRound then
		RogueMgr.instance:getStateMgr():setMonsterAttrBase(additionRound)

		local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
		local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
	end

	self._curAddRound = additionRound
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		self:updatePatterns(entity, buffMO, true)
	end
end

function M:onRemove(entity, buffMO)
	RogueMgr.instance:getStateMgr():setMonsterAttrBase(0)

	self._curAddRound = 0
end

return M
