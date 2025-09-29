-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/prop/RogueBuffHandler_ChangeJudgeDifficulty.lua

module("logic.extensions.roguelike.buff.prop.RogueBuffHandler_ChangeJudgeDifficulty", package.seeall)

local M = class("RogueBuffHandler_ChangeJudgeDifficulty", RogueBaseBuffHandler)

function M:ctor()
	self._triggerEvent = EventType.ROGUE_MONSTER_COMBAT_BEGIN
end

function M:onAdd(entity, buffMO)
	return
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		local param = string.split(buffMO:getParams(), "#")

		if #param == 0 then
			printError("效果配置有误", buffMO:getId())

			return
		end

		local judgeType = param[1]
		local changeNum = tonumber(param[2])

		if judgeType == "MONSTER" then
			local msg = lang("tip_monster_power_change" .. changeNum)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
			print("怪物战力变化", changeNum)
			RogueMgr.instance:getModel():setMonsterChangeFight(changeNum + RogueMgr.instance:getModel():getMonsterChangeFight())
		elseif judgeType == "EVENT" then
			local msg = lang("tip_event_difficulty_change" .. changeNum)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
			print("事件难度变化", changeNum)
			RogueMgr.instance:getModel():setEventChangeDifficulty(changeNum)
		end

		print("判定属性变化", judgeType, changeNum)

		return true
	end
end

function M:onRemove(entity, buffMO)
	return
end

return M
