-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreCurrencyItem2.lua

module("logic.extensions.store.view.StoreCurrencyItem2", package.seeall)

local M = class("StoreGoodsItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._btnBuyClick = ButtonAdapter.Get(registry:findUIElement("store_currency_item2_-176584724"))

	self._btnBuyClick:AddClickListener(self._clickSelf, self)

	self._itemIcon = registry:findUIElement("0&rewards_detail_item_-2041880288", UIComponentType.Image)
	self._doubleHintSign = registry:findUIElement("store_currency_item2_-1026037419")
	self._txtDoubleHint = registry:findUIElement("store_currency_item2_-1080995226", UIComponentType.Text)
	self._doubleHintSignMask = registry:findUIElement("store_currency_item2_-1864323674")
	self._discountSign = registry:findUIElement("store_currency_item2_1850758634")
	self._txtDiscount = registry:findUIElement("store_currency_item2_142320411", UIComponentType.Text)
	self._discountSignMask = registry:findUIElement("store_currency_item2_693340283")
	self._txtPrice1 = registry:findUIElement("store_currency_item2_-574208530", UIComponentType.Text)
	self._txtPrice2 = registry:findUIElement("store_currency_item2_-1936695795", UIComponentType.Text)
	self._imgPriceIcon = registry:findUIElement("store_currency_item2_-145776120", UIComponentType.Image)
	self._txtOriginalPrice = registry:findUIElement("store_currency_item2_-1684061173", UIComponentType.Text)
	self._txtName = registry:findUIElement("store_currency_item2_-1904578821", UIComponentType.Text)
	self._sellOutGo = registry:findUIElement("store_currency_item2_811440971")
	self._txtLimitNum = registry:findUIElement("store_currency_item2_-902881159", UIComponentType.Text)
end

function M:_showItemInfo(itemid, number)
	self._itemCell:setShowSelectedEffect(false)
	self._itemCell:updateData(ItemData.New({
		count = number,
		itemId = itemid
	}))
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

	StoreMainFacade.instance:showShippingTips(self._itemData)
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

	goutil.setActive(self._doubleHintSign, false)
	goutil.setActive(self._discountSign, false)
	goutil.setActive(self._txtOriginalPrice.gameObject, false)
	goutil.setActive(self._sellOutGo, false)
	goutil.setActive(self._doubleHintSignMask, false)
	goutil.setActive(self._discountSignMask, false)

	self._txtName.text = data:getName()
	self._txtPrice2.text = data:getCostFirstMoneyNum()

	IconLoader.setSprite(self._itemIcon, IconType.ItemIcon, data:getIcon())
	goutil.setActive(self._doubleHintSignMask, self._doubleHintSign.activeSelf)
	goutil.setActive(self._discountSignMask, self._discountSign.activeSelf)
end

function M:checkDiscountTick(data)
	if data:getDiscountTick() then
		self._remainingTime = self:getRemainedTime(data)

		if self._remainingTime > 0 then
			settimer(1, self._updateTimer, self, true)
		end
	end
end

function M:getRemainedTime(data)
	local beginT = false
	local endT = false
	local offset = 0

	if not string.nilorempty(data:getDiscountStartTime()) then
		beginT = TimeUtil.instance:dateStr2TimeStamp(data:getDiscountStartTime())
	end

	if not string.nilorempty(data:getDiscountEndTime()) then
		endT = TimeUtil.instance:dateStr2TimeStamp(data:getDiscountEndTime())
	end

	if beginT then
		if endT then
			if endT > ServerTime.now() and beginT <= ServerTime.now() then
				offset = endT - ServerTime.now()
			end
		elseif beginT > ServerTime.now() then
			offset = beginT - ServerTime.now()
		end
	elseif endT and endT > ServerTime.now() then
		offset = endT - ServerTime.now()
	end

	return offset
end

function M:_updateTimer()
	if self._remainingTime then
		if self._remainingTime > 0 then
			self._remainingTime = self._remainingTime - 1
		end

		if self._remainingTime <= 0 then
			removetimer(self._updateTimer, self)
		end
	else
		removetimer(self._updateTimer, self)
	end
end

function M:initCostInfo(costStr, initData)
	local costItems = StoreUtil.formatText(costStr)
	local len = #costItems

	if len == 1 then
		local itemId = costItems[1].itemId
		local num = costItems[1].num

		if initData then
			self._txtPrice2.text = num

			local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemId)

			if itemCo then
				IconLoader.setSprite(self._imgPriceIcon, IconType.ItemIcon, itemCo.icon)
			end
		end

		return itemId, num
	elseif enableErrorLog then
		printError("There are multiple consumable items,ID,", costStr)
	end
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
	self._txtDiscount = nil
	self._txtPrice1 = nil
	self._txtPrice2 = nil
	self._imgPriceIcon = nil
	self._txtName = nil
	self._sellOutGo = nil
	self._txtLimitNum = nil

	removetimer(self._updateTimer, self)
end

return M
