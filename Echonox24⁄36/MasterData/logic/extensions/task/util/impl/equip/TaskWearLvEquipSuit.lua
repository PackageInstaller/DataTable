-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/equip/TaskWearLvEquipSuit.lua

module("logic.extensions.task.util.impl.equip.TaskWearLvEquipSuit", package.seeall)

local M = class("TaskWearLvEquipSuit")

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

	local heroId = tonumber(paramArray[1])
	local quality = tonumber(paramArray[2])
	local level = tonumber(paramArray[3])
	local suitId = tonumber(paramArray[4])
	local name = ""

	if heroId ~= TaskEnum.Const.Any then
		local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(heroId)

		if heroInfoCO then
			name = heroInfoCO.name
		end
	end

	local suitName = ""

	if suitId ~= TaskEnum.Const.Any then
		local cfgSuit = EquipmentConfig.instance:getConfigByKey(ConfigName.EquipmentSuit, suitId)

		suitName = cfgSuit and cfgSuit.name or suitName
	end

	local qualityName = CommEnum.Quality2Name[quality]

	tempStr = string.gsub(tempStr, "#1#", name)
	tempStr = string.gsub(tempStr, "#2#", qualityName)
	tempStr = string.gsub(tempStr, "#3#", level)
	tempStr = string.gsub(tempStr, "#4#", suitName)

	return tempStr, maxCount
end

return M
