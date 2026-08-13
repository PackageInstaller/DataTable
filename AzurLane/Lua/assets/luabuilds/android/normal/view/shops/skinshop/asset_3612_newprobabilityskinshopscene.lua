class = var_0_10000

local var_0_0 = "NewProbabilitySkinShopScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NewSkinShopScene"))

function var_0_1.ResUISettings(arg_1_0)
	return false
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	local var_2_0 = arg_2_0.contextData

	NewSkinShopScene = var_2
	var_2_0.mode = var_2.MODE_OVERVIEW
	arg_2_0.commodity = arg_2_0:GetCommodity(arg_2_0.contextData.commodityId)
	NewProbabilitySkinShopView = var_1

	local var_2_1 = var_1.New
	local var_2_2 = arg_2_0._tf

	arg_2_0.itemView = var_2_1(var_2.Find(var_2_2, "overlay"), arg_2_0.event)
	ChargeTipWindow = var_1
	arg_2_0.chargeTipWindow = var_1.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_1.GetCommodity(arg_3_0, arg_3_1)
	Goods = var_1_10002

	local var_3_0 = var_1_10002.Create
	local var_3_1 = {
		shop_id = arg_3_1
	}

	Goods = var_1_10004

	local var_3_2 = var_3_0(var_3_1, var_1_10004.TYPE_CHARGE)

	getProxy = var_3_1
	ShopsProxy = var_4

	local var_3_3 = var_3_1(var_4)
	local var_3_4

	if not var_3.getChargedList(var_3_3) then
		var_3_4 = {}
	end

	ChargeConst = var_3_3

	local var_3_5 = var_3_3.getBuyCount(var_3_4, var_3_2.id)

	var_3_2:updateBuyCount(var_3_5)

	return var_3_2
end

function var_0_1.OnChargeSuccess(arg_4_0, arg_4_1)
	arg_4_0.commodity = arg_4_0:GetCommodity(arg_4_1)

	local var_4_0 = arg_4_0.chargeTipWindow

	var_3.ExecuteAction(var_4_0, "Show", var_2)

	if arg_4_0.itemView then
		local var_4_1 = arg_4_0.itemView

		if var_3.GetLoaded(var_4_1) then
			local var_4_2 = arg_4_0.itemView

			var_3.Flush(var_4_2, var_2)
		end
	end

	return
end

function var_0_1.didEnter(arg_5_0)
	var_0_1.super.didEnter(arg_5_0)

	setActive = var_1

	var_1(arg_5_0.atlasBtn, false)

	setActive = var_1

	local var_5_0 = arg_5_0._tf

	var_1(var_2.Find(var_5_0, "overlay/left/mask"), false)

	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_1.Find(var_5_1, "overlay/bottom").sizeDelta.x - 160

	rtf = var_3

	local var_5_3 = var_3(arg_5_0.scrollrect.gameObject)

	Vector2 = var_4
	var_5_3.sizeDelta = var_4(var_5_2, var_1.sizeDelta.y)
	setAnchoredPosition = var_4

	var_4(var_5_3, {
		x = 0
	})

	setAnchoredPosition = var_4

	var_4(arg_5_0.prevBtn, {
		x = 32
	})

	setActive = var_4

	local var_5_4 = arg_5_0._tf

	var_4(var_5.Find(var_5_4, "overlay/right/price"), false)

	setActive = var_4

	var_4(arg_5_0.live2dFilter, false)

	setActive = var_4

	var_4(arg_5_0.changeBtn, false)

	return
end

function var_0_1.UpdateCouponBtn(arg_6_0)
	local var_6_0 = arg_6_0.couponTr

	Vector3 = var_1_10002
	var_6_0.localScale = var_1_10002(0, 0, 0)

	return
end

function var_0_1.UpdateVoucherBtn(arg_7_0)
	local var_7_0 = arg_7_0.voucherTr

	Vector3 = var_1_10002
	var_7_0.localScale = var_1_10002(0, 0, 0)

	return
end

function var_0_1.UpdateTitle(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.title

	GetSpriteFromAtlas = var_1_10003
	var_8_0.sprite = var_1_10003("ui/SkinShopUI_atlas", "probabilityshop")

	local var_8_1 = arg_8_0.title

	var_2.SetNativeSize(var_8_1)

	setAnchoredPosition = var_2

	var_2(arg_8_0.title.gameObject, {
		x = 363
	})

	setActive = var_2

	var_2(arg_8_0.titleEn.gameObject, false)

	return
end

function var_0_1.GetAllCommodity(arg_9_0)
	local var_9_0 = arg_9_0.commodity
	local var_9_1 = var_1.GetSkinProbability(var_9_0)

	getProxy = var_9_0
	ShipSkinProxy = var_1_10003

	local var_9_2 = var_9_0(var_1_10003)

	return var_2.GetProbabilitySkins(var_9_2, var_9_1)
end

function var_0_1.GetSkinProbability(arg_10_0)
	local var_10_0 = arg_10_0.commodity
	local var_10_1 = var_1.GetSkinProbability(var_10_0)

	getProxy = var_10_0
	ShipSkinProxy = var_1_10003

	local var_10_2 = var_10_0(var_1_10003)

	return var_2.GetSkinProbabilitys(var_10_2, var_10_1)
end

function var_0_1.GetSkinClassify(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}

	NewSkinShopScene = var_1_10004
	var_11_0[1] = var_1_10004.PAGE_ALL

	return var_11_0
end

function var_0_1.IsType(arg_12_0, arg_12_1, arg_12_2)
	return true
end

function var_0_1.UpdateCommodities(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.skinProbabilityList = arg_13_0:GetSkinProbability()
	seriesAsync = var_4

	var_4({
		function(arg_14_0)
			var_0_1.super.UpdateCommodities(arg_13_0, arg_13_1, arg_13_2, arg_14_0)

			return
		end,
		function(arg_15_0)
			local var_15_0 = arg_13_0

			var_1.FlushItemView(var_15_0, arg_15_0)

			return
		end
	}, arg_13_3)

	return
end

function var_0_1.FlushItemView(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.itemView

	var_2.ExecuteAction(var_16_0, "Show", arg_16_0.commodity)
	arg_16_1()

	return
end

function var_0_1.OnUpdateItem(arg_17_0, arg_17_1, arg_17_2)
	var_0_1.super.OnUpdateItem(arg_17_0, arg_17_1, arg_17_2)

	local var_17_0 = arg_17_0.cards[arg_17_2].commodity.buyCount == 0

	setActive = var_5

	var_5(var_3.tagImg, not var_17_0)

	setActive = var_5

	var_5(var_3.tagEnImg, false)

	setActive = var_5

	var_5(var_3.discountTag, false)

	setActive = var_5

	var_5(var_3.timelimitTag, false)

	if not var_17_0 then
		local var_17_1 = var_3.tagImg

		GetSpriteFromAtlas = var_6
		var_17_1.sprite = var_6("ui/SkinShopUI_atlas", "tag_yigoumai")
	end

	local var_17_2 = arg_17_0.skinProbabilityList
	local var_17_3 = var_3.commodity
	local var_17_4

	if not var_17_2[var_6.getSkinId(var_17_3)] then
		var_17_4 = 0
	end

	local var_17_5 = var_3.txt
	local var_17_6 = " "

	string = var_1_10008
	var_17_5.text = var_17_6 .. var_1_10008.format("%0.1f", var_17_4 / 100) .. "%"

	return
end

function var_0_1.willExit(arg_18_0)
	if arg_18_0.itemView then
		local var_18_0 = arg_18_0.itemView

		var_1.Destroy(var_18_0)

		arg_18_0.itemView = nil
	end

	if arg_18_0.mainView then
		local var_18_1 = arg_18_0.mainView

		var_1.Dispose(var_18_1)

		arg_18_0.mainView = nil
	end

	if arg_18_0.chargeTipWindow then
		local var_18_2 = arg_18_0.chargeTipWindow

		var_1.Destroy(var_18_2)

		arg_18_0.chargeTipWindow = nil
	end

	Input = var_1
	var_1.multiTouchEnabled = true

	return
end

return var_0_1
