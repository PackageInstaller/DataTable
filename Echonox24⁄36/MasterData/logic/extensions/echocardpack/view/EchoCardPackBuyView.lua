-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardPackBuyView.lua

module("logic.extensions.echocardpack.view.EchoCardPackBuyView", package.seeall)

local M = class("EchoCardPackBuyView", ViewComponent)

function M:buildUI()
	self._sliderBuyNum = self:getSlider("echocard_package_detail_tips_1999946804")
	self._btnMinus = self:getBtn("echocard_package_detail_tips_1341449131")
	self._btnAdd = self:getBtn("echocard_package_detail_tips_-867780005")
	self._txtBuyNum = self:getText("echocard_package_detail_tips_918184611")
	self._btnBuy = Astral.SimpleLuaComponentContainer.Add(self:getGo("5&btn_right_1251431307"), CommButton)
	self._goPrice = self:getGo("6&com_price_1317146225")
	self._txtTips = self:getText("echocard_package_detail_tips_1541602032")
	self._txtOldPrice = self:getText("echocard_package_detail_tips_18598743")
	self._goPrice = self:getGo("7&com_price_1317146225")
	self._costCell = PrefabReferenceUtil.createCurrencyCostLuaCell(self._goPrice)
	self._toggle = self:getUIComponent("echocard_package_detail_tips_-912415953", UIComponentType.SpaceXToggle)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._toggle:AddListener(self._onToggleChange, self)
	self._btnMinus:AddClickListener(self._onClickMinus, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
	self._sliderBuyNum:AddOnValueChanged(self._onSliderValueChanged, self)
end

function M:unbindEvents()
	self._toggle:RemoveListener()
	self._btnMinus:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._sliderBuyNum:RemoveOnValueChanged()
end

function M:_setEvents(add)
	return
end

function M:onEnter()
	local param = self:getOpenParam()

	if not param or param[1] == EchoCardPackController.ViewType.Use then
		return
	end

	self._goodsMo = param[3]
	self._goodsType = self._goodsMo:getGoodsType()
	self._toggle.IsOn = false
	self._isUseCard = false
	self._echoCardPackItemId = EchoCardPackConfig.instance:getCommonEchoCardCostItemId()
	self._echoCardPackNum = ItemModel.instance:getItemCountByItemId(self._echoCardPackItemId)
	self._isCanUseCard = self._echoCardPackItemId ~= self._goodsMo:getCostItemId() and self._goodsMo:isCanExchange()

	self:_initBuyData()
	self:_updateView()
end

function M:onExit()
	return
end

function M:_initBuyData()
	local onceMaxNum = self._goodsMo:getOnceMaxNum()

	onceMaxNum = onceMaxNum <= 0 and 10 or onceMaxNum
	self._buyNum = 1

	local costItemId = self._goodsMo:getCostItemId()
	local myCount = ItemModel.instance:getItemCountByItemId(costItemId)
	local canBuyNum = math.floor(myCount / self._goodsMo:getCostNum())

	if self._isCanUseCard then
		canBuyNum = canBuyNum + self._echoCardPackNum
	end

	self._buyMax = onceMaxNum < canBuyNum and onceMaxNum or canBuyNum

	if self._buyMax <= 0 then
		self._buyMax = 1
	end

	self._buyMin = self._buyMax > 1 and 1 or 0
end

function M:_updateView()
	goutil.setActive(self._toggle.gameObject, self._isCanUseCard)
	self._costCell:updateData(self._goodsMo:getCostItemId())
	self:_updateSlider()
	self:_updateTotalPrice()
end

function M:_updateSlider()
	self._sliderBuyNum.slider.value = self._buyNum
	self._sliderBuyNum.slider.maxValue = self._buyMax
	self._sliderBuyNum.slider.minValue = self._buyMin
end

function M:_onToggleChange(index, isOn)
	if self._isUseCard == isOn then
		return
	end

	if self._echoCardPackNum < 1 then
		self._toggle.IsOn = false
	end

	self._isUseCard = isOn and self._echoCardPackNum > 0

	self:_updateTotalPrice()
end

function M:_onClickMinus()
	self._buyNum = self._buyNum - 1

	if self._buyNum < self._buyMin then
		self._buyNum = self._buyMin
	end

	self._sliderBuyNum.slider.value = self._buyNum

	self:_updateTotalPrice()
end

function M:_onClickAdd()
	self._buyNum = self._buyNum + 1

	if self._buyNum > self._buyMax then
		self._buyNum = self._buyMax
	end

	self._sliderBuyNum.slider.value = self._buyNum

	self:_updateTotalPrice()
end

function M:_onSliderValueChanged(value)
	self._buyNum = value

	self:_updateTotalPrice()
end

function M:_updateTotalPrice()
	self._txtBuyNum.text = self._buyNum

	local remainingNum = self._buyNum

	self._costCount1 = 0
	self._costCount2 = 0

	if self._echoCardPackNum > 0 and self._isUseCard and self._isCanUseCard then
		self._costItemId1 = self._echoCardPackItemId

		if self._echoCardPackNum >= self._buyNum then
			remainingNum = 0
			self._costCount1 = self._buyNum
		else
			remainingNum = self._buyNum - self._echoCardPackNum
			self._costCount1 = self._echoCardPackNum
		end
	end

	self._txtTips.text = langF("tip_store_exchange_echo_card_pack", self._echoCardPackNum - self._costCount1)

	goutil.setActive(self._txtOldPrice.gameObject, self._costCount1 > 0)

	self._txtOldPrice.text = self._buyNum * self._goodsMo:getCostNum()
	self._costItemId2 = self._goodsMo:getCostItemId()
	self._costCount2 = self._goodsMo:getCostNum() * remainingNum

	local myCount = ItemModel.instance:getItemCountByItemId(self._costItemId2)

	self._isEough = myCount >= self._costCount2

	local color = self._isEough and "#FFFFFF" or "#C93B3B"

	self._costCell:setCostCount(self._costCount2, color)
	self._btnBuy:setActiveState(self._buyNum > 0)
end

function M:_onClickBuy()
	if not self._isEough then
		if self._costItemId2 == GameEnum.CurrencyCodeEnum.CfjzCode or self._costItemId2 == GameEnum.CurrencyCodeEnum.YtjjCode then
			self:_showJumpDialog()

			return
		end

		local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._costItemId2)

		if itemCo then
			FloatWordMgr.instance:show(langF("tip_store_item_not_enough", itemCo.name))
		end

		return
	end

	if self._buyNum < 1 then
		return
	end

	local costItems = {}

	if self._costCount1 > 0 then
		local costItem = {
			costId = self._costItemId1,
			costCount = self._costCount1
		}

		table.insert(costItems, costItem)
	end

	if self._costCount2 > 0 then
		local costItem = {
			costId = self._costItemId2,
			costCount = self._costCount2
		}

		table.insert(costItems, costItem)
	end

	StoreAgent.instance:sendBuyGoodsRequest(self._goodsMo:getGoodsId(), self._buyNum, costItems)
	self:close()
end

function M:_showJumpDialog()
	local storeId = StoreEnum.StoreId.SecondExchange

	if self._costItemId2 == GameEnum.CurrencyCodeEnum.CfjzCode then
		storeId = StoreEnum.StoreId.TranscendentalMedium
	end

	local storeMo = StoreModel.instance:getStoreMoByID(storeId)
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._costItemId2)

	if not storeMo or not itemCo then
		return
	end

	self:close()

	local content = langF("tip_store_not_enough_jump", itemCo.name, storeMo:getName())
	local dialog = Dialog.showMessage(lang("tip_title"), content)

	dialog:setConfirmListener(function()
		local tabId = StoreModel.instance:getTabIdByStoreId(storeId)

		StoreMainFacade.instance:jumpToStore(tabId, storeId)
	end, nil)
end

return M
