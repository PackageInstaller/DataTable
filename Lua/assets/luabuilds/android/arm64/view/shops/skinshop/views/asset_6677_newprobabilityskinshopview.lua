local NewProbabilitySkinShopView = class("NewProbabilitySkinShopView", import("view.base.BaseSubView"))

function NewProbabilitySkinShopView:getUIName()
	return "ProbabilitySkinShopItem"
end

function NewProbabilitySkinShopView:OnLoaded()
	self.purchaseBtn = self._tf:Find("frame")
	self.tipTxt = self._tf:Find("tip/Text"):GetComponent(typeof(Text))
	self.icon = self._tf:Find("frame/icon/Image"):GetComponent(typeof(Image))
	self.tag = self._tf:Find("frame/icon/tag"):GetComponent(typeof(Image))
	self.nameTxt = self._tf:Find("frame/name/Text"):GetComponent(typeof(Text))
	self.priceTxt = self._tf:Find("frame/price"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("frame/desc"):GetComponent(typeof(Text))
	self.limitTxt = self._tf:Find("frame/count"):GetComponent(typeof(Text))
	self.uiList = UIItemList.New(self._tf:Find("frame/awards"), self._tf:Find("frame/awards/award"))

	self._tf:SetSiblingIndex(2)

	return
end

function NewProbabilitySkinShopView:Show(arg_3_1)
	NewProbabilitySkinShopView.super.Show(self)
	self:UpdateCommodity(arg_3_1)
	self:UpdateTip()

	return
end

function NewProbabilitySkinShopView:Flush(arg_4_1)
	self:UpdateCommodity(arg_4_1)

	return
end

local function var_0_1(arg_5_0)
	return ({
		"hot",
		"new_tag",
		"tuijian",
		"shuangbei_tag",
		"activity",
		"xianshi"
	})[arg_5_0] or "hot"
end

local function var_0_2(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getConfig("display")

	arg_6_0.uiList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			updateDrop(arg_7_2, {
				type = var_6_0[arg_7_1 + 1][1],
				id = var_6_0[arg_7_1 + 1][2],
				count = var_6_0[arg_7_1 + 1][3]
			})
		end

		return
	end)
	arg_6_0.uiList:align(#var_6_0)

	return
end

function NewProbabilitySkinShopView:UpdateCommodity(arg_8_1)
	self.icon.sprite = LoadSprite("ChargeIcon/" .. arg_8_1:getConfig("picture"))

	self.icon:SetNativeSize()

	self.nameTxt.text = arg_8_1:getConfig("name_display")
	self.priceTxt.text = GetMoneySymbol() .. arg_8_1:getConfig("money")
	self.limitTxt.text = arg_8_1:GetLimitDesc()
	self.descTxt.text = arg_8_1:getConfig("descrip")
	self.tag.sprite = LoadSprite("chargeTag", var_0_1((arg_8_1:getConfig("tag"))))

	self.tag:SetNativeSize()
	var_0_2(self, arg_8_1)
	onButton(self, self.purchaseBtn, function()
		if arg_8_1:canPurchase() then
			self:OnCharge(arg_8_1)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))
		end

		return
	end, SFX_PANEL)

	return
end

function NewProbabilitySkinShopView:OnCharge(arg_10_1)
	local var_10_0 = arg_10_1

	self:emit(NewProbabilitySkinShopMediator.OPEN_CHARGE_ITEM_PANEL, {
		isChargeType = true,
		isMonthCard = false,
		commodity = arg_10_1,
		infoTip = arg_10_1:GetInfoTip(),
		icon = "chargeicon/" .. arg_10_1:getConfig("picture"),
		name = arg_10_1:getConfig("name_display"),
		tipExtra = i18n("charge_title_getitem"),
		extraItems = arg_10_1:GetExtraServiceItem(),
		price = arg_10_1:getConfig("money"),
		isLocalPrice = arg_10_1:IsLocalPrice(),
		tagType = arg_10_1:getConfig("tag"),
		descExtra = arg_10_1:getConfig("descrip_extra"),
		limitArgs = arg_10_1:getConfig("limit_args"),
		onYes = function()
			if ChargeConst.isNeedSetBirth() then
				self:emit(NewProbabilitySkinShopMediator.OPEN_CHARGE_BIRTHDAY)
			else
				self:emit(NewProbabilitySkinShopMediator.CHARGE, var_10_0.id)
			end

			return
		end
	})

	return
end

function NewProbabilitySkinShopView:UpdateTip()
	self.tipTxt.text = i18n("probabilityskinshop_tip")

	return
end

function NewProbabilitySkinShopView:OnDestroy()
	return
end

return NewProbabilitySkinShopView
