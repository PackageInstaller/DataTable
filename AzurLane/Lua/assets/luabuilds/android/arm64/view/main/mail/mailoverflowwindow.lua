local var_0_0 = class("MailOverflowWindow", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MailOverflowMsgboxUI"
end

function var_0_0.OnInit(arg_2_0)
	onButton(arg_2_0, arg_2_0._tf:Find("bg"), function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)

	arg_2_0.closeBtn = arg_2_0._tf:Find("adapt/window_overflow/top/btnBack")

	onButton(arg_2_0, arg_2_0.closeBtn, function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)

	arg_2_0._window_overflow = arg_2_0._tf:Find("adapt/window_overflow")
	arg_2_0.titleTips = arg_2_0._window_overflow:Find("top/bg/infomation/title")
	arg_2_0._itemConfireText = arg_2_0._window_overflow:Find("content")
	arg_2_0._confireLabel = arg_2_0._window_overflow:Find("desc/label1")
	arg_2_0._confireInput = arg_2_0._window_overflow:Find("desc/InputField")
	arg_2_0._overflowtitleTips = arg_2_0._window_overflow:Find("top/bg/infomation/title")
	arg_2_0.PlaceholderText = arg_2_0._confireInput:Find("Placeholder")
	arg_2_0._overflowcancelButton = arg_2_0._window_overflow:Find("button_container/btn_not")
	arg_2_0._overflowconfirmButton = arg_2_0._window_overflow:Find("button_container/btn_ok")
	arg_2_0.item = arg_2_0._window_overflow:Find("item")
	arg_2_0.items = arg_2_0._window_overflow:Find("items")
	arg_2_0.itemList = UIItemList.New(arg_2_0.items, arg_2_0.item)

	setText(arg_2_0._overflowcancelButton:Find("Text"), i18n("mail_box_cancel"))
	setText(arg_2_0._overflowconfirmButton:Find("Text"), i18n("mail_box_confirm"))
	setText(arg_2_0.titleTips, i18n("mail_boxtitle_information"))
	setText(arg_2_0.PlaceholderText, i18n("mail_search"))

	return
end

function var_0_0.Updatelayout(arg_5_0)
	if not arg_5_0.key then
		arg_5_0.key = math.random(100000, 999999)

		setText(arg_5_0._confireLabel, i18n("mail_storeroom_max_2", arg_5_0.key))
	else
		setText(arg_5_0._confireLabel, "")
	end

	return
end

function var_0_0.showConformMsgBox(arg_6_0, arg_6_1)
	setText(arg_6_0._itemConfireText, arg_6_1.content)

	arg_6_0.key = nil

	arg_6_0:Updatelayout()
	onButton(arg_6_0, arg_6_0._overflowcancelButton, function()
		arg_6_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0._overflowconfirmButton, function()
		if arg_6_0.key and arg_6_0.key ~= tonumber((getInputText(arg_6_0._confireInput))) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("mail_input_erro"))

			return
		end

		arg_6_0:Hide()

		if arg_6_1.onYes then
			arg_6_1.onYes()
		end

		return
	end, SFX_PANEL)
	setActive(arg_6_0.item, false)
	arg_6_0.itemList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			updateDrop(arg_9_2:Find("IconTpl"), {
				type = arg_6_1.dropList[arg_9_1 + 1].type,
				id = arg_6_1.dropList[arg_9_1 + 1].id,
				count = arg_6_1.dropList[arg_9_1 + 1].count
			})
		end

		return
	end)
	arg_6_0.itemList:align(#arg_6_1.dropList)

	return
end

function var_0_0.Show(arg_10_0, arg_10_1)
	var_0_0.super.Show(arg_10_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_10_0._tf)
	arg_10_0:showConformMsgBox(arg_10_1)

	return
end

function var_0_0.Hide(arg_11_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0._tf, arg_11_0._parentTf)
	var_0_0.super.Hide(arg_11_0)
	setInputText(arg_11_0._confireInput, "")

	return
end

function var_0_0.OnDestroy(arg_12_0)
	if arg_12_0:isShowing() then
		arg_12_0:Hide()
	end

	return
end

return var_0_0
