local var_0_0 = class("ChatGuildInfoView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.btnTransform_, "name")

	arg_1_0:AddListeners()

	arg_1_0.refreshHandler_ = handler(arg_1_0, arg_1_0.RefreshBtn)
	arg_1_0.enterGuildHandler_ = handler(arg_1_0, arg_1_0.EnterGuild)

	manager.notify:RegistListener(GUILD_ENTER, arg_1_0.refreshHandler_)
	manager.notify:RegistListener(GUILD_EXIT, arg_1_0.refreshHandler_)
	manager.notify:RegistListener(GUILD_REQUIRE, arg_1_0.refreshHandler_)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.guildBtn_, nil, function()
		JumpTools.OpenPageByJump("guildInfo", {
			source = 2,
			guildID = arg_2_0.guildID_
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		if GuildData:GetGuildInfo().id then
			return
		end

		if table.keyof(ChatGuildRecruitData:GetRequireGuild(), arg_2_0.guildID_) then
			return
		end

		SDKTools.SendMessageToSDK("club_member_manage_jump", {
			source = 2
		})
		manager.notify:RegistListener(GUILD_ENTER, arg_2_0.enterGuildHandler_)
		GuildAction.GuildRequestJoin(arg_2_0.guildID_, function(arg_5_0)
			manager.notify:RemoveListener(GUILD_ENTER, arg_2_0.enterGuildHandler_)
		end)
	end)
end

function var_0_0.SetGuildID(arg_6_0, arg_6_1)
	arg_6_0.guildID_ = arg_6_1

	local var_6_0 = GuildData:GetCacheGuildInfo(arg_6_1)

	arg_6_0.nameText_.text = GetI18NText(var_6_0.name)

	local var_6_1 = ClubHeadIconCfg[var_6_0.icon]

	arg_6_0.iconBg_.sprite = getSpriteViaConfig("ClubHeadIcon", var_6_1.icon_bg)
	arg_6_0.levelText_.text = var_6_0.level
	arg_6_0.idText_.text = string.format("ID:%s", var_6_0.id)
	arg_6_0.memberText_.text = string.format("%s/%s", var_6_0.memberCnt, var_6_0.maxMemberCnt)

	arg_6_0:RefreshBtn()
end

function var_0_0.RefreshBtn(arg_7_0)
	if arg_7_0.gameObject_.activeSelf == false then
		return
	end

	local var_7_0 = arg_7_0.guildID_
	local var_7_1 = GuildData:GetGuildInfo()

	if var_7_1.id then
		if var_7_1.id == var_7_0 then
			arg_7_0.controller_:SetSelectedState("joined")

			arg_7_0.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_1"))
		else
			arg_7_0.controller_:SetSelectedState("cannot")

			arg_7_0.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_2"))
		end
	elseif table.keyof(ChatGuildRecruitData:GetRequireGuild(), var_7_0) then
		arg_7_0.controller_:SetSelectedState("applyed")

		arg_7_0.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_4"))
	else
		arg_7_0.controller_:SetSelectedState("apply")

		arg_7_0.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_3"))
	end
end

function var_0_0.EnterGuild(arg_8_0)
	if manager.windowBar:GetWhereTag() == nil then
		JumpTools.OpenPageByJump("/guildEntrace/guildMain")
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	manager.notify:RemoveListener(GUILD_ENTER, arg_9_0.refreshHandler_)
	manager.notify:RemoveListener(GUILD_EXIT, arg_9_0.refreshHandler_)
	manager.notify:RemoveListener(GUILD_REQUIRE, arg_9_0.refreshHandler_)

	arg_9_0.refreshHandler_ = nil
	arg_9_0.enterGuildHandler_ = nil
end

return var_0_0
