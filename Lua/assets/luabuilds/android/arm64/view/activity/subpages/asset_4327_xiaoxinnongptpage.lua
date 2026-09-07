local XiaoXinNongPtPage = class("XiaoXinNongPtPage", import(".TemplatePage.PtTemplatePage"))

function XiaoXinNongPtPage:OnInit()
	XiaoXinNongPtPage.super.OnInit(self)

	self.hearts = UIItemList.New(self._tf:Find("AD/heart"), self._tf:Find("AD/heart/mark"))

	return
end

function XiaoXinNongPtPage:OnFirstFlush()
	XiaoXinNongPtPage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function XiaoXinNongPtPage:OnUpdateFlush()
	XiaoXinNongPtPage.super.OnUpdateFlush(self)

	local var_4_0, var_4_1, var_4_2 = self.ptData:GetLevelProgress()
	local var_4_3, var_4_4, var_4_5 = self.ptData:GetResProgress()

	self.hearts:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			setActive(arg_5_2, arg_5_1 < self.ptData.level)
		end

		return
	end)
	setText(self.progress, setColorStr(var_4_3, "#7780D3") .. "/" .. setColorStr(var_4_4, "#ffffff"))
	self.hearts:align(var_4_1)

	return
end

return XiaoXinNongPtPage
