class = var_0_10000

local var_0_0 = "MailConfirmationWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MailConfirmationMsgboxUI"
end

function var_0_1.OnInit(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_4.Find(var_2_1, "bg")

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_2_1

	var_1_10001(var_2_0, var_2_2, var_2_3, var_2_1)

	local var_2_4 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_4, "adapt/window/top/btnBack")
	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.closeBtn

	local function var_2_7()
		local var_4_0 = arg_2_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_2_1

	var_1(var_2_5, var_2_6, var_2_7, var_2_1)

	local var_2_8 = arg_2_0._tf

	arg_2_0.cancelButton = var_1.Find(var_2_8, "adapt/window/button_container/btn_not")

	local var_2_9 = arg_2_0._tf

	arg_2_0.confirmButton = var_1.Find(var_2_9, "adapt/window/button_container/btn_ok")

	local var_2_10 = arg_2_0._tf

	arg_2_0._window = var_1.Find(var_2_10, "adapt/window")

	local var_2_11 = arg_2_0._tf

	arg_2_0._window_details = var_1.Find(var_2_11, "adapt/window_details")

	local var_2_12 = arg_2_0._window

	arg_2_0.titleTips = var_1.Find(var_2_12, "top/bg/infomation/title")

	local var_2_13 = arg_2_0._window

	arg_2_0._msgPanel = var_1.Find(var_2_13, "msg_panel")

	local var_2_14 = arg_2_0._window

	arg_2_0.contentText = var_1.Find(var_2_14, "msg_panel/content")

	local var_2_15 = arg_2_0._window

	arg_2_0._itemPanel = var_1.Find(var_2_15, "item_panel")

	local var_2_16 = arg_2_0._itemPanel
	local var_2_17 = var_1.Find(var_2_16, "tip/confire_text")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Text = var_2_1
	arg_2_0._itemText = var_2_18(var_2_17, var_4(var_2_1))

	local var_2_19 = arg_2_0._itemPanel

	arg_2_0._itemListItemContainer = var_1.Find(var_2_19, "scrollview/list")

	local var_2_20 = arg_2_0._itemListItemContainer

	arg_2_0._itemListItemTpl = var_1.Find(var_2_20, "item")

	local var_2_21 = arg_2_0._itemPanel

	arg_2_0._deltailBtn = var_1.Find(var_2_21, "tip/more_btn")

	local var_2_22 = arg_2_0._itemPanel
	local var_2_23 = var_1.Find(var_2_22, "scrollview/list")

	arg_2_0.rewardList = var_1.GetComponent(var_2_23, "LScrollRect")

	function arg_2_0.rewardList.onUpdateItem(arg_5_0, arg_5_1)
		arg_5_0 = arg_5_0 + 1

		local var_5_0 = arg_2_0.items[arg_5_0]

		updateDrop = var_2_10003
		tf = var_2_10005

		local var_5_1 = var_2_10005(arg_5_1)

		var_2_10003(var_5.Find(var_5_1, "IconTpl"), var_5_0)

		tf = var_2_10003

		local var_5_2 = var_2_10003(arg_5_1)
		local var_5_3 = var_3.Find(var_5_2, "IconTpl/name")

		setText = var_2_10004

		local var_5_4 = var_5_3

		shortenString = var_5_1
		getText = var_2_10009

		var_2_10004(var_5_4, var_5_1(var_2_10009(var_5_3), 4))

		return
	end

	local var_2_24 = arg_2_0._deltailBtn

	arg_2_0._deltailBtnSelectBg = var_1.Find(var_2_24, "selectBg")

	local var_2_25 = arg_2_0._deltailBtn

	arg_2_0._deltailBtnUnSelectBg = var_1.Find(var_2_25, "unselectBg")

	local var_2_26 = arg_2_0._window_details

	arg_2_0._totolmailCountText = var_1.Find(var_2_26, "top/mail/Text")

	local var_2_27 = arg_2_0._window_details

	arg_2_0._mailGettitle = var_1.Find(var_2_27, "top/bg/infomation/title")

	local var_2_28 = arg_2_0._window_details
	local var_2_29 = var_1.Find(var_2_28, "item_panel/scrollview/list")

	arg_2_0.lsrMailList = var_1.GetComponent(var_2_29, "LScrollRect")

	function arg_2_0.lsrMailList.onUpdateItem(arg_6_0, arg_6_1)
		arg_6_0 = arg_6_0 + 1

		local var_6_0 = arg_2_0.filterMails[arg_6_0]

		setText = var_2_10003
		tf = var_2_10005

		local var_6_1 = var_2_10005(arg_6_1)
		local var_6_2 = var_5.Find(var_6_1, "Text")

		shortenString = var_2_10006
		HXSet = var_8

		var_2_10003(var_6_2, var_2_10006(var_8.hxLan(var_6_0.title), 10))

		return
	end

	arg_2_0.mailids = {}
	onButton = var_1

	local var_2_30 = arg_2_0
	local var_2_31 = arg_2_0._deltailBtn

	local function var_2_32()
		if arg_2_0.require then
			return
		end

		arg_2_0.require = true

		local var_7_0 = arg_2_0
		local var_7_1 = var_0.emit

		MailMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.ON_GET_MAIL_TITLE, arg_2_0.mailids, function(arg_8_0)
			SetActive = var_3_10001

			var_3_10001(arg_2_0._deltailBtnUnSelectBg, false)

			SetActive = var_3_10001

			var_3_10001(arg_2_0._deltailBtnSelectBg, true)

			setActive = var_3_10001

			var_3_10001(arg_2_0._window_details, true)

			setText = var_3_10001

			local var_8_0 = arg_2_0._mailGettitle

			i18n = var_4

			var_3_10001(var_8_0, var_4("mail_getbox_title"))

			local var_8_1 = arg_2_0

			var_8_1.filterMails = arg_8_0
			table = var_8_1

			local var_8_2 = var_8_1.sort
			local var_8_3 = arg_2_0.filterMails

			CompareFuncs = var_4

			var_8_2(var_8_3, var_4({
				function(arg_9_0)
					return -arg_9_0.id
				end
			}))

			setText = var_8_2

			var_8_2(arg_2_0._totolmailCountText, #arg_2_0.filterMails)

			local var_8_4 = arg_2_0.lsrMailList

			var_1.SetTotalCount(var_8_4, #arg_2_0.filterMails, 0)

			return
		end)

		return
	end

	SFX_PANEL = var_2_1

	var_1(var_2_30, var_2_31, var_2_32, var_2_1)
	arg_2_0:commonSettings()

	setText = var_1

	local var_2_33 = arg_2_0.cancelButton
	local var_2_34 = var_3.Find(var_2_33, "Text")

	i18n = var_2_31

	var_1(var_2_34, var_2_31("mail_box_cancel"))

	setText = var_1

	local var_2_35 = arg_2_0.confirmButton
	local var_2_36 = var_3.Find(var_2_35, "Text")

	i18n = var_4

	var_1(var_2_36, var_4("mail_box_confirm"))

	setText = var_1

	local var_2_37 = arg_2_0.titleTips

	i18n = var_4

	var_1(var_2_37, var_4("mail_boxtitle_information"))

	return
end

function var_0_1.showTipsBox(arg_10_0, arg_10_1)
	SetActive = var_1_10002

	var_1_10002(arg_10_0._msgPanel, true)

	setText = var_1_10002

	var_1_10002(arg_10_0.contentText, arg_10_1.content)

	return
end

function var_0_1.showItemBox(arg_11_0, arg_11_1)
	SetActive = var_1_10002

	var_1_10002(arg_11_0._itemPanel, true)

	SetActive = var_1_10002

	var_1_10002(arg_11_0._deltailBtnUnSelectBg, true)

	SetActive = var_1_10002

	var_1_10002(arg_11_0._deltailBtnSelectBg, false)

	arg_11_0.mailids = arg_11_1.mailids

	local var_11_0 = arg_11_0._itemText
	local var_11_1

	if not arg_11_1.content then
		var_11_1 = ""
	end

	var_11_0.text = var_11_1
	setText = var_11_0

	local var_11_2 = arg_11_0._deltailBtn
	local var_11_3 = var_4.Find(var_11_2, "Text")

	i18n = var_5

	var_11_0(var_11_3, var_5("mail_take_maildetail_msgbox"))

	arg_11_0.items = arg_11_1.items

	local var_11_4 = #arg_11_0.items
	local var_11_5 = arg_11_0.rewardList

	var_3.SetTotalCount(var_11_5, var_11_4, 0)

	return
end

function var_0_1.commonSettings(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0._msgPanel, false)

	setActive = var_1_10001

	var_1_10001(arg_12_0._itemPanel, false)

	setActive = var_1_10001

	var_1_10001(arg_12_0._window_details, false)

	arg_12_0.require = false

	return
end

function var_0_1.Show(arg_13_0, arg_13_1)
	var_0_1.super.Show(arg_13_0)

	pg = var_2

	local var_13_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_13_0, arg_13_0._tf)
	arg_13_0:commonSettings()

	switch = var_2

	local var_13_1 = arg_13_1.type
	local var_13_2 = {}

	MailProxy = var_1_10006
	var_13_2[var_1_10006.MailMessageBoxType.ReceiveAward] = function()
		local var_14_0 = arg_13_0

		var_0.showItemBox(var_14_0, arg_13_1)

		return
	end
	MailProxy = var_6
	var_13_2[var_6.MailMessageBoxType.ShowTips] = function()
		local var_15_0 = arg_13_0

		var_0.showTipsBox(var_15_0, arg_13_1)

		return
	end

	var_2(var_13_1, var_13_2)

	onButton = var_2

	local var_13_3 = arg_13_0
	local var_13_4 = arg_13_0.cancelButton

	local function var_13_5()
		local var_16_0 = arg_13_0

		var_0.Hide(var_16_0)

		return
	end

	SFX_PANEL = var_7

	var_2(var_13_3, var_13_4, var_13_5, var_7)

	onButton = var_2

	local var_13_6 = arg_13_0
	local var_13_7 = arg_13_0.confirmButton

	local function var_13_8()
		local var_17_0 = arg_13_0

		var_0.Hide(var_17_0)

		if arg_13_1.onYes then
			arg_13_1.onYes()
		end

		return
	end

	SFX_PANEL = var_7

	var_2(var_13_6, var_13_7, var_13_8, var_7)

	return
end

function var_0_1.Hide(arg_18_0)
	pg = var_1_10001

	local var_18_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_18_0, arg_18_0._tf, arg_18_0._parentTf)
	var_0_1.super.Hide(arg_18_0)

	return
end

function var_0_1.OnDestroy(arg_19_0)
	if arg_19_0:isShowing() then
		arg_19_0:Hide()
	end

	return
end

return var_0_1
