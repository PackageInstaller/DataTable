-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/config/weekend_supply/WeekendSupplyConfig.lua

module("logic.extensions.welfare.config.weekend_supply.WeekendSupplyConfig", package.seeall)

local M = class("WeekendSupplyConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.WeekendSupply
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.WeekendSupply then
		self._content = content
	end
end

function M:getOneInfoById(id)
	return self._content[id]
end

function M:getSaturDayRewardInfo(id)
	local rewardCode = self._content[id].saturdayReward
	local rewardInfo = RewardConfig.instance:getRewardCfgByCode(rewardCode)

	return rewardInfo
end

function M:getSunDayRewardInfo(id)
	local rewardCode = self._content[id].sundayReward
	local rewardInfo = RewardConfig.instance:getRewardCfgByCode(rewardCode)

	return rewardInfo
end

function M:getMonDayRewardInfo(id)
	local rewardCode = self._content[id].mondayReward
	local rewardInfo = RewardConfig.instance:getRewardCfgByCode(rewardCode)

	return rewardInfo
end

function M:getExtraRewardInfo(id)
	local rewardCode = self._content[id].extraReward
	local rewardInfo = RewardConfig.instance:getRewardCfgByCode(rewardCode)

	return rewardInfo
end

M.instance = M.New()

return M
