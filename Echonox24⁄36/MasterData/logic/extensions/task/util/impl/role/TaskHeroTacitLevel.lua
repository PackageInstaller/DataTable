-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskHeroTacitLevel.lua

module("logic.extensions.task.util.impl.role.TaskHeroTacitLevel", package.seeall)

local M = class("TaskHeroTacitLevel")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 2 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code, param)
		end

		return tempStr, 1
	end

	local tacitLevel = tonumber(paramArray[1])
	local heroId = tonumber(paramArray[2])
	local heroInfo = PastInfoConfig.instance:getCharacterInfo(heroId)

	if heroInfo == nil then
		printError(string.format("invalid heroId %s", heroId))

		return tempStr, 1
	end

	tempStr = string.gsub(tempStr, "#1#", tacitLevel)
	tempStr = string.gsub(tempStr, "#2#", heroInfo.name)

	return tempStr, 1
end

return M
