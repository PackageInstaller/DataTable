-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/dungeon/TaskPassDungeonChapter.lua

module("logic.extensions.task.util.impl.dungeon.TaskPassDungeonChapter", package.seeall)

local M = class("TaskPassDungeonChapter")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 3 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code)
		end

		return tempStr, maxCount
	end

	maxCount = tonumber(paramArray[1])

	local chapter = tonumber(paramArray[2])
	local type = tonumber(paramArray[3])

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", chapter)
	tempStr = string.gsub(tempStr, "#3#", DungeonEnum.DifficultyName[type])

	return tempStr, maxCount
end

return M
