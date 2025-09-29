-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/tacit/TaskHeroSolo.lua

module("logic.extensions.task.util.impl.tacit.TaskHeroSolo", package.seeall)

local M = class("TaskHeroSolo")

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

	local levelId = tonumber(paramArray[1])
	local id = tonumber(paramArray[2])
	local partnerId = tonumber(paramArray[3])

	id = id == -1 and heroId or id

	local dungeonName = ""
	local dungeonCO = DungeonConfig.instance:getDungeonCfgById(levelId)

	if dungeonCO then
		dungeonName = dungeonCO.name
	end

	local name = ""
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(id)

	if heroInfoCO then
		name = heroInfoCO.name
	end

	local partnerName = ""

	if partnerId > 0 then
		local heroInfoCO2 = PastInfoConfig.instance:getCharacterInfo(partnerId)

		if heroInfoCO2 then
			partnerName = heroInfoCO2.name
		end
	end

	tempStr = string.gsub(tempStr, "#1#", dungeonName)
	tempStr = string.gsub(tempStr, "#2#", name)
	tempStr = string.gsub(tempStr, "#3#", partnerName)

	return tempStr, maxCount
end

return M
