local RechargeSkinNormalItem = class("RechargeSkinNormalItem", ReduxView)

function RechargeSkinNormalItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
	SetActive(self.gameObject_, true)
end

function RechargeSkinNormalItem:Init()
	self:InitUI()
end

function RechargeSkinNormalItem:InitUI()
	self:BindCfgUI()

	self.skinItem = RechargeSkinNewItem.New(self.gameObject_)
end

function RechargeSkinNormalItem:SetItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.data[arg_4_1])
end

function RechargeSkinNormalItem:SetData(arg_5_1, arg_5_2)
	self.data = arg_5_1
	self.shopCfg = getShopCfg(arg_5_1.id)
	self.goodID = arg_5_1.id
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

	self.buyTime = ShopData.GetShop(self.shopID)[self.goodID] ~= nil and ShopData.GetShop(self.shopID)[self.goodID].buy_times or 0
	self.restNum = self.shopCfg.limit_num - self.buyTime
	self.index = arg_5_2

	self:Show(true)
	self:UpdateView()
end

function RechargeSkinNormalItem:SetCallBack(arg_6_1)
	self.callBack_ = arg_6_1
end

function RechargeSkinNormalItem:UpdateView()
	self.skinItem:SetData(self.data)
	self.skinItem:SetCallBack(self.callBack_, self.index)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
	self:UpdateTimerView()
end

function RechargeSkinNormalItem:UpdateTimerView()
	self.skinItem:UpdateTimerView()
	self.skinItem.giftController_:SetSelectedState("false")
end

function RechargeSkinNormalItem:OnEnter()
	self:UpdateView()
end

function RechargeSkinNormalItem:OnExit()
	self.skinItem:OnExit()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function RechargeSkinNormalItem:Dispose()
	self.skinItem:Dispose()
	RechargeSkinNormalItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

function RechargeSkinNormalItem:GetItemHeight()
	return self.rectGo_.sizeDelta.x
end

function RechargeSkinNormalItem:SetAsLastSibling()
	self.transform_:SetAsLastSibling()
end

function RechargeSkinNormalItem:SetAsFirstSibling()
	self.transform_:SetAsFirstSibling()
end

function RechargeSkinNormalItem:GetIndex()
	return self.index
end

function RechargeSkinNormalItem:IsActive()
	return true
end

function RechargeSkinNormalItem:IsTimeBar()
	return false
end

function RechargeSkinNormalItem:Show(arg_18_1)
	SetActive(self.gameObject_, arg_18_1)
end

return RechargeSkinNormalItem
