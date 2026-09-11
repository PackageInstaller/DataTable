local ShopItemBase = class("ShopItemBase", ReduxView)

function ShopItemBase:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ShopItemBase:Init()
	self:InitUI()
	self:AddUIListener()
end

function ShopItemBase:AddUIListener()
	self:AddBtnListener(nil, nil, "OnClick")
	self:AddBtnListener(self.tipsBtn_, nil, function()
		if ItemCfg[self.itemCfg.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			JumpTools.OpenPageByJump("/showServantView", {
				state = "onlydetail",
				id = self.itemCfg.id
			})
		else
			ShowPopItem(POP_SOURCE_ITEM, {
				self.itemCfg.id
			})
		end
	end)
end

function ShopItemBase:SetPriceText(arg_5_1)
	if arg_5_1 == nil then
		arg_5_1 = self.goodID
	end

	local var_5_0, var_5_1, var_5_2 = ShopTools.GetPrice(self.goodID)

	self.priceText_.text = var_5_0
end

function ShopItemBase:UpdatePrice(arg_6_1)
	local var_6_0 = getShopCfg(arg_6_1)
	local var_6_1, var_6_2, var_6_3 = ShopTools.GetPrice(arg_6_1)

	if ShopListCfg[self.shopID].system == "1" and self.oldPriceLabel_ then
		SetActive(self.oldPriceLabel_.gameObject, true)

		self.oldPriceLabel_.text = var_6_2
	elseif self.oldPriceLabel_ then
		SetActive(self.oldPriceLabel_.gameObject, false)
	end

	self.moneyTxt_.text = ShopTools.GetMoneySymbol(arg_6_1)

	if var_6_1 <= 0 then
		self.costTypeController_:SetSelectedState("free")
	else
		if ShopTools.IsRMB(arg_6_1) then
			self.priceText_.text = var_6_1
		else
			self:SetCostIcon()
			self:SetPriceText(arg_6_1)
		end

		if self.isDiscountController_ then
			self.isDiscountController_:SetSelectedState(self:IsOnDiscountArea(arg_6_1) and "true" or "false")
		end

		self.costTypeController_:SetSelectedState(ShopTools.IsRMB(arg_6_1) and "money" or "currency")
	end

	if var_6_0.tag == ShopConst.TAGS.NEW then
		self.tipController_:SetSelectedState(self:IsOnDiscountArea(arg_6_1) and "discount" or "none")
	end

	if ShopTools.IsRMB(arg_6_1) and ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
		self.priceText_.text = GetTips("PC_SHOP_TIPS3")
		self.moneyTxt_.text = ""
	end
end

function ShopItemBase:IsOnDiscountArea(arg_7_1)
	return ShopTools.IsOnDiscountArea(arg_7_1)
end

function ShopItemBase:SetCostIcon()
	self.costIcon_.sprite = ItemTools.getItemLittleSprite((self.shopCfg.cost_id == 0 or nil) and self.shopCfg.cheap_cost_id)
end

function ShopItemBase:SetCommonItem()
	CommonTools.SetCommonData(self.commonItem_, {
		id = self.itemCfg.id
	}, self.commonData)
end

function ShopItemBase:SetData(arg_10_1)
	if arg_10_1 == nil then
		return
	end

	self.data = arg_10_1
	self.shopCfg = getShopCfg(arg_10_1.id)
	self.goodID = self.shopCfg.goods_id
	self.dlcID = self.shopCfg.dlc or nil
	self.haveDlc = self.dlcID ~= nil and self.dlcID ~= 0
	self.isExchange = self.shopCfg.shop_refresh == 2
	self.shopID = self.shopCfg.shop_id

	local var_10_0

	if self.shopCfg.description then
		self.itemCfg = RechargeShopDescriptionCfg[self.shopCfg.description]

		if self.itemCfg.type ~= 21 then
			var_10_0 = self.itemCfg.param[1]
		end
	else
		self.itemCfg = ItemCfg[self.shopCfg.give_id]
	end

	if var_10_0 and SkinCfg[var_10_0] then
		self.skinCfg = SkinCfg[var_10_0]
		self.skinID = var_10_0
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

	self.buyTime = ShopData.GetShop(self.shopID) == nil and 0 or ShopData.GetShop(self.shopID)[self.goodID] ~= nil and ShopData.GetShop(self.shopID)[self.goodID].buy_times or 0
	self.restNum = self.shopCfg.limit_num - self.buyTime

	self:UpdateView()
	self:UpdateTimerView()
end

function ShopItemBase:UpdateView()
	return
end

function ShopItemBase:UpdateTimerView()
	return
end

function ShopItemBase:GetItemInfo()
	return self.data
end

function ShopItemBase:RegistCallBack(arg_14_1)
	self.callBack = arg_14_1
end

function ShopItemBase:ClickFunction()
	if ItemCfg[self.shopCfg.give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		if ShopTools.HaveSkin(self.shopCfg.give_id) then
			return
		end
	elseif self.shopCfg.limit_num then
		if self.shopCfg.limit_num ~= -1 and self.shopCfg.limit_num <= self.data.buyTime then
			return
		end

		local var_15_0, var_15_1 = ShopTools.JudgeIsLvLimit(self.shopCfg.level_limit)

		if var_15_0 then
			return
		end
	end

	JumpTools.OpenPopUp("shopBuy", {
		goodInfo = self.data
	})
end

function ShopItemBase:OnEnter()
	return
end

function ShopItemBase:OnExit()
	return
end

function ShopItemBase:Dispose()
	ShopItemBase.super.Dispose(self)
end

return ShopItemBase
