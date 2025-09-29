-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreBuyConfirmView.lua

module("logic.extensions.store.view.StoreBuyConfirmView", package.seeall)

local M = class("StoreBuyConfirmView", ViewComponent)
local enoughColor = "#FFFFFF"
local unEnoughColor = "#C93B3B"

function M:buildUI()
	self._imgGiftBagIcon = self:getImage("store_shopping_tips_copy_-1502454849")
	self._goodsItem = self:getGo("1&rewards_detail_item_2141037416")
	self._txtGoodsName = self:getText("store_shopping_tips_copy_-1642614107")
	self._txtGoodsDesc = self:getText("store_shopping_tips_copy_-88665914")
	self._goDiscount = self:getGo("store_shopping_tips_copy_313245291")
	self._txtDiscount = self:getText("store_shopping_tips_copy_-708048424")
	self._imgCostIcon = self:getImage("store_shopping_tips_copy_-1537453763")
	self._txtOwnCount = self:getText("store_shopping_tips_copy_439682896")
	self._txtPrice = self:getText("store_shopping_tips_copy_-1646617434")
	self._txtOldPrice = self:getText("store_shopping_tips_copy_-760063296")
	self._txtTime = self:getText("store_shopping_tips_copy_-267484573")
	self._btnCancel = self:getBtn("5&btn_left_-1571983320")
	self._btnConfirm = self:getBtn("5&btn_right_1251431307")
	self._btnClose = self:getBtn("universal_second_tips_common_bg_1201003252")
	self._btnConfirm2 = self:getBtn("8&btn_left_-1571983320")
	self._txtBtnConfirm = self:getText("6&btn_right_1648124116")
	self._txtBtnConfirm2 = self:getText("8&btn_left_423343501")
	self._txtTitle = self:getText("universal_second_tips_common_bg_-1535781828")
	self._goRightTotalPrice = self:getGo("10&com_price_1317146225")
	self._costCellRight = PrefabReferenceUtil.createCurrencyCostLuaCell(self._goRightTotalPrice)
	self._goLeftTotalPrice2 = self:getGo("9&com_price_1317146225")
	self._costCellLeft = PrefabReferenceUtil.createCurrencyCostLuaCell(self._goLeftTotalPrice2)
	self._goSplitReward = self:getGo("store_shopping_tips_copy_-585123073")
	self._goSplitReward1 = self:getGo("2&rewards_detail_item_2141037416")
	self._goSplitReward2 = self:getGo("3&rewards_detail_item_2141037416")

	goutil.setActive(self._goSplitReward1, false)
	goutil.setActive(self._goSplitReward2, false)

	self._goExchange = self:getGo("store_shopping_tips_copy_-1960190562")
	self._txtBuyNum = self:getText("store_shopping_tips_copy_945445021")
	self._sliderBuyNum = self:getSlider("store_shopping_tips_copy_-498499585")
	self._btnMinus = self:getBtn("store_shopping_tips_copy_1168728181")
	self._btnAdd = self:getBtn("store_shopping_tips_copy_1005045188")
	self._minusCG = self:getUIComponent("store_shopping_tips_copy_-466718276", ComponentType.CanvasGroup)
	self._addCG = self:getUIComponent("store_shopping_tips_copy_-1745038159", ComponentType.CanvasGroup)
	self._goMask = self:getGo("store_shopping_tips_copy_-1881529412")
	self._goGifBag = self:getGo("store_shopping_tips_copy_502318764")
	self._goReward = self:getGo("4&rewards_detail_item_2141037416")

	goutil.setActive(self._goReward, false)

	self._goodsItemCell = Astral.LuaComponentContainer.Add(self._goodsItem, StoreItemCell)
	self._goMonthCardIcon = self:getGo("store_shopping_tips_copy_-2108674083")
	self._buyNum = 1
	self._price = 0
	self._rewardItemList = {}
	self._curRewardItems = {}
	self._laterRewardItems = {}
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnConfirm2:AddClickListener(self._onClickConfirm2, self)
	self._btnMinus:AddClickListener(self._onClickMinus, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._sliderBuyNum:AddOnValueChanged(self._onSliderValueChanged, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnMinus:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._sliderBuyNum:RemoveOnValueChanged()
	self._btnConfirm2:RemoveClickListener()
end

function M:onEnter()
	self._buyMax = 1
	self._buyMin = 1
	self._goodsMo = self:getFirstParam()
	self._goodsType = self._goodsMo:getGoodsType()

	self._btnConfirm:RemoveClickListener()
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)

	self._txtBtnConfirm.text = lang("tip_common_confirm")

	self._costCellRight:setIsBlockClick(false)

	if self._goodsType == StoreEnum.GoodsType.Skin then
		self:_initSkinGoods()
	elseif self._goodsType == StoreEnum.GoodsType.GiftBag then
		self:_initGiftBagGoods()
	elseif self._goodsType == StoreEnum.GoodsType.MonthlyCard then
		self:_initMonthCardGoods()
	elseif self._goodsType == StoreEnum.GoodsType.Normal then
		self:_initNormalGoods()
	end

	self._txtTitle.text = StoreUtil.getBuyConfirmTitleNme(self._goodsType)

	self:_setEvent(true)
	self:_updateMoneyView()
end

function M:onExit()
	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_EVENT, self._handleJump, self)
	else
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_EVENT, self._handleJump, self)
	end
end

function M:destroyUI()
	self._rewardItemList = nil

	IconLoader.clearSprite(self._imgCostIcon)
	IconLoader.clearSprite(self._imgGiftBagIcon)
end

function M:_initSkinGoods()
	self._buyNum = 1
	self._buyMax = 1
	self._sliderBuyNum.slider.maxValue = self._buyMax
	self._sliderBuyNum.slider.minValue = 0
	self._txtOwnCount.text = langF("tip_store_has_num", 0)

	goutil.setActive(self._goodsItem, true)
	goutil.setActive(self._imgGiftBagIcon.gameObject, false)

	local skinId = self._goodsMo:getSkinId()
	local itemData = ItemUtil.createItemData({
		count = 0,
		itemId = skinId
	})

	self._goodsItemCell:updateData(itemData)
	self._goodsItemCell:getComponent("num"):setCountTextActive(false)
	self._goodsItemCell:getComponent("normal"):setClickListener(self._clickCell, self)
	self._sliderBuyNum:SetValue(self._buyMin)
	self:_initUniversalView()
	self:_updateBtnColor()
	self:_setGoActive(1)
	self:_setSliderState(false)
end

function M:_initMonthCardGoods()
	self._buyNum = 1

	local remainedDay = self._goodsMo:getRemainedDay()

	goutil.setActive(self._txtOwnCount.gameObject, remainedDay > 0)

	self._txtOwnCount.text = remainedDay > 0 and langF("tip_store_monthcard_remaining", remainedDay) or ""

	goutil.setActive(self._goodsItem, false)
	goutil.setActive(self._imgGiftBagIcon.gameObject, false)
	self:_initUniversalView()
	self:_setGoActive(2)

	local dailyRewardStr = self._goodsMo:getDailyReward()
	local rewardStr = self._goodsMo:getReward()
	local dailyReward = StoreUtil.formatText(dailyRewardStr)[1]
	local itemDataDaily = ItemUtil.createItemData({
		itemId = dailyReward.itemId,
		count = dailyReward.num
	})
	local reward = StoreUtil.formatText(rewardStr)[1]
	local itemDataCur = ItemUtil.createItemData({
		itemId = reward.itemId,
		count = reward.num
	})

	self:_updateSplitRewards({
		itemDataCur
	}, {
		itemDataDaily
	})

	local texts = string.split(self._goodsMo:getDesc(), "|")
	local desc = texts[1]

	for i = 2, #texts do
		desc = desc .. "\n" .. texts[i]
	end

	self._txtGoodsDesc.text = desc
	self._txtPrice.text = StoreUtil.getMoneyMark(self._price)

	self._costCellRight:setCostCount(StoreUtil.getMoneyMark(self._price))
	self._costCellRight:setIsBlockClick(true)
	goutil.setActive(self._imgCostIcon.gameObject, false)
	self._costCellRight:setIconVisible(false)
	RectTransformUtils.ForceRebuildLayoutImmediate(self._goRightTotalPrice.transform)
end

function M:_initGiftBagGoods()
	self._buyNum = 1

	goutil.setActive(self._goodsItem, false)
	goutil.setActive(self._txtOwnCount.gameObject, false)
	goutil.setActive(self._imgGiftBagIcon.gameObject, true)
	self:_initUniversalView()
	self:_setGoActive(3)

	local url = StoreUtil.getGiftBagIconPath(self._goodsMo:getIcon())

	IconLoader.setSprite(self._imgGiftBagIcon, IconType.StoreIcon, url)

	local reward = self._goodsMo:getReward()

	self._rewardList = StoreUtil.formatText(reward)

	local rewardList2 = self._goodsMo:getDailyRewards()

	if #rewardList2 > 0 then
		goutil.setActive(self._goSplitReward, true)
		goutil.setActive(self._goGifBag, false)

		local rewards1 = {}

		for i = 1, #self._rewardList do
			local data = self._rewardList[i]
			local itemData = ItemUtil.createItemData({
				itemId = data.itemId,
				count = data.num
			})

			table.insert(rewards1, itemData)
		end

		local rewards2 = {}

		for i = 1, #rewardList2 do
			local data = rewardList2[i]
			local itemData = ItemUtil.createItemData({
				itemId = data.itemId,
				count = data.num
			})

			table.insert(rewards2, itemData)
		end

		self:_updateSplitRewards(rewards1, rewards2)
	else
		self:_updateRewardItems()
	end

	local hasBatch = self._goodsMo:getBatchBuyNum() > 0 and self._goodsMo:getBatchBuyCost() ~= ""

	goutil.setActive(self._goLeftTotalPrice2, hasBatch)
	goutil.setActive(self._btnConfirm2.gameObject, hasBatch)

	local myCount = ItemModel.instance:getItemCountByItemId(self._costItemId)

	if hasBatch then
		self._batchCostCount = self._goodsMo:getBatchPrice()
		self._isLeftFree = self._batchCostCount <= 0
		self._batchBuyNum = self._goodsMo:getBatchBuyNum()
		self._batchIsEough = myCount >= self._batchCostCount

		local color = self._batchIsEough and enoughColor or unEnoughColor

		if self._isLeftFree then
			self._costCellRight:setCostCount(lang("tip_store_free"))
		else
			self._costCellRight:setCostCount(string.format("<color=%s>%s</color>", color, self._batchCostCount))
		end

		self._batchCostItemId = self._goodsMo:getBatchCostItemId()

		self:_updateLeftCostIcon(self._batchCostItemId)
		self._btnConfirm:RemoveClickListener()
		self._btnConfirm:AddClickListener(self._batchBuyConfirm, self)

		self._costCount = self._price
		self._isEough = myCount >= self._costCount

		local color = self._isEough and enoughColor or unEnoughColor

		if self._costCount <= 0 then
			self._costCellLeft:setCostCount(lang("tip_store_free"))
		else
			self._costCellLeft:setCostCount(string.format("<color=%s>%s</color>", color, self._costCount))
		end

		self._txtBtnConfirm.text = langF("tip_store_buy_confirm", self._batchBuyNum)
		self._txtBtnConfirm2.text = langF("tip_store_buy_confirm", self._buyNum)
	end
end

function M:_initNormalGoods()
	self._buyNum = 1

	goutil.setActive(self._txtOwnCount.gameObject, true)
	self:_setGoActive(1)
	self:_initUniversalView()

	self._buyMin = 1
	self._buyMax = self:_getBuyMaxNum()
	self._sliderBuyNum.slider.maxValue = self._buyMax
	self._sliderBuyNum.slider.minValue = self._buyMin == self._buyMax and 0 or self._buyMin

	self._sliderBuyNum:SetValue(self._buyMin)
	self:_setNormalGoodsIcon()
	self:_updateBtnColor()
end

function M:_updateSplitRewards(curRewards, nextRewards)
	local index1 = 1

	for i = 1, #curRewards do
		if not self._curRewardItems[i] then
			local go = goutil.clone(self._goSplitReward2)

			goutil.addChildToParent(go, self._goSplitReward2.transform.parent)

			self._curRewardItems[i] = Astral.LuaComponentContainer.Add(go, StoreItemCell)
		end

		self._curRewardItems[i]:updateData(curRewards[i])
		goutil.setActive(self._curRewardItems[i]._go, true)

		index1 = index1 + 1
	end

	for i = index1, #self._curRewardItems do
		goutil.setActive(self._curRewardItems[i]._go, false)
	end

	index1 = 1

	for i = 1, #nextRewards do
		if not self._laterRewardItems[i] then
			local go = goutil.clone(self._goSplitReward1)

			goutil.addChildToParent(go, self._goSplitReward1.transform.parent)

			self._laterRewardItems[i] = Astral.LuaComponentContainer.Add(go, StoreItemCell)
		end

		self._laterRewardItems[i]:updateData(nextRewards[i])
		goutil.setActive(self._laterRewardItems[i]._go, true)

		index1 = index1 + 1
	end

	for i = index1, #self._laterRewardItems do
		goutil.setActive(self._laterRewardItems[i]._go, false)
	end
end

function M:_setNormalGoodsIcon()
	local useFirstItemName = string.nilorempty(self._goodsMo:getName())
	local firstReward = self._goodsMo:getFirstReward()
	local useItemIcon = string.nilorempty(self._goodsMo:getIcon())
	local itemData = ItemUtil.createItemData({
		count = 0,
		itemId = firstReward.itemId
	})
	local count = ItemModel.instance:getItemCountByItemId(firstReward.itemId)

	self._txtOwnCount.text = langF("tip_store_has_num", count)

	goutil.setActive(self._imgGiftBagIcon.gameObject, not useItemIcon)
	goutil.setActive(self._goodsItem, useItemIcon)

	if not useItemIcon then
		IconLoader.setSprite(self._imgGiftBagIcon, IconType.ItemIcon, self._goodsMo:getIcon())
	elseif itemData then
		if useFirstItemName then
			self._txtGoodsName.text = itemData:getName()
		end

		if useItemIcon then
			self._goodsItemCell:updateData(itemData)
			self._goodsItemCell:getComponent("num"):setCountTextActive(false)
			self._goodsItemCell:getComponent("normal"):setClickListener(nil, nil)
		end
	end
end

function M:_getBuyMaxNum()
	local buyLimit = self._goodsMo:getBuyLimit()
	local hisBuyLimit = self._goodsMo:getHisBuyLimit()
	local dailyBuyLimit = self._goodsMo:getDailyBuyMaxNum()
	local limit = StoreUtil.getMinLimit(0, buyLimit or 0)

	limit = StoreUtil.getMinLimit(limit, hisBuyLimit or 0)
	limit = StoreUtil.getMinLimit(limit, dailyBuyLimit or 0)

	local remainedNum = self._goodsMo:getRemainedNum()
	local onceMaxNum = self._goodsMo:getOnceMaxNum()
	local dailyBuyNum = self._goodsMo:getDailyBuyNum()
	local dailyBuyMaxNum = self._goodsMo:getDailyBuyMaxNum()

	if limit > 0 then
		self._canBuyMax = remainedNum ~= -1 and remainedNum or limit
		self._isBuyLimit = self._canBuyMax > 0

		if onceMaxNum > 0 and dailyBuyMaxNum > 0 then
			local dailyRemainedNum = dailyBuyMaxNum - dailyBuyNum > 0 and dailyBuyMaxNum - dailyBuyNum or 0
			local onceRemainedNum = onceMaxNum

			if self._isBuyLimit then
				if dailyRemainedNum <= onceRemainedNum and dailyRemainedNum <= remainedNum then
					self._canBuyMax = dailyRemainedNum
				elseif onceRemainedNum <= dailyRemainedNum and onceRemainedNum <= remainedNum then
					self._canBuyMax = onceRemainedNum
				elseif remainedNum > 0 and remainedNum <= dailyRemainedNum and remainedNum <= onceRemainedNum then
					self._canBuyMax = remainedNum
				end
			end
		elseif onceMaxNum > 0 then
			if onceMaxNum < self._canBuyMax then
				self._canBuyMax = onceMaxNum
			end
		elseif dailyBuyMaxNum > 0 then
			self._canBuyMax = dailyBuyMaxNum - dailyBuyNum > 0 and dailyBuyMaxNum - dailyBuyNum or 0
		end
	elseif dailyBuyMaxNum > 0 then
		self._canBuyMax = dailyBuyMaxNum - dailyBuyNum > 0 and dailyBuyMaxNum - dailyBuyNum or 0

		if onceMaxNum > 0 and onceMaxNum < self._canBuyMax then
			self._canBuyMax = onceMaxNum
		end
	elseif onceMaxNum > 0 then
		self._canBuyMax = onceMaxNum
	else
		self._canBuyMax = 999
	end

	if self._costItemId then
		local myCount = ItemModel.instance:getItemCountByItemId(self._costItemId)

		if self._price ~= 0 then
			local myMax = math.floor(myCount / self._price)

			if myMax == 0 then
				myMax = 1
			end

			if myMax < self._canBuyMax then
				self._canBuyMax = myMax
			end
		end
	end

	return self._canBuyMax
end

function M:_setGoActive(vale)
	goutil.setActive(self._goExchange, vale == 1)
	goutil.setActive(self._goSplitReward, vale == 2)
	goutil.setActive(self._goGifBag, vale == 3)
	goutil.setActive(self._goMonthCardIcon, vale == 2)
	self:_setSliderState(vale == 1)
	goutil.setActive(self._goLeftTotalPrice2, false)
	goutil.setActive(self._btnConfirm2.gameObject, false)
end

function M:_initUniversalView()
	self._txtGoodsName.text = self._goodsMo:getName()
	self._txtGoodsDesc.text = self:_getGoodDesc()

	local isDiscount = self._goodsMo:getIsDiscount()

	goutil.setActive(self._goDiscount, isDiscount)
	goutil.setActive(self._txtOldPrice.gameObject, isDiscount)

	if isDiscount then
		self._price = self._goodsMo:getDiscountPrice()
		self._txtOldPrice.text = self._goodsMo:getPrice()
		self._costItemId = self._goodsMo:getDiscountedCostItemId()
		self._txtDiscount.text = StoreUtil.getDiscount(self._goodsMo:getDiscount(), true)
	else
		self._costItemId = self._goodsMo:getCostItemId()
		self._price = self._goodsMo:getPrice()
	end

	self._isRightFree = self._price <= 0

	self:_updateCostIcon(self._costItemId)

	self._txtPrice.text = self._isRightFree and lang("tip_store_free") or self._price

	self:_updateTotalPrice()

	local leftTime = self._goodsMo:getGoodsTimeStr()

	self._txtTime.text = leftTime

	goutil.setActive(self._txtTime.gameObject, leftTime ~= "")
end

function M:_getGoodDesc()
	local content = self._goodsMo:getDesc()

	if content ~= "" then
		return content
	end

	local rewardList = StoreUtil.formatText(self._goodsMo:getReward())

	if #rewardList ~= 1 then
		return content
	end

	local itemData = ItemUtil.createItemData({
		itemId = rewardList[1].itemId,
		count = rewardList[1].num
	})

	if itemData then
		if GameEnum.ItemTypeEnum.HeroType == itemData:getType() then
			local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(itemData:getItemId())

			if heroInfoCO then
				return heroInfoCO.baseInfo
			end
		else
			return itemData:getItemUseDesc()
		end
	end

	return content
end

function M:_updateTotalPrice()
	if not self._costItemId then
		return
	end

	self._txtBuyNum.text = self._buyNum
	self._costCount = self._price * self._buyNum

	local myCount = ItemModel.instance:getItemCountByItemId(self._costItemId)

	self._isEough = myCount >= self._costCount

	local color = self._isEough and enoughColor or unEnoughColor

	if self._isRightFree then
		self._costCellRight:setCostCount(lang("tip_store_free"))
	else
		self._costCellRight:setCostCount(string.format("<color=%s>%s</color>", color, self._costCount))
	end
end

function M:_updateCostIcon(itemId)
	if itemId then
		MoneyUtil.setMoneyIcon(self._imgCostIcon, itemId)
		self._costCellRight:updateData(itemId)
	end

	goutil.setActive(self._imgCostIcon.gameObject, itemId and not self._isRightFree)
	self._costCellRight:setIconVisible(itemId and not self._isRightFree)
	RectTransformUtils.ForceRebuildLayoutImmediate(self._goRightTotalPrice.transform)
end

function M:_updateLeftCostIcon(itemId)
	if itemId then
		self._costCellLeft:updateData(itemId)
	end

	self._costCellLeft:setIconVisible(itemId and not self._isLeftFree)
	RectTransformUtils.ForceRebuildLayoutImmediate(self._goLeftTotalPrice2.transform)
end

function M:_onClickCancel()
	self:_close()
end

function M:_onClickConfirm()
	self:_sendBuyGoodsRequest()
	self:_close()
end

function M:_batchBuyConfirm()
	self._isEough = self._batchIsEough
	self._costCount = self._batchCostCount
	self._buyNum = self._batchBuyNum
	self._costItemId = self._batchCostItemId

	self:_sendBuyGoodsRequest()
	self:_close()
end

function M:_onClickConfirm2()
	self:_sendBuyGoodsRequest()
	self:_close()
end

function M:_onClickClose()
	self:_close()
end

function M:_close()
	StoreModel.instance:setJumpInfo(false)
	self:close()
end

function M:_onClickMinus()
	self._buyNum = self._buyNum - 1

	if self._buyNum < self._buyMin then
		self._buyNum = self._buyMin
	end

	self._sliderBuyNum.slider.value = self._buyNum

	self:_updateTotalPrice()
	self:_updateBtnColor()
end

function M:_onClickAdd()
	self._buyNum = self._buyNum + 1

	if self._buyNum > self._buyMax then
		self._buyNum = self._buyMax
	end

	self._sliderBuyNum.slider.value = self._buyNum

	self:_updateTotalPrice()
	self:_updateBtnColor()
end

function M:_clickCell()
	return
end

function M:_updateBtnColor()
	self._minusCG.alpha = self._buyNum <= self._buyMin and 0.2 or 1
	self._addCG.alpha = self._buyNum >= self._buyMax and 0.2 or 1

	goutil.setActive(self._goMask, self._buyMin == self._buyMax)
end

function M:_onSliderValueChanged(value)
	self._buyNum = value

	self:_updateTotalPrice()
	self:_updateBtnColor()
end

function M:_updateRewardItems()
	for i = 1, #self._rewardList do
		local rewardItem = self._rewardItemList[i]

		if not rewardItem then
			local go = goutil.cloneAndSetParent(self._goReward, self._goReward.transform.parent)

			rewardItem = Astral.LuaComponentContainer.Add(go, StoreItemCell)
			self._rewardItemList[i] = rewardItem
		end

		goutil.setActive(rewardItem._go, true)

		local data = self._rewardList[i]
		local itemData = ItemUtil.createItemData({
			itemId = data.itemId,
			count = data.num
		})

		rewardItem:updateData(itemData)
	end

	for i = #self._rewardList + 1, #self._rewardItemList do
		goutil.setActive(self._rewardItemList[i]._go, false)
	end
end

function M:_sendBuyGoodsRequest()
	if self._goodsType == StoreEnum.GoodsType.MonthlyCard then
		self:_buyMothCard()

		return
	end

	if not self._isEough then
		if self._costItemId == GameEnum.CurrencyCodeEnum.CfjzCode or self._costItemId == GameEnum.CurrencyCodeEnum.YtjjCode then
			self:_showJumpDialog()

			return
		end

		local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._costItemId)

		if itemCo then
			FloatWordMgr.instance:show(langF("tip_store_item_not_enough", itemCo.name))
		end

		return
	end

	if self._buyNum < 1 then
		return
	end

	if not self:_checkIsCanAddBackPack() then
		return
	end

	local costItems = StoreUtil.createCostItems(self._costItemId, self._costCount)

	StoreAgent.instance:sendBuyGoodsRequest(self._goodsMo:getGoodsId(), self._buyNum, costItems)
end

function M:_showJumpDialog()
	local storeId = StoreEnum.StoreId.SecondExchange

	if self._costItemId == GameEnum.CurrencyCodeEnum.CfjzCode then
		storeId = StoreEnum.StoreId.TranscendentalMedium
	end

	local storeMo = StoreModel.instance:getStoreMoByID(storeId)
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._costItemId)

	if not storeMo or not itemCo then
		return
	end

	self:_close()

	local content = langF("tip_store_not_enough_jump", itemCo.name, storeMo:getName())
	local dialog = Dialog.showMessage(lang("tip_title"), content)

	dialog:setConfirmListener(function()
		local tabId = StoreModel.instance:getTabIdByStoreId(storeId)

		StoreMainFacade.instance:jumpToStore(tabId, storeId)
	end, nil)
end

function M:_checkIsCanAddBackPack()
	local rewardList = StoreUtil.formatText(self._goodsMo:getReward())
	local itemIds = {}

	for i = 1, #rewardList do
		table.insert(itemIds, rewardList[i].itemId)
	end

	if not MainBackpackModel.instance:isCanAddToBackPack(itemIds) then
		FloatWordMgr.instance:show(lang("tip_backpack_upper_limit_store"))

		return false
	end

	return true
end

function M:_buyMothCard()
	StoreController.instance:buyMothCard(self._goodsMo)
end

function M:_setSliderState(value)
	goutil.setActive(self._sliderBuyNum.gameObject, value)
	goutil.setActive(self._btnMinus.gameObject, value)
	goutil.setActive(self._btnAdd.gameObject, value)
end

function M:_handleJump()
	local tabId = self._goodsMo:getTabId()
	local storeId = self._goodsMo:getStoreId()
	local index = StoreModel.instance:getStoreTabIndexById(tabId)
	local goodsId = self._goodsMo:getGoodsId()

	StoreModel.instance:setJumpInfo({
		index = index,
		tabId = tabId,
		targetStoreId = storeId,
		targetGoodsId = goodsId
	})
	self:close()
end

function M:_updateMoneyView()
	if not self._goodsMo then
		return
	end

	local storeCO = StoreConfig.instance:getStoreCO(self._goodsMo:getStoreId())

	if storeCO then
		self._viewPresentor:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, nil, storeCO.showCoin)
	end
end

return M
