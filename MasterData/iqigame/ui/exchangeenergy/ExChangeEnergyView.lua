-- chunkname: @IQIGame\\UI\\ExChangeEnergy\\ExChangeEnergyView.lua

local m = {
	ItemTabs = {},
	SelectItems = {}
}
local exChangeEnergyItem = require("IQIGame.UI.ExChangeEnergy.ExChangeEnergyItem")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickExChangeBtn()
		self:OnClickExChangeBtn()
	end

	function self.DelegateOnClickCancelBtn()
		self:OnClickCancelBtn()
	end

	function self.DelegateUpdateItem()
		self:OnUpDateItem()
	end

	function self.DelegateUseItemResultEvent()
		self:UseItemResultEvent()
	end

	function self.DelegateBuyItemResultEvent()
		self:BuyItemResultEvent()
	end

	function self.DelegateOnSelectItem(energyItem)
		self:OnSelectItem(energyItem)
	end

	function self.DelegateOnCancelSelectItem()
		self:OnCancelItem()
	end

	self.CancelBtnCom = self.CancelBtn:GetComponent("Button")
	self.ItemPool = UIViewObjectPool.New(self.Item, self.ItemContent.transform, function(_view)
		return exChangeEnergyItem.New(_view, self.DelegateOnSelectItem, self.DelegateOnCancelSelectItem)
	end)

	UGUIUtil.SetTextsInChildren(self.ConfirmBtn, BuyEnergyUIApi:GetConfrimButtonText())
	UGUIUtil.SetTextsInChildren(self.CancelBtn, BuyEnergyUIApi:GetCancelBtnTitle())
	self:AddListeners()
end

function m:AddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExChangeBtn)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCancelBtn)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	EventDispatcher.AddEventListener(EventID.BuyItemResult, self.DelegateBuyItemResultEvent)
end

function m:RemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExChangeBtn)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCancelBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.BuyItemResult, self.DelegateBuyItemResultEvent)
end

function m:SetData()
	self:SetTipsState(0)

	local cfgItemCidList = CfgDiscreteDataTable[37].Data
	local tempItemCids = {}

	for _, v in ipairs(cfgItemCidList) do
		local num = WarehouseModule.GetItemNumByCfgID(v)

		if num > 0 then
			table.insert(tempItemCids, v)
		end
	end

	table.insert(tempItemCids, Constant.ItemCid.NORMAL_MONEY)

	self.itemCidList = tempItemCids

	self.ItemPool:ForItems(function(_item)
		_item:OnReduceClick()
		_item:Hide()
	end)

	self.ItemTabs = {}

	for i = 1, #self.itemCidList do
		local energyItem = self.ItemPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		energyItem:SetData(self.itemCidList[i], i)
		energyItem:Show()

		self.ItemTabs[i] = energyItem

		if i == self.normalSelectIndex then
			energyItem:OnSelectClick()
		end
	end
end

function m:OnClickExChangeBtn()
	if self.isCurrencyItem then
		if self.isMaxBuyCount then
			NoticeModule.ShowNotice(12016)

			return
		end

		local currencyNum = WarehouseModule.GetItemNumByCfgID(self.NeedMoneyCid)

		if currencyNum < self.NeedMoneyCount then
			NoticeModule.ShowNotice(12017)

			return
		end

		ShopModule.BuyItemRequest(self.shopItemData.cid, 1)
	else
		local useItems = {}

		for k, v in pairs(self.SelectItems) do
			if v.num > 0 then
				local useItemPods = {}

				useItemPods.num = v.num
				useItemPods.id = v.itemData.id
				useItemPods.selectIndex = 0

				table.insert(useItems, useItemPods)
			end
		end

		if table.len(useItems) > 0 then
			ItemModule.UseItem(useItems)
		else
			NoticeModule.ShowNotice(51015)
		end
	end
end

function m:OnSelectItem(energyItem)
	if self.LastSelectItem then
		self.LastSelectItem:OnReduceClick()
	end

	self.LastSelectItem = energyItem
	self.normalSelectIndex = energyItem.Index

	local addEnergyCount = 0

	self.isCurrencyItem = energyItem.isCurrencyItem

	if not energyItem.isCurrencyItem then
		self.SelectItems[energyItem.itemData.id] = {
			num = 1,
			itemData = energyItem.itemData
		}
		addEnergyCount = CfgItemTable[energyItem.itemData.cid].ActionParams[2]
	else
		self.shopData = ShopModule.GetShopDataWithShopID(Constant.ShopType.Energy)

		local commodityCfg = ShopModule.findOneByCommodityByShopId(self.shopData.id)

		self.shopItemData = self.shopData.itemDic[commodityCfg.Id]
		self.shopItemCfg = self.shopItemData.config
		self.isMaxBuyCount = self.shopItemData.buyNum >= self.shopItemCfg.Time

		local priceArray = {}

		for i = 1, #self.shopItemCfg.Price do
			if table.len(self.shopItemCfg.Price[i]) > 0 then
				priceArray[i] = self.shopItemCfg.Price[i]
			end
		end

		local curBuyPrice = self.shopItemData.buyNum >= #priceArray and priceArray[#priceArray] or priceArray[self.shopItemData.buyNum + 1]

		self.NeedMoneyCid = curBuyPrice[1]
		self.NeedMoneyCount = curBuyPrice[2]
		self.SelectItems[energyItem.itemData.id] = {
			itemData = energyItem.itemData,
			num = self.NeedMoneyCount
		}
		addEnergyCount = self.shopItemCfg.Number
	end

	self:SetTipsState(addEnergyCount)
end

function m:OnCancelItem()
	self.SelectItems = {}
end

function m:OnClickCancelBtn()
	self.SelectItems = {}

	UIModule.Close(Constant.UIControllerName.BuyEnergyUI)
end

function m:OnCancleAllSelect()
	for k, v in pairs(self.ItemTabs) do
		v:OnReduceClick()
	end

	EventDispatcher.Dispatch(EventID.RefreshShowEnergyEvent, 0)
end

function m:NotifyEnergyShow()
	local AllAddEnergy = 0

	for k, v in pairs(self.SelectItems) do
		AllAddEnergy = AllAddEnergy + CfgItemTable[v.itemData.cid].ActionParams[2] * v.num
	end

	EventDispatcher.Dispatch(EventID.RefreshShowEnergyEvent, AllAddEnergy)
	self:SetTipsState(AllAddEnergy)
end

function m:OnUpDateItem()
	if not self.isCurrencyItem then
		self:SetData()
	end
end

function m:BuyItemResultEvent()
	if self.isCurrencyItem then
		self:SetData()
	end
end

function m:UseItemResultEvent()
	self.SelectItems = {}
end

function m:SetTipsState(energyCount)
	if self.isCurrencyItem then
		UGUIUtil.SetText(self.TipsTitleText, BuyEnergyUIApi:GetUseCurrencyTips(self.NeedMoneyCount, energyCount, self.shopItemCfg.Time - self.shopItemData.buyNum))
	else
		UGUIUtil.SetText(self.TipsTitleText, BuyEnergyUIApi:GetUseTips(energyCount))
	end

	LuaUtility.SetGameObjectShow(self.TipsTitleText, energyCount > 0)
end

function m:Show()
	self.normalSelectIndex = 1

	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()

	self.ItemTabs = nil

	self.ItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.ItemPool = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
