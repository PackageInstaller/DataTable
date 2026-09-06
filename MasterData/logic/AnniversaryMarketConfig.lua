-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/config/AnniversaryMarketConfig.lua

module("logic.extensions.anniversarymarket.config.AnniversaryMarketConfig", package.seeall)

local AnniversaryMarketConfig = class("AnniversaryMarketConfig", BaseConfig)

function AnniversaryMarketConfig:onInit()
	AnniversaryMarketConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function AnniversaryMarketConfig:getNames()
	return {
		"anniversary_market_activity",
		"anniversary_market_price_plan",
		"anniversary_market_prize_pool",
		"anniversary_market_refresh_plan",
		"anniversary_market_weight_plan",
		"anniversary_market_prize",
		"anniversary_market_prize_level"
	}
end

function AnniversaryMarketConfig:handleConfig(name, content)
	if name == "anniversary_market_activity" then
		self._anniversary_market_activity = content
	elseif name == "anniversary_market_price_plan" then
		self._anniversary_market_price_plan = content

		self:_getSortPriceCfgs()
	elseif name == "anniversary_market_prize_pool" then
		self._anniversary_market_prize_pool = content
	elseif name == "anniversary_market_refresh_plan" then
		self._anniversary_market_refresh_plan = content

		self:getRefreshPlanCfgSort()
	elseif name == "anniversary_market_weight_plan" then
		self._anniversary_market_weight_plan = content
	elseif name == "anniversary_market_prize" then
		self._anniversary_market_prize = content
	elseif name == "anniversary_market_prize_level" then
		self._anniversary_market_prize_level = content
	end
end

function AnniversaryMarketConfig:getActCfg(activityId)
	return self._anniversary_market_activity[activityId]
end

function AnniversaryMarketConfig:getPricePlanCfg()
	return self._anniversary_market_price_plan
end

function AnniversaryMarketConfig:getPricePlanCfgById(pricePlanId)
	return self._anniversary_market_price_plan[pricePlanId]
end

function AnniversaryMarketConfig:_getSortPriceCfgs()
	self._sortPricePlanCfgs = {}

	local cfgs = self:getPricePlanCfg()

	for pricePlanId, cfg in pairs(cfgs) do
		self._sortPricePlanCfgs[pricePlanId] = self._sortPricePlanCfgs[pricePlanId] or {}
		self._sortPricePlanCfgs[pricePlanId] = {}

		for range, data in pairs(cfg) do
			table.insert(self._sortPricePlanCfgs[pricePlanId], data)
		end

		table.sort(self._sortPricePlanCfgs[pricePlanId], function(a, b)
			return a.priceRange[1] < b.priceRange[1]
		end)
	end
end

function AnniversaryMarketConfig:getPrizePoolCfg(activityId)
	return self._anniversary_market_prize_pool[activityId]
end

function AnniversaryMarketConfig:getPrizePoolCfgById(activityId, prizePoolId)
	return self._anniversary_market_prize_pool[activityId] and self._anniversary_market_prize_pool[activityId][prizePoolId]
end

function AnniversaryMarketConfig:getRefreshPlanCfg(refreshPlanId)
	return self._anniversary_market_refresh_plan[refreshPlanId]
end

function AnniversaryMarketConfig:getRefreshPlanCfgSort()
	local refreshPlanCfgs = self._anniversary_market_refresh_plan

	self._sortRefreshPlanCfgs = {}

	for refreshPlanId, cfgs in pairs(refreshPlanCfgs) do
		self._sortRefreshPlanCfgs[refreshPlanId] = self._sortRefreshPlanCfgs[refreshPlanId] or {}

		for k, cfg in pairs(cfgs) do
			table.insert(self._sortRefreshPlanCfgs[refreshPlanId], cfg)
		end

		table.sort(self._sortRefreshPlanCfgs[refreshPlanId], function(a, b)
			return a.refreshTimes < b.refreshTimes
		end)
	end
end

function AnniversaryMarketConfig:getWeightPlanCfg(weightPlanId)
	return self._anniversary_market_weight_plan[weightPlanId]
end

function AnniversaryMarketConfig:getWeightPlanCfgByPoolId(activityId, prizePoolId, refreshTime)
	local prizePoolCfg = AnniversaryMarketConfig.instance:getPrizePoolCfgById(activityId, prizePoolId)
	local refreshPlanId = prizePoolCfg.refreshPlanId

	if refreshPlanId then
		local refreshPlanCfgs = self._sortRefreshPlanCfgs[refreshPlanId]
		local refreshCfg = {}

		for i, cfg in ipairs(refreshPlanCfgs) do
			if refreshTime >= cfg.refreshTimes then
				refreshCfg = cfg
			end
		end

		local weightPlanId = refreshCfg.weightPlanId

		if weightPlanId then
			return self._anniversary_market_weight_plan[weightPlanId]
		end
	end
end

function AnniversaryMarketConfig:getMarketPrizeCfg(prizeId)
	return self._anniversary_market_prize[prizeId]
end

function AnniversaryMarketConfig:getPriceRangesCfg(pricePlanId)
	return self._sortPricePlanCfgs[pricePlanId]
end

function AnniversaryMarketConfig:getPrizeLevelCfg(activityId)
	return self._anniversary_market_prize_level[activityId]
end

function AnniversaryMarketConfig:getPrizeLevelCfgByPoolId(activityId, prizePoolId)
	return self._anniversary_market_prize_level[activityId] and self._anniversary_market_prize_level[activityId][prizePoolId]
end

function AnniversaryMarketConfig:getPrizeContent(prizeId)
	return self._anniversary_market_prize[prizeId] and self._anniversary_market_prize[prizeId].prizeContent
end

function AnniversaryMarketConfig:getIsBigPrize(prizeId)
	return self._anniversary_market_prize[prizeId] and self._anniversary_market_prize[prizeId].bigPrize
end

function AnniversaryMarketConfig:getPrizePoolIdList(activityId)
	local prizePoolCfgs = self._anniversary_market_prize_pool[activityId]
	local poolIdList = {}

	for i, cfg in ipairs(prizePoolCfgs) do
		table.insert(poolIdList, cfg.prizePoolId)
	end

	return poolIdList
end

AnniversaryMarketConfig.instance = AnniversaryMarketConfig.New()

return AnniversaryMarketConfig
