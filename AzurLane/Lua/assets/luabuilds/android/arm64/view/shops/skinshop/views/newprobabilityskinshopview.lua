local var_0_0 = class("NewProbabilitySkinShopView", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ProbabilitySkinShopItem"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.purchaseBtn = arg_2_0._tf:Find("frame")
	arg_2_0.tipTxt = arg_2_0._tf:Find("tip/Text"):GetComponent(typeof(Text))
	arg_2_0.icon = arg_2_0._tf:Find("frame/icon/Image"):GetComponent(typeof(Image))
	arg_2_0.tag = arg_2_0._tf:Find("frame/icon/tag"):GetComponent(typeof(Image))
	arg_2_0.nameTxt = arg_2_0._tf:Find("frame/name/Text"):GetComponent(typeof(Text))
	arg_2_0.priceTxt = arg_2_0._tf:Find("frame/price"):GetComponent(typeof(Text))
	arg_2_0.descTxt = arg_2_0._tf:Find("frame/desc"):GetComponent(typeof(Text))
	arg_2_0.limitTxt = arg_2_0._tf:Find("frame/count"):GetComponent(typeof(Text))
	arg_2_0.uiList = UIItemList.New(arg_2_0._tf:Find("frame/awards"), arg_2_0._tf:Find("frame/awards/award"))

	arg_2_0._tf:SetSiblingIndex(2)

	return
end

function var_0_0.Show(arg_3_0, arg_3_1)
	var_0_0.super.Show(arg_3_0)
	arg_3_0:UpdateCommodity(arg_3_1)
	arg_3_0:UpdateTip()

	return
end

function var_0_0.Flush(arg_4_0, arg_4_1)
	arg_4_0:UpdateCommodity(arg_4_1)

	return
end

local function var_0_1(arg_5_0)
	local var_5_0 = ({
		"hot",
		"new_tag",
		"tuijian",
		"shuangbei_tag",
		"activity",
		"xianshi"
	})[arg_5_0]

	if not ({
		"hot",
		"new_tag",
		"tuijian",
		"shuangbei_tag",
		"activity",
		"xianshi"
	})[arg_5_0] then
		var_5_0 = "hot"
	end

	return var_5_0
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
	arg_6_0.uiList:align(#arg_6_1:getConfig("display"))

	return
end

function var_0_0.UpdateCommodity(arg_8_0, arg_8_1)
	arg_8_0.icon.sprite = LoadSprite("ChargeIcon/" .. arg_8_1:getConfig("picture"))

	arg_8_0.icon:SetNativeSize()

	arg_8_0.nameTxt.text = arg_8_1:getConfig("name_display")
	arg_8_0.priceTxt.text = GetMoneySymbol() .. arg_8_1:getConfig("money")
	arg_8_0.limitTxt.text = arg_8_1:GetLimitDesc()
	arg_8_0.descTxt.text = arg_8_1:getConfig("descrip")
	arg_8_0.tag.sprite = LoadSprite("chargeTag", var_0_1((arg_8_1:getConfig("tag"))))

	arg_8_0.tag:SetNativeSize()
	var_0_2(arg_8_0, arg_8_1)
	onButton(arg_8_0, arg_8_0.purchaseBtn, function()
		if arg_8_1:canPurchase() then
			arg_8_0:OnCharge(arg_8_1)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnCharge(arg_10_0, arg_10_1)
	arg_10_0:emit(NewProbabilitySkinShopMediator.OPEN_CHARGE_ITEM_PANEL, {
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
				arg_10_0:emit(NewProbabilitySkinShopMediator.OPEN_CHARGE_BIRTHDAY)
			else
				arg_10_0:emit(NewProbabilitySkinShopMediator.CHARGE, var_0.id)
			end

			return
		end
	})

	return
end

function var_0_0.UpdateTip(arg_12_0)
	arg_12_0.tipTxt.text = i18n("probabilityskinshop_tip")

	return
end

function var_0_0.OnDestroy(arg_13_0)
	return
end

return var_0_0
