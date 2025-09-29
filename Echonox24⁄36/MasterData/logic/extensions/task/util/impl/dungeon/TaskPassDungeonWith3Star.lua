-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/dungeon/TaskPassDungeonWith3Star.lua

module("logic.extensions.task.util.impl.dungeon.TaskPassDungeonWith3Star", package.seeall)

local M = class("PassDungeonWith3Star")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local dungeonId = tonumber(param)

	if not dungeonId then
		if enableErrorLog then
			printError("Invalid parameter with code:", code)
		end

		return tempStr, maxCount
	end

	local dungeonName = TaskUtil.getDungeonFormatName(dungeonId)

	if not string.nilorempty(dungeonName) then
		tempStr = string.gsub(tempStr, "#1#", dungeonName)
	end

	return tempStr, maxCount
end

return M
