local SanDiegoPtPage = class("SanDiegoPtPage", import(".TemplatePage.PtTemplatePage"))

function SanDiegoPtPage:OnFirstFlush()
	SanDiegoPtPage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.bg:Find("help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("littleSanDiego_npc")
		})

		return
	end, SFX_PANEL)

	return
end

return SanDiegoPtPage
