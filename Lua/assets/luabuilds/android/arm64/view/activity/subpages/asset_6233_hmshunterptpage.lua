local HMSHunterPTPage = class("HMSHunterPTPage", import(".TemplatePage.PtTemplatePage"))

function HMSHunterPTPage:OnInit()
	HMSHunterPTPage.super.OnInit(self)

	self.helpBtn = self.bg:Find("help")

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("hunter_npc")
		})

		return
	end, SFX_PANEL)

	return
end

return HMSHunterPTPage
