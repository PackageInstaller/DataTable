-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/house/TaskUpgradeFacility.lua

module("logic.extensions.task.util.impl.house.TaskUpgradeFacility", package.seeall)

local M = class("TaskUpgradeFacility")

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

	local level = tonumber(paramArray[1])
	local roomType = tonumber(paramArray[2])

	maxCount = level
	tempStr = string.gsub(tempStr, "#1#", level)
	tempStr = string.gsub(tempStr, "#2#", lang(HouseMainEnum.RoomTypName[roomType]))

	return tempStr, maxCount
end

return M
