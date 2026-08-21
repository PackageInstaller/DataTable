local var_0_0 = class("WorldCruiseChargePage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "WorldCruiseChargePage"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.buyWindow = arg_3_0._tf:Find("buy_window")
	arg_3_0.cancelBtn = arg_3_0.buyWindow:Find("button_container/button_cancel")

	setText(arg_3_0.cancelBtn:Find("Image"), i18n("text_cancel"))

	arg_3_0.confirmBtn = arg_3_0.buyWindow:Find("button_container/button_ok")
	arg_3_0.priceTF = arg_3_0.confirmBtn:Find("Image")

	setText(arg_3_0.buyWindow:Find("left/got/desc"), i18n("battlepass_pay_acquire"))

	local var_3_0 = arg_3_0.buyWindow:Find("right/items/scrollview/list")

	arg_3_0.uiItemList = UIItemList.New(var_3_0, var_3_0:Find("tpl"))

	arg_3_0.uiItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = arg_3_0.itemList[arg_4_1]

			updateDrop(arg_4_2, arg_3_0.itemList[arg_4_1])
			setText(arg_4_2:Find("name"), shortenString(arg_3_0.itemList[arg_4_1]:getConfig("name"), 4))
			onButton(arg_3_0, arg_4_2, function()
				arg_3_0:emit(BaseUI.ON_NEW_STYLE_DROP, {
					drop = var_4_0
				})

				return
			end, SFX_CONFIRM)
		end

		return
	end)

	arg_3_0.unlcokWindow = arg_3_0._tf:Find("unlock_window")

	setText(arg_3_0.unlcokWindow:Find("tip"), i18n("word_click_to_close"))

	arg_3_0.unlockItem = arg_3_0.unlcokWindow:Find("IconTpl")

	onButton(arg_3_0, arg_3_0._tf:Find("bg"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		if ChargeConst.isNeedSetBirth() then
			arg_3_0:emit(WorldCruiseMediator.EVENT_OPEN_BIRTHDAY)
		else
			pg.m02:sendNotification(GAME.CHARGE_OPERATION, {
				shopId = arg_3_0.passId
			})
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ShowBuyWindow(arg_9_0)
	setActive(arg_9_0.buyWindow, true)
	setActive(arg_9_0.unlcokWindow, false)
	arg_9_0:Show()

	if arg_9_0.passId and arg_9_0.passId == var_0_0.GetPassID() then
		return
	end

	arg_9_0.passId = var_0_0.GetPassID()

	local var_9_0 = Goods.Create({
		shop_id = arg_9_0.passId
	}, Goods.TYPE_CHARGE)
	local var_9_1 = Drop.Create(var_9_0:getConfig("display")[1])

	LoadImageSpriteAtlasAsync(var_9_1:getIcon(), "", arg_9_0.buyWindow:Find("left/got/award/icon"))
	setText(arg_9_0.buyWindow:Find("left/got/award/count"), "x" .. var_9_1.count)
	setText(arg_9_0.buyWindow:Find("right/tip"), var_9_0:getConfig("descrip_extra"))

	local var_9_2 = var_9_0:getConfig("money")

	if PLATFORM_CODE == PLATFORM_CHT and var_9_0:IsLocalPrice() then
		-- block empty
	else
		var_9_2 = GetMoneySymbol() .. var_9_2
	end

	setText(arg_9_0.priceTF, var_9_2)

	arg_9_0.itemList = var_9_0:GetExtraServiceItem()

	arg_9_0.uiItemList:align(#arg_9_0.itemList)

	return
end

function var_0_0.GetPassID()
	local var_10_0 = getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)

	if var_10_0 and not var_10_0:isEnd() then
		for iter_10_0, iter_10_1 in ipairs(pg.pay_data_display.all) do
			if pg.pay_data_display[iter_10_1].sub_display and type(pg.pay_data_display[iter_10_1].sub_display) == "table" and pg.pay_data_display[iter_10_1].sub_display[1] == var_10_0.id then
				return iter_10_1
			end
		end
	end

	return
end

function var_0_0.ShowUnlockWindow(arg_11_0, arg_11_1)
	setActive(arg_11_0.buyWindow, false)
	setActive(arg_11_0.unlcokWindow, true)
	arg_11_0:Show()
	updateDrop(arg_11_0.unlockItem, (Drop.Create(arg_11_1:getConfig("display")[1])))
	onButton(arg_11_0, arg_11_0.unlockItem, function()
		arg_11_0:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_0
		})

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.Show(arg_13_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_13_0._tf)
	var_0_0.super.Show(arg_13_0)

	return
end

function var_0_0.Hide(arg_14_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0._tf)
	var_0_0.super.Hide(arg_14_0)

	return
end

function var_0_0.OnDestroy(arg_15_0)
	return
end

return var_0_0
