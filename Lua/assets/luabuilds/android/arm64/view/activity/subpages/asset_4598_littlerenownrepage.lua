local LittleRenownRePage = class("LittleRenownRePage", import(".TemplatePage.PtTemplatePage"))

function LittleRenownRePage:OnInit()
	LittleRenownRePage.super.OnInit(self)

	self.heartTpl = self.bg:Find("HeartTpl")
	self.heartContainer = self.bg:Find("HeartContainer")
	self.heartUIItemList = UIItemList.New(self.heartContainer, self.heartTpl)

	self.heartUIItemList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			setActive(arg_2_2:Find("Full"), not (self.ptData:GetLevelProgress() < arg_2_1 + 1))
		end

		return
	end)

	self.helpBtn = self.bg:Find("help_btn")

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.littleRenown_npc.tip
		})

		return
	end, SFX_PANEL)

	return
end

function LittleRenownRePage:OnUpdateFlush()
	LittleRenownRePage.super.OnUpdateFlush(self)

	local var_4_0, var_4_1 = self.ptData:GetLevelProgress()

	self.heartUIItemList:align(var_4_1)

	return
end

function LittleRenownRePage:OnFirstFlush()
	LittleRenownRePage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL)

		return
	end, SFX_PANEL)

	return
end

return LittleRenownRePage
