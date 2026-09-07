local PublicGuildMainScene = class("PublicGuildMainScene", import("...base.BaseUI"))

function PublicGuildMainScene:getUIName()
	return "PublicGuildMainUI"
end

function PublicGuildMainScene:OnUpdateDonateList()
	if self.page and isa(self.page, PublicGuildOfficePage) and self.page:GetLoaded() then
		self.page:Flush()
	end

	return
end

function PublicGuildMainScene:OnPlayerUpdate(arg_3_1)
	self:SetPlayer(arg_3_1)

	if self.resPage and self.resPage:GetLoaded() then
		self.resPage:Update(arg_3_1)
	end

	return
end

function PublicGuildMainScene:OnTechGroupUpdate(arg_4_1)
	if self.page and isa(self.page, PublicGuildTechnologyPage) and self.page:GetLoaded() then
		self.page:OnTechGroupUpdate(arg_4_1)
	end

	return
end

function PublicGuildMainScene:RefreshAll()
	if self.page and self.page:GetLoaded() then
		self.page:Show(self.publicGuild)
	end

	return
end

function PublicGuildMainScene:SetPublicGuild(arg_6_1)
	self.publicGuild = arg_6_1

	return
end

function PublicGuildMainScene:SetPlayer(arg_7_1)
	self.player = arg_7_1

	return
end

function PublicGuildMainScene:init()
	self._playerResOb = self._tf:Find("blur_panel/adapt/top/res")
	self.resPage = PublicGuildResPage.New(self._playerResOb, self.event)
	self.backBtn = self._tf:Find("blur_panel/adapt/top/back")
	self.helpBtn = self._tf:Find("blur_panel/adapt/left_length/frame/help")
	self.toggles = {
		self._tf:Find("blur_panel/adapt/left_length/frame/scroll_rect/tagRoot/office"),
		self._tf:Find("blur_panel/adapt/left_length/frame/scroll_rect/tagRoot/technology")
	}

	local var_8_0 = self._tf:Find("pages")

	self.pages = {
		PublicGuildOfficePage.New(var_8_0, self.event),
		PublicGuildTechnologyPage.New(var_8_0, self.event)
	}

	return
end

function PublicGuildMainScene:didEnter()
	pg.GuildPaintingMgr.GetInstance():Enter(self._tf:Find("bg/painting"))
	self.resPage:ExecuteAction("Update", self.player)
	onButton(self, self.backBtn, function()
		self:emit(PublicGuildMainScene.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		if isa(self.page, PublicGuildOfficePage) then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = i18n("guild_public_office_tip")
			})
		elseif isa(self.page, PublicGuildTechnologyPage) then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = i18n("guild_public_tech_tip")
			})
		end

		return
	end, SFX_PANEL)

	for iter_9_0, iter_9_1 in ipairs(self.toggles) do
		onToggle(self, iter_9_1, function(arg_12_0)
			if arg_12_0 then
				self:SwitchPage(iter_9_0)
			end

			return
		end, SFX_PANEL)

		if iter_9_0 == 1 then
			triggerToggle(iter_9_1, true)
		end
	end

	return
end

function PublicGuildMainScene:SwitchPage(arg_13_1)
	if self.page then
		self.page:Hide()
	end

	self.pages[arg_13_1]:ExecuteAction("Show", self.publicGuild)

	self.page = self.pages[arg_13_1]

	return
end

function PublicGuildMainScene:willExit()
	pg.GuildPaintingMgr.GetInstance():Exit()
	self.resPage:Destroy()

	for iter_14_0, iter_14_1 in pairs(self.pages) do
		iter_14_1:Destroy()
	end

	return
end

return PublicGuildMainScene
