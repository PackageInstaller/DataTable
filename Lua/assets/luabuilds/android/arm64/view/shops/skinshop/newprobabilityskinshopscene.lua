local var_0_0 = class("NewProbabilitySkinShopScene", import(".NewSkinShopScene"))

function var_0_0.ResUISettings(arg_1_0)
	return false
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)

	arg_2_0.contextData.mode = NewSkinShopScene.MODE_OVERVIEW
	arg_2_0.commodity = arg_2_0:GetCommodity(arg_2_0.contextData.commodityId)
	arg_2_0.itemView = NewProbabilitySkinShopView.New(arg_2_0._tf:Find("overlay"), arg_2_0.event)
	arg_2_0.chargeTipWindow = ChargeTipWindow.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_0.GetCommodity(arg_3_0, arg_3_1)
	local var_3_0 = Goods.Create({
		shop_id = arg_3_1
	}, Goods.TYPE_CHARGE)
	local var_3_1 = getProxy(ShopsProxy):getChargedList() or {}

	var_3_0:updateBuyCount((ChargeConst.getBuyCount(var_3_1, var_3_0.id)))

	return var_3_0
end

function var_0_0.OnChargeSuccess(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetCommodity(arg_4_1)

	arg_4_0.commodity = var_4_0

	arg_4_0.chargeTipWindow:ExecuteAction("Show", var_4_0)

	if arg_4_0.itemView and arg_4_0.itemView:GetLoaded() then
		arg_4_0.itemView:Flush(var_4_0)
	end

	return
end

function var_0_0.didEnter(arg_5_0)
	var_0_0.super.didEnter(arg_5_0)
	setActive(arg_5_0.atlasBtn, false)
	setActive(arg_5_0._tf:Find("overlay/left/mask"), false)

	local var_5_0 = arg_5_0._tf:Find("overlay/bottom")
	local var_5_1 = rtf(arg_5_0.scrollrect.gameObject)

	var_5_1.sizeDelta = Vector2(var_5_0.sizeDelta.x - 160, var_5_0.sizeDelta.y)

	setAnchoredPosition(var_5_1, {
		x = 0
	})
	setAnchoredPosition(arg_5_0.prevBtn, {
		x = 32
	})
	setActive(arg_5_0._tf:Find("overlay/right/price"), false)
	setActive(arg_5_0.live2dFilter, false)
	setActive(arg_5_0.changeBtn, false)

	return
end

function var_0_0.UpdateCouponBtn(arg_6_0)
	arg_6_0.couponTr.localScale = Vector3(0, 0, 0)

	return
end

function var_0_0.UpdateVoucherBtn(arg_7_0)
	arg_7_0.voucherTr.localScale = Vector3(0, 0, 0)

	return
end

function var_0_0.UpdateTitle(arg_8_0, arg_8_1)
	arg_8_0.title.sprite = GetSpriteFromAtlas("ui/SkinShopUI_atlas", "probabilityshop")

	arg_8_0.title:SetNativeSize()
	setAnchoredPosition(arg_8_0.title.gameObject, {
		x = 363
	})
	setActive(arg_8_0.titleEn.gameObject, false)

	return
end

function var_0_0.GetAllCommodity(arg_9_0)
	return getProxy(ShipSkinProxy):GetProbabilitySkins((arg_9_0.commodity:GetSkinProbability()))
end

function var_0_0.GetSkinProbability(arg_10_0)
	return getProxy(ShipSkinProxy):GetSkinProbabilitys((arg_10_0.commodity:GetSkinProbability()))
end

function var_0_0.GetSkinClassify(arg_11_0, arg_11_1, arg_11_2)
	return {
		NewSkinShopScene.PAGE_ALL
	}
end

function var_0_0.IsType(arg_12_0, arg_12_1, arg_12_2)
	return true
end

function var_0_0.UpdateCommodities(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.skinProbabilityList = arg_13_0:GetSkinProbability()

	seriesAsync({
		function(arg_14_0)
			var_0_0.super.UpdateCommodities(arg_13_0, arg_13_1, arg_13_2, arg_14_0)

			return
		end,
		function(arg_15_0)
			arg_13_0:FlushItemView(arg_15_0)

			return
		end
	}, arg_13_3)

	return
end

function var_0_0.FlushItemView(arg_16_0, arg_16_1)
	arg_16_0.itemView:ExecuteAction("Show", arg_16_0.commodity)
	arg_16_1()

	return
end

function var_0_0.OnUpdateItem(arg_17_0, arg_17_1, arg_17_2)
	var_0_0.super.OnUpdateItem(arg_17_0, arg_17_1, arg_17_2)

	local var_17_0 = arg_17_0.cards[arg_17_2]
	local var_17_1 = arg_17_0.cards[arg_17_2].commodity.buyCount == 0

	setActive(arg_17_0.cards[arg_17_2].tagImg, not (arg_17_0.cards[arg_17_2].commodity.buyCount == 0))
	setActive(var_17_0.tagEnImg, false)
	setActive(var_17_0.discountTag, false)
	setActive(var_17_0.timelimitTag, false)

	if not var_17_1 then
		var_17_0.tagImg.sprite = GetSpriteFromAtlas("ui/SkinShopUI_atlas", "tag_yigoumai")
	end

	local var_17_2 = arg_17_0.skinProbabilityList[var_17_0.commodity:getSkinId()] or 0

	var_17_0.txt.text = " " .. string.format("%0.1f", var_17_2 / 100) .. "%"

	return
end

function var_0_0.willExit(arg_18_0)
	if arg_18_0.itemView then
		arg_18_0.itemView:Destroy()

		arg_18_0.itemView = nil
	end

	if arg_18_0.mainView then
		arg_18_0.mainView:Dispose()

		arg_18_0.mainView = nil
	end

	if arg_18_0.chargeTipWindow then
		arg_18_0.chargeTipWindow:Destroy()

		arg_18_0.chargeTipWindow = nil
	end

	Input.multiTouchEnabled = true

	return
end

return var_0_0
