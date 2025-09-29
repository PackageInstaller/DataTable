-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreGoodsItem.lua

module("logic.extensions.store.view.StoreGoodsItem", package.seeall)

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

	self._btnBuyClick = ButtonAdapter.Get(registry:findUIElement("store_common_item_546426268"))

	self._btnBuyClick:AddClickListener(self._clickSelf, self)

	self._itemObj = registry:findUIElement("0&rewards_detail_item_2141037416")
	self._itemIcon = registry:findUIElement("0&rewards_detail_item_-2041880288", UIComponentType.Image)
	self._itemQuality = registry:findUIElement("0&rewards_detail_item_868117965", UIComponentType.Image)
	self._heroImgObj = registry:findUIElement("store_common_item_816191810")
	self._heroImgIcon = registry:findUIElement("store_common_item_944939153", UIComponentType.Image)
	self._goodsQuality = registry:findUIElement("store_common_item_873174015", UIComponentType.Image)
	self._doubleHintSign = registry:findUIElement("store_common_item_8592336")
	self._txtDoubleHint = registry:findUIElement("store_common_item_2110103779", UIComponentType.Text)
	self._doubleHintSignMask = registry:findUIElement("store_common_item_1387552547")
	self._discountSign = registry:findUIElement("store_common_item_-1408981137")
	self._txtDiscount = registry:findUIElement("store_common_item_-902868578", UIComponentType.Text)
	self._discountSignMask = registry:findUIElement("store_common_item_-54803957")
	self._countGo = registry:findUIElement("store_common_item_-416497081")
	self._txtCount = registry:findUIElement("store_common_item_-1548374831", UIComponentType.Text)
	self._txtPrice1 = registry:findUIElement("store_common_item_529708907", UIComponentType.Text)
	self._txtPrice2 = registry:findUIElement("store_common_item_1321512072", UIComponentType.Text)
	self._imgPriceIcon = registry:findUIElement("store_common_item_890982541", UIComponentType.Image)
	self._txtOriginalPrice = registry:findUIElement("store_common_item_1506522766", UIComponentType.Text)
	self._txtName = registry:findUIElement("store_common_item_1278123134", UIComponentType.Text)
	self._sellOutGo = registry:findUIElement("store_common_item_-234264114")
	self._txtLimitNum = registry:findUIElement("store_common_item_142332668", UIComponentType.Text)
	self._txtLimitTime = registry:findUIElement("store_common_item_-767117527", UIComponentType.Text)
end

function M:_showItemInfo(itemid, number, useFirstItemName, useItemIcon)
	local itemData = ItemUtil.createItemData({
		count = 0,
		itemId = itemid
	})

	if itemData then
		if useFirstItemName then
			self._txtName.text = itemData:getName()
		end

		local isHero = GameEnum.ItemTypeEnum.HeroType == itemData:getType()

		goutil.setActive(self._itemObj, not isHero)
		goutil.setActive(self._heroImgObj, isHero)

		if isHero then
			IconLoader.setSpriteByItemType(self._heroImgIcon, itemData:getType(), itemData:getIcon())
		elseif useItemIcon then
			IconLoader.setSpriteByItemType(self._itemIcon, itemData:getType(), itemData:getIcon())
			IconLoader.setSprite(self._itemQuality, IconType.Skinlib, CommEnum.Quality2ItemBg[itemData:getQuality()])
		end
	end
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
	local url = StoreUtil.getQualityIconPath(StoreEnum.GoodsQualityIcon[data:getQuality()])

	IconLoader.setSprite(self._goodsQuality, IconType.StoreIcon, url)
	goutil.setActive(self._doubleHintSign, false)
	goutil.setActive(self._discountSign, false)
	goutil.setActive(self._txtOriginalPrice.gameObject, false)
	goutil.setActive(self._sellOutGo, false)
	goutil.setActive(self._doubleHintSignMask, false)
	goutil.setActive(self._discountSignMask, false)

	self._txtLimitNum.text = ""
	self._txtLimitTime.text = data:getGoodsTimeStr()

	goutil.setActive(self._txtLimitNum.gameObject, true)
	goutil.setActive(self._countGo, true)

	local reward = data:getReward()
	local rewardList = StoreUtil.formatText(reward)
	local len = #rewardList

	if len > 1 then
		self._txtCount.text = "x1"
	elseif len == 1 then
		self._txtCount.text = "x" .. rewardList[len].num
	else
		self._txtCount.text = "x1"
	end

	local itemId, num = self:initCostInfo(data:getCost(), true)
	local remainedNum = data:getRemainedNum()

	if remainedNum >= 0 then
		local buyLimit = data:getBuyLimit()
		local hisBuyLimit = data:getHisBuyLimit()
		local dailyBuyLimit = data:getDailyBuyMaxNum()
		local limit = 0

		limit = self:getMinLimit(limit, buyLimit)
		limit = self:getMinLimit(limit, hisBuyLimit)
		limit = self:getMinLimit(limit, dailyBuyLimit)
		self._txtLimitNum.text = langF("tip_store_limmit_show", remainedNum, limit)

		if data:getRemainedNum() == 0 then
			self._hasSellOut = true

			goutil.setActive(self._sellOutGo, true)
		end
	end

	local useFirstItemName = string.nilorempty(data:getName())

	if not useFirstItemName then
		self._txtName.text = data:getName()
	end

	local firstReward = data:getFirstReward()
	local useItemIcon = string.nilorempty(data:getIcon())

	self:_showItemInfo(firstReward.itemId, firstReward.num, useFirstItemName, useItemIcon)

	if not useItemIcon then
		IconLoader.setSprite(self._itemIcon, IconType.ItemIcon, data:getIcon())
		IconLoader.setSprite(self._itemQuality, IconType.Skinlib, CommEnum.Quality2ItemBg[data:getQuality()])
	end

	if goodsType == StoreEnum.GoodsType.Normal then
		local remainedNum = data:getRemainedNum()

		if remainedNum == 0 then
			self._hasSellOutToday = true
			self._hasSellOut = true

			goutil.setActive(self._sellOutGo, true)
		end
	end

	local isDisCount = data:getIsDiscount()

	goutil.setActive(self._discountSign, isDisCount)
	goutil.setActive(self._txtOriginalPrice.gameObject, isDisCount)

	if isDisCount then
		self._txtDiscount.text = "-" .. 100 - data:getDiscount() * 10 .. "%"
		self._discountPrice = data:getDiscountPrice()
	end

	if isDisCount then
		self._txtPrice2.text = self._discountPrice
		self._txtOriginalPrice.text = data:getPrice()
	else
		self._txtPrice2.text = num
	end

	if self._sellOutGo.activeSelf then
		goutil.setActive(self._doubleHintSignMask, self._doubleHintSign.activeSelf)
		goutil.setActive(self._discountSignMask, self._discountSign.activeSelf)
	end

	self:_showGoodsEndRemainedSeconds()
end

function M:getMinLimit(curent, target)
	if curent == 0 then
		return target
	end

	if target == 0 then
		return curent
	end

	return Mathf.Min(curent, target)
end

function M:_showGoodsEndRemainedSeconds()
	self._remainGoodsSeconds = self._itemData:getGoodEndRemainedSeconds()

	if self._remainGoodsSeconds > 0 then
		self._remainGoodsSeconds = self._remainGoodsSeconds + 3

		self:_startCounter()
		self:_updateTimeView()
	else
		self:_stopCounter()

		self._txtLimitTime.text = ""
	end
end

function M:_startCounter()
	if self._remainGoodsSeconds <= 0 then
		return
	end

	self:_stopCounter()
	Scheduler.addListener(1, self._onSecond, self, true)
end

function M:_stopCounter()
	Scheduler.removeListener(self._onSecond, self)
end

function M:_onSecond()
	self._remainGoodsSeconds = self._remainGoodsSeconds - 1

	self:_updateTimeView()

	if self._remainGoodsSeconds <= 0 then
		self:_onRefreshGoods()
		self:_stopCounter()

		self._txtLimitTime.text = ""
	end
end

function M:_onRefreshGoods()
	GlobalDispatcher:dispatchEvent(EventType.STORE_STATE_CODE_ERROR)
end

function M:_updateTimeView()
	self._txtLimitTime.text = self._itemData:getGoodsTimeStr()
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
	local beginTime = false
	local endTime = false
	local offset = 0

	if not string.nilorempty(data:getDiscountStartTime()) then
		beginTime = TimeUtil.instance:dateStr2TimeStamp(data:getDiscountStartTime())
	end

	if not string.nilorempty(data:getDiscountEndTime()) then
		endTime = TimeUtil.instance:dateStr2TimeStamp(data:getDiscountEndTime())
	end

	if beginT then
		if endT then
			if ServerTime.now() < endT and beginT <= ServerTime.now() then
				offset = endT - ServerTime.now()
			end
		elseif beginT > ServerTime.now() then
			offset = beginT - ServerTime.now()
		end
	elseif endT and ServerTime.now() < endT then
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
	self._countGo = nil
	self._txtCount = nil
	self._txtPrice1 = nil
	self._txtPrice2 = nil
	self._imgPriceIcon = nil
	self._txtName = nil
	self._sellOutGo = nil
	self._txtLimitNum = nil

	removetimer(self._updateTimer, self)
	self:_stopCounter()
end

return M
