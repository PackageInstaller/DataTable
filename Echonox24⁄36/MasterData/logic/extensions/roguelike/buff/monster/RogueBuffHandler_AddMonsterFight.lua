-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_AddMonsterFight.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_AddMonsterFight", package.seeall)

local M = class("RogueBuffHandler_AddMonsterFight", RogueBaseBuffHandler)

function M:onAdd(entity, buffMO)
	local changeNum = tonumber(buffMO:getParams())

	if changeNum == nil or changeNum == 0 then
		changeNum = 1
	end

	RogueMgr.instance:getModel():setMonsterChangeFight(changeNum + RogueMgr.instance:getModel():getMonsterChangeFight())
end

function M:onRemove(entity, buffMO)
	return
end

return M
