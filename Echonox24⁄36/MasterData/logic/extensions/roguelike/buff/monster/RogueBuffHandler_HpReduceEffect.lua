-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_HpReduceEffect.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_HpReduceEffect", package.seeall)

local M = class("RogueBuffHandler_HpReduceEffect", RogueBaseBuffHandler)

function M:ctor()
	self._triggerEvent = EventType.ROGUE_REFRESH_MONSTER_HP
end

function M:onAdd(entity, buffMO)
	self._originHp = entity.monsterProp:getOriginHp()
	self._triggerTime = 0
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		local curHp = entity.monsterProp:getHp()

		curHp = curHp + #RogueMgr.instance:getRogueFlow().judgeMgr:getCurRoundCombatDice()

		local params = buffMO:getBuffCO().params

		params = string.split(params, "#")

		local offset = tonumber(params[1])
		local effectId = tonumber(params[2])
		local time = math.modf((self._originHp - curHp) / offset)

		if time > self._triggerTime then
			for i = 1, time - self._triggerTime do
				if entity.monsterProp:getIsDeath() then
					return
				end

				RogueMgr.instance:getStateMgr():setAdditionFighting(RogueMgr.instance:getStateMgr():getAdditionFighting() + 1)

				local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
				local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

				GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
			end

			self._triggerTime = time
		end
	end
end

function M:execAttack(effectId)
	if RogueMgr.instance:getIsClientMode() then
		RogueMgr.instance:getModel():attackAllRole(1)
	else
		print("执行效果id", effectId)

		if effectId == nil or effectId == 0 then
			return
		end

		RoguelikeAgent.instance:sendTakeEffectRequest({
			effectId
		}, 0, -1)
	end
end

function M:onRemove(entity, buffMO)
	return
end

return M
