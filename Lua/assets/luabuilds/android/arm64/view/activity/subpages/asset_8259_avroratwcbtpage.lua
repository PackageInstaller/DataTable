local AvroraTWCBTPage = class("AvroraTWCBTPage", import("...base.BaseActivityPage"))

function AvroraTWCBTPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.get = self.bg:Find("get")
	self.go = self.bg:Find("go")

	return
end

function AvroraTWCBTPage:OnFirstFlush()
	onButton(self, self.go, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	local var_2_0 = getProxy(ChapterProxy):isClear(304)

	setActive(self.go, not var_2_0)
	setActive(self.get, var_2_0)

	return
end

return AvroraTWCBTPage
