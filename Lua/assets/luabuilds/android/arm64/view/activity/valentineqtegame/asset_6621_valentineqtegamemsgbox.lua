local ValentineQteGameMsgBox = class("ValentineQteGameMsgBox")

ValentineQteGameMsgBox.EXIT_TXT = 1
ValentineQteGameMsgBox.PAUSE_TXT = 2

function ValentineQteGameMsgBox:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self._tf = arg_1_1

	self:OnInit()
	self:OnRegister()

	return
end

function ValentineQteGameMsgBox:OnInit()
	self.confirmBtn = self._tf:Find("frame/btns/confirm_btn")
	self.cancelBtn = self._tf:Find("frame/btns/cancel_btn")

	GetComponent(self._tf:Find("frame/exit"), typeof(Image)):SetNativeSize()
	GetComponent(self._tf:Find("frame/puase"), typeof(Image)):SetNativeSize()

	self.texts = {
		[ValentineQteGameMsgBox.EXIT_TXT] = self._tf:Find("frame/exit"),
		[ValentineQteGameMsgBox.PAUSE_TXT] = self._tf:Find("frame/puase")
	}

	return
end

function ValentineQteGameMsgBox:OnRegister()
	onButton(self, self.confirmBtn, function()
		if self.settings.onYes then
			self.settings.onYes()
		end

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		if self.settings.onNo then
			self.settings.onNo()
		end

		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function ValentineQteGameMsgBox:Show(arg_6_1)
	self.settings = arg_6_1

	setActive(self._tf, true)

	for iter_6_0, iter_6_1 in pairs(self.texts) do
		setActive(iter_6_1, false)
	end

	if self.texts[arg_6_1.content] then
		setActive(self.texts[arg_6_1.content], true)
	end

	setActive(self.cancelBtn, not arg_6_1.noNo)

	return
end

function ValentineQteGameMsgBox:Hide()
	setActive(self._tf, false)

	self.settings = nil

	return
end

function ValentineQteGameMsgBox:Destroy()
	pg.DelegateInfo.Dispose(self)
	self:Hide()

	return
end

return ValentineQteGameMsgBox
