-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/exchange/StoreExchangeViewItem.lua

module("logic.extensions.store.view.exchange.StoreExchangeViewItem", package.seeall)

local M = class("StoreExchangeViewItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self.id = UIDUtil.getEventUID()
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._btnBuyClick = ButtonAdapter.Get(registry:findUIElement("store_exchange_item_-465412311"))

	self._btnBuyClick:AddClickListener(self._clickSelf, self)

	self._imgIcon = registry:findUIElement("store_exchange_item_-1248927276", UIComponentType.Image)
	self._imgQuality = registry:findUIElement("store_exchange_item_-1284385419", UIComponentType.Image)
	self._goLimit = registry:findUIElement("store_exchange_item_1972733199")
	self._txtLimitName = registry:findUIElement("store_exchange_item_1972733199", UIComponentType.Text)
	self._txtLimitNum = registry:findUIElement("store_exchange_item_171758398", UIComponentType.Text)
	self._imgPriceIcon = registry:findUIElement("store_exchange_item_2071185456", UIComponentType.Image)
	self._txtPrice = registry:findUIElement("store_exchange_item_-446944082", UIComponentType.Text)
	self._txtOriginalPrice = registry:findUIElement("store_exchange_item_-622518017", UIComponentType.Text)
	self._txtFree = registry:findUIElement("store_exchange_item_1717095881", UIComponentType.Text)
	self._goPrice = registry:findUIElement("store_exchange_item_488274196")
	self._goSellOut = registry:findUIElement("store_exchange_item_1366831857")
	self._txtTime = registry:findUIElement("store_exchange_item_-504036062", UIComponentType.Text)
	self._goTime = registry:findUIElement("store_exchange_item_1511754710")
	self._txtName = registry:findUIElement("store_exchange_item_-213271000", UIComponentType.Text)
	self._goDiscount = registry:findUIElement("store_exchange_item_802016290")
	self._txtDiscount = registry:findUIElement("store_exchange_item_607414715", UIComponentType.Text)
	self._goNewSign = registry:findUIElement("0&new_sigh_291166182")
	self._goAnimation = registry:findUIElement("store_exchange_item_-679599189")
	self._canvasGroupAnim = registry:findUIElement("store_exchange_item_-679599189", ComponentType.CanvasGroup)
	self._animation = self._go:GetComponent(ComponentType.Animation)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.STORE_PLAY_ITEM_ANIMATION, self._playAnimation, self)
	else
		GlobalDispatcher:removeEventListener(EventType.STORE_PLAY_ITEM_ANIMATION, self._playAnimation, self)
	end
end

function M:_clickSelf()
	goutil.setActive(self._goNewSign, false)
	StoreModel.instance:setIsNeedShowNew({
		self._itemData
	})

	if self._hasSellOut or self._hasSellOutToday then
		FloatWordMgr.instance:show(lang("tip_store_item_has_sellout"))

		return
	end

	if self._funcClickSelf then
		if self._funcClickSelfHandler then
			self._funcClickSelf(self._funcClickSelfHandler, self._itemData)
		else
			self._funcClickSelf(self._itemData)
		end

		return
	end

	ViewMgr.instance:open(ViewName.StoreBuyConfirmView, self._itemData)
end

function M:setClickSelfFunc(func, handler)
	self._funcClickSelf = func
	self._funcClickSelfHandler = handler
end

function M:SetItemData(itemData, itemIndex)
	if itemData:getGoodsType() == false then
		goutil.setActive(self._go, false)
		printError("【兑换商店】请检查商品配置，商品id：" .. itemData:getGoodsId())

		return
	end

	goutil.setActive(self._go, true)

	self._curIndex = itemIndex
	self._itemData = itemData
	self._goodsType = self._itemData:getGoodsType()
	self._hasSellOut = false
	self._hasSellOutToday = false

	self:_updateCellView()
end

function M:_updateCellView()
	self:_setBuyLimity(self._itemData)
	self:_setIcon(self._itemData)
	self:_setQuality()
	self:_setGoodsName(self._itemData)
	self:_checkDiscountTick(self._itemData)
	self:_initCostInfo(self._itemData)
	self:_setIsNew()
end

function M:_setIsNew()
	local isNew = StoreModel.instance:getIsNeedShowNew(self._itemData)

	goutil.setActive(self._goNewSign, isNew and not self._hasSellOut)
end

function M:_setGoodsName(data)
	local useFirstItemName = string.nilorempty(data:getName())

	if not useFirstItemName then
		self._txtName.text = data:getName()
	end
end

function M:_setBuyLimity(data)
	local isLimit = self._itemData:getRemainedNum() > 0

	goutil.setActive(self._goLimit, isLimit)

	self._hasSellOut = false

	local remainedNum = data:getRemainedNum()

	if remainedNum >= 0 then
		local buyLimit = data:getBuyLimit()
		local hisBuyLimit = data:getHisBuyLimit()
		local dailyBuyLimit = data:getDailyBuyMaxNum()
		local limit = 0

		limit = StoreUtil.getMinLimit(limit, buyLimit)
		limit = StoreUtil.getMinLimit(limit, hisBuyLimit)
		limit = StoreUtil.getMinLimit(limit, dailyBuyLimit)
		self._txtLimitNum.text = langF("tip_store_limmit_show", remainedNum, limit)

		if data:getRemainedNum() == 0 then
			self._hasSellOut = true
			self._hasSellOutToday = true
		end
	end

	if isLimit then
		self._txtLimitName.text = StoreUtil.getLimitName(self._itemData)
	end

	goutil.setActive(self._goSellOut, self._hasSellOut)
end

function M:_setIcon(data)
	local useFirstItemName = string.nilorempty(data:getName())
	local firstReward = data:getFirstReward()
	local useItemIcon = string.nilorempty(data:getIcon())
	local itemData = ItemUtil.createItemData({
		count = 0,
		itemId = firstReward.itemId
	})

	if not useItemIcon then
		IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, data:getIcon())
	elseif itemData then
		if useFirstItemName then
			self._txtName.text = itemData:getName()
		end

		if useItemIcon then
			IconLoader.setSpriteByItemType(self._imgIcon, itemData:getType(), itemData:getIcon())
		end
	end
end

function M:_setQuality()
	local quality = self._itemData:getQuality()
	local qualityUrl = StoreUtil.getQualityIconPath(StoreEnum.ExchangeItemQualityIcon[quality])

	if self._qualityUrl ~= qualityUrl then
		self._qualityUrl = qualityUrl

		if qualityUrl then
			goutil.setActive(self._imgQuality.gameObject, true)
			IconLoader.setSprite(self._imgQuality, IconType.StoreIcon, qualityUrl)
		end
	end

	goutil.setActive(self._imgQuality.gameObject, qualityUrl ~= nil)
end

function M:_setPriceIcon(itemId)
	if itemId then
		MoneyUtil.setMoneyIcon(self._imgPriceIcon, itemId)
	end
end

function M:_initCostInfo(data)
	local itemId
	local isDiscount = not self._hasSellOut and data:getIsDiscount()

	if isDiscount then
		self._txtPrice.text = data:getDiscountPrice()
		self._txtOriginalPrice.text = data:getPrice()
		self._txtDiscount.text = StoreUtil.getDiscount(data:getDiscount())
		itemId = data:getDiscountedCostItemId()
	else
		self._txtPrice.text = data:getPrice()
		itemId = data:getCostItemId()
	end

	goutil.setActive(self._txtOriginalPrice.gameObject, isDiscount)
	goutil.setActive(self._goDiscount, isDiscount)

	local isFree = not isDiscount and data:getPrice() <= 0

	goutil.setActive(self._txtFree.gameObject, isFree)
	goutil.setActive(self._goPrice, not isFree)
	self:_setPriceIcon(itemId)
end

function M:_checkDiscountTick(data)
	removetimer(self._updateTimer, self)

	self._remainingTime = data:getGoodEndRemainedSeconds()

	goutil.setActive(self._goTime, self._remainingTime > 0)

	if self._remainingTime > 0 then
		self._txtTime.text = data:getGoodsTimeStr()

		settimer(1, self._updateTimer, self, true)
	end
end

function M:_updateTimer()
	if self._remainingTime >= 0 then
		self._remainingTime = self._remainingTime - 1
		self._txtTime.text = self._itemData:getGoodsTimeStr()
	else
		self:_onRefreshGoods()
		goutil.setActive(self._goTime, false)
		removetimer(self._updateTimer, self)
	end
end

function M:_onRefreshGoods()
	GlobalDispatcher:dispatchEvent(EventType.REFRESH_STORE_LIST)
end

function M:_playAnimation()
	if not self._go.activeSelf then
		return
	end

	if self._animation then
		self._animation:Stop()
		self._animation:Play("store_exchange_open")
	end
end

function M:OnDestroy()
	self:setEvent(false)

	if self._tweener then
		self._tweener:Kill(false)
	end

	removetimer(self._updateTimer, self)
	IconLoader.clearSprite(self._imgPriceIcon)
	IconLoader.clearSprite(self._imgIcon)
	IconLoader.clearSprite(self._imgQuality)

	self._compContainer = nil
	self._go = nil
	self._viewElementsRegistry = nil
	self._curIndex = nil
	self._itemData = nil

	self._btnBuyClick:RemoveClickListener()

	self._btnBuyClick = nil
	self._imgPriceIcon = nil
	self._imgIcon = nil
	self._imgQuality = nil

	self:setClickSelfFunc(nil, nil)
end

return M
