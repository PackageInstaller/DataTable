local var_0_0 = class("AppreciateUnlockMsgBox", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "AppreciateUnlockMsgBox"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.customMsgbox = arg_2_0._tf
	arg_2_0.msgBoxItemPanel = arg_2_0.customMsgbox:Find("frame/bg/item_panel")
	arg_2_0.msgboxItemContains = arg_2_0.customMsgbox:Find("frame/bg/item_panel/items")
	arg_2_0.msgBoxItemTpl = arg_2_0.msgboxItemContains:Find("equipmenttpl")
	arg_2_0.msgBoxItemContent = arg_2_0.customMsgbox:Find("frame/bg/item_panel/content")
	arg_2_0.msgBoxItemContent1 = arg_2_0.customMsgbox:Find("frame/bg/item_panel/content_num")
	arg_2_0.msgBoxCancelBtn = arg_2_0.customMsgbox:Find("frame/btns/cancel_btn")
	arg_2_0.msgBoxConfirmBtn = arg_2_0.customMsgbox:Find("frame/btns/confirm_btn")
	arg_2_0.msgBoxContent = arg_2_0.customMsgbox:Find("frame/bg/content")
	arg_2_0.msgBtnBack = arg_2_0.customMsgbox:Find("frame/top/btnBack")

	SetActive(arg_2_0.customMsgbox, false)

	arg_2_0.settings = {}

	onButton(arg_2_0, arg_2_0.msgBoxConfirmBtn, function()
		if arg_2_0.settings.onYes then
			arg_2_0.settings.onYes()
		else
			arg_2_0:hideCustomMsgBox()
		end

		return
	end, SFX_PANEL)
	SetActive(arg_2_0.msgBoxCancelBtn, not defaultValue(arg_2_0.settings.hideNO, false))
	onButton(arg_2_0, arg_2_0.msgBoxCancelBtn, function()
		if arg_2_0.settings.onCancel then
			arg_2_0.settings.onCancel()
		else
			arg_2_0:hideCustomMsgBox()
		end

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.customMsgbox, function()
		arg_2_0:hideCustomMsgBox()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.msgBtnBack, function()
		arg_2_0:hideCustomMsgBox()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.showCustomMsgBox(arg_7_0, arg_7_1)
	arg_7_0.isShowCustomMsgBox = true
	arg_7_0.settings = arg_7_1

	setActive(arg_7_0.customMsgbox, true)
	pg.UIMgr.GetInstance():OverlayPanel(arg_7_0.customMsgbox)

	local var_7_0 = arg_7_1.items and #arg_7_1.items > 0

	setActive(arg_7_0.msgBoxItemPanel, var_7_0)
	setActive(arg_7_0.msgBoxContent, not var_7_0)

	local var_7_1 = getProxy(PlayerProxy):getData()

	if var_7_0 then
		local var_7_2 = arg_7_1.items

		for iter_7_0 = arg_7_0.msgboxItemContains.childCount + 1, #arg_7_1.items do
			cloneTplTo(arg_7_0.msgBoxItemTpl, arg_7_0.msgboxItemContains)
		end

		for iter_7_1 = 1, arg_7_0.msgboxItemContains.childCount do
			local var_7_3 = arg_7_0.msgboxItemContains:GetChild(iter_7_1 - 1)

			SetActive(var_7_3, iter_7_1 <= #var_7_2)

			if iter_7_1 <= #var_7_2 then
				local var_7_4 = var_7_2[iter_7_1]

				updateDrop(var_7_3, var_7_2[iter_7_1])

				local var_7_5 = 0

				if var_7_4.type == DROP_TYPE_RESOURCE then
					var_7_5 = var_7_1:getResById(var_7_4.id)
				elseif var_7_4.type == DROP_TYPE_ITEM then
					var_7_5 = getProxy(BagProxy):getItemCountById(var_7_4.id)
				end

				if var_7_5 < var_7_4.count then
					local var_7_6 = "<color=#D6341DFF>" .. var_7_4.count .. "</color>" or "<color=#A9F548FF>" .. var_7_4.count .. "</color>"

					setText(var_7_3:Find("icon_bg/count"), var_7_5 .. "/" .. var_7_6)
				end
			end
		end

		local var_7_7 = arg_7_1.content or ""

		setText(arg_7_0.msgBoxItemContent, var_7_7)

		local var_7_8 = arg_7_1.content1 or ""

		setText(arg_7_0.msgBoxItemContent1, var_7_8)
	else
		local var_7_10 = arg_7_1.content or ""

		var_7_9(arg_7_0.msgBoxContent, var_7_10)
	end

	return
end

function var_0_0.hideCustomMsgBox(arg_8_0)
	arg_8_0.isShowCustomMsgBox = nil

	SetActive(arg_8_0.customMsgbox, false)
	arg_8_0:Destroy()

	return
end

function var_0_0.OnDestroy(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0.customMsgbox, arg_9_0._tf)

	return
end

return var_0_0
