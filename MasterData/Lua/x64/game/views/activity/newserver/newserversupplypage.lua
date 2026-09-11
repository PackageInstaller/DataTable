local NewServerSupplyPage = class("NewServerSupplyPage", ReduxView)

function NewServerSupplyPage:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/NewServer/NewServerShopUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function NewServerSupplyPage:Init()
	self:InitUI()

	self.giftList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, RechargeGiftItem)
end

function NewServerSupplyPage:AddEventListeners()
	self:RegistEventListener(SHOP_LIST_UPDATE, function(arg_4_0)
		if arg_4_0 > 0 and arg_4_0 == self.curShopId_ then
			self:RefreshList()
		end
	end)
	self:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_5_0, arg_5_1)
		self:RefreshShopGoodInfo(arg_5_0, arg_5_1)
	end)
	self:RegistEventListener(RECHARGE_SUCCESS, function(arg_6_0)
		self:RefreshList()
	end)
end

function NewServerSupplyPage:InitUI()
	self:BindCfgUI()
end

function NewServerSupplyPage:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)

	if arg_8_1 == true then
		self:AddEventListeners()
	else
		self:RemoveAllEventListener()
	end
end

function NewServerSupplyPage:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function NewServerSupplyPage:Dispose()
	NewServerSupplyPage.super.Dispose(self)

	if self.giftList_ then
		self.giftList_:Dispose()

		self.giftList_ = nil
	end
end

function NewServerSupplyPage:SetData()
	self.curShopId_ = ShopConst.SHOP_ID.NEW_SERVER_SHOP
	self.shopDataList_ = self:InitShopList(self.curShopId_)

	self.giftList_:StartScroll(#self.shopDataList_)
end

function NewServerSupplyPage:IndexItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.shopDataList_[arg_12_1])
	arg_12_2:SetOutOfDateHandler(handler(self, self.OnItemOutOfDate))
end

function NewServerSupplyPage:OnItemOutOfDate(arg_13_1)
	self:RefreshList()

	if #self.shopDataList_ == 0 and self.treeRefreshHandler_ ~= nil then
		self.treeRefreshHandler_()
	end
end

function NewServerSupplyPage:RefreshList()
	self.shopDataList_ = self:InitShopList(self.curShopId_)

	self.giftList_:StartScroll(#self.shopDataList_)
end

function NewServerSupplyPage:InitShopList(arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs((ShopTools.FilterShopDataList(arg_15_1))) do
		if RechargeShopDescriptionCfg[getShopCfg(iter_15_1.id).description] ~= nil then
			table.insert(var_15_0, iter_15_1)
		end
	end

	table.sort(var_15_0, function(arg_16_0, arg_16_1)
		local var_16_0 = getShopCfg(arg_16_0.id)
		local var_16_1 = getShopCfg(arg_16_1.id)
		local var_16_2 = self:GetGoodStatus(arg_16_0.id, arg_15_1)
		local var_16_3 = self:GetGoodStatus(arg_16_1.id, arg_15_1)

		if var_16_2 ~= var_16_3 then
			return var_16_2 < var_16_3
		end

		local var_16_4 = var_16_0.cost
		local var_16_5 = var_16_1.cost

		if var_16_0.cost == 0 and var_16_5 ~= 0 or var_16_5 == 0 and var_16_4 ~= 0 then
			return var_16_4 < var_16_5
		end

		local var_16_6 = var_16_0.tag
		local var_16_7 = var_16_1.tag

		if var_16_0.tag == 1 and var_16_7 == 0 or var_16_6 == 0 and var_16_7 == 1 then
			return var_16_7 < var_16_6
		end

		if var_16_0.shop_sort ~= var_16_1.shop_sort then
			return var_16_0.shop_sort > var_16_1.shop_sort
		end

		return var_16_0.goods_id > var_16_1.goods_id
	end)

	return var_15_0
end

function NewServerSupplyPage:GetGoodStatus(arg_17_1, arg_17_2)
	local var_17_1 = getShopCfg(arg_17_1, arg_17_2)
	local var_17_2 = ShopData.GetShop(var_17_1.shop_id)[arg_17_1]

	if ShopData.IsGoodOutOfDate(arg_17_1, arg_17_2) then
		return 2
	end

	if (var_17_2 ~= nil and var_17_1.limit_num ~= nil and var_17_1.limit_num ~= -1 and var_17_1.limit_num - var_17_2.buy_times <= 0 or nil) and true then
		return 2
	end

	if ShopData.IsGoodUnlock(arg_17_1, arg_17_2) == 0 then
		return 1
	end

	return 0
end

function NewServerSupplyPage:RefreshShopGoodInfo(arg_18_1, arg_18_2)
	if self.curShopId_ ~= arg_18_1 then
		return
	end

	for iter_18_0, iter_18_1 in pairs(self.giftList_:GetItemList()) do
		if arg_18_2 == iter_18_1.goodId_ then
			iter_18_1:SetData(iter_18_1.index_, iter_18_1.shopId_, iter_18_1.goodId_)
		end
	end
end

function NewServerSupplyPage:OnShopBuyResult(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if arg_19_1 == 0 then
		self:RefreshList()
	end
end

return NewServerSupplyPage
