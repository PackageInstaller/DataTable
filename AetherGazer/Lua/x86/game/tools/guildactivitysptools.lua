local var_0_0 = {}
local var_0_1 = {
	[ActivityConst.GUILD_ACTIVITY_SP_2_4] = {
		helpKey = "CLUB_ACTIVITY_SP_AFFIX_DESC",
		application_1 = "ACTIVITY_CLUB_SP_APPLICATION_INTRODUCTION1",
		activityName = "",
		introduction = "ACTIVITY_CLUB_SP_INTRODUCTION",
		exitClub = "ACTIVITY_CLUB_SP_ACTIVITYING_EXIT_CLUB_TIP",
		application_2 = "ACTIVITY_CLUB_SP_APPLICATION_INTRODUCTION2",
		isPrefabInfoType = false,
		removeMenber = "ACTIVITY_CLUB_SP_ACTIVITYING_REMOVE_MEMBER_TIP",
		nextMapLock = "ACTIVITY_CLUB_SP_NEXT_MAP_LOCK_TIP",
		secondOpen = "ACTIVITY_CLUB_SP_SECOND_STAGE_OPEN_TIP",
		register = ActivityConst.GUILD_ACTIVITY_SP_2_4_REGISTER,
		start = ActivityConst.GUILD_ACTIVITY_SP_2_4_START,
		currencyID = {
			MaterialConst.GUILD_ACTIVITY_SP_COIN1,
			MaterialConst.GUILD_ACTIVITY_SP_COIN2
		},
		shopID = ShopConst.SHOP_ID.SUPPORT_SHOP,
		pages = GameSetting.activity_club_sp_describe.value,
		chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_4
	},
	[ActivityConst.GUILD_ACTIVITY_SP_2_8] = {
		helpKey = "CLUB_ACTIVITY_SP2_AFFIX_DESC",
		application_1 = "ACTIVITY_CLUB_SP2_APPLICATION_INTRODUCTION1",
		activityName = "ACTIVITY_CLUB_SP2_NAME",
		introduction = "ACTIVITY_CLUB_SP2_INTRODUCTION",
		exitClub = "ACTIVITY_CLUB_SP2_ACTIVITYING_EXIT_CLUB_TIP",
		application_2 = "ACTIVITY_CLUB_SP2_APPLICATION_INTRODUCTION2",
		isPrefabInfoType = true,
		removeMenber = "ACTIVITY_CLUB_SP2_ACTIVITYING_REMOVE_MEMBER_TIP",
		nextMapLock = "ACTIVITY_CLUB_SP2_NEXT_MAP_LOCK_TIP",
		secondOpen = "ACTIVITY_CLUB_SP2_SECOND_STAGE_OPEN_TIP",
		register = ActivityConst.GUILD_ACTIVITY_SP_2_8_REGISTER,
		start = ActivityConst.GUILD_ACTIVITY_SP_2_8_START,
		currencyID = {
			MaterialConst.GUILD_ACTIVITY_SP_2_8_COIN1,
			MaterialConst.GUILD_ACTIVITY_SP_2_8_COIN2
		},
		shopID = ShopConst.SHOP_ID.SUPPORT_SHOP_2_8,
		pages = GameSetting.activity_club_sp2_describe.value,
		chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_8
	}
}

function var_0_0.GetActivityEnterViewPrefab(arg_1_0)
	local var_1_0

	if arg_1_0 == ActivityConst.GUILD_ACTIVITY_SP_2_4 then
		var_1_0 = Asset.Load("UI/GuildActivitySPUI/GuildActivitySPEnterUI")
	else
		var_1_0 = Asset.Load("UI/VersionUI/IndiaUI_2_8/IndiaGuildUI/IndiaGuildActivitySPEnterUI")
	end

	return var_1_0
end

function var_0_0.GetCurActivityIDInfo(arg_2_0)
	return var_0_1[arg_2_0]
end

function var_0_0.GetCurActivityDescribe()
	local var_3_0 = GuildActivitySPData:GetCurMainActivityID()

	if var_0_1[var_3_0] then
		return var_0_1[var_3_0].pages, var_0_1[var_3_0].isPrefabInfoType
	else
		CustomLog.Log("未获取到对应活动的玩法说明配置信息" .. var_3_0)
	end
end

function var_0_0.GetActivityState()
	return var_0_1
end

function var_0_0.GetCurOpenActivityStateInfo()
	local var_5_0 = GuildActivitySPData:GetCurMainActivityID()

	return var_0_1[var_5_0]
end

function var_0_0.CheckGuildActivitySPIsOpen()
	local var_6_0 = GuildActivitySPData:GetCurMainActivityID()

	if var_6_0 then
		local var_6_1 = ActivityData:GetActivityData(var_6_0)
		local var_6_2 = var_6_1.startTime
		local var_6_3 = var_6_1.stopTime
		local var_6_4 = manager.time:GetServerTime()

		if var_6_2 <= var_6_4 and var_6_4 < var_6_3 then
			return true, var_6_0
		end
	end

	return false
end

function var_0_0.CheckActivityCurState(arg_7_0)
	local var_7_0 = var_0_1[arg_7_0]

	if var_7_0 then
		if var_0_0.CheckActivityIsOpen(var_7_0.start) then
			return "start", var_7_0.start
		end

		if var_0_0.CheckActivityIsOpen(var_7_0.register) then
			return "register", var_7_0.register
		end
	end
end

function var_0_0.CheckActivityIsOpen(arg_8_0)
	local var_8_0 = ActivityData:GetActivityData(arg_8_0)
	local var_8_1 = var_8_0.startTime
	local var_8_2 = var_8_0.stopTime
	local var_8_3 = manager.time:GetServerTime()

	if var_8_1 <= var_8_3 and var_8_3 < var_8_2 then
		return true
	end
end

function var_0_0.GetCurActivityTimeStage(arg_9_0)
	local var_9_0 = manager.time:GetServerTime()
	local var_9_1 = ActivityData:GetActivityData(arg_9_0)
	local var_9_2 = var_9_1.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600
	local var_9_3 = var_9_1.stopTime

	if var_9_2 < var_9_0 then
		return 2, var_9_3, var_9_2
	else
		return 1, var_9_3, var_9_2
	end
end

function var_0_0.GetTopUserLevel(arg_10_0)
	local var_10_0 = ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_10_0]

	if var_10_0 then
		return #var_10_0
	end
end

function var_0_0.GetCurCurrencyID(arg_11_0, arg_11_1)
	if arg_11_0 and arg_11_1 then
		return var_0_1[arg_11_0].currencyID[arg_11_1]
	end
end

function var_0_0.GetCantUseHeroList()
	local var_12_0 = GuildActivitySPData:GetFightHeroList()
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		table.insert(var_12_1, iter_12_1.id)
	end

	local var_12_2 = HeroData:GetUnlockHeros()
	local var_12_3 = {}

	for iter_12_2, iter_12_3 in ipairs(var_12_2) do
		if not table.indexof(var_12_1, iter_12_3) then
			table.insert(var_12_3, iter_12_3)
		end
	end

	return var_12_3
end

return var_0_0
