local IslandCommonMsgboxWindow = class("IslandCommonMsgboxWindow", import(".IslandBaseMsgboxWindow"))

function IslandCommonMsgboxWindow:getUIName()
	return "IslandCommonMsgBox"
end

function IslandCommonMsgboxWindow:OnLoaded()
	self.titleTxt = self._tf:Find("title"):GetComponent(typeof(Text))
	self.contentTxt = self._tf:Find("content/Text"):GetComponent("RichText")
	self.closeBtn = self._tf:Find("close")
	self.cancelBtn = self._tf:Find("cancel")
	self.confirmBtn = self._tf:Find("confirm")
	self.cancelTxt = self._tf:Find("cancel/Text"):GetComponent(typeof(Text))
	self.confirmTxt = self._tf:Find("confirm/Text"):GetComponent(typeof(Text))

	return
end

function IslandCommonMsgboxWindow:OnInit()
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

function IslandCommonMsgboxWindow:OnShow()
	if self.settings.rawIconDic then
		for iter_7_0, iter_7_1 in pairs(self.settings.rawIconDic) do
			self.contentTxt:AddSprite(iter_7_0, iter_7_1)
		end
	end

	self.titleTxt.text = self.settings.title or i18n("island_msg_info")
	self.contentTxt.text = self.settings.content or ""
	self.onYes = self.settings.onYes
	self.onNo = self.settings.onNo
	self.onHide = self.settings.onHide

	self:FlushBtn(self.settings)

	return
end

function IslandCommonMsgboxWindow:FlushBtn(arg_8_1)
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

function IslandCommonMsgboxWindow:OnHide()
	self.onYes = nil
	self.onNo = nil

	if self.onHide then
		self.onHide()

		self.onHide = nil
	end

	return
end

function IslandCommonMsgboxWindow:GetMsgBoxMgr()
	return self.view
end

function IslandCommonMsgboxWindow:OnDestroy()
	return
end

return IslandCommonMsgboxWindow
