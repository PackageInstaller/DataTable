local PtAwardLayer = class("PtAwardLayer", import("view.base.BaseUI"))

function PtAwardLayer:getUIName()
	return "ActivitybonusWindow_btnVariant"
end

function PtAwardLayer:init()
	self.window = PtAwardWindow.New(self._tf, self)

	function self.window.Hide()
		self:Hide()

		return
	end

	self.btn_banned = self._tf:Find("window/btn_banned")
	self.btn_get = self._tf:Find("window/btn_get")
	self.btn_got = self._tf:Find("window/btn_got")

	return
end

function PtAwardLayer:didEnter()
	onButton(self, self.btn_get, function()
		local var_5_0, var_5_1 = self.contextData.ptData:GetResProgress()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = self.contextData.ptData:GetId(),
			arg1 = var_5_1
		})

		return
	end, SFX_PANEL)
	self:UpdateView()

	return
end

function PtAwardLayer:UpdateView()
	self.window:Show(self.contextData.ptData)

	local var_6_0 = self.contextData.ptData:CanGetAward()

	setActive(self.btn_get, var_6_0)
	setActive(self.btn_banned, not var_6_0)

	return
end

function PtAwardLayer:Hide()
	self:closeView()

	return
end

function PtAwardLayer:willExit()
	if self.window then
		self.window:Dispose()

		self.window = nil
	end

	return
end

return PtAwardLayer
