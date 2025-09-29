-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/controller/StoreController.lua

module("logic.extensions.store.controller.StoreController", package.seeall)

local M = class("StoreController", BaseController)

function M:ctor()
	return
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.REFRESH_MONTH_CARD_DATA, self._monthCardRewardPush, self)
end

function M:buySkinGoods(skinId)
	local storeList = StoreModel.instance:getStoresByStoreType(StoreEnum.MallType.Skin)

	if #storeList <= 0 then
		return
	end

	self._tabId = storeList[1]:getTabId()
	self._storeId = storeList[1]:getId()
	self._skinId = skinId

	local goodsList = StoreModel.instance:getGoodsList(self._tabId, self._storeId)

	if not goodsList or #goodsList < 1 then
		GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._openBuyConfirmView, self)
		StoreAgent.instance:sendGetGoodsListRequest({
			self._storeId
		})

		return
	end

	self:_openBuyConfirmView()
end

function M:_openBuyConfirmView()
	GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._openBuyConfirmView, self)

	local goodsList = StoreModel.instance:getGoodsList(self._tabId, self._storeId)

	for i = 1, #goodsList do
		if goodsList[i]:getSkinId() == self._skinId then
			ViewMgr.instance:open(ViewName.StoreBuyConfirmView, goodsList[i])

			return
		end
	end

	FloatWordMgr.instance:show(lang("tip_store_good_outline"))
end

function M:isCanBuyMonthCard(monthCardMo, showTips)
	local remainedDay = monthCardMo:getRemainedDay()
	local totalLimit = monthCardMo:getTotalDayLimit()
	local isCanBuy = totalLimit > remainedDay + monthCardMo:getEffectiveDays()

	if not isCanBuy and showTips then
		FloatWordMgr.instance:show(lang("tip_store_monthcard_maxday"))
	end

	return isCanBuy
end

function M:tryOpenMonthCardRewardTipsView()
	if not self._hasMonthCardDailyReward then
		return
	end

	local code = LoginPopEnum.PopCode[LoginPopEnum.PopType.MonthCard]

	if LoginPopUpsModel.instance:isContain(code) then
		return
	end

	local jumpId = 10900004

	GlobalDispatcher:dispatchEvent(EventType.LOGIN_POP_UP_REG, code, 0, true, jumpId)
end

function M:setMonthCardReward(value)
	self._hasMonthCardDailyReward = value
end

function M:getMonthCardReward()
	return self._hasMonthCardDailyReward
end

function M:_monthCardRewardPush(e)
	self:tryOpenMonthCardRewardTipsView()
end

function M:buyMothCard(goodsMo)
	local remainedDay = goodsMo:getRemainedDay()
	local totalLimit = goodsMo:getTotalDayLimit()

	if totalLimit < remainedDay + goodsMo:getEffectiveDays() then
		FloatWordMgr.instance:show(lang("tip_store_monthcard_maxday"))

		return
	end

	local payMoney = goodsMo:getPrice()
	local coinName = goodsMo:getName()
	local moreCharge = 0
	local payType = 0
	local productName = goodsMo:getName()
	local coinsAmount = 1
	local rate = 10
	local platformGoodsId = goodsMo:getSdkPayId()
	local exStr
	local goodsId = goodsMo:getGoodsId()
	local tabId = goodsMo:getTabId()

	StoreAgent.instance:sendBuyGoodsRequestBySDK(goodsId, 1, tabId, payMoney, coinName, moreCharge, payType, productName, coinsAmount, rate, platformGoodsId, exStr)
end

function M:onReset()
	GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._openBuyConfirmView, self)
	GlobalDispatcher:removeEventListener(EventType.REFRESH_MONTH_CARD_DATA, self._monthCardRewardPush)
end

M.instance = M.New()

return M
