local FriendRefusePage = class("FriendRefusePage", import("...base.BaseSubView"))

function FriendRefusePage:getUIName()
	return "FriendRefuseUI"
end

function FriendRefusePage:OnLoaded()
	return
end

function FriendRefusePage:OnInit()
	self.context = self._tf:Find("window/frame/Text"):GetComponent(typeof(Text))
	self.remind = self._tf:Find("window/remind")
	self.confirmBtn = self._tf:Find("window/confirm_btn")
	self.cancelBtn = self._tf:Find("window/cancel_btn")
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.checkLabel = self.remind:Find("Text"):GetComponent(typeof(Text))

	onButton(nil, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(nil, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(nil, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.isOn = false

	onToggle(nil, self.remind, function(arg_7_0)
		self.isOn = arg_7_0

		return
	end, SFX_PANEL)
	onButton(nil, self.confirmBtn, function()
		if self.func then
			self.func(self.isOn)
		end

		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function FriendRefusePage:Show(arg_9_1, arg_9_2, arg_9_3)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.func = arg_9_3
	self.context.text = arg_9_1

	triggerToggle(self.remind, false)
	setActive(self._tf, true)

	self.checkLabel.text = arg_9_2

	self._tf:SetAsLastSibling()

	return
end

function FriendRefusePage:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	setActive(self._tf, false)

	self.func = nil
	self.context.text = ""
	self.checkLabel.text = ""

	return
end

function FriendRefusePage:OnDestroy()
	self:Hide()
	removeOnButton(self._tf)
	removeOnButton(self.cancelBtn)

	return
end

return FriendRefusePage
