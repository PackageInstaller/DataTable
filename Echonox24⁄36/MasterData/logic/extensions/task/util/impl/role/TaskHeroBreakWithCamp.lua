-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskHeroBreakWithCamp.lua

module("logic.extensions.task.util.impl.role.TaskHeroBreakWithCamp", package.seeall)

local M = class("TaskHeroBreakWithCamp")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 5 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code)
		end

		return tempStr, maxCount
	end

	maxCount = tonumber(paramArray[1])

	local level = tonumber(paramArray[2])
	local affinity = tonumber(paramArray[3])
	local breakLv = tonumber(paramArray[4])
	local camp = tonumber(paramArray[5])

	return tempStr, maxCount
end

return M
