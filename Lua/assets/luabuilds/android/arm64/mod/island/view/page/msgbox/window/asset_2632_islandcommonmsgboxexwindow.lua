local IslandCommonMsgboxEXWindow = class("IslandCommonMsgboxEXWindow", import(".IslandCommonMsgboxWindow"))

function IslandCommonMsgboxEXWindow:getUIName()
	return "IslandCommonMsgBoxEX"
end

function IslandCommonMsgboxEXWindow:OnLoaded()
	self.titleTxt = self.rtTitle:GetComponent(typeof(Text))
	self.contentTxt = self.rtContext:GetComponent("RichText")
	self.cancelTxt = self.rtCancelText:GetComponent(typeof(Text))
	self.confirmTxt = self.rtConfirmText:GetComponent(typeof(Text))

	return
end

function IslandCommonMsgboxEXWindow:OnInit()
	onButton(self, self.cancelBtn, function()
		self:Hide()
		existCall(self.onNo)

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:Hide()
		existCall(self.onYes)

		return
	end, SFX_PANEL)

	return
end

function IslandCommonMsgboxEXWindow:OnShow()
	if self.settings.rawIconDic then
		for iter_7_0, iter_7_1 in pairs(self.settings.rawIconDic) do
			self.contentTxt:AddSprite(iter_7_0, iter_7_1)
		end
	end

	self.titleTxt.text = self.settings.title or i18n("island_msg_info")
	self.contentTxt.text = self.settings.content or ""
	self.contentTxt.alignment = self.settings.alignment or TextAnchor.MiddleCenter
	self.onYes = self.settings.onYes
	self.onNo = self.settings.onNo
	self.onHide = self.settings.onHide

	self:FlushBtn(self.settings)

	return
end

function IslandCommonMsgboxEXWindow:FlushBtn(arg_8_1)
	setActive(self.cancelBtn, not arg_8_1.hideNo)

	self.confirmBtn.sizeDelta = Vector2(arg_8_1.hideNo and 880 or 420, self.confirmBtn.sizeDelta.y)

	if arg_8_1.noText then
		self.cancelTxt.text = arg_8_1.noText or i18n("word_cancel")
	end

	if arg_8_1.yesText then
		self.confirmTxt.text = arg_8_1.yesText or i18n("word_ok")
	end

	return
end

function IslandCommonMsgboxEXWindow:OnHide()
	self.onYes = nil
	self.onNo = nil

	if self.onHide then
		self.onHide()

		self.onHide = nil
	end

	return
end

function IslandCommonMsgboxEXWindow:GetMsgBoxMgr()
	return self.view
end

function IslandCommonMsgboxEXWindow:OnDestroy()
	return
end

return IslandCommonMsgboxEXWindow
