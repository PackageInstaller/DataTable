-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/monument/TaskCrossChamberTimeAtHomePage.lua

module("logic.extensions.task.util.impl.monument.TaskCrossChamberTimeAtHomePage", package.seeall)

local M = class("TaskCrossChamberTimeAtHomePage")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 1 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code)
		end

		return tempStr, maxCount
	end

	maxCount = tonumber(paramArray[1])
	tempStr = string.gsub(tempStr, "#1#", maxCount)

	return tempStr, maxCount
end

return M
