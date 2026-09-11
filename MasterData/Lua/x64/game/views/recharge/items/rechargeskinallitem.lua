local RechargeSkinAllItem = class("RechargeSkinAllItem", ReduxView)

function RechargeSkinAllItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
	SetActive(self.gameObject_, true)
end

function RechargeSkinAllItem:Init()
	self:InitUI()
end

function RechargeSkinAllItem:InitUI()
	self:BindCfgUI()

	self.skinItem = RechargeSkinNewItem.New(self.skinGo_)
	self.dlcItem = RechargeSkinDlcItem.New(self.dlcGo_)
end

function RechargeSkinAllItem:SetItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.data[arg_4_1])
end

function RechargeSkinAllItem:SetData(arg_5_1, arg_5_2)
	self.data = arg_5_1
	self.shopCfg = getShopCfg(arg_5_1.id)
	self.goodID = arg_5_1.id
	self.dlcID = self.shopCfg.dlc or nil
	self.haveDlc = self.dlcID ~= nil and self.dlcID ~= 0
	self.isExchange = self.shopCfg.shop_refresh == 2
	self.shopID = self.shopCfg.shop_id

	local var_5_0

	if self.shopCfg.description then
		self.itemCfg = RechargeShopDescriptionCfg[self.shopCfg.description]
		var_5_0 = self.itemCfg.param[1]
	else
		self.itemCfg = ItemCfg[self.shopCfg.give_id]
	end

	if var_5_0 and SkinCfg[var_5_0] then
		self.skinCfg = SkinCfg[var_5_0]
		self.skinID = var_5_0
		self.heroCfg = HeroCfg[self.skinCfg.hero]
	end

	if self.haveDlc then
		self.shopDlcCfg = getShopCfg(self.dlcID)
		self.itemDlcCfg = RechargeShopDescriptionCfg[self.shopDlcCfg.description]

		if self.itemDlcCfg == nil then
			self.itemDlcCfg = ItemCfg[getShopCfg(self.dlcID).give_id]
		end

		self.canBuyDlc = self.shopDlcCfg and ShopConst.SHOP_ID.DLC_SHOP == self.shopDlcCfg.shop_id
	end

	self.index = arg_5_2

	self:Show(true)
	self:UpdateView()
end

function RechargeSkinAllItem:SetCallBack(arg_6_1)
	self.callBack_ = arg_6_1
end

function RechargeSkinAllItem:UpdateView()
	self.skinItem:SetData(self.data)
	self.dlcItem:SetData(self.dlcID, self.skinID, self.goodID)
	self.skinItem:SetCallBack(self.callBack_, self.index)
	self.dlcItem:SetCallBack(self.callBack_, self.index)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
	self:UpdateTimerView()
end

function RechargeSkinAllItem:UpdateTimerView()
	self.skinItem:UpdateTimerView()
	self.dlcItem:UpdateTimerView()
end

function RechargeSkinAllItem:OnEnter()
	self:UpdateView()
end

function RechargeSkinAllItem:OnExit()
	self.skinItem:OnExit()
	self.dlcItem:OnExit()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function RechargeSkinAllItem:Dispose()
	self.skinItem:Dispose()
	self.dlcItem:Dispose()
	RechargeSkinAllItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

function RechargeSkinAllItem:GetItemHeight()
	return self.rectGo_.sizeDelta.x
end

function RechargeSkinAllItem:SetAsLastSibling()
	self.transform_:SetAsLastSibling()
end

function RechargeSkinAllItem:SetAsFirstSibling()
	self.transform_:SetAsFirstSibling()
end

function RechargeSkinAllItem:GetIndex()
	return self.index
end

function RechargeSkinAllItem:IsActive()
	return true
end

function RechargeSkinAllItem:IsTimeBar()
	return false
end

function RechargeSkinAllItem:Show(arg_18_1)
	SetActive(self.gameObject_, arg_18_1)
end

return RechargeSkinAllItem
