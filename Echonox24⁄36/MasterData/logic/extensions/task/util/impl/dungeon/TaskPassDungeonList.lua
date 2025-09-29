-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/dungeon/TaskPassDungeonList.lua

module("logic.extensions.task.util.impl.dungeon.TaskPassDungeonList", package.seeall)

local M = class("TaskPassDungeonList")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local dungeonNameLst = {}
	local paramArray = string.split(param, "#")
	local len = paramArray and #paramArray or 0

	if len == 2 then
		maxCount = tonumber(paramArray[1])

		for w in string.gmatch(paramArray[2], "%d+") do
			local dungeonCo = DungeonConfig.instance:getDungeonCfgById(tonumber(w))

			if dungeonCo then
				table.insert(dungeonNameLst, dungeonCo.name)
			end
		end
	elseif enableErrorLog then
		printError("Invalid parameter with code:", code)
	end

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", table.concat(dungeonNameLst, "、"))

	return tempStr, maxCount
end

return M
