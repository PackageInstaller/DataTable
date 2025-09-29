-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/bag/TaskGetEchoId.lua

module("logic.extensions.task.util.impl.bag.TaskGetEchoId", package.seeall)

local M = class("TaskGetEchoId")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local echoId = tonumber(param)

	if not echoId then
		if enableErrorLog then
			printError("Invalid parameter with code:", code)
		end

		return tempStr, maxCount
	end

	local itemName = false
	local itemCO = BackpackConfig.instance:getItemInfoByItemId(echoId)

	if itemCO then
		itemName = itemCO.name
	end

	tempStr = string.gsub(desc, "#1#", itemName)

	return tempStr, maxCount
end

return M
