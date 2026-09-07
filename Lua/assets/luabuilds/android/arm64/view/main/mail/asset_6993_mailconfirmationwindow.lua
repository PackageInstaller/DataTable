local MailConfirmationWindow = class("MailConfirmationWindow", import("view.base.BaseSubView"))

function MailConfirmationWindow:getUIName()
	return "MailConfirmationMsgboxUI"
end

function MailConfirmationWindow:OnInit()
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.closeBtn = self._tf:Find("adapt/window/top/btnBack")

	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.cancelButton = self._tf:Find("adapt/window/button_container/btn_not")
	self.confirmButton = self._tf:Find("adapt/window/button_container/btn_ok")
	self._window = self._tf:Find("adapt/window")
	self._window_details = self._tf:Find("adapt/window_details")
	self.titleTips = self._window:Find("top/bg/infomation/title")
	self._msgPanel = self._window:Find("msg_panel")
	self.contentText = self._window:Find("msg_panel/content")
	self._itemPanel = self._window:Find("item_panel")
	self._itemText = self._itemPanel:Find("tip/confire_text"):GetComponent(typeof(Text))
	self._itemListItemContainer = self._itemPanel:Find("scrollview/list")
	self._itemListItemTpl = self._itemListItemContainer:Find("item")
	self._deltailBtn = self._itemPanel:Find("tip/more_btn")
	self.rewardList = self._itemPanel:Find("scrollview/list"):GetComponent("LScrollRect")

	function self.rewardList.onUpdateItem(arg_5_0, arg_5_1)
		arg_5_0 = arg_5_0 + 1

		updateDrop(tf(arg_5_1):Find("IconTpl"), self.items[arg_5_0])

		local var_5_0 = tf(arg_5_1):Find("IconTpl/name")

		setText(var_5_0, shortenString(getText(var_5_0), 4))

		return
	end

	self._deltailBtnSelectBg = self._deltailBtn:Find("selectBg")
	self._deltailBtnUnSelectBg = self._deltailBtn:Find("unselectBg")
	self._totolmailCountText = self._window_details:Find("top/mail/Text")
	self._mailGettitle = self._window_details:Find("top/bg/infomation/title")
	self.lsrMailList = self._window_details:Find("item_panel/scrollview/list"):GetComponent("LScrollRect")

	function self.lsrMailList.onUpdateItem(arg_6_0, arg_6_1)
		arg_6_0 = arg_6_0 + 1

		setText(tf(arg_6_1):Find("Text"), shortenString(HXSet.hxLan(self.filterMails[arg_6_0].title), 10))

		return
	end

	self.mailids = {}

	onButton(self, self._deltailBtn, function()
		if self.require then
			return
		end

		self.require = true

		self:emit(MailMediator.ON_GET_MAIL_TITLE, self.mailids, function(arg_8_0)
			SetActive(self._deltailBtnUnSelectBg, false)
			SetActive(self._deltailBtnSelectBg, true)
			setActive(self._window_details, true)
			setText(self._mailGettitle, i18n("mail_getbox_title"))

			self.filterMails = arg_8_0

			table.sort(self.filterMails, CompareFuncs({
				function(arg_9_0)
					return -arg_9_0.id
				end
			}))
			setText(self._totolmailCountText, #self.filterMails)
			self.lsrMailList:SetTotalCount(#self.filterMails, 0)

			return
		end)

		return
	end, SFX_PANEL)
	self:commonSettings()
	setText(self.cancelButton:Find("Text"), i18n("mail_box_cancel"))
	setText(self.confirmButton:Find("Text"), i18n("mail_box_confirm"))
	setText(self.titleTips, i18n("mail_boxtitle_information"))

	return
end

function MailConfirmationWindow:showTipsBox(arg_10_1)
	SetActive(self._msgPanel, true)
	setText(self.contentText, arg_10_1.content)

	return
end

function MailConfirmationWindow:showItemBox(arg_11_1)
	SetActive(self._itemPanel, true)
	SetActive(self._deltailBtnUnSelectBg, true)
	SetActive(self._deltailBtnSelectBg, false)

	self.mailids = arg_11_1.mailids
	self._itemText.text = arg_11_1.content or ""

	setText(self._deltailBtn:Find("Text"), i18n("mail_take_maildetail_msgbox"))

	self.items = arg_11_1.items

	self.rewardList:SetTotalCount(#self.items, 0)

	return
end

function MailConfirmationWindow:commonSettings()
	setActive(self._msgPanel, false)
	setActive(self._itemPanel, false)
	setActive(self._window_details, false)

	self.require = false

	return
end

function MailConfirmationWindow:Show(arg_13_1)
	MailConfirmationWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:commonSettings()
	switch(arg_13_1.type, {
		[MailProxy.MailMessageBoxType.ReceiveAward] = function()
			self:showItemBox(arg_13_1)

			return
		end,
		[MailProxy.MailMessageBoxType.ShowTips] = function()
			self:showTipsBox(arg_13_1)

			return
		end
	})
	onButton(self, self.cancelButton, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmButton, function()
		self:Hide()

		if arg_13_1.onYes then
			arg_13_1.onYes()
		end

		return
	end, SFX_PANEL)

	return
end

function MailConfirmationWindow:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	MailConfirmationWindow.super.Hide(self)

	return
end

function MailConfirmationWindow:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return MailConfirmationWindow
