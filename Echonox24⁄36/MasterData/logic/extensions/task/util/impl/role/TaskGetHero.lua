-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskGetHero.lua

module("logic.extensions.task.util.impl.role.TaskGetHero", package.seeall)

local M = class("TaskGetHero")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 4 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code)
		end

		return tempStr, maxCount
	end

	maxCount = tonumber(paramArray[1])

	local rarity = paramArray[2]
	local camp = paramArray[3]
	local career = paramArray[4]
	local rarityName = false
	local campName = false
	local careerName = false

	return tempStr, maxCount, true
end

return M
