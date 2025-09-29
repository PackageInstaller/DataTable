-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/roguelike/TaskRoguelikeKillEnemy.lua

module("logic.extensions.task.util.impl.roguelike.TaskRoguelikeKillEnemy", package.seeall)

local M = class("TaskRoguelikeKillEnemy")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 2 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code)
		end

		return tempStr, maxCount
	end

	maxCount = tonumber(paramArray[1])

	local monsterId = tonumber(paramArray[2])
	local name = false
	local monsterCO = RoguelikeConfig.instance:getRoguelikeMonsterById(monsterId)

	if monsterCO then
		name = monsterCO.name
	end

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", name or monsterId)

	return tempStr, maxCount
end

return M
