-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_HpReduce2Fight.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_HpReduce2Fight", package.seeall)

local M = class("RogueBuffHandler_HpReduce2Fight", RogueBaseBuffHandler)

function M:ctor()
	self._triggerEvent = EventType.ROGUE_REFRESH_MONSTER_HP
	self._curOffset = 0
end

function M:onAdd(entity, buffMO)
	self._originHp = entity.monsterProp:getOriginHp()
	self._triggerTime = 0

	self:checkEffect(entity)
end

function M:checkEffect(entity)
	if entity.monsterProp:getIsDeath() then
		return
	end

	local curHp = entity.monsterProp:getHp()

	if self._originHp - curHp > self._curOffset then
		self._curOffset = self._originHp - curHp

		RogueMgr.instance:getModel():setMonsterChangeFight(self._curOffset)

		local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
		local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
	end
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		self:checkEffect(entity)
	end
end

function M:onRemove(entity, buffMO)
	RogueMgr.instance:getModel():setMonsterChangeFight(0)
end

return M
