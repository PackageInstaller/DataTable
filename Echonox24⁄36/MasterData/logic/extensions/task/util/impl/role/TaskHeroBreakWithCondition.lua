-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskHeroBreakWithCondition.lua

module("logic.extensions.task.util.impl.role.TaskHeroBreakWithCondition", package.seeall)

local M = class("TaskHeroBreakWithCondition")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	maxCount = tonumber(paramArray[1])

	return tempStr, maxCount
end

return M
