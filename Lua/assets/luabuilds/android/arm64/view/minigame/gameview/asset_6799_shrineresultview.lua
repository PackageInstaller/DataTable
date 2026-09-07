local ShrineResultView = class("ShrineResultView", import("...base.BaseSubView"))

function ShrineResultView:getUIName()
	return "ShrineResult"
end

function ShrineResultView:OnInit()
	self:Show()
	self:initData()
	self:initUI()

	return
end

function ShrineResultView:OnDestroy()
	if self.closeFunc then
		self.closeFunc()

		self.closeFunc = nil
	end

	return
end

function ShrineResultView:initData()
	return
end

function ShrineResultView:initUI()
	self.bg = self._tf:Find("BGImg")
	self.dft = GetComponent(self._tf, "DftAniEvent")
	self.text_buff = self._tf:Find("Main/MainBox/Text_Buff")
	self.text_nobuff = self._tf:Find("Main/MainBox/Text_NoBuff")
	self.buffImg_1 = self._tf:Find("Main/MainBox/Buff_1")
	self.buffImg_2 = self._tf:Find("Main/MainBox/Buff_2")
	self.buffImg_3 = self._tf:Find("Main/MainBox/Buff_3")

	onButton(self, self.bg, function()
		self:Destroy()

		return
	end, SFX_CANCEL)
	self.dft:SetStartEvent(function()
		setButtonEnabled(self.bg, false)

		return
	end)
	self.dft:SetEndEvent(function()
		setButtonEnabled(self.bg, true)

		return
	end)

	return
end

function ShrineResultView:updateView(arg_9_1, arg_9_2)
	if arg_9_2 then
		setText(self.text_buff, arg_9_1)
	else
		setText(self.text_nobuff, arg_9_1)
	end

	setActive(self.text_buff, arg_9_2)
	setActive(self.text_nobuff, not arg_9_2)
	setActive(self.buffImg_1, arg_9_2 == 1)
	setActive(self.buffImg_2, arg_9_2 == 2)
	setActive(self.buffImg_3, arg_9_2 == 3)

	return
end

function ShrineResultView:setCloseFunc(arg_10_1)
	self.closeFunc = arg_10_1

	return
end

return ShrineResultView
