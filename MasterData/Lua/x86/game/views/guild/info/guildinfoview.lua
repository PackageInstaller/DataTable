local GuildInfoView = class("GuildInfoView", ReduxView)

function GuildInfoView:UIName()
	return "Widget/System/Club/ClubSharePopUI"
end

function GuildInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildInfoView:Init()
	self:BindCfgUI()

	self.iconBg_.immediate = true

	self:AddListeners()

	self.controller_ = self.btnController:GetController("btn")
	self.emptyController = self.btnController:GetController("empty")
	self.clearController = self.controller:GetController("clear")
	self.refreshHandler_ = handler(self, self.RefreshBtn)
	self.enterGuildHandler_ = handler(self, self.EnterGuild)
end

function GuildInfoView:OnEnter()
	self.guildID_ = self.params_.guildID

	self:RefreshUI()
	manager.notify:RegistListener(GUILD_ENTER, self.refreshHandler_)
	manager.notify:RegistListener(GUILD_EXIT, self.refreshHandler_)
	manager.notify:RegistListener(GUILD_REQUIRE, self.refreshHandler_)
end

function GuildInfoView:OnExit()
	manager.notify:RemoveListener(GUILD_ENTER, self.refreshHandler_)
	manager.notify:RemoveListener(GUILD_EXIT, self.refreshHandler_)
	manager.notify:RemoveListener(GUILD_REQUIRE, self.refreshHandler_)
end

function GuildInfoView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.joinBtn_, nil, function()
		if GuildData:GetGuildInfo().id then
			return
		end

		if table.keyof(ChatGuildRecruitData:GetRequireGuild(), self.guildID_) then
			return
		end

		SDKTools.SendMessageToSDK("club_member_manage_jump", {
			source = self.params_.source
		})
		manager.notify:RegistListener(GUILD_ENTER, self.enterGuildHandler_)
		GuildAction.GuildRequestJoin(self.guildID_, function(arg_9_0)
			manager.notify:RemoveListener(GUILD_ENTER, self.enterGuildHandler_)
		end)
	end)
end

function GuildInfoView:RefreshUI()
	local var_10_0 = GuildData:GetCacheGuildInfo(self.guildID_)

	self.iconBg_.spriteSync = getSpritePathViaConfig("ClubHeadIcon", ClubHeadIconCfg[var_10_0.icon].bg)
	self.idText_.text = string.format("ID:%s", var_10_0.id)
	self.nameText_.text = GetI18NText(var_10_0.name)
	self.levelText_.text = string.format(GetTips("CLUB_LEVEL"), var_10_0.level)
	self.activePointText_.text = GetI18NText(var_10_0.contribute)
	self.memberText_.text = string.format("%s/%s", var_10_0.memberCnt, var_10_0.maxMemberCnt)
	self.captainNameText_.text = GetI18NText(var_10_0.captain)

	if var_10_0.notice and var_10_0.notice ~= "" then
		self.emptyController:SetSelectedState("full")

		self.noticeText_.text = GetI18NText(var_10_0.notice)
	else
		self.emptyController:SetSelectedState("empty")
	end

	self:RefreshLevelLimitInfo()

	for iter_10_0 = var_10_0.level - 1, 1, -1 do
		-- block empty
	end

	if var_10_0.level >= GameSetting.club_max_level.value[1] then
		-- block empty
	end

	self:RefreshBtn()
end

function GuildInfoView:RefreshLevelLimitInfo()
	local var_11_0 = GuildData:GetCacheGuildInfo(self.guildID_)

	if GuildData:GetGuildInfo().id == self.guildID_ then
		self.clearController:SetSelectedState("clear")

		self.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_5"))
	else
		local var_11_1 = PlayerData:GetPlayerInfo()

		self.joinTxt_.text = string.format(GetTips("CLUB_LEVEL_LIMIT"), var_11_0.limitLevel)

		if var_11_1.userLevel < var_11_0.limitLevel then
			self.clearController:SetSelectedState("notclear")
		else
			self.clearController:SetSelectedState("clear")
		end
	end
end

function GuildInfoView:RefreshBtn()
	local var_12_0 = GuildData:GetGuildInfo()

	if var_12_0.id then
		self.controller_:SetSelectedState("cannot")

		if var_12_0.id == self.guildID_ then
			self.controller_:SetSelectedState("self")
		end
	elseif table.keyof(ChatGuildRecruitData:GetRequireGuild(), self.guildID_) then
		self.controller_:SetSelectedState("applyed")
	else
		self.controller_:SetSelectedState("apply")
	end
end

function GuildInfoView:EnterGuild()
	self:Back()
	JumpTools.OpenPageByJump("/guildEntrace/guildMain")
end

function GuildInfoView:Dispose()
	GuildInfoView.super.Dispose(self)

	self.refreshHandler_ = nil
	self.enterGuildHandler_ = nil
end

return GuildInfoView
