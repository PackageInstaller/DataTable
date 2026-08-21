local var_0_0 = class("BackyardFeedPurchasePage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "BackYardFeedShopPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.foodItem = arg_2_0._tf:Find("frame")
	arg_2_0.icon = arg_2_0.foodItem:Find("icon_bg/icon")
	arg_2_0.foodName = arg_2_0._tf:Find("frame/name"):GetComponent(typeof(Text))
	arg_2_0.foodDesc = arg_2_0._tf:Find("frame/desc"):GetComponent(typeof(Text))
	arg_2_0.calPanel = arg_2_0._tf:Find("frame/cal_panel")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/cancel_btn")
	arg_2_0.countValue = arg_2_0.calPanel:Find("value/Text"):GetComponent(typeof(Text))
	arg_2_0.total = arg_2_0.calPanel:Find("total/Text"):GetComponent(typeof(Text))
	arg_2_0.totalIcon = arg_2_0.calPanel:Find("total/icon"):GetComponent(typeof(Image))
	arg_2_0.minusBtn = arg_2_0.calPanel:Find("minus_btn")
	arg_2_0.addBtn = arg_2_0.calPanel:Find("add_btn")
	arg_2_0.tenBtn = arg_2_0.calPanel:Find("ten_btn")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/ok_btn")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/cancel_btn")
	arg_2_0.closetBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0._parentTF = arg_2_0._tf.parent

	setText(arg_2_0.cancelBtn:Find("text"), i18n("word_cancel"))
	setText(arg_2_0.confirmBtn:Find("text"), i18n("word_ok"))
	setText(arg_2_0._tf:Find("frame/title"), i18n("words_information"))

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
	onButton(arg_3_0, arg_3_0.closetBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	var_0_0.super.Show(arg_7_0)
	arg_7_0:UpdateFood(arg_7_1)

	local var_7_0 = pg.shop_template[underscore.detect(getGameset("food_shop_id")[2], function(arg_8_0)
		return arg_8_0[1] == arg_7_1
	end)[2]]
	local var_7_1 = var_7_0.resource_type
	local var_7_2 = 1

	arg_7_0.total.text = var_7_0.resource_num * 1

	LoadSpriteAtlasAsync("props/" .. id2res(var_7_0.resource_type), "", function(arg_9_0)
		arg_7_0.totalIcon.sprite = arg_9_0
		tf(arg_7_0.totalIcon.gameObject).sizeDelta = Vector2(50, 50)

		return
	end)

	arg_7_0.countValue.text = 1

	onButton(arg_7_0, arg_7_0.minusBtn, function()
		if var_7_2 <= 1 then
			return
		end

		var_7_2 = var_7_2 - 1
		arg_7_0.countValue.text = var_7_2
		arg_7_0.total.text = var_0 * var_7_2

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.addBtn, function()
		if var_7_2 == 999 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardGranaryLayer_buyCountLimit", var_7_2))

			return
		end

		var_7_2 = var_7_2 > 999 and 999 or var_7_2 + 1
		arg_7_0.countValue.text = var_7_2
		arg_7_0.total.text = var_0 * var_7_2

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.tenBtn, function()
		if var_7_2 == 999 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardGranaryLayer_buyCountLimit", var_7_2))

			return
		end

		var_7_2 = var_7_2 + 10 >= 999 and 999 or var_7_2 + 10
		arg_7_0.countValue.text = var_7_2
		arg_7_0.total.text = var_0 * var_7_2

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.confirmBtn, function()
		arg_7_0:Purchase({
			count = var_7_2,
			resourceType = var_7_1,
			resourceNum = var_0,
			shopId = var_0
		})

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.Purchase(arg_14_0, arg_14_1)
	if getProxy(PlayerProxy):getRawData()[id2res(arg_14_1.resourceType)] < arg_14_1.resourceNum * arg_14_1.count then
		if arg_14_1.resourceType == 4 then
			GoShoppingMsgBox(i18n("switch_to_shop_tip_3", i18n("word_gem")), ChargeScene.TYPE_DIAMOND)
		elseif arg_14_1.resourceType == 2 and ItemTipPanel.ShowOilBuyTip(arg_14_1.resourceNum * arg_14_1.count) then
			-- block empty
		else
			local var_14_0 = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = arg_14_1.resourceType
			})

			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardGranaryLayer_error_noResource", (var_14_0:getName())))
		end

		arg_14_0:Hide()

		return
	end

	arg_14_0:emit(BackyardFeedMediator.BUY_FOOD, arg_14_1.shopId, arg_14_1.count)
	arg_14_0:Hide()

	return
end

function var_0_0.UpdateFood(arg_15_0, arg_15_1)
	local var_15_0 = Item.getConfigData(arg_15_1)

	;({
		id = arg_15_1
	}).cnt = getProxy(BagProxy):getItemCountById(arg_15_1)

	updateItem(arg_15_0.foodItem, Item.New({
		id = arg_15_1
	}))

	arg_15_0.foodName.text = var_15_0.name
	arg_15_0.foodDesc.text = var_15_0.display

	return
end

function var_0_0.Hide(arg_16_0)
	var_0_0.super.Hide(arg_16_0)

	return
end

function var_0_0.OnDestroy(arg_17_0)
	arg_17_0:Hide()

	return
end

return var_0_0
