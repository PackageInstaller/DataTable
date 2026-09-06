-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/config/AnchorSimulatorConfig.lua

module("logic.extensions.anchorsimulator.config.AnchorSimulatorConfig", package.seeall)

local AnchorSimulatorConfig = class("AnchorSimulatorConfig", BaseConfig)

function AnchorSimulatorConfig:onInit()
	AnchorSimulatorConfig.super.onInit(self)
end

function AnchorSimulatorConfig:getNames()
	return {
		"anchor_simulator_activity",
		"anchor_simulator_property",
		"anchor_simulator_property_level",
		"anchor_simulator_level",
		"anchor_simulator_buff",
		"anchor_simulator_goal",
		"anchor_simulator_guest",
		"anchor_simulator_rank_prize",
		"anchor_simulator_bullet_screen"
	}
end

function AnchorSimulatorConfig:handleConfig(name, content)
	if name == "anchor_simulator_activity" then
		self._anchor_simulator_activity = content
	elseif name == "anchor_simulator_property" then
		self._anchor_simulator_property = content
	elseif name == "anchor_simulator_property_level" then
		self._anchor_simulator_property_level = content
	elseif name == "anchor_simulator_level" then
		self._anchor_simulator_level = content
	elseif name == "anchor_simulator_buff" then
		self._anchor_simulator_buff = content
	elseif name == "anchor_simulator_goal" then
		self._anchor_simulator_goal = content
	elseif name == "anchor_simulator_guest" then
		self._anchor_simulator_guest = content
	elseif name == "anchor_simulator_rank_prize" then
		self._anchor_simulator_rank_prize = content
	elseif name == "anchor_simulator_bullet_screen" then
		self._anchor_simulator_bullet_screen = content
	end
end

function AnchorSimulatorConfig:getActData(activityId)
	return self._anchor_simulator_activity[activityId]
end

function AnchorSimulatorConfig:getActDataValue(activityId, key, isToNumber)
	local data = self:getActData(activityId)

	if isToNumber then
		return checknumber(data and data[key])
	else
		return data and data[key]
	end
end

function AnchorSimulatorConfig:getStrengthLimit(activityId)
	return self:getActDataValue(activityId, "strengthLimit", true)
end

function AnchorSimulatorConfig:getBreakAddStrength(activityId)
	return self:getActDataValue(activityId, "breakAddStrength", true)
end

function AnchorSimulatorConfig:getStrengthItem(activityId)
	return self:getActDataValue(activityId, "strengthItem")
end

function AnchorSimulatorConfig:getClassLimit(activityId)
	return self:getActDataValue(activityId, "classLimit", true)
end

function AnchorSimulatorConfig:getTrainTimes(activityId)
	return self:getActDataValue(activityId, "trainTimes", true)
end

function AnchorSimulatorConfig:getDailyLiveLimit(activityId)
	return self:getActDataValue(activityId, "dailyLiveLimit", true)
end

function AnchorSimulatorConfig:getBuffRatio(activityId)
	return self:getActDataValue(activityId, "buffRatio", true)
end

function AnchorSimulatorConfig:getClassCostStrength(activityId)
	return self:getActDataValue(activityId, "classCostStrength", true)
end

function AnchorSimulatorConfig:getClassExp(activityId)
	return self:getActDataValue(activityId, "classExp", true)
end

function AnchorSimulatorConfig:getGoalArray(activityId)
	return self:getActDataValue(activityId, "goalArray")
end

function AnchorSimulatorConfig:getPropertyCfg(activityId)
	return self._anchor_simulator_property[activityId]
end

function AnchorSimulatorConfig:getPropertyData(activityId, propertyType)
	if self._anchor_simulator_property[activityId] then
		return self._anchor_simulator_property[activityId][propertyType]
	end
end

function AnchorSimulatorConfig:getPropertyLevelCfg(activityId, propertyType)
	local data = self:getPropertyData(activityId, propertyType)
	local levelPlan = data and data.levelPlan

	if levelPlan then
		return self._anchor_simulator_property_level[levelPlan]
	end
end

function AnchorSimulatorConfig:getPropertyLevelData(activityId, propertyType, level)
	local cfg = self:getPropertyLevelCfg(activityId, propertyType)

	if cfg then
		return cfg[level]
	end
end

function AnchorSimulatorConfig:getPropertyLevelDataByExp(activityId, propertyType, exp)
	local result
	local cfg = self:getPropertyLevelCfg(activityId, propertyType)

	if cfg then
		local low, high = 1, #cfg

		while low <= high do
			local mid = math.floor((low + high) / 2)

			if exp >= cfg[mid].exp then
				result = cfg[mid]
				low = mid + 1
			else
				high = mid - 1
			end
		end
	end

	return result
end

function AnchorSimulatorConfig:getPropertyLevelByExp(activityId, propertyType, exp)
	local data = self:getPropertyLevelDataByExp(activityId, propertyType, exp)

	return (data or nil) and (data.level or 0)
end

function AnchorSimulatorConfig:getPropertyMaxLevel(activityId, propertyType)
	local cfg = self:getPropertyLevelCfg(activityId, propertyType)

	return (cfg or nil) and (#cfg or 0)
end

function AnchorSimulatorConfig:getPropertyExpByLv(activityId, propertyType, level)
	local data = self:getPropertyLevelData(activityId, propertyType, level)

	return (data or nil) and (data.exp or 0)
end

function AnchorSimulatorConfig:getLevelCfg(activityId)
	return self._anchor_simulator_level[activityId]
end

function AnchorSimulatorConfig:getLevelData(activityId, level)
	if self._anchor_simulator_level[activityId] then
		return self._anchor_simulator_level[activityId][level]
	end
end

function AnchorSimulatorConfig:getLevelDataByHeat(activityId, heatValue)
	local result
	local cfg = self:getLevelCfg(activityId)

	if cfg then
		local low, high = 1, #cfg

		while low <= high do
			local mid = math.floor((low + high) / 2)

			if heatValue >= cfg[mid].heatValue then
				result = cfg[mid]
				low = mid + 1
			else
				high = mid - 1
			end
		end
	end

	return result
end

function AnchorSimulatorConfig:getMaxLevel(activityId)
	local cfg = self:getLevelCfg(activityId)

	return (cfg or nil) and (#cfg or 0)
end

function AnchorSimulatorConfig:getBuffCfg(activityId)
	return self._anchor_simulator_buff[activityId]
end

function AnchorSimulatorConfig:getBuffData(activityId, times)
	if self._anchor_simulator_buff[activityId] then
		return self._anchor_simulator_buff[activityId][times]
	end
end

function AnchorSimulatorConfig:getMaxBuffTimes(activityId)
	local cfg = self:getBuffCfg(activityId)

	return (cfg or nil) and (#cfg or 0)
end

function AnchorSimulatorConfig:getGoalCfg(activityId)
	return self._anchor_simulator_goal[activityId]
end

function AnchorSimulatorConfig:getGoalData(activityId, times)
	local result
	local cfg = self:getGoalCfg(activityId)

	if cfg then
		local left, right = 1, #cfg

		while left <= right do
			local mid = math.floor((left + right) / 2)

			if times >= cfg[mid].times then
				result = cfg[mid]
				left = mid + 1
			else
				right = mid - 1
			end
		end
	end

	return result
end

function AnchorSimulatorConfig:getGuestCfg(activityId)
	return self._anchor_simulator_guest[activityId]
end

function AnchorSimulatorConfig:getGuestData(activityId, guestId)
	if self._anchor_simulator_guest[activityId] then
		return self._anchor_simulator_guest[activityId][guestId]
	end
end

function AnchorSimulatorConfig:getRankPrizeCfg(activityId)
	return self._anchor_simulator_rank_prize[activityId]
end

function AnchorSimulatorConfig:getRankPrizeDataByRank(activityId, rank)
	local cfg = self._anchor_simulator_rank_prize[activityId]

	if cfg then
		local low = 1
		local high = #cfg

		while low <= high do
			local mid = math.floor((low + high) / 2)
			local midValue = cfg[mid]

			if rank < midValue.rankRange[1] then
				high = mid - 1
			elseif rank > midValue.rankRange[2] then
				low = mid + 1
			else
				return midValue
			end
		end
	end

	return nil
end

function AnchorSimulatorConfig:getBulletCfg(bulletPlanId)
	return self._anchor_simulator_bullet_screen[bulletPlanId]
end

function AnchorSimulatorConfig:getBulletData(bulletPlanId, bulletId)
	if self._anchor_simulator_bullet_screen[bulletPlanId] then
		return self._anchor_simulator_bullet_screen[bulletPlanId][bulletId]
	end
end

AnchorSimulatorConfig.instance = AnchorSimulatorConfig.New()

return AnchorSimulatorConfig
