local XiaoKeWeiPtRePage = class("XiaoKeWeiPtRePage", import(".TemplatePage.PtTemplatePage"))

function XiaoKeWeiPtRePage:OnInit()
	XiaoKeWeiPtRePage.super.OnInit(self)

	self.hearts = UIItemList.New(self._tf:Find("AD/heart"), self._tf:Find("AD/heart/mark"))
	self.helpBtn = self._tf:Find("AD/help_btn")

	return
end

function XiaoKeWeiPtRePage:OnFirstFlush()
	XiaoKeWeiPtRePage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.gametip_xiaokewei.tip
		})

		return
	end, SFX_PANEL)

	return
end

function XiaoKeWeiPtRePage:OnUpdateFlush()
	XiaoKeWeiPtRePage.super.OnUpdateFlush(self)

	local var_5_0, var_5_1, var_5_2 = self.ptData:GetLevelProgress()

	self.hearts:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			setActive(arg_6_2, arg_6_1 < self.ptData.level)
		end

		return
	end)
	self.hearts:align(var_5_1)

	return
end

return XiaoKeWeiPtRePage
