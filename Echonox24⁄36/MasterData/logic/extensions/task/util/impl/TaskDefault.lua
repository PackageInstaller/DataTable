-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/TaskDefault.lua

module("logic.extensions.task.util.impl.TaskDefault", package.seeall)

local M = class("TaskDefault")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 0
	local paramArray = string.split(param, "#")

	maxCount = tonumber(paramArray[1])

	for i = 1, 10 do
		if string.nilorempty(paramArray[i]) then
			break
		else
			local subStr = string.format("#%s#", i)

			tempStr = string.gsub(tempStr, subStr, paramArray[i])
		end
	end

	return tempStr, maxCount
end

return M
