-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/roguelike/TaskRoguelikeCollect.lua

module("logic.extensions.task.util.impl.roguelike.TaskRoguelikeCollect", package.seeall)

local M = class("TaskRoguelikeCollect")

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

	local cfgGallery = RoguelikeConfig.instance:getGalleryById(tonumber(paramArray[2]))
	local galleryName = cfgGallery and cfgGallery.name or ""
	local type = tonumber(paramArray[3])
	local typeName = lang(string.format("tip_task_roguelike_collect_%s", type))
	local percent = string.format("%s%%", paramArray[1])

	tempStr = string.gsub(tempStr, "#1#", percent)
	tempStr = string.gsub(tempStr, "#2#", galleryName)
	tempStr = string.gsub(tempStr, "#3#", typeName)

	return tempStr, maxCount
end

return M
