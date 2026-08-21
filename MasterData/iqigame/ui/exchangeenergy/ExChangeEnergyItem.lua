-- chunkname: @IQIGame\\UI\\ExChangeEnergy\\ExChangeEnergyItem.lua

local m = {
	needNum = 0,
	isSelect = false,
	selectCount = 0,
	isCurrencyItem = false
}

function m.New(view, onSelectItem, onCancelSelectItem)
	local obj = Clone(m)

	obj:Init(view, onSelectItem, onCancelSelectItem)

	return obj
end

function m:Init(view, onSelectItem, onCancelSelectItem)
	self.View = view
	self.onSelectItem = onSelectItem
	self.onCancelSelectItem = onCancelSelectItem

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateSelectClick()
		self:OnSelectClick()
	end

	self.CommonSlot = ItemCell.New(self.CommonSlotUI, false, false)

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateSelectClick)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateSelectClick)
end

function m:SetData(itemCid, index)
	self.Index = index
	self.ItemNum = WarehouseModule.GetItemNumByCfgID(itemCid)
	self.isCurrencyItem = itemCid == Constant.ItemCid.NORMAL_MONEY

	if self.isCurrencyItem then
		self.shopData = ShopModule.GetShopDataWithShopID(Constant.ShopType.Energy)

		local commodityCfg = ShopModule.findOneByCommodityByShopId(self.shopData.id)

		self.shopItemData = self.shopData.itemDic[commodityCfg.Id]
		self.shopItemCfg = self.shopItemData.config
		self.isMaxBuyCount = self.shopItemData.buyNum >= self.shopItemCfg.Time

		local curBuyPrice = self.shopItemData.buyNum >= self.shopItemCfg.Time and self.shopItemCfg.Price[#self.shopItemCfg.Price] or self.shopItemCfg.Price[self.shopItemData.buyNum + 1]

		self.needNum = curBuyPrice[2]
	else
		self.needNum = 1
	end

	self.itemData = nil

	if self.ItemNum <= 0 then
		self.itemData = ItemData.CreateByCIDAndNumber(itemCid, self.ItemNum)
	else
		self.itemData = WarehouseModule.GetItemDataByCfgID(itemCid)
	end

	self.CommonSlot:SetItem(self.itemData)
	self.CommonSlot:SetNum(self.ItemNum)

	self.isSelect = false

	self:RefreshSelectCountAndState(false)
end

function m:OnSelectClick()
	if self.isSelect then
		return
	end

	if self.onSelectItem then
		self.onSelectItem(self)
	end

	self:RefreshSelectCountAndState(true)

	self.isSelect = true
end

function m:OnReduceClick()
	if self.onCancelSelectItem then
		self.onCancelSelectItem()
	end

	self.isSelect = false

	self:RefreshSelectCountAndState(false)
end

function m:RefreshSelectCountAndState(state)
	LuaUtility.SetTransGameObjectShow(self.CheckState.transform, state)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self.itemData = nil

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
