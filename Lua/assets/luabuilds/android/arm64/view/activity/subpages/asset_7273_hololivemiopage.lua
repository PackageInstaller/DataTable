local HoloLiveMioPage = class("HoloLiveMioPage", import(".TemplatePage.PtTemplatePage"))

function HoloLiveMioPage:OnInit()
	HoloLiveMioPage.super.OnInit(self)

	self.heartTpl = self.bg:Find("HeartTpl")
	self.heartContainer = self.bg:Find("HeartContainer")
	self.helpBtn = self.bg:Find("HelpBtn")

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hololive_dashenling.tip
		})

		return
	end, SFX_PANEL)

	self.heartUIItemList = UIItemList.New(self.heartContainer, self.heartTpl)

	self.heartUIItemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			setActive(arg_3_2:Find("Full"), not (self.ptData:GetLevelProgress() < arg_3_1 + 1))
		end

		return
	end)

	return
end

function HoloLiveMioPage:OnUpdateFlush()
	HoloLiveMioPage.super.OnUpdateFlush(self)

	local var_4_0, var_4_1 = self.ptData:GetLevelProgress()

	self.heartUIItemList:align(var_4_1)

	return
end

return HoloLiveMioPage
