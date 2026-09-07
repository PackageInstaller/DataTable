local GuildTechnologyLayer = class("GuildTechnologyLayer", import("..base.BaseUI"))

function GuildTechnologyLayer:getUIName()
	return "GuildEmptyUI"
end

function GuildTechnologyLayer:setGuild(arg_2_1)
	self.guildVO = arg_2_1

	return
end

function GuildTechnologyLayer:init()
	self.technologyPage = GuildTechnologyPage.New(self._tf, self.event)
	self.helpBtn = self._tf:Find("frame/help")

	return
end

function GuildTechnologyLayer:didEnter()
	self:UpdatePainting()
	self.technologyPage:ExecuteAction("SetUp", self.guildVO)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.guild_tech_tip.tip
		})

		return
	end, SFX_PANEL)

	return
end

function GuildTechnologyLayer:UpdatePainting()
	pg.GuildPaintingMgr.GetInstance():Update(self.guildVO:GetOfficePainting(), Vector3(-737, -171, 0))

	return
end

function GuildTechnologyLayer:UpdateUpgradeList()
	if self.technologyPage:GetLoaded() then
		self.technologyPage:UpdateUpgradeList()
	end

	return
end

function GuildTechnologyLayer:UpdateBreakOutList()
	if self.technologyPage:GetLoaded() then
		self.technologyPage:UpdateBreakOutList()
	end

	return
end

function GuildTechnologyLayer:UpdateGuild(arg_9_1)
	self:setGuild(arg_9_1)

	if self.technologyPage and self.technologyPage:GetLoaded() then
		self.technologyPage:Update(self.guildVO)
	end

	return
end

function GuildTechnologyLayer:UpdateAll()
	if self.technologyPage:GetLoaded() then
		self.technologyPage:Flush()
	end

	return
end

function GuildTechnologyLayer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	self:emit(GuildTechnologyLayer.ON_BACK)

	return
end

function GuildTechnologyLayer:willExit()
	self.technologyPage:Destroy()

	if isActive(pg.MsgboxMgr.GetInstance()._go) then
		triggerButton(pg.MsgboxMgr.GetInstance()._closeBtn)
	end

	return
end

return GuildTechnologyLayer
