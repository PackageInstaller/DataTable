local SelectSkinMsgbox = class("SelectSkinMsgbox", import("view.base.BaseSubView"))

function SelectSkinMsgbox:getUIName()
	return "SelectSkinMsgboxUI"
end

function SelectSkinMsgbox:OnLoaded()
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.cancelBtn = self._tf:Find("window/button_container/cancel")
	self.confirmBtn = self._tf:Find("window/button_container/confirm")
	self.contentTxt = self._tf:Find("window/frame/content"):GetComponent(typeof(Text))
	self.leftItemTr = self._tf:Find("window/frame/left")
	self.rightItemTr = self._tf:Find("window/frame/right")
	self.leftNameTxt = self.leftItemTr:Find("name_bg/Text"):GetComponent(typeof(Text))
	self.rightNameTxt = self.rightItemTr:Find("name_bg/Text"):GetComponent(typeof(Text))

	setText(self.cancelBtn:Find("pic"), i18n("msgbox_text_cancel"))
	setText(self.confirmBtn:Find("pic"), i18n("msgbox_text_confirm"))
	setText(self._tf:Find("window/top/bg/infomation/title"), i18n("title_info"))

	return
end

function SelectSkinMsgbox:OnInit()
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function SelectSkinMsgbox:Show(arg_7_1)
	SelectSkinMsgbox.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.contentTxt.text = arg_7_1.content

	updateDrop(self.leftItemTr, arg_7_1.leftDrop)
	updateDrop(self.rightItemTr, arg_7_1.rightDrop)

	self.leftNameTxt.text = arg_7_1.leftDrop:getConfig("name")
	self.rightNameTxt.text = arg_7_1.rightDrop:getConfig("name")

	onButton(self, self.confirmBtn, function()
		self:Hide()

		if arg_7_1.onYes then
			arg_7_1.onYes()
		end

		return
	end, SFX_PANEL)

	return
end

function SelectSkinMsgbox:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	SelectSkinMsgbox.super.Hide(self)

	return
end

function SelectSkinMsgbox:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return SelectSkinMsgbox
