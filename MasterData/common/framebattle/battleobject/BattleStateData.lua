-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\BattleStateData.lua

local StateData = require("ClientData/ResBattleState")
local BattleStateData = {}
local levelMap = {}

local function getMaxLevel(level, levelDict)
	for i = level, 1, -1 do
		if levelDict[i] then
			return i
		end
	end

	return nil
end

function BattleStateData.getStateData(stateId, stateLevel)
	local data = StateData[stateId]

	if data then
		local level = stateLevel
		local stateLevelMap = levelMap[stateId]

		if stateLevelMap and stateLevelMap[level] then
			level = stateLevelMap[level]
		elseif not data[level] then
			local maxLevel = getMaxLevel(level, data)

			if maxLevel then
				if stateLevelMap then
					stateLevelMap[level] = maxLevel
				else
					levelMap[stateId] = {}
					levelMap[stateId][level] = maxLevel
				end

				level = maxLevel
			end
		end

		return data[level] or {}
	end

	return {}
end

return BattleStateData
