-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/roguelike/TaskRoguelikeInOneGame.lua

module("logic.extensions.task.util.impl.roguelike.TaskRoguelikeInOneGame", package.seeall)

local M = class("TaskRoguelikeInOneGame")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1

	return tempStr, maxCount
end

return M
