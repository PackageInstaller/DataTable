local EquipGoodsItem = class("EquipGoodsItem", ShopItemBase)

function EquipGoodsItem:InitUI()
	self:BindCfgUI()

	self.commonItem_ = CommonItemView.New(self.commonGo_)
end

function EquipGoodsItem:AddUIListener()
	self:AddBtnListener(self.buyBtn_, nil, function()
		self:ClickFunction()
	end)
end

function EquipGoodsItem:SetData(arg_4_1, arg_4_2)
	self.index = arg_4_2
	self.data = arg_4_1
	self.shopCfg = getShopCfg(arg_4_1.id)
	self.goodID = arg_4_1.id
	self.dlcID = self.shopCfg.dlc or nil
	self.haveDlc = self.dlcID ~= nil and self.dlcID ~= 0
	self.isExchange = self.shopCfg.shop_refresh == 2
	self.shopID = arg_4_1.shopId

	local var_4_0

	if self.shopCfg.description then
		self.itemCfg = RechargeShopDescriptionCfg[self.shopCfg.description]
		var_4_0 = self.itemCfg.param[1]
	else
		self.itemCfg = ItemCfg[self.shopCfg.give_id]
	end

	if var_4_0 and SkinCfg[var_4_0] then
		self.skinCfg = SkinCfg[var_4_0]
		self.skinID = var_4_0
		self.heroCfg = HeroCfg[self.skinCfg.hero]
	end

	if self.haveDlc then
		self.shopDlcCfg = getShopCfg(self.dlcID)
		self.itemDlcCfg = RechargeShopDescriptionCfg[self.shopDlcCfg.description]

		if self.itemDlcCfg == nil then
			self.itemDlcCfg = ItemCfg[getShopCfg(self.dlcID).give_id]
		end

		self.canBuyDlc = ShopConst.SHOP_ID.DLC_SHOP == self.shopDlcCfg.shop_id
	end

	self.buyTime = ShopData.GetShop(self.shopID)[self.goodID] ~= nil and ShopData.GetShop(self.shopID)[self.goodID].buy_times or 0
	self.restNum = self.shopCfg.limit_num - self.data.buyTime

	self:UpdateView()
	self:UpdateTimerView()
end

function EquipGoodsItem:UpdateView()
	self:SetCommonItem()
	self:SetCostIcon()
	self:SetPriceText(self.goodID)

	self.titleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Common/com_equip_icon_0" .. self.index)
end

function EquipGoodsItem:OnEnter()
	self:UpdateView()
end

function EquipGoodsItem:OnExit()
	return
end

function EquipGoodsItem:Dispose()
	EquipGoodsItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return EquipGoodsItem
