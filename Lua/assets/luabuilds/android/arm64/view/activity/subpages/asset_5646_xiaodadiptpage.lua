local XiaoDaDiPtPage = class("XiaoDaDiPtPage", import(".TemplatePage.PtTemplatePage"))

function XiaoDaDiPtPage:OnInit()
	XiaoDaDiPtPage.super.OnInit(self)

	self.hearts = UIItemList.New(self._tf:Find("AD/heart"), self._tf:Find("AD/heart/mark"))

	return
end

function XiaoDaDiPtPage:OnFirstFlush()
	XiaoDaDiPtPage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function XiaoDaDiPtPage:OnUpdateFlush()
	XiaoDaDiPtPage.super.OnUpdateFlush(self)

	local var_4_0, var_4_1, var_4_2 = self.ptData:GetLevelProgress()
	local var_4_3, var_4_4, var_4_5 = self.ptData:GetResProgress()

	self.hearts:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			setActive(arg_5_2, arg_5_1 < self.ptData.level)
		end

		return
	end)
	setText(self.progress, var_4_3 .. "/" .. var_4_4)
	self.hearts:align(var_4_1)

	return
end

return XiaoDaDiPtPage
