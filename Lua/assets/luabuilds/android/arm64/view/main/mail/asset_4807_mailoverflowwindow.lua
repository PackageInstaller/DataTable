local MailOverflowWindow = class("MailOverflowWindow", import("view.base.BaseSubView"))

function MailOverflowWindow:getUIName()
	return "MailOverflowMsgboxUI"
end

function MailOverflowWindow:OnInit()
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.closeBtn = self._tf:Find("adapt/window_overflow/top/btnBack")

	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self._window_overflow = self._tf:Find("adapt/window_overflow")
	self.titleTips = self._window_overflow:Find("top/bg/infomation/title")
	self._itemConfireText = self._window_overflow:Find("content")
	self._confireLabel = self._window_overflow:Find("desc/label1")
	self._confireInput = self._window_overflow:Find("desc/InputField")
	self._overflowtitleTips = self._window_overflow:Find("top/bg/infomation/title")
	self.PlaceholderText = self._confireInput:Find("Placeholder")
	self._overflowcancelButton = self._window_overflow:Find("button_container/btn_not")
	self._overflowconfirmButton = self._window_overflow:Find("button_container/btn_ok")
	self.item = self._window_overflow:Find("item")
	self.items = self._window_overflow:Find("items")
	self.itemList = UIItemList.New(self.items, self.item)

	setText(self._overflowcancelButton:Find("Text"), i18n("mail_box_cancel"))
	setText(self._overflowconfirmButton:Find("Text"), i18n("mail_box_confirm"))
	setText(self.titleTips, i18n("mail_boxtitle_information"))
	setText(self.PlaceholderText, i18n("mail_search"))

	return
end

function MailOverflowWindow:Updatelayout()
	if not self.key then
		self.key = math.random(100000, 999999)

		setText(self._confireLabel, i18n("mail_storeroom_max_2", self.key))
	else
		setText(self._confireLabel, "")
	end

	return
end

function MailOverflowWindow:showConformMsgBox(arg_6_1)
	setText(self._itemConfireText, arg_6_1.content)

	self.key = nil

	self:Updatelayout()
	onButton(self, self._overflowcancelButton, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._overflowconfirmButton, function()
		if self.key and self.key ~= tonumber((getInputText(self._confireInput))) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("mail_input_erro"))

			return
		end

		self:Hide()

		if arg_6_1.onYes then
			arg_6_1.onYes()
		end

		return
	end, SFX_PANEL)
	setActive(self.item, false)
	self.itemList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			updateDrop(arg_9_2:Find("IconTpl"), {
				type = arg_6_1.dropList[arg_9_1 + 1].type,
				id = arg_6_1.dropList[arg_9_1 + 1].id,
				count = arg_6_1.dropList[arg_9_1 + 1].count
			})
		end

		return
	end)
	self.itemList:align(#arg_6_1.dropList)

	return
end

function MailOverflowWindow:Show(arg_10_1)
	MailOverflowWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:showConformMsgBox(arg_10_1)

	return
end

function MailOverflowWindow:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	MailOverflowWindow.super.Hide(self)
	setInputText(self._confireInput, "")

	return
end

function MailOverflowWindow:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return MailOverflowWindow
