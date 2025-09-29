-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreCurrencyItem1.lua

module("logic.extensions.store.view.StoreCurrencyItem1", package.seeall)

local M = class("StoreCurrencyItem1")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._btnBuyClick = ButtonAdapter.Get(registry:findUIElement("store_currency_item1_1141097544"))

	self._btnBuyClick:AddClickListener(self._clickSelf, self)

	self._itemIcon = registry:findUIElement("0&rewards_detail_item_-2041880288", UIComponentType.Image)
	self._itemQuality = registry:findUIElement("0&rewards_detail_item_868117965", UIComponentType.Image)
	self._goodsQuality = registry:findUIElement("store_currency_item1_-473770807", UIComponentType.Image)
	self._doubleHintSign = registry:findUIElement("store_currency_item1_1940761329")
	self._txtDoubleHint = registry:findUIElement("store_currency_item1_250286530", UIComponentType.Text)
	self._doubleHintSignMask = registry:findUIElement("store_currency_item1_563801602")
	self._discountSign = registry:findUIElement("store_currency_item1_-550889906")
	self._txtDiscount = registry:findUIElement("store_currency_item1_-1191059265", UIComponentType.Text)
	self._discountSignMask = registry:findUIElement("store_currency_item1_-1742091297")
	self._txtPrice1 = registry:findUIElement("store_currency_item1_1824261706", UIComponentType.Text)
	self._txtName = registry:findUIElement("store_currency_item1_1056976223", UIComponentType.Text)
end

function M:_showItemInfo(itemid, number)
	return
end

function M:_clickSelf()
	if self._hasSellOutToday then
		FloatWordMgr.instance:show(lang("tip_store_item_has_sellout"))

		return
	end

	if self._hasSellOut then
		return
	end

	if not self._itemData then
		return
	end

	local _goodIds = self._itemData:getGoodsId()
	local _tabId = self._itemData:getTabId()
	local _payMoney = self._itemData:getPrice()
	local _coinName = self._itemData:getName()
	local _moreCharge = 0
	local _payType = 0
	local _productName = self._itemData:getName()
	local _coinsAmount = 1
	local _rate = 10
	local _platformGoodsId = self._itemData:getSdkPayId()
	local _exStr

	StoreAgent.instance:sendBuyGoodsRequestBySDK(_goodIds, 1, _tabId, _payMoney, _coinName, _moreCharge, _payType, _productName, _coinsAmount, _rate, _platformGoodsId, _exStr)
end

function M:SetItemData(itemData, itemIndex)
	self._curIndex = itemIndex
	self._itemData = itemData
	self._hasSellOut = false
	self._hasSellOutToday = false

	self:_updateCellInfo(itemData)
end

function M:_updateCellInfo(data)
	local goodsType = data:getGoodsType()

	IconLoader.setSprite(self._itemIcon, IconType.ItemIcon, data:getIcon())
	goutil.setActive(self._doubleHintSign, false)
	goutil.setActive(self._discountSign, false)
	goutil.setActive(self._doubleHintSignMask, false)
	goutil.setActive(self._discountSignMask, false)

	self._txtName.text = data:getName()
	self._txtPrice1.text = string.format("￥%s", data:getPrice())

	goutil.setActive(self._doubleHintSignMask, self._doubleHintSign.activeSelf)
	goutil.setActive(self._discountSignMask, self._discountSign.activeSelf)
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._trs = nil
	self._viewElementsRegistry = nil
	self._curIndex = nil
	self._itemData = nil

	self._btnBuyClick:RemoveClickListener()

	self._btnBuyClick = nil
	self._imgIcon = nil
	self._doubleHintSign = nil
	self._txtDoubleHint = nil
	self._discountSign = nil
	self._txtPrice1 = nil
	self._txtName = nil
end

return M
