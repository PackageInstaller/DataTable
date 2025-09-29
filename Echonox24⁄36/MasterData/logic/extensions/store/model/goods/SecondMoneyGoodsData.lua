-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/model/goods/SecondMoneyGoodsData.lua

module("logic.extensions.store.model.goods.SecondMoneyGoodsData", package.seeall)

local M = class("SecondMoneyGoodsData", GoodsBaseData)

function M:ctor(secondMoneyGoodsNO, tabId, goodsCommonInfo)
	self._goodsId = goodsCommonInfo.goodsId
	self._isFirst = secondMoneyGoodsNO.isFirst
	self._storeId = goodsCommonInfo.mallId
	self._name = false
	self._icon = false
	self._goodsType = false
	self._costFirstMoneyNum = false
	self._secondMoneyId = false
	self._exchangeNum = false
	self._firstExtraExchangeNum = false
	self._normalExtraExchangeNum = false
	self._desc = false
	self._onlineEndTime = goodsCommonInfo.endRemainedSeconds
	self._updateTime = ServerTime.now()

	self:initData(self._goodsId, tabId, self._storeId)
end

function M:initData(goodsId, tabId, storeId)
	M.super.initData(self, goodsId, tabId, storeId)

	local goodsCo = StoreConfig.instance:getSecondMoneyGoods(goodsId)

	if goodsCo then
		self._name = goodsCo.name
		self._icon = goodsCo.icon
		self._goodsType = goodsCo.goodsType
		self._costFirstMoneyNum = goodsCo.costFirstMoneyNum
		self._secondMoneyId = goodsCo.secondMoneyId
		self._exchangeNum = goodsCo.exchangeNum
		self._firstExtraExchangeNum = goodsCo.firstExtraExchangeNum
		self._normalExtraExchangeNum = goodsCo.normalExtraExchangeNum
		self._desc = goodsCo.desc
		self._quality = goodsCo.quality

		self:setSortIndex(goodsCo.sortIndex)
	end
end

function M:getName()
	return self._name or ""
end

function M:getIcon()
	return self._icon
end

function M:getGoodsType()
	return self._goodsType
end

function M:getCostFirstMoneyNum()
	return self._costFirstMoneyNum
end

function M:getIsFirst()
	return self._isFirst
end

function M:getSecondMoneyId()
	return self._secondMoneyId
end

function M:getExchangeNum()
	return self._exchangeNum
end

function M:getFrstExtraExchangeNum()
	return self._firstExtraExchangeNum
end

function M:getNormalExtraExchangeNum()
	return self._normalExtraExchangeNum
end

function M:getDesc()
	return self._desc
end

function M:getQuality()
	return self._quality
end

return M
