-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskHeroUnlockThinking.lua

module("logic.extensions.task.util.impl.role.TaskHeroUnlockThinking", package.seeall)

local M = class("TaskHeroUnlockThinking")

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

	local id = tonumber(paramArray[1])
	local thinkingId = tonumber(paramArray[2])
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(id)
	local thinkingCO = ThinkingConfig.instance:getThinkingCO(thinkingId)
	local nameHero = heroInfoCO and heroInfoCO.name or ""
	local nameThinking = thinkingCO and thinkingCO.name or ""

	tempStr = string.gsub(tempStr, "#1#", nameHero)
	tempStr = string.gsub(tempStr, "#2#", nameThinking)

	return tempStr, maxCount
end

return M
