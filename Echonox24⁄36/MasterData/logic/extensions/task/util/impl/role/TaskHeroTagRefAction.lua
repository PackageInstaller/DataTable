-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskHeroTagRefAction.lua

module("logic.extensions.task.util.impl.role.TaskHeroTagRefAction", package.seeall)

local M = class("TaskHeroTagRefAction")

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

	local id = tonumber(paramArray[2])
	local actionCode = tonumber(paramArray[3])
	local name = ""
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(id)

	if heroInfoCO then
		name = heroInfoCO.name
	end

	local skillActionCO = ActiveSkillConfig.instance:getSkillEffectActionCO(actionCode)
	local skillActionName = skillActionCO.name

	tempStr = string.gsub(tempStr, "#2#", name)
	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#3#", skillActionName)

	return tempStr, maxCount
end

return M
