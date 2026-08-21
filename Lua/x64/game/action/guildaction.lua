local var_0_0 = {}

manager.net:Bind(31001, function(arg_1_0)
	GuildData:InitGuildInfo(arg_1_0.club)
	GuildData:SetShareTimestamp(arg_1_0)
	GuildData:SetAssistHero(arg_1_0.assist_hero_id_list)
	manager.notify:Invoke(GUILD_ENTER)
	TaskRedPoint:UpdateClubTaskRedTip()
end)
manager.net:Bind(31999, function(arg_2_0)
	GuildData:UpdateRequestMember(arg_2_0)
	manager.notify:Invoke(GUILD_REFRESH_REQUEST)
end)
manager.net:Bind(31997, function(arg_3_0)
	GuildData:ChangedCaptain(arg_3_0)
	manager.notify:Invoke(GUILD_REFRESH_MEMBER)
end)
manager.net:Bind(31995, function(arg_4_0)
	GuildData:ChangedDeputy(arg_4_0)
	manager.notify:Invoke(GUILD_REFRESH_MEMBER)
end)
manager.net:Bind(31993, function(arg_5_0)
	GuildData:DismissDeputy(arg_5_0)
	manager.notify:Invoke(GUILD_REFRESH_MEMBER)
end)
manager.net:Bind(31989, function(arg_6_0)
	GuildData:RemoveMember(arg_6_0)

	if arg_6_0.id == USER_ID then
		var_0_0.GuildExitFun()

		return
	end

	manager.notify:Invoke(GUILD_REFRESH_MEMBER)
end)
manager.net:Bind(31985, function(arg_7_0)
	GuildData:AddMember(arg_7_0)
	manager.notify:Invoke(GUILD_REFRESH_MEMBER)
end)
manager.net:Bind(31983, function(arg_8_0)
	GuildData:ImpeachCaptain(arg_8_0)
	manager.notify:Invoke(GUILD_CAPTAIN_IMPEACH)
end)
manager.net:Bind(31981, function(arg_9_0)
	GuildData:CancelImpeach()
	manager.notify:Invoke(GUILD_CAPTAIN_IMPEACH)
end)
manager.net:Bind(31979, function(arg_10_0)
	GuildData:InitGuildRequestMember(arg_10_0.join_list)
	manager.notify:Invoke(GUILD_REFRESH_MEMBER)
end)
manager.net:Bind(31977, function(arg_11_0)
	GuildData:SetExitTime(arg_11_0.time_stamp)
end)
manager.net:Bind(31211, function(arg_12_0)
	if GuildData:GetGuildInfo().post >= GuildConst.GUILD_POST.TRAINEE then
		GuildData:Trainee2Member()
		CommunityAction:RefreshWelfare()
	end
end)
manager.net:Bind(31975, function(arg_13_0)
	GuildData:SetRenameFreeCnt(arg_13_0.chance)
end)
manager.net:Bind(33001, function(arg_14_0)
	if isSuccess(arg_14_0.result) then
		GuildData:InitBossDataFromServer(arg_14_0)
		var_0_0.UpdateGuildBossRedPoint()
	else
		ShowTips(GetTips(arg_14_0.result))
	end
end)
manager.net:Bind(33999, function(arg_15_0)
	GuildData:UpdateBossDamage(arg_15_0.boss_challenge_total_damage)
	var_0_0.UpdateGuildBossRedPoint()
end)
manager.net:Bind(27405, function(arg_16_0)
	GuildData:SetShareTimestamp(arg_16_0)
	manager.notify:Invoke(GUILD_SHARE)
end)
manager.notify:RegistListener(WEEK_ZERO_REFRESH, function()
	if GuildData:GetGuildInfo().id == nil then
		return
	end

	GuildData:RefreshWeekResources()
end)

function var_0_0.GuildRequestJoin(arg_18_0, arg_18_1)
	manager.net:SendWithLoadingNew(31010, {
		id = arg_18_0
	}, 31011, function(arg_19_0)
		if isSuccess(arg_19_0.result) then
			ShowTips(arg_19_0.result)
			ChatGuildRecruitData:AddRequireGuild(arg_18_0)
			manager.notify:Invoke(GUILD_REQUIRE)
		elseif arg_19_0.result == TipsCfg.get_id_list_by_define.ERROR_USER_JOIN_COOL_DOWN then
			local var_19_0 = arg_19_0.remain_time

			if var_19_0 > 0 then
				local var_19_1 = GetTips("CLUB_REQUEST_CD")
				local var_19_2

				if var_19_0 < 60 then
					var_19_2 = GetTips("SECOND")
					var_19_2 = string.format("%s%s", var_19_0, var_19_2)
				elseif var_19_0 < 3600 then
					var_19_2 = GetTips("MINUTE")
					var_19_2 = string.format("%s%s", math.floor(var_19_0 / 60), var_19_2)
				else
					var_19_2 = GetTips("HOUR")
					var_19_2 = string.format("%s%s", math.floor(var_19_0 / 3600), var_19_2)
				end

				ShowTips(string.format(var_19_1, var_19_2))
			end
		else
			if arg_19_0.result == TipsCfg.get_id_list_by_define.ERROR_CLUB_REQUEST_TWICE or arg_19_0.result == TipsCfg.get_id_list_by_define.USER_REQUEST_JOIN_CLUB_SUCCESS then
				ChatGuildRecruitData:AddRequireGuild(arg_18_0)
				manager.notify:Invoke(GUILD_REQUIRE)
			end

			ShowTips(arg_19_0.result)
		end

		arg_18_1()
	end)
end

function var_0_0.SearchGuild(arg_20_0, arg_20_1)
	manager.net:SendWithLoadingNew(31028, {
		id = arg_20_0
	}, 31029, function(arg_21_0)
		if isSuccess(arg_21_0.result) then
			GuildData:InitSearceList(arg_21_0.club_base_info)
		end

		arg_20_1(arg_21_0)
	end)
end

function var_0_0.FoundedGuild(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	manager.net:SendWithLoadingNew(31008, {
		name = arg_22_0,
		icon = arg_22_2,
		notice = arg_22_1
	}, 31009, function(arg_23_0)
		arg_22_3(arg_23_0)
		SendMessageManagerToSDK("guild_join")
	end)
end

function var_0_0.RequiredGuildInfo(arg_24_0)
	manager.net:SendWithLoadingNew(31002, {
		nothing = 1
	}, 31003, function(arg_25_0)
		GuildData:InitGuildInfo(arg_25_0.club_base_info)
		GuildData:SetShareTimestamp(arg_25_0)
		arg_24_0(arg_25_0)
	end)
end

function var_0_0.RequiredGuildMemberList(arg_26_0)
	if manager.time:GetServerTime() - GuildData:GetRequiredMemberStamptime() < 60 then
		arg_26_0({
			result = 0
		})

		return
	end

	manager.net:SendWithLoadingNew(31004, {
		nothing = 1
	}, 31005, function(arg_27_0)
		GuildData:InitGuildMember(arg_27_0.members)
		GuildData:SetRequiredMemberStamptime()
		arg_26_0(arg_27_0)
	end)
end

function var_0_0.RequiredGuildRecommendList(arg_28_0)
	manager.net:SendWithLoadingNew(31006, {
		nothing = 1
	}, 31007, function(arg_29_0)
		if GuildData:GetGuildInfo().id ~= nil then
			return
		end

		GuildData:InitGuildRecommendList(arg_29_0.recommend_club_list)
		arg_28_0(arg_29_0)
	end)
end

function var_0_0.GuildRename(arg_30_0, arg_30_1, arg_30_2)
	manager.net:SendWithLoadingNew(31022, {
		name = arg_30_0,
		type = arg_30_1
	}, 31023, function(arg_31_0)
		if isSuccess(arg_31_0.result) then
			GuildData:SetGuildName(arg_30_0)
			manager.notify:Invoke(GUILD_RENAME, arg_30_0)
		end

		arg_30_2(arg_31_0)
	end)
end

function var_0_0.GuildChangeNotice(arg_32_0, arg_32_1)
	manager.net:SendWithLoadingNew(31024, {
		notice = arg_32_0
	}, 31025, function(arg_33_0)
		if isSuccess(arg_33_0.result) then
			GuildData:SetGuildNotice(arg_32_0)
			manager.notify:Invoke(GUILD_NOTICE, arg_32_0)
		end

		arg_32_1(arg_33_0)
	end)
end

function var_0_0.GuildSwitchIcon(arg_34_0, arg_34_1)
	manager.net:SendWithLoadingNew(31026, {
		icon = arg_34_0
	}, 31027, function(arg_35_0)
		if isSuccess(arg_35_0.result) then
			GuildData:SetGuildIcon(arg_34_0)
			manager.notify:Invoke(GUILD_SWITCH_ICON_SERVER, arg_34_0)
		end

		arg_34_1(arg_35_0)
	end)
end

function var_0_0.GuildRequestSetting(arg_36_0, arg_36_1, arg_36_2)
	manager.net:SendWithLoadingNew(31018, {
		setting = {
			examine_recruit_join_request_switch = arg_36_0,
			join_request_limit = arg_36_1
		}
	}, 31019, function(arg_37_0)
		arg_36_2(arg_37_0)
	end)
end

function var_0_0.GuildExit(arg_38_0, arg_38_1)
	manager.net:SendWithLoadingNew(31012, {
		id = arg_38_0
	}, 31013, function(arg_39_0)
		if isSuccess(arg_39_0.result) then
			var_0_0.GuildExitFun()
		end

		if arg_38_1 then
			arg_38_1(arg_39_0)
		end
	end)
end

function var_0_0.GuildRemoveMember(arg_40_0, arg_40_1)
	manager.net:SendWithLoadingNew(31014, {
		id = arg_40_0
	}, 31015, function(arg_41_0)
		arg_40_1(arg_41_0)
	end)
end

function var_0_0.GuildMobilityCaptain(arg_42_0, arg_42_1)
	manager.net:SendWithLoadingNew(31016, {
		id = arg_42_0,
		post = GuildConst.GUILD_POST.CAPTAIN
	}, 31017, function(arg_43_0)
		arg_42_1(arg_43_0)
	end)
end

function var_0_0.GuildMobilityDeputy(arg_44_0, arg_44_1)
	manager.net:SendWithLoadingNew(31016, {
		id = arg_44_0,
		post = GuildConst.GUILD_POST.DEPUTY
	}, 31017, function(arg_45_0)
		arg_44_1(arg_45_0)
	end)
end

function var_0_0.GuildDismiss(arg_46_0, arg_46_1)
	manager.net:SendWithLoadingNew(31016, {
		id = arg_46_0,
		post = GuildConst.GUILD_POST.MEMBER
	}, 31017, function(arg_47_0)
		arg_46_1(arg_47_0)
	end)
end

function var_0_0.GuildImpeach(arg_48_0, arg_48_1)
	manager.net:SendWithLoadingNew(31020, {
		nothing = 1
	}, 31021, function(arg_49_0)
		arg_48_1(arg_49_0)
	end)
end

function var_0_0.GuildCancelImpeach(arg_50_0)
	manager.net:SendWithLoadingNew(31030, {
		nothing = 1
	}, 31031, function(arg_51_0)
		if isSuccess(arg_51_0.result) then
			manager.redPoint:setTip(RedPointConst.GUILD_IMPEACH, 0)
		end

		arg_50_0(arg_51_0)
	end)
end

function var_0_0.GuildAgreeRequest(arg_52_0, arg_52_1)
	manager.net:SendWithLoadingNew(31032, {
		type = 1,
		id = arg_52_0
	}, 31033, function(arg_53_0)
		arg_52_1(arg_53_0)
		SendMessageManagerToSDK("guild_join")
	end)
end

function var_0_0.GuildRefuseRequest(arg_54_0, arg_54_1)
	manager.net:SendWithLoadingNew(31032, {
		type = 2,
		id = arg_54_0
	}, 31033, function(arg_55_0)
		arg_54_1(arg_55_0)
	end)
end

function var_0_0.ApplyCaptain(arg_56_0)
	manager.net:SendWithLoadingNew(31034, {
		nothing = 1
	}, 31035, function(arg_57_0)
		if isSuccess(arg_57_0.result) then
			GuildData:ApplyCaptain()
			manager.notify:Invoke(GUILD_CAPTAIN_IMPEACH)
		end

		arg_56_0(arg_57_0)
	end)
end

function var_0_0.EnterGuild()
	local var_58_0 = GuildData:GetRecommendList()

	if table.length(var_58_0) <= 0 then
		GuildAction.RequiredGuildRecommendList(function(arg_59_0)
			if isSuccess(arg_59_0.result) then
				JumpTools.OpenPageByJump("/guildEntrace/guildRecommendView")
			else
				ShowTips(arg_59_0.result)
			end
		end)
	else
		JumpTools.OpenPageByJump("/guildEntrace/guildRecommendView")
	end
end

function var_0_0.GuildExitFun()
	GuildData:ExitGuild()
	ChatGuildData:RemoveChatData()
	CommunityData:CommunityExit()
	ChatGuildRecruitData:RemoveRequireData()
	manager.notify:Invoke(GUILD_EXIT)
	var_0_0.UpdateGuildBossRedPoint()
end

function var_0_0.GuildShare(arg_61_0, arg_61_1)
	manager.net:SendWithLoadingNew(27400, {
		recommend = arg_61_0
	}, 27401, function(arg_62_0)
		arg_61_1(arg_62_0)
	end)
end

function var_0_0.RequestClubBossInfo(arg_63_0)
	local var_63_0 = {
		club_id = arg_63_0
	}

	manager.net:SendWithLoadingNew(33000, var_63_0, 33001, var_0_0.OnRequestClubBossInfoCallback)
end

function var_0_0.OnRequestClubBossInfoCallback(arg_64_0, arg_64_1)
	return
end

function var_0_0.GetAssistBriefInfo(arg_65_0)
	local var_65_0 = {
		club_id = arg_65_0
	}

	manager.net:SendWithLoadingNew(33002, var_65_0, 33003, var_0_0.OnGetAssistBriefInfoCallback)
end

function var_0_0.OnGetAssistBriefInfoCallback(arg_66_0, arg_66_1)
	if isSuccess(arg_66_0.result) then
		GuildData:InitAssistInfoListFromServer(arg_66_0.assist_info_list)
	else
		ShowTips(GetTips(arg_66_0.result))
	end
end

function var_0_0.GuildBossChangeDifficulty(arg_67_0)
	local var_67_0 = {
		difficulty = arg_67_0
	}

	manager.net:SendWithLoadingNew(33004, var_67_0, 33005, var_0_0.OnGuildBossChangeDifficultyCallback)
end

function var_0_0.OnGuildBossChangeDifficultyCallback(arg_68_0, arg_68_1)
	if isSuccess(arg_68_0.result) then
		GuildData:OnBossDifficultlyChange(arg_68_1.difficulty)
	else
		ShowTips(GetTips(arg_68_0.result))
	end
end

function var_0_0.GuildBossGetRankInfo(arg_69_0)
	local var_69_0 = {
		club_id = arg_69_0
	}

	manager.net:SendWithLoadingNew(33006, var_69_0, 33007, var_0_0.OnGuildBossGetRankInfoCallback)
end

function var_0_0.OnGuildBossGetRankInfoCallback(arg_70_0, arg_70_1)
	if isSuccess(arg_70_0.result) then
		GuildData:InitGuildBossRankFromServer(arg_70_0.info_list)
	else
		ShowTips(GetTips(arg_70_0.result))
	end
end

function var_0_0.GetGuildBossReward(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = {
		club_id = arg_71_0,
		type = arg_71_1,
		award_id = arg_71_2
	}

	manager.net:SendWithLoadingNew(33008, var_71_0, 33009, var_0_0.OnGetGuildBossRewardCallback)
end

function var_0_0.OnGetGuildBossRewardCallback(arg_72_0, arg_72_1)
	if isSuccess(arg_72_0.result) then
		if arg_72_1.type == 1 then
			for iter_72_0, iter_72_1 in ipairs(ClubBossCfg[GuildData:GetBossDifficulty()].personal_reward) do
				if iter_72_1[1] == arg_72_1.award_id then
					local var_72_0 = iter_72_1[2]
					local var_72_1 = formatRewardCfgList(var_72_0)
					local var_72_2 = mergeReward(var_72_1)

					getReward(var_72_2)

					break
				end
			end

			GuildData:OnGuildBossPersonalRewardGet(arg_72_1.award_id)
			var_0_0.UpdateGuildPersonRedPoint()
		elseif arg_72_1.type == 2 then
			for iter_72_2, iter_72_3 in ipairs(ClubBossCfg[GuildData:GetBossDifficulty()].reward) do
				if iter_72_3[1] == arg_72_1.award_id then
					local var_72_3 = iter_72_3[2]
					local var_72_4 = formatRewardCfgList(var_72_3)
					local var_72_5 = mergeReward(var_72_4)

					getReward(var_72_5)

					break
				end
			end

			GuildData:OnGuildBossCommonRewardGet(arg_72_1.award_id)
			var_0_0.UpdateGuildCommonRedPoint()
		elseif arg_72_1.type == 3 then
			getReward(formatRewardCfgList(ClubBossPreposeCfg[1].personal_reward))
			GuildData:OnGetGuildBossFirstBonus()
			var_0_0.UpdateGuildBossPreposeFirstRedPoint()
		end

		manager.notify:Invoke(GUILD_BOSS_BONUS_GET, {})
	else
		ShowTips(GetTips(arg_72_0.result))
	end
end

function var_0_0.SetAssistHero(arg_73_0, arg_73_1, arg_73_2)
	local var_73_0 = GuildData:GetCurrentBossAssistantHeroId() or {}
	local var_73_1 = clone(var_73_0)

	if arg_73_2 then
		if GuildData:CheckCurrentHeroIDIsAssistant(arg_73_1) then
			Debugger.LogError("有重复人物id放入助战列表")

			return
		end

		table.insert(var_73_1, arg_73_1)
	else
		if not GuildData:CheckCurrentHeroIDIsAssistant(arg_73_1) then
			Debugger.LogError("有重复人物id放入助战列表")

			return
		end

		local var_73_2 = table.indexof(var_73_1, arg_73_1)

		if var_73_2 then
			table.remove(var_73_1, var_73_2)
		end
	end

	local var_73_3 = {
		club_id = arg_73_0,
		hero_id_list = var_73_1
	}

	manager.net:SendWithLoadingNew(33010, var_73_3, 33011, var_0_0.OnSetAssistHeroCallback)
end

function var_0_0.OnSetAssistHeroCallback(arg_74_0, arg_74_1)
	if isSuccess(arg_74_0.result) then
		GuildData:SetAssistHero(arg_74_1.hero_id_list)
	else
		ShowTips(GetTips(arg_74_0.result))
	end
end

function var_0_0.UpdateGuildBossRedPoint()
	var_0_0.UpdateGuildBossFirstOpenRedPoint()
	var_0_0.UpdateGuildPersonRedPoint()
	var_0_0.UpdateGuildCommonRedPoint()
	var_0_0.UpdateGuildBossPreposeFirstRedPoint()
end

function var_0_0.UpdateGuildBossPreposeFirstRedPoint()
	if not GuildData:GetBossData().initedFromServer then
		manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_FIRST_BONUS, 0)

		return
	end

	manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_FIRST_BONUS, GuildData:CanGetBonus() and 1 or 0)
end

function var_0_0.UpdateGuildPersonRedPoint()
	if not GuildData:GetBossData().initedFromServer then
		manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PERSONAL_BONUS, 0)

		return
	end

	local var_77_0 = ClubBossCfg[GuildData:GetBossDifficulty()]
	local var_77_1 = false

	for iter_77_0, iter_77_1 in ipairs(var_77_0.personal_reward) do
		local var_77_2 = GuildData:HaveGetGuildBossPersonalReward(iter_77_1[1])
		local var_77_3 = GuildData:GetBossPersonalScore() >= iter_77_1[1]

		if not var_77_2 then
			var_77_1 = var_77_3

			break
		end

		var_77_1 = false

		if false then
			var_77_1 = true
		end

		break
	end

	manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PERSONAL_BONUS, var_77_1 and 1 or 0)
end

function var_0_0.UpdateGuildCommonRedPoint()
	if not GuildData:GetBossData().initedFromServer then
		manager.redPoint:setTip(RedPointConst.GUILD_BOSS_COMMON_BONUS, 0)

		return
	end

	local var_78_0 = ClubBossCfg[GuildData:GetBossDifficulty()]
	local var_78_1 = false

	for iter_78_0, iter_78_1 in ipairs(var_78_0.reward) do
		local var_78_2 = GuildData:HaveGetGuildBossCommonReward(iter_78_1[1])
		local var_78_3 = ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp * (100 - iter_78_1[1]) / 100 >= ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp - GuildData:GetCurrentBossDamage()

		var_78_1 = not var_78_2 and var_78_3

		if var_78_1 then
			break
		end
	end

	manager.redPoint:setTip(RedPointConst.GUILD_BOSS_COMMON_BONUS, var_78_1 and 1 or 0)
end

function var_0_0.UpdateGuildBossFirstOpenRedPoint()
	if not GuildData:GetBossData().initedFromServer then
		manager.redPoint:setTip(RedPointConst.GUILD_BOSS_CHALLENGE_OPEN, 0)
		manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_OPEN, 0)

		return
	end

	local var_79_0, var_79_1 = GuildData:GetLastTime()

	if var_79_0 == "prepose" then
		saveData("guild_boss", "challenge", 1)

		if (getData("guild_boss", "prepose") or 1) == 1 then
			manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_OPEN, 1)
		else
			manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_OPEN, 0)
		end

		manager.redPoint:setTip(RedPointConst.GUILD_BOSS_CHALLENGE_OPEN, 0)
	else
		saveData("guild_boss", "prepose", 1)

		if (getData("guild_boss", "challenge") or 1) == 1 then
			manager.redPoint:setTip(RedPointConst.GUILD_BOSS_CHALLENGE_OPEN, 1)
		else
			manager.redPoint:setTip(RedPointConst.GUILD_BOSS_CHALLENGE_OPEN, 0)
		end

		manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_OPEN, 0)
	end
end

return var_0_0
