local SkinBuyCheckDLCItem = class("SkinBuyCheckDLCItem", ReduxView)

function SkinBuyCheckDLCItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SkinBuyCheckDLCItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.discountController = ControllerUtil.GetController(self.transform_, "discount")
end

function SkinBuyCheckDLCItem:InitUI()
	self:BindCfgUI()

	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.itemController = ControllerUtil.GetController(self.transform_, "icon")
end

function SkinBuyCheckDLCItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		self.clickFunc(self.index)
	end)
	self:AddBtnListener(self.m_addBtn, nil, function()
		if self.index == 1 then
			return
		end

		if ShopConst.SHOP_ID.DLC_SHOP ~= getShopCfg(self.id).shop_id then
			return
		end

		self.selectClickFunc(self.id)
	end)
end

function SkinBuyCheckDLCItem:SetData(arg_7_1, arg_7_2)
	self.index = arg_7_1
	self.id = arg_7_2

	local var_7_0 = getShopCfg(arg_7_2)

	if not var_7_0.give then
		-- block empty
	end

	local var_7_3 = var_7_0.description and RechargeShopDescriptionCfg[var_7_0.description] or ItemCfg[var_7_0.give_id or var_7_0.description]

	self.isDlc = var_7_3.type ~= ItemConst.ITEM_TYPE.HERO_SKIN

	if var_7_3.type == ItemConst.ITEM_TYPE.HERO_SKIN then
		self.itemController:SetSelectedIndex(1)

		self.m_skinIcon.sprite = ItemTools.getItemSprite(var_7_3.id)
	else
		self.itemController:SetSelectedIndex(0)

		self.m_icon.sprite = ItemTools.getItemSprite(var_7_3.id)
	end

	self.m_currency.sprite = ItemTools.getItemLittleSprite(var_7_0.cost_id)

	self:UpdateTimer()
end

function SkinBuyCheckDLCItem:UpdateTimer()
	local var_8_0 = getShopCfg(self.id)
	local var_8_1, var_8_2, var_8_3 = ShopTools.GetPrice(self.id, var_8_0.shop_id)

	self.m_num.text = var_8_1
	self.m_oldPriceLabel.text = var_8_2

	local var_8_4, var_8_5, var_8_6 = ShopTools.IsOnDiscountArea(self.id, var_8_0.shop_id)

	if var_8_4 and var_8_6 then
		if var_8_5 then
			self.discountController:SetSelectedState("time_limit_discount")

			self.discountLastTimeLabel_.text = self.isDlc and string.format("%s", manager.time:GetLostTimeStr((TimeMgr.GetInstance():parseTimeFromConfig(var_8_0.cheap_close_time)))) or ""
		else
			self.discountController:SetSelectedState("discount")
		end
	else
		self.discountController:SetSelectedState("null")
	end
end

function SkinBuyCheckDLCItem:GetIndex()
	return self.index
end

function SkinBuyCheckDLCItem:SetSelect(arg_10_1)
	self.selectController:SetSelectedIndex(arg_10_1 and 1 or 0)
end

function SkinBuyCheckDLCItem:SetState(arg_11_1)
	self.m_btn.interactable = arg_11_1 ~= 2

	self.stateController:SetSelectedIndex(arg_11_1)
end

function SkinBuyCheckDLCItem:Dispose()
	SkinBuyCheckDLCItem.super.Dispose(self)
end

function SkinBuyCheckDLCItem:RegistCallBack(arg_13_1)
	self.clickFunc = arg_13_1
end

function SkinBuyCheckDLCItem:RegistSelectCallBack(arg_14_1)
	self.selectClickFunc = arg_14_1
end

return SkinBuyCheckDLCItem
