-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/tacit/TaskHeroMakeDamageWithBuff.lua

module("logic.extensions.task.util.impl.tacit.TaskHeroMakeDamageWithBuff", package.seeall)

local M = class("TaskHeroMakeDamageWithBuff")

function M:parseContent(code, desc, param, heroId)
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
	local buffId = tonumber(paramArray[3])

	id = id == -1 and heroId or id

	local name = ""
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(id)

	if heroInfoCO then
		name = heroInfoCO.name
	end

	local buffName = ""
	local buffCO = BuffConfig.instance:getBuffCO(buffId)

	if buffCO then
		buffName = buffCO.name
	end

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", name)
	tempStr = string.gsub(tempStr, "#3#", buffName)

	return tempStr, maxCount
end

return M
