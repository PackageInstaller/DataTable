-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/model/TradingPostMo.lua

module("logic.extensions.trading.model.TradingPostMo", package.seeall)

local M = class("TradingPostMo")

function M:updateByNo(tradePostNo)
	self._level = tradePostNo.level
	self._productivity = tradePostNo.productivity
	self._productivityCount = tradePostNo.productivity.productivity
	self._enterHero = tradePostNo.enterHero
	self._dailyOrder = tradePostNo.dailyOrder
	self._weeklyOrder = tradePostNo.weeklyOrder
	self._orderRefreshTimes = tradePostNo.orderRefreshTimes

	self:updateHouseCo()
	self:updateNextProductTimeStamp()
	self:_updateProductCostTime()
end

function M:setLevel(level)
	self._level = level

	self:updateHouseCo()
end

function M:updateHouseCo()
	self._co = TradingConfig.instance:getHouseCoByLevel(self._level)
end

function M:getLevel()
	return self._level
end

function M:getSpeed()
	return self._productivity.speed
end

function M:getProductHouseRatio()
	return self._productivity.houseRatio
end

function M:getProductivity()
	return self._productivityCount
end

function M:setProductivity(productivity)
	self._productivityCount = productivity

	if self._productivity then
		self:updateNextProductTimeStamp()
	end
end

function M:getEnterHero()
	return self._enterHero or {}
end

function M:getEnterHeroAdd()
	return string.format("+%d%%", self._productivity.heroAdd)
end

function M:getHeroAdd()
	return self._productivity.heroAdd or 0
end

function M:setDailyOrder(dailyOrder)
	self._dailyOrder = dailyOrder
end

function M:getDailyOrder()
	return self._dailyOrder
end

function M:setWeeklyOrder(weeklyOrder)
	self._weeklyOrder = weeklyOrder
end

function M:getWeeklyOrder()
	return self._weeklyOrder
end

function M:getOrderRefreshTimes()
	return self._orderRefreshTimes
end

function M:setOrderRefreshTimes(orderRefreshTimes)
	self._orderRefreshTimes = orderRefreshTimes
end

function M:getJobCount()
	return self._co.jobCount
end

function M:getProductivityByCo()
	return self._co.productivity
end

function M:getMaxDailyOrder()
	return self._co.maxDailyOrder
end

function M:getMaxWeeklyOrder()
	return self._co.maxWeeklyOrder
end

function M:getUnlockOrderLevel()
	return self._co.unlockOrder
end

function M:getUnlockJobCount()
	return self._co.jobCount
end

function M:getUpgradeDesc()
	local co = TradingConfig.instance:getHouseCoByLevel(self._level + 1)

	if co then
		return co.upgradeDesc
	else
		return lang("tip_trading_lang_11")
	end
end

function M:getNextProductTimeStamp()
	return self._nextProductTimeStamp
end

function M:updateNextProductTimeStamp(isPush)
	local needProductivity = TradingConfig.instance:getConstCoByKey("OrderProductivity").numValue
	local currProductivity = self:getProductivity()
	local minCount = math.ceil((needProductivity - currProductivity) / self:getSpeed())
	local serverDate = ServerTime.nowDate()
	local currSecond = isPush and 0 or serverDate.sec

	self._nextProductTimeStamp = ServerTime.now() - currSecond + minCount * 60
end

function M:_updateProductCostTime()
	local needProductivity = TradingConfig.instance:getConstCoByKey("OrderProductivity").numValue
	local minCount = needProductivity / self:getSpeed()

	self._productCostSec = minCount * 60
	self._productCostTime = math.ceil(minCount) * 60
end

function M:getProductCostSec()
	return self._productCostSec
end

function M:getRemainTimeToDailyOrderFull()
	local remainTime = 0
	local co = TradingConfig.instance:getHouseCoByLevel(self:getLevel())
	local dailyOrderIds = self:getDailyOrder()

	if #dailyOrderIds < co.maxDailyOrder then
		local remainCount = co.maxDailyOrder - #dailyOrderIds

		remainCount = remainCount - 1
		remainTime = self:getNextProductTimeStamp() - ServerTime.now() + remainCount * self._productCostSec
		remainTime = math.max(0, remainTime)
	end

	return remainTime
end

return M
