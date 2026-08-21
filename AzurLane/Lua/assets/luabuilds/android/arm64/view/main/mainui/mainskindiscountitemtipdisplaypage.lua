local var_0_0 = class("MainSkinDiscountItemTipDisplayPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MainSkinDiscountItemTipUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/btnBack")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("window/btn_cancel")
	arg_2_0.goBtn = arg_2_0._tf:Find("window/btn_go")
	arg_2_0.helpBtn = arg_2_0._tf:Find("window/btn_help")
	arg_2_0.remindBtn = arg_2_0._tf:Find("window/stopRemind")
	arg_2_0.uiItemList = UIItemList.New(arg_2_0._tf:Find("window/item_panel/scrollview/list"), arg_2_0._tf:Find("window/item_panel/scrollview/list/tpl"))

	setText(arg_2_0._tf:Find("window/item_panel/label/Text"), i18n("skin_discount_item_expired_tip"))
	setText(arg_2_0._tf:Find("window/stopRemind/Label"), i18n("skin_discount_item_repeat_remind_label"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.skin_discount_item_notice.tip
		})

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
	onButton(arg_3_0, arg_3_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE)
		arg_3_0:Destroy()

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.remindBtn, function(arg_8_0)
		if arg_8_0 then
			arg_3_0:MarkRemind()
		else
			arg_3_0:UnMarkRemind()
		end

		return
	end, SFX_PANEL)
	triggerToggle(arg_3_0.remindBtn, true)

	return
end

function var_0_0.MarkRemind(arg_9_0)
	PlayerPrefs.SetString("SkinDiscountItemTip" .. getProxy(PlayerProxy):getRawData().id, GetZeroTime() + 1)
	PlayerPrefs.Save()

	return
end

function var_0_0.UnMarkRemind(arg_10_0)
	PlayerPrefs.DeleteKey("SkinDiscountItemTip" .. getProxy(PlayerProxy):getRawData().id)
	PlayerPrefs.Save()

	return
end

function var_0_0.Show(arg_11_0, arg_11_1)
	arg_11_0:UpdateList(arg_11_1)
	pg.UIMgr.GetInstance():BlurPanel(arg_11_0._tf)

	return
end

function var_0_0.UpdateList(arg_12_0, arg_12_1)
	arg_12_0.uiItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			arg_12_0:UpdateItem(arg_12_1[arg_13_1 + 1], arg_13_2)
		end

		return
	end)
	arg_12_0.uiItemList:align(#arg_12_1)

	return
end

function var_0_0.UpdateItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = Drop.Create({
		DROP_TYPE_ITEM,
		arg_14_1.id,
		arg_14_1.count
	})

	updateDrop(arg_14_2, var_14_0)
	setScrollText(arg_14_2:Find("name_bg/Text"), var_14_0:getName())
	onButton(arg_14_0, arg_14_2, function()
		pg.m02:sendNotification(NewMainMediator.ON_DROP, var_14_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_16_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_16_0._tf, pg.UIMgr.GetInstance()._normalUIMain)

	return
end

return var_0_0
