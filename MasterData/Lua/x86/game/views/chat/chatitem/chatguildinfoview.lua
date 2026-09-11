local ChatGuildInfoView = class("ChatGuildInfoView", ReduxView)

function ChatGuildInfoView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.btnTransform_, "name")

	self:AddListeners()

	self.refreshHandler_ = handler(self, self.RefreshBtn)
	self.enterGuildHandler_ = handler(self, self.EnterGuild)

	manager.notify:RegistListener(GUILD_ENTER, self.refreshHandler_)
	manager.notify:RegistListener(GUILD_EXIT, self.refreshHandler_)
	manager.notify:RegistListener(GUILD_REQUIRE, self.refreshHandler_)
end

function ChatGuildInfoView:AddListeners()
	self:AddBtnListener(self.guildBtn_, nil, function()
		JumpTools.OpenPageByJump("guildInfo", {
			source = 2,
			guildID = self.guildID_
		})
	end)
	self:AddBtnListener(self.button_, nil, function()
		if GuildData:GetGuildInfo().id then
			return
		end

		if table.keyof(ChatGuildRecruitData:GetRequireGuild(), self.guildID_) then
			return
		end

		SDKTools.SendMessageToSDK("club_member_manage_jump", {
			source = 2
		})
		manager.notify:RegistListener(GUILD_ENTER, self.enterGuildHandler_)
		GuildAction.GuildRequestJoin(self.guildID_, function(arg_5_0)
			manager.notify:RemoveListener(GUILD_ENTER, self.enterGuildHandler_)
		end)
	end)
end

function ChatGuildInfoView:SetGuildID(arg_6_1)
	self.guildID_ = arg_6_1

	local var_6_0 = GuildData:GetCacheGuildInfo(arg_6_1)

	self.nameText_.text = GetI18NText(var_6_0.name)
	self.iconBg_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[var_6_0.icon].icon_bg)
	self.levelText_.text = var_6_0.level
	self.idText_.text = string.format("ID:%s", var_6_0.id)
	self.memberText_.text = string.format("%s/%s", var_6_0.memberCnt, var_6_0.maxMemberCnt)

	self:RefreshBtn()
end

function ChatGuildInfoView:RefreshBtn()
	if self.gameObject_.activeSelf == false then
		return
	end

	local var_7_0 = self.guildID_
	local var_7_1 = GuildData:GetGuildInfo()

	if var_7_1.id then
		if var_7_1.id == var_7_0 then
			self.controller_:SetSelectedState("joined")

			self.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_1"))
		else
			self.controller_:SetSelectedState("cannot")

			self.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_2"))
		end
	elseif table.keyof(ChatGuildRecruitData:GetRequireGuild(), var_7_0) then
		self.controller_:SetSelectedState("applyed")

		self.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_4"))
	else
		self.controller_:SetSelectedState("apply")

		self.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_3"))
	end
end

function ChatGuildInfoView:EnterGuild()
	if manager.windowBar:GetWhereTag() == nil then
		JumpTools.OpenPageByJump("/guildEntrace/guildMain")
	end
end

function ChatGuildInfoView:Dispose()
	ChatGuildInfoView.super.Dispose(self)
	manager.notify:RemoveListener(GUILD_ENTER, self.refreshHandler_)
	manager.notify:RemoveListener(GUILD_EXIT, self.refreshHandler_)
	manager.notify:RemoveListener(GUILD_REQUIRE, self.refreshHandler_)

	self.refreshHandler_ = nil
	self.enterGuildHandler_ = nil
end

return ChatGuildInfoView
