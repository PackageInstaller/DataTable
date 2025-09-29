-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/model/goods/NormalGoodsData.lua

module("logic.extensions.store.model.goods.NormalGoodsData", package.seeall)

local M = class("NormalGoodsData", GoodsBaseData)

function M:ctor(normalGoodsNO, tabId, goodsCommonInfo)
	self._goodsId = goodsCommonInfo.goodsId
	self._storeId = goodsCommonInfo.mallId
	self._isDiscount = false

	if normalGoodsNO:HasField("discountedPrice") then
		self._discountPrice = normalGoodsNO.discountedPrice
	else
		local goodsCo = StoreConfig.instance:getNormalGoods(self._goodsId)
		local isDiscount, discountTick = StoreUtil._checkDiscountEnable(goodsCo)

		self._isDiscount = isDiscount
		self._discountTick = discountTick
		self._discount = goodsCo.discount

		if isDiscount and goodsCo.discountCost ~= "" then
			self._discountedCostItemId, self._discountPrice = StoreUtil.getCostPrice(goodsCo.discountCost)
		end
	end

	if normalGoodsNO:HasField("dailyBuyNum") then
		self._dailyBuyNum = normalGoodsNO.dailyBuyNum
	end

	if normalGoodsNO:HasField("discount") then
		self._isDiscount = true
		self._discount = normalGoodsNO.discount * 10
	end

	self._remainedNum = -1

	if normalGoodsNO:HasField("remainedNum") then
		self._remainedNum = normalGoodsNO.remainedNum
	end

	self._name = false
	self._icon = false
	self._goodsType = false
	self._reward = false
	self._desc = false
	self._cost = false
	self._discountCost = false
	self._buyLimit = 0
	self._onceMaxNum = false
	self._dailyBuyMaxNum = false
	self._hisBuyLimit = false
	self._price = 0
	self._onlineEndTime = tonumber(goodsCommonInfo.endRemainedSeconds)
	self._updateTime = ServerTime.now()

	self:initData(self._goodsId, tabId, self._storeId)
end

function M:initData(goodsId, tabId, storeId)
	M.super.initData(self, goodsId, tabId, storeId)

	local goodsCo = StoreConfig.instance:getNormalGoods(goodsId)

	if not goodsCo then
		if enableErrorLog then
			printError(string.format("StoreConfig::cannot find config for goodsId[%s]", goodsId))
		end

		return
	end

	self._name = goodsCo.name
	self._icon = goodsCo.icon
	self._goodsType = goodsCo.goodsType
	self._reward = goodsCo.reward
	self._desc = goodsCo.desc
	self._cost = goodsCo.cost
	self._discountCost = goodsCo.discountCost
	self._buyLimit = goodsCo.buyLimit
	self._onceMaxNum = goodsCo.onceMaxNum
	self._dailyBuyMaxNum = goodsCo.dailyBuyLimit
	self._hisBuyLimit = goodsCo.hisBuyLimit
	self._tag = goodsCo.tag
	self._discountStartTime = goodsCo.discountStartTime
	self._discountEndTime = goodsCo.discountStartTime
	self._costItemId, self._price = StoreUtil.getCostPrice(goodsCo.cost)

	self:setSortIndex(goodsCo.sortIndex)

	local rewardItems = StoreUtil.formatText(goodsCo.reward)
	local rewardLen = #rewardItems

	if rewardLen >= 1 then
		self._firstRewardTb = rewardItems[1]

		local itemData = ItemUtil.createItemData({
			itemId = rewardItems[1].itemId,
			count = rewardItems[1].num
		})

		if itemData then
			self._quality = itemData:getQuality()
		else
			printError(string.format("物品不存在ID: %s ,配置在商品ID：%s", rewardItems[1].itemId, goodsId))
		end
	end
end

function M:_getParseNormalDiscountedCostPrice(discountCost)
	local costItems = StoreUtil.formatText(discountCost)
	local len = #costItems

	if len ~= 1 then
		if enableErrorLog then
			printError("Discounted Cost Item Length More then 1?", len)
		end

		return false, false
	end

	local itemId = costItems[1].itemId
	local num = costItems[1].num

	return itemId, num
end

function M:getRemainedNum()
	return self._remainedNum
end

function M:getBuyLimit()
	return self._buyLimit
end

function M:getOnceMaxNum()
	return self._onceMaxNum
end

function M:getName()
	return self._name or ""
end

function M:getIcon()
	return self._icon
end

function M:getReward()
	return self._reward
end

function M:getDesc()
	return self._desc
end

function M:getCost()
	return self._cost
end

function M:getDiscountCost()
	return self._discountCost
end

function M:getGoodsType()
	return self._goodsType
end

function M:getIsDiscount()
	return self._isDiscount
end

function M:getDiscount()
	return self._discount or 0
end

function M:getDiscountedCostItemId()
	return self._discountedCostItemId or self._costItemId
end

function M:getPrice()
	return self._price
end

function M:getDiscountPrice()
	return self._discountPrice or false
end

function M:getDailyBuyNum()
	return self._dailyBuyNum or 0
end

function M:getDailyBuyMaxNum()
	return self._dailyBuyMaxNum or 0
end

function M:getHisBuyLimit()
	return self._hisBuyLimit or 0
end

function M:getDiscountStartTime()
	return self._discountStartTime or false
end

function M:getDiscountEndTime()
	return self._discountEndTime or false
end

function M:getDiscountTimeStr()
	local result = ""

	if self._isDiscount then
		local now = ServerTime.now()

		if not string.nilorempty(self._discountEndTime) then
			local endTimeStamp = TimeUtil.instance:dateStr2TimeStamp(self._discountEndTime)
			local offsetTs = endTimeStamp - now

			if offsetTs > 0 then
				result = TextFormatter.formatFullExpireTime(offsetTs)
			end
		end
	end

	return result
end

function M:getDiscountTick()
	return self._discountTick or false
end

function M:getQuality()
	return self._quality or 1
end

function M:getFirstReward()
	return self._firstRewardTb or false
end

function M:getTag()
	return self._tag
end

return M
