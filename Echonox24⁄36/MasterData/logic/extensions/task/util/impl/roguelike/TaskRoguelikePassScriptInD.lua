-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/roguelike/TaskRoguelikePassScriptInD.lua

module("logic.extensions.task.util.impl.roguelike.TaskRoguelikePassScriptInD", package.seeall)

local M = class("TaskRoguelikePassScriptInD")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 3 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code)
		end

		return tempStr, maxCount
	end

	maxCount = tonumber(paramArray[1])

	local scriptId = tonumber(paramArray[2])
	local level = tonumber(paramArray[3])
	local cfgScript = RoguelikeConfig.instance:getScriptById(scriptId)
	local cfgLv = RoguelikeConfig.instance:getDiffLevelByLevel(level, scriptId)
	local nameScript = cfgScript and cfgScript.name or ""
	local nameDifficulty = cfgLv and cfgLv.name or ""

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", nameScript)
	tempStr = string.gsub(tempStr, "#3#", nameDifficulty)

	return tempStr, maxCount
end

return M
