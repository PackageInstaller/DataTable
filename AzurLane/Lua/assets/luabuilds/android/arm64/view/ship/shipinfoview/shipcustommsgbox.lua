local var_0_0 = class("ShipCustomMsgBox", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ShipCustomMsgBox"
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
	arg_2_0.msgBoxTitle = arg_2_0.customMsgbox:Find("frame/top/title_list/infomation/title")
	arg_2_0.msgBoxTitleEn = arg_2_0.customMsgbox:Find("frame/top/title_list/infomation/title_en")

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

function var_0_0.SetShareData(arg_7_0, arg_7_1)
	arg_7_0.shareData = arg_7_1

	return
end

function var_0_0.showCustomMsgBox(arg_8_0, arg_8_1)
	arg_8_0.isShowCustomMsgBox = true
	arg_8_0.settings = arg_8_1

	setActive(arg_8_0.customMsgbox, true)
	pg.UIMgr.GetInstance():OverlayPanel(arg_8_0.customMsgbox)

	local var_8_0 = arg_8_1.items and #arg_8_1.items > 0

	setActive(arg_8_0.msgBoxItemPanel, var_8_0)
	setActive(arg_8_0.msgBoxContent, not var_8_0)

	if var_8_0 then
		local var_8_1 = arg_8_1.items

		for iter_8_0 = arg_8_0.msgboxItemContains.childCount + 1, #arg_8_1.items do
			cloneTplTo(arg_8_0.msgBoxItemTpl, arg_8_0.msgboxItemContains)
		end

		for iter_8_1 = 1, arg_8_0.msgboxItemContains.childCount do
			local var_8_2 = arg_8_0.msgboxItemContains:GetChild(iter_8_1 - 1)

			SetActive(var_8_2, iter_8_1 <= #var_8_1)

			if iter_8_1 <= #var_8_1 then
				local var_8_3 = var_8_1[iter_8_1]

				updateDrop(var_8_2, var_8_1[iter_8_1])

				local var_8_4 = 0

				if var_8_3.type == DROP_TYPE_RESOURCE then
					var_8_4 = arg_8_0.shareData.player:getResById(var_8_3.id)
				elseif var_8_3.type == DROP_TYPE_ITEM then
					var_8_4 = getProxy(BagProxy):getItemCountById(var_8_3.id)
				end

				local var_8_5 = var_8_3.count

				var_8_4 = var_8_4 < var_8_3.count and "<color=#D6341DFF>" .. var_8_4 .. "</color>" or "<color=#A9F548FF>" .. var_8_4 .. "</color>"

				setText(var_8_2:Find("icon_bg/count"), var_8_4 .. "/" .. var_8_5)
			end
		end

		local var_8_6 = arg_8_1.content or ""

		setText(arg_8_0.msgBoxItemContent, var_8_6)

		local var_8_7 = arg_8_1.content1 or ""

		setText(arg_8_0.msgBoxItemContent1, var_8_7)
	else
		local var_8_9 = arg_8_1.content or ""

		var_8_8(arg_8_0.msgBoxContent, var_8_9)
	end

	if arg_8_1.title then
		setText(arg_8_0.msgBoxTitle, arg_8_1.title.title)
		setText(arg_8_0.msgBoxTitleEn, arg_8_1.title.titleEn or "")
	end

	return
end

function var_0_0.hideCustomMsgBox(arg_9_0)
	arg_9_0.isShowCustomMsgBox = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0.customMsgbox, arg_9_0._tf)
	SetActive(arg_9_0.customMsgbox, false)

	return
end

function var_0_0.OnDestroy(arg_10_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0.customMsgbox, arg_10_0._tf)

	arg_10_0.shareData = nil

	return
end

return var_0_0
