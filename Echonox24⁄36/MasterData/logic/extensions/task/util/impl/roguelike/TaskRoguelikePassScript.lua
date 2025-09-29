-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/roguelike/TaskRoguelikePassScript.lua

module("logic.extensions.task.util.impl.roguelike.TaskRoguelikePassScript", package.seeall)

local M = class("TaskRoguelikePassScript")

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

	local scriptId = tonumber(paramArray[2])
	local itemName = false
	local scriptCO = RoguelikeConfig.instance:getScriptById(scriptId)

	if scriptCO then
		itemName = scriptCO.name
	else
		printWarn("任务配置错误，剧本id", scriptId)

		return "", maxCount
	end

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", itemName)

	return tempStr, maxCount
end

return M
