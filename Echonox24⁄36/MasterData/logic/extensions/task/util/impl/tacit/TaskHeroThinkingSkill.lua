-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/tacit/TaskHeroThinkingSkill.lua

module("logic.extensions.task.util.impl.tacit.TaskHeroThinkingSkill", package.seeall)

local M = class("TaskHeroThinkingSkill")

function M:parseContent(code, desc, param, heroId)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 2 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code)
		end

		return tempStr, maxCount
	end

	local id = tonumber(paramArray[1])
	local thinkingId = tonumber(paramArray[2])

	id = id == -1 and heroId or id

	local name = ""
	local thinkingCO = ThinkingConfig.instance:getThinkingCO(thinkingId)

	if thinkingCO then
		name = thinkingCO.name
	end

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", name)

	return tempStr, maxCount
end

return M
