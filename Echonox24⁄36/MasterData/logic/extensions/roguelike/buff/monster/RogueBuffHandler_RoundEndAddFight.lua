-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_RoundEndAddFight.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_RoundEndAddFight", package.seeall)

local M = class("RogueBuffHandler_RoundEndAddFight", RogueBaseBuffHandler)

function M:ctor()
	self._triggerEvent = EventType.ROGUE_ROUND_END
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		local additionFighting = RogueMgr.instance:getStateMgr():getRoundIndex() - 1
		local params = string.split(buffMO:getParams(), "#")
		local curAddition = tonumber(params[1])
		local maxAddition = tonumber(params[2])

		if maxAddition >= additionFighting + curAddition then
			RogueMgr.instance:getModel():setMonsterChangeFight(additionFighting + curAddition)

			local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
			local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
		else
			RogueMgr.instance:getModel():setMonsterChangeFight(maxAddition)

			if additionFighting ~= maxAddition then
				local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
				local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

				GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
			end
		end
	end
end

function M:onRemove(entity, buffMO)
	return
end

return M
