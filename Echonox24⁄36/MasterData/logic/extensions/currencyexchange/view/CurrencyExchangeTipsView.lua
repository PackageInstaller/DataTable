-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/currencyexchange/view/CurrencyExchangeTipsView.lua

module("logic.extensions.currencyexchange.view.CurrencyExchangeTipsView", package.seeall)

local M = class("CurrencyExchangeTipsView", ViewComponent)

M.ColorRed = "#d9474b"

local MONEY_SHOW_TYPE = {
	[1001] = CommEnum.MoneyShowType.DefaultHideType,
	[1002] = CommEnum.MoneyShowType.DefaultHideType,
	[1003] = CommEnum.MoneyShowType.DefaultHideType,
	[1101] = CommEnum.MoneyShowType.OnlyDiamondEnergyType,
	[1102] = CommEnum.MoneyShowType.DiamondJsjjShowType,
	[1103] = CommEnum.MoneyShowType.LotteryEchoShowType,
	[1104] = CommEnum.MoneyShowType.OnlyDiamondShowType
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._topCurrencyGo = self:getGo("top_currency_1050779625")
	self._gridLayoutGroup = self._topCurrencyGo:GetComponent(UIComponentType.HorizontalOrVerticalLayoutGroup)
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "universal_second_tips_common_bg/content/txtTitle")
	self._txtDesc = self:getText("common_exchange_tips_-542329446")
	self._btnCancel = self:getBtnByPath("allContent/btnCancel")
	self._btnClose = self:getBtnByPath("universal_second_tips_common_bg/content/btnClose")
	self._btnConfirm = self:getBtnByPath("allContent/btnUse")
	self._txtBtnConfirm = goutil.findChildTextComponent(self._btnConfirm.gameObject, "normal/Text1")
	self._itemSource = Astral.LuaComponentContainer.Add(self:getGo("2&rewards_detail_item_2141037416"), ItemCell)

	self._itemSource:Awake()
	self._itemSource:getComponent("num"):setVisible(true)
	self._itemSource:setShowSelectedEffect(false)
	self._itemSource:setShowTipsPassEvent(false)

	self._itemTarget = Astral.LuaComponentContainer.Add(self:getGo("3&rewards_detail_item_2141037416"), ItemCell)

	self._itemTarget:Awake()
	self._itemTarget:getComponent("num"):setVisible(true)
	self._itemTarget:setShowSelectedEffect(false)
	self._itemTarget:setShowTipsPassEvent(false)

	self._txtUseNum = self:getText("common_exchange_tips_-1797876727")

	local longPressTriggerCfg = {
		0.6,
		0.2,
		0.01
	}

	self._btnMinus = Astral.UILongPressTrigger.Get(self:getGo("common_exchange_tips_-1148320437"))
	self._btnAdd = Astral.UILongPressTrigger.Get(self:getGo("common_exchange_tips_-1641731210"))

	self._btnAdd:SetTriggerTime(longPressTriggerCfg)
	self._btnMinus:SetTriggerTime(longPressTriggerCfg)

	self._slider = UIComponentType.SliderAdapter(self:getGo("common_exchange_tips_116018291"))
	self._uiSlider = self:getUIComponent("common_exchange_tips_116018291", UIComponentType.Slider)
	self._uiSlider.value = 0
end

function M:destroyUI()
	self._itemSource = nil
	self._itemTarget = nil
	self._topCurrencyGo = nil
	self._gridLayoutGroup = nil
	self._txtDesc = nil
	self._btnCancel = nil
	self._btnClose = nil
	self._btnConfirm = nil
	self._txtBtnConfirm = nil
	self._btnMinus = nil
	self._btnAdd = nil

	for _, value in pairs(self._cellItem or {}) do
		value:destroyUI()
	end

	self._cellItem = nil
end

function M:bindEvents()
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnAdd:AddLongPressListener(self._onLongPressAdd, self, nil)
	self._btnMinus:AddLongPressListener(self._tryMinusOne, self, nil)
	self._slider:AddOnValueChanged(self._onSliderValChanged, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnAdd:RemoveLongPressListener()
	self._btnMinus:RemoveLongPressListener()
	self._slider:RemoveOnValueChanged()

	for _, value in pairs(self._cellItem or {}) do
		value:unbindEvents()
	end
end

function M:onEnter()
	self:_setEvent(true)

	self._cellItem = {}

	local info = self:getFirstParam()

	if Astral.OSDef.isEditor then
		TableUtil.dump(info)
	end

	local isBackOpen = self._viewPresentor:getIsBackOpen()

	self._viewPresentor:getBlurView():setNoBlurOnEnter(isBackOpen)

	self._txtTitle.text = string.nilorempty(info.titleStr) and lang("tip_exchange_title") or info.titleStr
	self._id = info.id
	self._minMulti = info.minMulti
	self._multiStep = info.multiStep
	self._isMulti = info.isMulti
	self._cfgCO = CurrencyExchangeConfig.instance:getCurrencyExchange(self._id)

	if self._cfgCO == nil then
		printError("无法从[%s]找到[%s]的数据", ConfigName.CurrencyExchange, self._id)
		self:close()
	end

	self:updateCfg(self._id)

	self._isGoods = false

	self:_initUniversalInfo()
end

function M:_initGoodsInfo()
	local goodsCo = StoreConfig.instance:getNormalGoods(self._cfgCO:getGoodsId())

	if not goodsCo then
		if enableErrorLog then
			printError(string.format("StoreConfig::cannot find config for goodsId[%s]", goodsId))
		end

		return
	end

	StoreAgent.instance:sendGetGoodsListRequest({
		goodsCo.mallId
	})
end

function M:_updateGoods()
	self._goodsMo = StoreModel.instance:getGoodMoByGoodsId(self._cfgCO:getGoodsId())

	if not self._goodsMo or self._goodsMo:getSellOut() then
		self:_initUniversalInfo()

		return
	end

	self._isGoods = true
	self._costItemId = self._goodsMo:getDiscountedCostItemId()

	local isDiscount = self._goodsMo:getIsDiscount()

	self._price = self._goodsMo:getPrice()

	if isDiscount then
		self._price = self._goodsMo:getDiscountPrice()
	end

	self._maxMulti = StoreUtil.getNormalBuyMaxNum(self._goodsMo, self._costItemId, self._price)
	self._maxMulti = self._maxMulti < 1 and 1 or self._maxMulti

	if self._minMulti > self._maxMulti then
		self._minMulti = self._maxMulti
	end

	self._curMultiNum = self._minMulti
	self._uiSlider.minValue = self._minMulti
	self._uiSlider.maxValue = self._maxMulti
	self._uiSlider.value = self._curMultiNum

	self:updateItemPreUseShow()
end

function M:_initUniversalInfo()
	self._maxNum, self._maxMulti = self:_getNowCanUseMaxNum()
	self._uiSlider.minValue = self._minMulti
	self._uiSlider.maxValue = self._maxMulti
	self._curMultiNum = self._minMulti

	self:updateItemPreUseShow()
end

function M:onExit()
	self._cacheSourceItemCount = nil

	self:_setEvent(false)

	for _, value in pairs(self._cellItem or {}) do
		value:onExit()
	end
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateGoods, self)
	else
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateGoods, self)
	end
end

function M:_handleGainItemAdd(e, params)
	if self._isGoods then
		self:close()

		return
	end

	local lastSoureItemCount = self._cacheSourceItemCount

	if lastSoureItemCount and lastSoureItemCount ~= self:_getItemCount(self._cfgCO:getSourceId()) then
		self._cacheSourceItemCount = self:_getItemCount(self._cfgCO:getSourceId())
		self._maxNum, self._maxMulti = self:_getNowCanUseMaxNum()

		self:updateItemPreUseShow()
	end
end

function M:updateCfg(id)
	self._jumpId = self._cfgCO:getJumpId()

	local sourceItemId = self._cfgCO:getSourceId()
	local targetItemId = self._cfgCO:getTargetId()

	self:updateItemShow(true, sourceItemId)
	self:updateItemShow(false, targetItemId)
	self:_updateTopCurrency(id, sourceItemId, targetItemId)

	self._cacheSourceItemCount = self:_getItemCount(self._cfgCO:getSourceId())
end

function M:_onClickClose()
	self:close()
end

function M:_onClickConfirm()
	if self._isGoods then
		if not self._isEnough then
			local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._costItemId)

			if itemCo then
				FloatWordMgr.instance:show(langF("tip_store_item_not_enough", itemCo.name))

				return
			end
		end

		if self._curMultiNum > 0 then
			local costItems = StoreUtil.createCostItems(self._costItemId, self._costCount)

			StoreAgent.instance:sendBuyGoodsRequest(self._goodsMo:getGoodsId(), self._curMultiNum, costItems)
			self:close()
		end

		return
	end

	local nowMultiNum = self._curMultiNum

	if self:_getSourceEnough(nowMultiNum) then
		BackpackAgent.instance:sendExchangeCurrencyRequest(self._id, nowMultiNum)
		self:close()
	elseif self._jumpId > 0 then
		if not SystemJumpController.instance:canJump(self._jumpId, true) then
			return
		end

		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, self._jumpId)
		self:close()
	else
		FloatWordMgr.instance:show(string.format(lang("tip_store_item_not_enough"), self._cfgCO:getItemNameSource()))
	end
end

function M:updateItemPreUseShow()
	local wantedSourceNum = 0
	local wantedTargetNum = 0
	local enough = false

	if self._isGoods then
		self._costCount = self._price * self._curMultiNum

		local myCount = ItemModel.instance:getItemCountByItemId(self._costItemId)

		self._isEnough = myCount >= self._costCount
		self._firstReward = self._goodsMo:getFirstReward()
		wantedSourceNum = self._price * self._curMultiNum
		wantedTargetNum = self._curMultiNum * self._firstReward.num
		enough = self._isEnough
	else
		wantedSourceNum = self._curMultiNum * self._cfgCO:getSourceNum()
		wantedTargetNum = self._curMultiNum * self._cfgCO:getTargetNum()
		enough = self:_getSourceEnough(self._curMultiNum)
	end

	if enough then
		self._txtBtnConfirm.text = lang("tip_exchange")

		self._itemSource:getComponent("num"):setCountText(wantedSourceNum)

		self._txtDesc.text = string.format(lang("tip_cost_s_exchange_s"), wantedSourceNum, self._cfgCO:getItemNameSource(), wantedTargetNum, self._cfgCO:getItemNameTarget())
	else
		self._itemSource:getComponent("num"):setCountText(string.format("<color=%s>%d</color>", self.ColorRed, wantedSourceNum))

		if self._jumpId > 0 then
			self._txtBtnConfirm.text = lang("tip_goto_get")
			self._txtDesc.text = string.format(lang("tip_not_enough_goto"), self._cfgCO:getItemNameSource(), self.ColorRed, wantedSourceNum, self._cfgCO:getJumpDesc())
		else
			self._txtBtnConfirm.text = lang("tip_exchange")
			self._txtDesc.text = string.format(lang("tip_cost_s_exchange_s_c"), self.ColorRed, wantedSourceNum, self._cfgCO:getItemNameSource(), wantedTargetNum, self._cfgCO:getItemNameTarget())
		end
	end

	self._txtUseNum.text = wantedSourceNum

	self._itemTarget:getComponent("num"):setCountText(wantedTargetNum)
end

function M:_onSliderValChanged(val)
	self._curMultiNum = val

	self:updateItemPreUseShow()
end

function M:_onLongPressAdd()
	self:_tryAddOne(true)
end

function M:_tryAddOne(showToast)
	if self._curMultiNum >= self._maxMulti then
		return
	end

	local _readyNum = self._curMultiNum + self._multiStep

	if _readyNum > self._maxMulti then
		return
	end

	self._curMultiNum = _readyNum

	self:updateItemPreUseShow()
	self._uiSlider:SetValueWithoutNotify(self._curMultiNum)
end

function M:_tryMinusOne()
	if self._curMultiNum <= self:_getMinMulti() then
		return
	end

	local _readyNum = self._curMultiNum - self._multiStep

	if _readyNum < self:_getMinMulti() then
		return
	end

	self._curMultiNum = _readyNum

	self:updateItemPreUseShow()
	self._uiSlider:SetValueWithoutNotify(self._curMultiNum)
end

function M:_updateTopCurrency(cfgId, sourceItemId, targetItemId)
	if not MONEY_SHOW_TYPE[cfgId] then
		printWarn(string.format("没有为[%s]定义顶部资源栏配置，将使用默认配置", cfgId))
	end

	self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, MONEY_SHOW_TYPE[cfgId])
end

function M:updateItemShow(isSource, itemId)
	local itemCell = isSource and self._itemSource or self._itemTarget
	local itemData = ItemUtil.createItemData({
		itemId = itemId
	})

	itemData:setCount(1)
	itemCell:updateData(itemData)

	local countStr

	if isSource then
		itemCell:getComponent("num"):setVisible(not self._isMulti)
	end
end

function M:_getMinMulti()
	return self._minMulti or 1
end

function M:_getItemCount(itemId)
	return ItemModel.instance:getItemCountByItemId(itemId)
end

function M:_getSourceEnough(multiNum)
	local owenNum = self:_getItemCount(self._cfgCO:getSourceId())

	return owenNum >= self:_getWantedUseSourceNum(multiNum)
end

function M:_getWantedUseSourceNum(multiNum)
	return multiNum * self._cfgCO:getSourceNum()
end

function M:_getWantedGetTargetNum(multiNum)
	return multiNum * self._cfgCO:getTargetNum()
end

function M:_getTargetNumLimit()
	return self._cfgCO:getTargetLimit()
end

function M:_getNowCanUseMaxNum()
	local num = 0
	local multi = 0
	local multiMax = self._cfgCO:getMaxMultiNum()
	local owenNum = self:_getItemCount(self._cfgCO:getSourceId())

	multi = math.floor(owenNum / self._cfgCO:getSourceNum())

	if multi == 0 then
		multi = self:_getMinMulti()
		num = self:_getWantedUseSourceNum(multi)

		return num, multi
	end

	if multiMax == 0 then
		local enough = self:_getSourceEnough(multi)

		while enough do
			multi = multi + self._multiStep
			enough = self:_getSourceEnough(multi)

			if not enough then
				multi = multi - self._multiStep
			end
		end

		multi = math.floor(multi / self._multiStep) * self._multiStep
	else
		multi = multiMax <= multi and multiMax or multi
	end

	multi = multi <= self:_getMinMulti() and self:_getMinMulti() or multi
	num = self:_getWantedUseSourceNum(multi)

	return num, multi
end

return M
