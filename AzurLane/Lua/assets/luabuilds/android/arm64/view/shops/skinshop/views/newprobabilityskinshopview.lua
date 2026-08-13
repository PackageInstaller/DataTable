class = var_0_10000

local var_0_0 = "NewProbabilitySkinShopView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ProbabilitySkinShopItem"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.purchaseBtn = var_1.Find(var_2_0, "frame")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "tip/Text")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.tipTxt = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "frame/icon/Image")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.icon = var_2_6(var_2_5, var_4(var_1_10006))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "frame/icon/tag")
	local var_2_9 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.tag = var_2_9(var_2_8, var_4(var_1_10006))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "frame/name/Text")
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nameTxt = var_2_12(var_2_11, var_4(var_1_10006))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "frame/price")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.priceTxt = var_2_15(var_2_14, var_4(var_1_10006))

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_1.Find(var_2_16, "frame/desc")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.descTxt = var_2_18(var_2_17, var_4(var_1_10006))

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_1.Find(var_2_19, "frame/count")
	local var_2_21 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.limitTxt = var_2_21(var_2_20, var_4(var_1_10006))
	UIItemList = var_1

	local var_2_22 = var_1.New
	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_3.Find(var_2_23, "frame/awards")
	local var_2_25 = arg_2_0._tf

	arg_2_0.uiList = var_2_22(var_2_24, var_4.Find(var_2_25, "frame/awards/award"))

	local var_2_26 = arg_2_0._tf

	var_1.SetSiblingIndex(var_2_26, 2)

	return
end

function var_0_1.Show(arg_3_0, arg_3_1)
	var_0_1.super.Show(arg_3_0)
	arg_3_0:UpdateCommodity(arg_3_1)
	arg_3_0:UpdateTip()

	return
end

function var_0_1.Flush(arg_4_0, arg_4_1)
	arg_4_0:UpdateCommodity(arg_4_1)

	return
end

local function var_0_2(arg_5_0)
	local var_5_0

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

local function var_0_3(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getConfig("display")
	local var_6_1 = arg_6_0.uiList

	var_3.make(var_6_1, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = var_6_0[arg_7_1 + 1]
			local var_7_1 = {
				type = var_7_0[1],
				id = var_7_0[2],
				count = var_7_0[3]
			}

			updateDrop = var_5

			var_5(arg_7_2, var_7_1)
		end

		return
	end)

	local var_6_2 = arg_6_0.uiList

	var_3.align(var_6_2, #var_6_0)

	return
end

function var_0_1.UpdateCommodity(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getConfig(var_8_0, "picture")
	local var_8_2 = arg_8_0.icon

	LoadSprite = var_8_0
	var_8_2.sprite = var_8_0("ChargeIcon/" .. var_8_1)

	local var_8_3 = arg_8_0.icon

	var_3.SetNativeSize(var_8_3)

	arg_8_0.nameTxt.text = arg_8_1:getConfig("name_display")

	local var_8_4 = arg_8_0.priceTxt

	GetMoneySymbol = var_4
	var_8_4.text = var_4() .. arg_8_1:getConfig("money")
	arg_8_0.limitTxt.text = arg_8_1:GetLimitDesc()
	arg_8_0.descTxt.text = arg_8_1:getConfig("descrip")

	local var_8_5 = arg_8_1
	local var_8_6 = arg_8_1.getConfig(var_8_5, "tag")
	local var_8_7 = arg_8_0.tag

	LoadSprite = var_8_5
	var_8_7.sprite = var_8_5("chargeTag", var_0_2(var_8_6))

	local var_8_8 = arg_8_0.tag

	var_4.SetNativeSize(var_8_8)
	var_0_3(arg_8_0, arg_8_1)

	onButton = var_4

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0.purchaseBtn

	local function var_8_11()
		local var_9_0 = arg_8_1

		if var_0.canPurchase(var_9_0) then
			local var_9_1 = arg_8_0

			var_0.OnCharge(var_9_1, arg_8_1)
		else
			pg = var_0

			local var_9_2 = var_0.TipsMgr.GetInstance()
			local var_9_3 = var_0.ShowTips

			i18n = var_2_10003

			var_9_3(var_9_2, var_2_10003("buy_countLimit"))
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_8_9, var_8_10, var_8_11, var_1_10009)

	return
end

function var_0_1.OnCharge(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1
	local var_10_1 = var_2.GetExtraServiceItem(var_10_0)
	local var_10_2 = {
		isChargeType = true,
		isMonthCard = false,
		commodity = arg_10_1,
		infoTip = var_2:GetInfoTip(),
		icon = "chargeicon/" .. var_2:getConfig("picture"),
		name = var_2:getConfig("name_display")
	}

	i18n = var_5
	var_10_2.tipExtra = var_5("charge_title_getitem")
	var_10_2.extraItems = var_10_1
	var_10_2.price = var_2:getConfig("money")
	var_10_2.isLocalPrice = var_2:IsLocalPrice()
	var_10_2.tagType = var_2:getConfig("tag")
	var_10_2.descExtra = var_2:getConfig("descrip_extra")
	var_10_2.limitArgs = var_2:getConfig("limit_args")

	function var_10_2.onYes()
		ChargeConst = var_2_10000

		if var_2_10000.isNeedSetBirth() then
			local var_11_0 = arg_10_0
			local var_11_1 = var_0.emit

			NewProbabilitySkinShopMediator = var_2_10003

			var_11_1(var_11_0, var_2_10003.OPEN_CHARGE_BIRTHDAY)
		else
			local var_11_2 = arg_10_0
			local var_11_3 = var_0.emit

			NewProbabilitySkinShopMediator = var_2_10003

			var_11_3(var_11_2, var_2_10003.CHARGE, var_0.id)
		end

		return
	end

	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0.emit

	NewProbabilitySkinShopMediator = var_8

	var_10_4(var_10_3, var_8.OPEN_CHARGE_ITEM_PANEL, var_10_2)

	return
end

function var_0_1.UpdateTip(arg_12_0)
	local var_12_0 = arg_12_0.tipTxt

	i18n = var_1_10002
	var_12_0.text = var_1_10002("probabilityskinshop_tip")

	return
end

function var_0_1.OnDestroy(arg_13_0)
	return
end

return var_0_1
