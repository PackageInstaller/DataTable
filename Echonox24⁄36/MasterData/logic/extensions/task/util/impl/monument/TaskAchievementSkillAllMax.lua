-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/monument/TaskAchievementSkillAllMax.lua

module("logic.extensions.task.util.impl.monument.TaskAchievementSkillAllMax", package.seeall)

local M = class("TaskAchievementSkillAllMax")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1

	return tempStr, maxCount
end

return M
