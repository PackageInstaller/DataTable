local var_0_0 = class("MailConfirmationWindow", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MailConfirmationMsgboxUI"
end

function var_0_0.OnInit(arg_2_0)
	onButton(arg_2_0, arg_2_0._tf:Find("bg"), function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)

	arg_2_0.closeBtn = arg_2_0._tf:Find("adapt/window/top/btnBack")

	onButton(arg_2_0, arg_2_0.closeBtn, function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)

	arg_2_0.cancelButton = arg_2_0._tf:Find("adapt/window/button_container/btn_not")
	arg_2_0.confirmButton = arg_2_0._tf:Find("adapt/window/button_container/btn_ok")
	arg_2_0._window = arg_2_0._tf:Find("adapt/window")
	arg_2_0._window_details = arg_2_0._tf:Find("adapt/window_details")
	arg_2_0.titleTips = arg_2_0._window:Find("top/bg/infomation/title")
	arg_2_0._msgPanel = arg_2_0._window:Find("msg_panel")
	arg_2_0.contentText = arg_2_0._window:Find("msg_panel/content")
	arg_2_0._itemPanel = arg_2_0._window:Find("item_panel")
	arg_2_0._itemText = arg_2_0._itemPanel:Find("tip/confire_text"):GetComponent(typeof(Text))
	arg_2_0._itemListItemContainer = arg_2_0._itemPanel:Find("scrollview/list")
	arg_2_0._itemListItemTpl = arg_2_0._itemListItemContainer:Find("item")
	arg_2_0._deltailBtn = arg_2_0._itemPanel:Find("tip/more_btn")
	arg_2_0.rewardList = arg_2_0._itemPanel:Find("scrollview/list"):GetComponent("LScrollRect")

	function arg_2_0.rewardList.onUpdateItem(arg_5_0, arg_5_1)
		arg_5_0 = arg_5_0 + 1

		updateDrop(tf(arg_5_1):Find("IconTpl"), arg_2_0.items[arg_5_0])

		local var_5_0 = tf(arg_5_1):Find("IconTpl/name")

		setText(var_5_0, shortenString(getText(var_5_0), 4))

		return
	end

	arg_2_0._deltailBtnSelectBg = arg_2_0._deltailBtn:Find("selectBg")
	arg_2_0._deltailBtnUnSelectBg = arg_2_0._deltailBtn:Find("unselectBg")
	arg_2_0._totolmailCountText = arg_2_0._window_details:Find("top/mail/Text")
	arg_2_0._mailGettitle = arg_2_0._window_details:Find("top/bg/infomation/title")
	arg_2_0.lsrMailList = arg_2_0._window_details:Find("item_panel/scrollview/list"):GetComponent("LScrollRect")

	function arg_2_0.lsrMailList.onUpdateItem(arg_6_0, arg_6_1)
		arg_6_0 = arg_6_0 + 1

		setText(tf(arg_6_1):Find("Text"), shortenString(HXSet.hxLan(arg_2_0.filterMails[arg_6_0].title), 10))

		return
	end

	arg_2_0.mailids = {}

	onButton(arg_2_0, arg_2_0._deltailBtn, function()
		if arg_2_0.require then
			return
		end

		arg_2_0.require = true

		arg_2_0:emit(MailMediator.ON_GET_MAIL_TITLE, arg_2_0.mailids, function(arg_8_0)
			SetActive(arg_2_0._deltailBtnUnSelectBg, false)
			SetActive(arg_2_0._deltailBtnSelectBg, true)
			setActive(arg_2_0._window_details, true)
			setText(arg_2_0._mailGettitle, i18n("mail_getbox_title"))

			arg_2_0.filterMails = arg_8_0

			table.sort(arg_2_0.filterMails, CompareFuncs({
				function(arg_9_0)
					return -arg_9_0.id
				end
			}))
			setText(arg_2_0._totolmailCountText, #arg_2_0.filterMails)
			arg_2_0.lsrMailList:SetTotalCount(#arg_2_0.filterMails, 0)

			return
		end)

		return
	end, SFX_PANEL)
	arg_2_0:commonSettings()
	setText(arg_2_0.cancelButton:Find("Text"), i18n("mail_box_cancel"))
	setText(arg_2_0.confirmButton:Find("Text"), i18n("mail_box_confirm"))
	setText(arg_2_0.titleTips, i18n("mail_boxtitle_information"))

	return
end

function var_0_0.showTipsBox(arg_10_0, arg_10_1)
	SetActive(arg_10_0._msgPanel, true)
	setText(arg_10_0.contentText, arg_10_1.content)

	return
end

function var_0_0.showItemBox(arg_11_0, arg_11_1)
	SetActive(arg_11_0._itemPanel, true)
	SetActive(arg_11_0._deltailBtnUnSelectBg, true)
	SetActive(arg_11_0._deltailBtnSelectBg, false)

	arg_11_0.mailids = arg_11_1.mailids
	arg_11_0._itemText.text = arg_11_1.content or ""

	setText(arg_11_0._deltailBtn:Find("Text"), i18n("mail_take_maildetail_msgbox"))

	arg_11_0.items = arg_11_1.items

	arg_11_0.rewardList:SetTotalCount(#arg_11_0.items, 0)

	return
end

function var_0_0.commonSettings(arg_12_0)
	setActive(arg_12_0._msgPanel, false)
	setActive(arg_12_0._itemPanel, false)
	setActive(arg_12_0._window_details, false)

	arg_12_0.require = false

	return
end

function var_0_0.Show(arg_13_0, arg_13_1)
	var_0_0.super.Show(arg_13_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_13_0._tf)
	arg_13_0:commonSettings()
	switch(arg_13_1.type, {
		[MailProxy.MailMessageBoxType.ReceiveAward] = function()
			arg_13_0:showItemBox(arg_13_1)

			return
		end,
		[MailProxy.MailMessageBoxType.ShowTips] = function()
			arg_13_0:showTipsBox(arg_13_1)

			return
		end
	})
	onButton(arg_13_0, arg_13_0.cancelButton, function()
		arg_13_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_13_0, arg_13_0.confirmButton, function()
		arg_13_0:Hide()

		if arg_13_1.onYes then
			arg_13_1.onYes()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Hide(arg_18_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_18_0._tf, arg_18_0._parentTf)
	var_0_0.super.Hide(arg_18_0)

	return
end

function var_0_0.OnDestroy(arg_19_0)
	if arg_19_0:isShowing() then
		arg_19_0:Hide()
	end

	return
end

return var_0_0
