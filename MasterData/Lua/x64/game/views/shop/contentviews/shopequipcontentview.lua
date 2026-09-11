local ShopEquipContentView = class("ShopEquipContentView", ShopContentViewBase)

function ShopEquipContentView:InitUI()
	self.gameObject_ = Object.Instantiate(Asset.Load("UI/Shop/contentViews/equipView"), self.containerGo_.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ExchangeItemView)
	self.positionDropdown_ = self.positionDropdownGo_.transform:GetComponent("Dropdown")
	self.suitDropdown_ = self.suitDropdownGo_.transform:GetComponent("Dropdown")
end

function ShopEquipContentView:AddUIListener()
	self:AddToggleListener(self.positionDropdown_, function(arg_3_0)
		self.selectedPos = arg_3_0 == 0 and 0 or arg_3_0

		self:UpdateListByFilter()
	end)
	self:AddToggleListener(self.suitDropdown_, function(arg_4_0)
		if arg_4_0 == 0 then
			self.selectedSuitId = 0

			OperationRecorder.Record("shop", "shop_equip_all")
		else
			self.selectedSuitId = EquipSuitCfg[self:GetShopSuits()[arg_4_0]].id

			OperationRecorder.Record("shop", "shop_equip_one")
		end

		self:UpdateListByFilter()
	end)
end

function ShopEquipContentView:ResetFilter()
	self.positionDropdown_.value = 0
	self.suitDropdown_.value = 0
end

function ShopEquipContentView:InitEquipDropdownData()
	self.positionDropdown_.options:Clear()

	local var_6_0 = GetTips("ALL_POSITION")

	self.positionDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format((ShopListCfg[self.shopId_].params ~= nil and #ShopListCfg[self.shopId_].params > 0 and ShopListCfg[self.shopId_].params[1].POS_ALL_LABEL ~= nil or nil) and GetTips(ShopListCfg[self.shopId_].params[1].POS_ALL_LABEL))))

	for iter_6_0 = 1, 6 do
		self.positionDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(GetTips("POSITION_TIP"), iter_6_0)))
	end

	self.positionDropdown_:RefreshShownValue()
	self.suitDropdown_.options:Clear()

	local var_6_1 = GetTips("ALL_EQUIP")

	self.suitDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format((ShopListCfg[self.shopId_].params ~= nil and #ShopListCfg[self.shopId_].params > 0 and ShopListCfg[self.shopId_].params[1].SUIT_ALL_LABEL ~= nil or nil) and GetTips(ShopListCfg[self.shopId_].params[1].SUIT_ALL_LABEL)), allIcon))

	local var_6_2 = self:GetShopSuits()

	for iter_6_1 = 1, #var_6_2 do
		self.suitDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(EquipSuitCfg[var_6_2[iter_6_1]].name, (AtlasManager.GetSpriteWithoutAtlas(SpritePathCfg.EquipIcon_s.path .. EquipSuitCfg[var_6_2[iter_6_1]].equip_skill_icon))))
	end

	self.suitDropdown_:RefreshShownValue()
end

function ShopEquipContentView:GetShopSuits()
	local var_7_0 = {}
	local var_7_1 = HideInfoData:GetEquipSuitHideList()

	for iter_7_0, iter_7_1 in ipairs(ShopData.GetShop(self.shopId_).shopItemIDs) do
		local var_7_2 = getShopCfg(iter_7_1, self.shopId_)

		if var_7_2.taken_down == 0 then
			if ItemCfg[var_7_2.give_id].type == ItemConst.ITEM_TYPE.EQUIP then
				if table.indexof(var_7_0, EquipCfg[var_7_2.give_id].suit) == false and not var_7_1[EquipCfg[var_7_2.give_id].suit] then
					table.insert(var_7_0, EquipCfg[var_7_2.give_id].suit)
				end
			end
		end
	end

	return var_7_0
end

function ShopEquipContentView:UpdateListByFilter()
	self:RefreshList()
end

function ShopEquipContentView:RefreshList(arg_9_1)
	ShopEquipContentView.super.RefreshList(self, arg_9_1)

	self.shopDataList_ = self:GetShopGoodList(self.shopId_)

	if arg_9_1 and self.list_:GetNum() == #self.shopDataList_ then
		self.list_:Refresh()
	else
		self.list_:StartScroll(#self.shopDataList_)
	end

	self:InitEquipDropdownData()
end

function ShopEquipContentView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:RegistCallBack(handler(self, self.OnShopClick))
	arg_10_2:SetData(self.shopDataList_[arg_10_1])
end

function ShopEquipContentView:GetShopGoodList()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs((ShopTools.FilterShopDataList(self.shopId_))) do
		local var_11_1 = getShopCfg(iter_11_1.id, self.shopId_)
		local var_11_2 = false
		local var_11_3 = false

		if ItemCfg[var_11_1.give_id].type == ItemConst.ITEM_TYPE.EQUIP then
			local var_11_5 = EquipCfg[var_11_1.give_id]

			var_11_2 = self.selectedSuitId == 0 or self.selectedSuitId == nil or self.selectedSuitId == var_11_5.suit
			var_11_3 = self.selectedPos == 0 or self.selectedPos == nil or self.selectedPos == var_11_5.pos
		end

		if ItemCfg[var_11_1.give_id].type == ItemConst.ITEM_TYPE.EQUIP then
			if var_11_2 and var_11_3 then
				table.insert(var_11_0, iter_11_1)
			end
		elseif (self.selectedPos == 0 or self.selectedPos == nil) and (self.selectedSuitId == 0 or self.selectedSuitId == nil) then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function ShopEquipContentView:ScrollByPosition(arg_12_1, arg_12_2)
	local var_12_0

	if arg_12_2 then
		for iter_12_0, iter_12_1 in ipairs(self.shopDataList_) do
			if iter_12_1.id == arg_12_2 then
				var_12_0 = iter_12_0

				break
			end
		end
	end

	if var_12_0 ~= nil then
		self.list_:ScrollToIndex(var_12_0)
	elseif arg_12_1 then
		self.list_:SetScrolledPosition(arg_12_1)
	end
end

function ShopEquipContentView:GetLuaList()
	return self.list_
end

function ShopEquipContentView:GetItemList()
	return self.list_:GetItemList()
end

function ShopEquipContentView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	ShopEquipContentView.super.Dispose(self)
end

return ShopEquipContentView
