-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_RoundEnd2Injured.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_RoundEnd2Injured", package.seeall)

local M = class("RogueBuffHandler_RoundEnd2Injured", RogueBaseBuffHandler)

function M:ctor()
	self._triggerEvent = EventType.ROGUE_ROUND_END
end

function M:onAdd(entity, buffMO)
	entity.monsterProp:setIsHpImmuneAttack(true)
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		entity.monsterProp:reduceHp(1)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MONSTER_HP_ANI, entity.monsterProp:getId(), 1)

		local efffectId = tonumber(buffMO:getParams())

		if efffectId and efffectId ~= 0 then
			RoguelikeController.instance:execEffectIds({
				efffectId
			})
		end

		local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
		local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
	end
end

function M:onRemove(entity, buffMO)
	entity.monsterProp:setIsHpImmuneAttack(false)
end

return M
