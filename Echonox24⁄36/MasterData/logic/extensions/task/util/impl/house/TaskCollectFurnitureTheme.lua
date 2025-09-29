-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/house/TaskCollectFurnitureTheme.lua

module("logic.extensions.task.util.impl.house.TaskCollectFurnitureTheme", package.seeall)

local M = class("TaskCollectFurnitureTheme")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local themeId = tonumber(param)
	local co = LivingFacilitiesConfig.instance:getConfigByKey(ConfigName.HouseFurnitureTheme, themeId)

	if co then
		tempStr = string.gsub(tempStr, "#1#", co.name)
	end

	return tempStr, maxCount
end

return M
