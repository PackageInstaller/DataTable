local ShipGiftItem = class("ShipGiftItem", import("view.base.BasePanel"))

ShipGiftItem.SELECT_ITEM = "ShipGiftItem::selectItem"
ShipGiftItem.REFRESH_USE_ITEM_CNT = "ShipGiftItem::refreshUseItemCnt"

function ShipGiftItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function ShipGiftItem:Init()
	self.item = self._tf:Find("IconTpl")
	self.nameText = self._tf:Find("name")
	self.valueText = self._tf:Find("numberTitle/value")
	self.useCntText = self._tf:Find("count/value")
	self.selectImg = self._tf:Find("select")
	self.countPanel = self._tf:Find("count")
	self.maxBtn = self._tf:Find("count/maxBtn")
	self.addBtn = self._tf:Find("count/addBtn")
	self.subtractBtn = self._tf:Find("count/subtractBtn")
	self.favoriteTF = self.item:Find("favorite")

	setText(self._tf:Find("numberTitle"), i18n("ship_gift_cnt"))
	pressPersistTrigger(self.addBtn, 0.5, function(arg_3_0)
		if self.selectCnt >= self.maxCnt then
			return
		end

		self.selectCnt = self.selectCnt + 1

		self:emit(ShipGiftItem.REFRESH_USE_ITEM_CNT, self.selectCnt)
		self:RefreshUseCnt()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self.subtractBtn, 0.5, function(arg_4_0)
		if self.selectCnt <= (self.itemVO.count > 0 and 1 or 0) then
			return
		end

		self.selectCnt = self.selectCnt - 1

		self:emit(ShipGiftItem.REFRESH_USE_ITEM_CNT, self.selectCnt)
		self:RefreshUseCnt()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(self, self.maxBtn, function()
		self.selectCnt = self.maxCnt

		self:emit(ShipGiftItem.REFRESH_USE_ITEM_CNT, self.selectCnt)
		self:RefreshUseCnt()

		return
	end, SFX_PANEL)
	onButton(self, self.item, function()
		self:emit(BaseUI.ON_ITEM, self.itemVO.id)

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		if self.selectIndex == self.index then
			return
		end

		self:emit(ShipGiftItem.SELECT_ITEM, self.index)

		return
	end, SFX_PANEL)

	return
end

function ShipGiftItem:didEnter(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	self:RefreshData(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	updateItem(self.item, arg_8_2)
	setText(self.nameText, arg_8_2:getConfig("name"))
	setText(self.valueText, arg_8_2.count or 0)
	setActive(findTF(self.item, "icon_bg/count"), false)

	local var_8_0 = ShipGiftTools.GetItemFavoriteState(arg_8_1, arg_8_2)

	setImageSprite(self.favoriteTF, (GetSpriteFromAtlas("energy", ShipGiftTools.GetItemIntimacySpriteName(arg_8_1, arg_8_2))))
	self:RefreshSelect(arg_8_5, arg_8_4)

	return
end

function ShipGiftItem:RefreshData(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self.shipVO = arg_9_1
	self.index = arg_9_3
	self.itemVO = arg_9_2
	self.selectCnt = arg_9_4
	self.maxCnt = ShipGiftTools.GetNeedMaxCnt(arg_9_1, arg_9_2)

	return
end

function ShipGiftItem:RefreshSelect(arg_10_1, arg_10_2)
	local var_10_0 = self.index == arg_10_1

	self.selectIndex = arg_10_1

	setActive(self.selectImg, var_10_0)
	setActive(self.countPanel, var_10_0)

	self.selectCnt = arg_10_2

	if var_10_0 == true then
		self:RefreshUseCnt()
	end

	return
end

function ShipGiftItem:RefreshUI(arg_11_1, arg_11_2)
	self:RefreshSelect(arg_11_1, arg_11_2)

	return
end

function ShipGiftItem:RefreshUseCnt()
	if self.selectCnt >= self.maxCnt then
		self.selectCnt = self.maxCnt

		setGray(self.addBtn, true)
	else
		setGray(self.addBtn, false)
	end

	if self.selectCnt <= (self.itemVO.count > 0 and 1 or 0) then
		setGray(self.subtractBtn, true)
	else
		setGray(self.subtractBtn, false)
	end

	setText(self.useCntText, self.selectCnt)

	return
end

function ShipGiftItem:willExit()
	return
end

function ShipGiftItem:Dispose()
	self:detach()

	return
end

return ShipGiftItem
