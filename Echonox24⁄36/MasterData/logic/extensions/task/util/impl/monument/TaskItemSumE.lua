-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/monument/TaskItemSumE.lua

module("logic.extensions.task.util.impl.monument.TaskItemSumE", package.seeall)

local M = class("TaskItemSumE")

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

	local itemId = tonumber(paramArray[2])
	local name = ""
	local itemCO = BackpackConfig.instance:getItemInfoByItemId(itemId)

	if itemCO then
		name = itemCO.name
	end

	tempStr = string.gsub(tempStr, "#2#", name)
	tempStr = string.gsub(tempStr, "#1#", paramArray[1])

	return tempStr, maxCount
end

return M
