local var_0_0 = class("NewSkinShopPurchaseView", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "NewSkinShopPurchaseUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/cancel")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/confirm")
	arg_2_0.toggle = arg_2_0._tf:Find("frame")
	arg_2_0.title = arg_2_0._tf:Find("frame/title")
	arg_2_0.text = arg_2_0._tf:Find("frame/bg/Text"):GetComponent(typeof(Text))
	arg_2_0.tipText = arg_2_0._tf:Find("frame/bg/tipText")
	arg_2_0.textWithGift = arg_2_0._tf:Find("frame/gift_bg/Text"):GetComponent(typeof(Text))
	arg_2_0.dropsList = UIItemList.New(arg_2_0._tf:Find("frame/gift_bg/gift/drops"), arg_2_0._tf:Find("frame/gift_bg/gift/drops/item"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		if arg_3_0.commodity then
			arg_3_0:emit(NewSkinShopMainView.EVT_ON_PURCHASE, arg_3_0.commodity)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	var_0_0.super.Show(arg_7_0)

	arg_7_0.commodity = arg_7_1

	arg_7_0:Flush(arg_7_1)
	arg_7_0:emit(NewSkinShopMainView.EVT_SHOW_OR_HIDE_PURCHASE_VIEW, true)

	return
end

function var_0_0.GetText(arg_8_0, arg_8_1)
	if arg_8_1 then
		return arg_8_0.textWithGift or arg_8_0.text
	end
end

function var_0_0.Flush(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:GetGiftList()
	local var_9_1 = #var_9_0 > 0

	triggerToggle(arg_9_0.toggle, #var_9_0 > 0)

	local var_9_2 = arg_9_0:GetText(var_9_1)

	setAnchoredPosition(arg_9_0.title, {
		y = var_9_1 and 460 or 401
	})

	local var_9_3 = arg_9_1:GetPrice()
	local var_9_4 = pg.ship_skin_template[arg_9_1:getSkinId()].name

	if var_9_3 <= getProxy(PlayerProxy):getRawData():getChargeGem() then
		local var_9_5 = COLOR_GREEN or COLOR_RED

		var_9_2.text = i18n("skin_shop_buy_confirm", var_9_5, var_9_3, var_9_4)

		arg_9_0:SetTipText(arg_9_1:getSkinId())
		arg_9_0:FlushGift(var_9_0)

		return
	end
end

function var_0_0.FlushGift(arg_10_0, arg_10_1)
	arg_10_0.dropsList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			updateDrop(arg_11_2, {
				type = arg_10_1[arg_11_1 + 1].type,
				id = arg_10_1[arg_11_1 + 1].id,
				count = arg_10_1[arg_11_1 + 1].count
			})
			onButton(arg_10_0, arg_11_2, function()
				arg_10_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_10_0.dropsList:align(#arg_10_1)

	return
end

function var_0_0.SetTipText(arg_13_0, arg_13_1)
	local var_13_0
	local var_13_1

	for iter_13_0, iter_13_1 in ipairs(pg.gameset.no_share_skin_tip.description) do
		for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
			if pg.ship_skin_template[arg_13_1].ship_group == iter_13_3[1] then
				var_13_0 = iter_13_1
				var_13_1 = iter_13_2

				break
			end
		end
	end

	setActive(arg_13_0.tipText, var_13_1)

	if var_13_1 then
		local var_13_2 = ""

		for iter_13_4, iter_13_5 in ipairs(var_13_0) do
			if iter_13_4 ~= var_13_1 then
				var_13_2 = var_13_2 == "" and i18n(iter_13_5[2]) or var_13_2 .. "、" .. i18n(iter_13_5[2])
			end
		end

		setText(arg_13_0.tipText, i18n("no_share_skin_gametip", i18n(var_13_0[var_13_1][2]), var_13_2))
	end

	return
end

function var_0_0.Hide(arg_14_0)
	var_0_0.super.Hide(arg_14_0)
	arg_14_0:emit(NewSkinShopMainView.EVT_SHOW_OR_HIDE_PURCHASE_VIEW, false)

	arg_14_0.commodity = nil

	return
end

function var_0_0.OnDestroy(arg_15_0)
	return
end

return var_0_0
