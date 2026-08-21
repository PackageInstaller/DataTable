local var_0_0 = class("GuildInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubSharePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.iconBg_.immediate = true

	arg_3_0:AddListeners()

	arg_3_0.controller_ = arg_3_0.btnController:GetController("btn")
	arg_3_0.emptyController = arg_3_0.btnController:GetController("empty")
	arg_3_0.clearController = arg_3_0.controller:GetController("clear")
	arg_3_0.refreshHandler_ = handler(arg_3_0, arg_3_0.RefreshBtn)
	arg_3_0.enterGuildHandler_ = handler(arg_3_0, arg_3_0.EnterGuild)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.guildID_ = arg_4_0.params_.guildID

	arg_4_0:RefreshUI()
	manager.notify:RegistListener(GUILD_ENTER, arg_4_0.refreshHandler_)
	manager.notify:RegistListener(GUILD_EXIT, arg_4_0.refreshHandler_)
	manager.notify:RegistListener(GUILD_REQUIRE, arg_4_0.refreshHandler_)
end

function var_0_0.OnExit(arg_5_0)
	manager.notify:RemoveListener(GUILD_ENTER, arg_5_0.refreshHandler_)
	manager.notify:RemoveListener(GUILD_EXIT, arg_5_0.refreshHandler_)
	manager.notify:RemoveListener(GUILD_REQUIRE, arg_5_0.refreshHandler_)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.joinBtn_, nil, function()
		if GuildData:GetGuildInfo().id then
			return
		end

		if table.keyof(ChatGuildRecruitData:GetRequireGuild(), arg_6_0.guildID_) then
			return
		end

		SDKTools.SendMessageToSDK("club_member_manage_jump", {
			source = arg_6_0.params_.source
		})
		manager.notify:RegistListener(GUILD_ENTER, arg_6_0.enterGuildHandler_)
		GuildAction.GuildRequestJoin(arg_6_0.guildID_, function(arg_9_0)
			manager.notify:RemoveListener(GUILD_ENTER, arg_6_0.enterGuildHandler_)
		end)
	end)
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = GuildData:GetCacheGuildInfo(arg_10_0.guildID_)
	local var_10_1 = ClubHeadIconCfg[var_10_0.icon]

	arg_10_0.iconBg_.spriteSync = getSpritePathViaConfig("ClubHeadIcon", var_10_1.bg)
	arg_10_0.idText_.text = string.format("ID:%s", var_10_0.id)
	arg_10_0.nameText_.text = GetI18NText(var_10_0.name)
	arg_10_0.levelText_.text = string.format(GetTips("CLUB_LEVEL"), var_10_0.level)
	arg_10_0.activePointText_.text = GetI18NText(var_10_0.contribute)
	arg_10_0.memberText_.text = string.format("%s/%s", var_10_0.memberCnt, var_10_0.maxMemberCnt)
	arg_10_0.captainNameText_.text = GetI18NText(var_10_0.captain)

	if var_10_0.notice and var_10_0.notice ~= "" then
		arg_10_0.emptyController:SetSelectedState("full")

		arg_10_0.noticeText_.text = GetI18NText(var_10_0.notice)
	else
		arg_10_0.emptyController:SetSelectedState("empty")
	end

	arg_10_0:RefreshLevelLimitInfo()

	local var_10_2 = var_10_0.level
	local var_10_3 = var_10_0.exp

	for iter_10_0 = var_10_2 - 1, 1, -1 do
		var_10_3 = var_10_3 - ClubLevelCfg[iter_10_0].club_level_exp
	end

	local var_10_4 = ClubLevelCfg[var_10_2].club_level_exp

	if var_10_2 >= GameSetting.club_max_level.value[1] then
		-- block empty
	end

	arg_10_0:RefreshBtn()
end

function var_0_0.RefreshLevelLimitInfo(arg_11_0)
	local var_11_0 = GuildData:GetCacheGuildInfo(arg_11_0.guildID_)

	if GuildData:GetGuildInfo().id == arg_11_0.guildID_ then
		arg_11_0.clearController:SetSelectedState("clear")

		arg_11_0.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_5"))
	else
		local var_11_1 = PlayerData:GetPlayerInfo()

		arg_11_0.joinTxt_.text = string.format(GetTips("CLUB_LEVEL_LIMIT"), var_11_0.limitLevel)

		if var_11_1.userLevel < var_11_0.limitLevel then
			arg_11_0.clearController:SetSelectedState("notclear")
		else
			arg_11_0.clearController:SetSelectedState("clear")
		end
	end
end

function var_0_0.RefreshBtn(arg_12_0)
	local var_12_0 = arg_12_0.guildID_
	local var_12_1 = GuildData:GetGuildInfo()

	if var_12_1.id then
		arg_12_0.controller_:SetSelectedState("cannot")

		if var_12_1.id == arg_12_0.guildID_ then
			arg_12_0.controller_:SetSelectedState("self")
		end
	elseif table.keyof(ChatGuildRecruitData:GetRequireGuild(), var_12_0) then
		arg_12_0.controller_:SetSelectedState("applyed")
	else
		arg_12_0.controller_:SetSelectedState("apply")
	end
end

function var_0_0.EnterGuild(arg_13_0)
	arg_13_0:Back()
	JumpTools.OpenPageByJump("/guildEntrace/guildMain")
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)

	arg_14_0.refreshHandler_ = nil
	arg_14_0.enterGuildHandler_ = nil
end

return var_0_0
