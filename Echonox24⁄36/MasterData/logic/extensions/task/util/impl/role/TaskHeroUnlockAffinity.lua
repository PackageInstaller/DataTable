-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskHeroUnlockAffinity.lua

module("logic.extensions.task.util.impl.role.TaskHeroUnlockAffinity", package.seeall)

local M = class("TaskHeroUnlockAffinity")

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

	local id = tonumber(paramArray[2])
	local name = ""
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(id)

	if heroInfoCO then
		name = heroInfoCO.name
	end

	tempStr = string.gsub(tempStr, "#2#", name)
	tempStr = string.gsub(tempStr, "#1#", maxCount)

	return tempStr, maxCount
end

return M
