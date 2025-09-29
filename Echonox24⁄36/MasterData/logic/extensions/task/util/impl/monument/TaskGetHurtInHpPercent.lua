-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/monument/TaskGetHurtInHpPercent.lua

module("logic.extensions.task.util.impl.monument.TaskGetHurtInHpPercent", package.seeall)

local M = class("TaskGetHurtInHpPercent")

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

	tempStr = string.gsub(tempStr, "#1#", paramArray[1])

	return tempStr, maxCount
end

return M
