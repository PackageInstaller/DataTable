local var_0_0 = class("ItemRecycleConfirmationPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ItemRecycleConfirmationUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/btnBack")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("window/button_container/cancel")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("window/button_container/confirm")
	arg_2_0.content = arg_2_0._tf:Find("window/single_item_panel/Text")
	arg_2_0.itemTpl = arg_2_0._tf:Find("window/single_item_panel/left")
	arg_2_0.resTpl = arg_2_0._tf:Find("window/single_item_panel/right")
	arg_2_0.itemName = arg_2_0.itemTpl:Find("name_bg/Text"):GetComponent(typeof(Text))
	arg_2_0.resName = arg_2_0.resTpl:Find("name_bg/Text"):GetComponent(typeof(Text))

	setText(arg_2_0._tf:Find("window/top/bg/infomation/title"), i18n("words_information"))
	setText(arg_2_0._tf:Find("window/button_container/cancel/pic"), i18n("word_cancel"))
	setText(arg_2_0._tf:Find("window/button_container/confirm/pic"), i18n("word_ok"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		if arg_3_0.itemId then
			pg.m02:sendNotification(GAME.SELL_ITEM, {
				items = {
					{
						count = 1,
						id = arg_3_0.itemId
					}
				}
			})
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetCallback(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.onShowFunc = arg_8_1
	arg_8_0.onHideFunc = arg_8_2

	return
end

function var_0_0.Hide(arg_9_0)
	var_0_0.super.Hide(arg_9_0)

	if arg_9_0.onHideFunc then
		arg_9_0.onHideFunc()
	end

	return
end

function var_0_0.Show(arg_10_0, arg_10_1)
	var_0_0.super.Show(arg_10_0)

	arg_10_0.itemId = arg_10_1.itemId

	setText(arg_10_0.content, arg_10_1.content)
	arg_10_0:UpdateItem()
	arg_10_0:UpdateResource()

	if arg_10_0.onShowFunc then
		arg_10_0.onShowFunc()
	end

	return
end

function var_0_0.UpdateItem(arg_11_0)
	local var_11_0 = Drop.Create({
		DROP_TYPE_ITEM,
		arg_11_0.itemId,
		1
	})

	updateDrop(arg_11_0.itemTpl, var_11_0)

	arg_11_0.itemName.text = shortenString(var_11_0:getName(), 5)

	return
end

function var_0_0.UpdateResource(arg_12_0)
	local var_12_0 = Item.New({
		id = arg_12_0.itemId
	}):GetPrice() or {
		1,
		0
	}
	local var_12_1 = Drop.Create({
		DROP_TYPE_RESOURCE,
		var_12_0[1],
		var_12_0[2]
	})

	updateDrop(arg_12_0.resTpl, var_12_1)

	arg_12_0.resName.text = shortenString(var_12_1:getName(), 5)

	return
end

function var_0_0.OnDestroy(arg_13_0)
	arg_13_0:SetCallback(nil, nil)

	return
end

return var_0_0
