-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_RoundEnd2Death.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_RoundEnd2Death", package.seeall)

local M = class("RogueBuffHandler_RoundEnd2Death", RogueBaseBuffHandler)

function M:ctor()
	self._triggerEvent = EventType.ROGUE_ROUND_END
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		local round = RogueMgr.instance:getStateMgr():getRoundIndex()

		if round >= tonumber(buffMO:getParams()) then
			entity.monsterProp:setHp(0)

			local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
			local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
		end
	end
end

function M:onRemove(entity, buffMO)
	return
end

return M
