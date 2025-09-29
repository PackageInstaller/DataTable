-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskWakeup.lua

module("logic.extensions.task.util.impl.role.TaskWakeup", package.seeall)

local M = class("TaskWakeup")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local heroId = tonumber(param)
	local heroInfo = PastInfoConfig.instance:getCharacterInfo(heroId)

	if heroInfo == nil then
		printError(string.format("invalid heroId %s, code %s", heroId, code))

		return tempStr, 1
	end

	tempStr = string.gsub(tempStr, "#1#", heroInfo.name)

	return tempStr, 1
end

return M
