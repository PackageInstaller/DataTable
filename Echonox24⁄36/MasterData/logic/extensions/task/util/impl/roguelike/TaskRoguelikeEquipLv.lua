-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/roguelike/TaskRoguelikeEquipLv.lua

module("logic.extensions.task.util.impl.roguelike.TaskRoguelikeEquipLv", package.seeall)

local M = class("TaskRoguelikeEquipLv")

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

	local cfgItem = BackpackConfig.instance:getItemInfoByItemId(tonumber(paramArray[2]))
	local name = cfgItem and cfgItem.name or ""

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", name)

	return tempStr, maxCount
end

return M
