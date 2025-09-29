-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_Damage2Fighting.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_Damage2Fighting", package.seeall)

local M = class("RogueBuffHandler_Damage2Fighting", RogueBaseBuffHandler)

function M:ctor()
	self._triggerEvent = EventType.ROGUE_MONSTER_TAKE_DAMAGE
end

function M:onAdd(entity, buffMO)
	return
end

function M:onTrigger(triggerEvent, entity, buffMO, params)
	if M.super.onTrigger(self, triggerEvent) then
		print("执行被动 伤害转战斗力", params)
		RogueMgr.instance:getStateMgr():setAdditionFighting(RogueMgr.instance:getStateMgr():getAdditionFighting() + 1)

		local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
		local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
	end
end

function M:onRemove(entity, buffMO)
	return
end

return M
