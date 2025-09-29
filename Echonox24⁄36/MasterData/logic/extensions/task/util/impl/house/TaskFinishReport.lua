-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/house/TaskFinishReport.lua

module("logic.extensions.task.util.impl.house.TaskFinishReport", package.seeall)

local M = class("TaskFinishReport")

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

	local lv = tonumber(paramArray[2])

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", self:_level2Name(lv))

	return tempStr, maxCount
end

function M:_level2Name(lv)
	local tempStr = {
		"正常",
		"良好",
		"优秀",
		"完美"
	}

	return tempStr[lv] or "nil"
end

return M
