local var_0_0 = {}
local var_0_1
local var_0_2

function var_0_0.Init()
	var_0_1 = false
	var_0_2 = false
end

manager.net:Bind(36001, function(arg_2_0)
	GuildActivityData:InitMainDataFromServer(arg_2_0)
	var_0_0.UpdateRedPoint(ActivityConst.GUILD_ACTIVITY_START)
end)
manager.net:Bind(36003, function(arg_3_0)
	GuildActivityData:UpdateGridsDataFromServer(arg_3_0.grid_status)
end)
manager.net:Bind(36005, function(arg_4_0)
	GuildActivityData:UpdateGuildActivityHeroes(arg_4_0.hero_list)
	var_0_0.UpdateOnFightNotFullRedPoint(ActivityConst.GUILD_ACTIVITY_START)
end)
manager.net:Bind(36007, function(arg_5_0)
	GuildActivityData:UpdateSelfGridDataFromServer(arg_5_0)
end)
manager.net:Bind(36009, function(arg_6_0)
	GuildActivityData:SetIsSignFromServer(arg_6_0.is_sign)
	var_0_0.UpdateUnregisterRedPoint()
	var_0_0.UpdateOnFightNotFullRedPoint(ActivityConst.GUILD_ACTIVITY_START)
end)
manager.notify:RegistListener(GUILD_ENTER, function()
	var_0_0.UpdateRedPoint(ActivityConst.GUILD_ACTIVITY_START)
end)
manager.notify:RegistListener(HERO_UNLOCK_SUCCESS, function()
	var_0_0.UpdateOnFightNotFullRedPoint(ActivityConst.GUILD_ACTIVITY_START)
end)

function var_0_0.UpdateRedPoint(arg_9_0)
	var_0_0.UpdateUnregisterRedPoint()
	var_0_0.UpdateCoinRedPoint(arg_9_0)
	var_0_0.UpdateOnFightNotFullRedPoint(arg_9_0)

	local var_9_0

	if not ActivityData:GetActivityIsOpen(arg_9_0) then
		local var_9_1 = string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, arg_9_0)

		manager.redPoint:setTip(var_9_1, 0)

		local var_9_2 = string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_RATE, arg_9_0)

		manager.redPoint:setTip(var_9_2, 0)
	end
end

function var_0_0.UpdateUnregisterRedPoint()
	local var_10_0 = true

	if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
		var_10_0 = false
	end

	local var_10_1 = ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) or ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_REGISTER)
	local var_10_2 = var_10_0 and not var_0_0.GetUnRegisterRedPointClicked() and not GuildActivityData:HaveRegister() and var_10_1

	manager.redPoint:setTip(RedPointConst.GUILD_ACTIVITY_UNREGISTER, var_10_2 and 1 or 0)
end

function var_0_0.UpdateCoinRedPoint(arg_11_0)
	local var_11_0 = true

	if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
		var_11_0 = false
	end

	local var_11_1 = GuildActivityData:IsAllAffixMax(arg_11_0)
	local var_11_2 = GameSetting.activity_club_red_dot_need.value[1]
	local var_11_3 = false

	if var_11_2 <= GuildActivityData:GetTotalCoinToGet() then
		var_11_3 = true
	end

	local var_11_4 = ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START)
	local var_11_5 = var_11_0 and not var_11_1 and var_11_4 and not var_0_0.GetCoinRedPointClicked() and var_11_3

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_UNGET_COIN, arg_11_0), var_11_5 and 1 or 0)
end

function var_0_0.UpdateOnFightNotFullRedPoint(arg_12_0)
	local var_12_0 = true

	if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
		var_12_0 = false
	end

	local var_12_1 = ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START)
	local var_12_2 = GuildActivityData:HaveTakeOnFightNum() >= math.min(GuildActivityData:CanTakeOnFightNum(), HeroData:GetHeroNum())
	local var_12_3 = var_12_0 and var_12_1 and GuildActivityData:HaveRegister() and not var_12_2

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_ON_FIGHT_NOT_FULL, arg_12_0), var_12_3 and 1 or 0)
end

function var_0_0.SetUnRegisterRedPointClicked(arg_13_0)
	var_0_1 = arg_13_0

	var_0_0.UpdateUnregisterRedPoint()
end

function var_0_0.GetUnRegisterRedPointClicked()
	return var_0_1
end

function var_0_0.SetCoinRedPointClicked(arg_15_0, arg_15_1)
	var_0_2 = arg_15_0

	var_0_0.UpdateCoinRedPoint(arg_15_1)
end

function var_0_0.GetCoinRedPointClicked()
	return var_0_2
end

function var_0_0.Register(arg_17_0)
	local var_17_0 = {}

	manager.net:SendWithLoadingNew(36010, var_17_0, 36011, function(arg_18_0, arg_18_1)
		if isSuccess(arg_18_0.result) then
			ShowTips("ACTIVITY_CLUB_REGISTER_SUCCESS")
			GuildActivityData:SignUpSuccess()
			arg_17_0()
		else
			ShowTips(GetTips(arg_18_0.result))
		end
	end)
end

function var_0_0.EnterGuildWarField(arg_19_0)
	local var_19_0 = {}

	manager.net:SendWithLoadingNew(36012, var_19_0, 36013, function(arg_20_0, arg_20_1)
		if isSuccess(arg_20_0.result) then
			GuildActivityData:InitGridsDataFromServer(arg_20_0.grid_status)
			arg_19_0()
		else
			ShowTips(GetTips(arg_20_0.result))
		end
	end)
end

function var_0_0.ExitGuildWarField(arg_21_0)
	local var_21_0 = {}

	manager.net:SendWithLoadingNew(36014, var_21_0, 36015, function(arg_22_0, arg_22_1)
		if isSuccess(arg_22_0.result) then
			arg_21_0()
		else
			ShowTips(GetTips(arg_22_0.result))
		end
	end)
end

function var_0_0.LockNode(arg_23_0)
	local var_23_0 = {
		id = arg_23_0
	}

	manager.net:SendWithLoadingNew(36016, var_23_0, 36017, var_0_0.OnLockNodeCallback)
end

function var_0_0.OnLockNodeCallback(arg_24_0, arg_24_1)
	if isSuccess(arg_24_0.result) then
		GuildActivityData:OnGridOccupying(arg_24_1.id)
	else
		ShowTips(GetTips(arg_24_0.result))
	end
end

function var_0_0.UnlockNode(arg_25_0)
	local var_25_0 = {
		id = arg_25_0
	}

	manager.net:SendWithLoadingNew(36018, var_25_0, 36019, var_0_0.OnUnLockNodeCallback)
end

function var_0_0.OnUnLockNodeCallback(arg_26_0, arg_26_1)
	if isSuccess(arg_26_0.result) then
		GuildActivityData:OnGridCancelOccupy(arg_26_1.id)
	else
		ShowTips(GetTips(arg_26_0.result))
	end
end

function var_0_0.GetFightRecord(arg_27_0, arg_27_1)
	local var_27_0 = {
		id = arg_27_0
	}

	manager.net:SendWithLoadingNew(36020, var_27_0, 36021, function(arg_28_0, arg_28_1)
		if isSuccess(arg_28_0.result) then
			local var_28_0 = {}

			for iter_28_0, iter_28_1 in ipairs(arg_28_0.records) do
				local var_28_1 = {
					uid = iter_28_1.uid,
					icon = iter_28_1.base_info.icon,
					icon_frame = iter_28_1.base_info.icon_frame,
					name = iter_28_1.base_info.nick,
					damage = iter_28_1.damage,
					hero_list = iter_28_1.hero_list,
					timestamp = iter_28_1.timestamp
				}

				table.insert(var_28_0, var_28_1)
			end

			table.sort(var_28_0, function(arg_29_0, arg_29_1)
				return arg_29_0.damage > arg_29_1.damage
			end)
			arg_27_1(var_28_0)
		else
			ShowTips(GetTips(arg_28_0.result))
		end
	end)
end

function var_0_0.OnGetFightRecordCallback(arg_30_0, arg_30_1)
	if isSuccess(arg_30_0.result) then
		GuildActivityData:InitFightRecordFromServer(arg_30_0.records)
	else
		ShowTips(GetTips(arg_30_0.result))
	end
end

function var_0_0.SetFightMember(arg_31_0, arg_31_1)
	local var_31_0 = {
		up_hero_id_list = arg_31_0,
		down_hero_id_list = arg_31_1
	}

	manager.net:SendWithLoadingNew(36022, var_31_0, 36023, var_0_0.OnSetFightMemberCallback)
end

function var_0_0.OnSetFightMemberCallback(arg_32_0, arg_32_1)
	if isSuccess(arg_32_0.result) then
		GuildActivityData:OnSetFightMember()
		var_0_0.UpdateOnFightNotFullRedPoint(ActivityConst.GUILD_ACTIVITY_START)
	else
		ShowTips(GetTips(arg_32_0.result))
	end
end

function var_0_0.UpgradeAffix(arg_33_0, arg_33_1)
	manager.net:SendWithLoadingNew(36024, {
		id = arg_33_0
	}, 36025, function(arg_34_0, arg_34_1)
		if arg_33_1 ~= nil then
			arg_33_1(arg_34_0, arg_34_1)
			var_0_0.UpdateCoinRedPoint(ActivityConst.GUILD_ACTIVITY_START)
		end
	end)
end

function var_0_0.RequireReceive(arg_35_0, arg_35_1)
	manager.net:SendWithLoadingNew(36036, {
		level = ActivityClubLevelSettingCfg[arg_35_0].user_level
	}, 36037, arg_35_1)
end

function var_0_0.QueryRankList(arg_36_0, arg_36_1)
	manager.net:SendWithLoadingNew(36032, {
		id = arg_36_0
	}, 36033, function(arg_37_0, arg_37_1)
		if isSuccess(arg_37_0.result) then
			GuildActivityData:SetRankData(arg_37_0)
			arg_36_1()
		else
			ShowTips(arg_37_0.result)
		end
	end)
end

function var_0_0.GiveUpNode(arg_38_0)
	local var_38_0 = {
		id = arg_38_0
	}

	manager.net:SendWithLoadingNew(36030, var_38_0, 36031, var_0_0.OnGiveUpNodeCallback)
end

function var_0_0.OnGiveUpNodeCallback(arg_39_0, arg_39_1)
	if isSuccess(arg_39_0.result) then
		GuildActivityData:OnGridGiveUp(arg_39_1.id)
		GuildActivityData:RefreshAffixRedPoint(ActivityConst.GUILD_ACTIVITY_START)
	else
		ShowTips(GetTips(arg_39_0.result))
	end
end

function var_0_0.EnterNext(arg_40_0)
	local var_40_0 = {
		id = arg_40_0
	}

	manager.net:SendWithLoadingNew(36028, var_40_0, 36029, var_0_0.OnEnterNextCallback)
end

function var_0_0.OnEnterNextCallback(arg_41_0, arg_41_1)
	if isSuccess(arg_41_0.result) then
		manager.notify:CallUpdateFunc(GUILD_ACTIVITY_ENTER_NEW_LEVEL)
	else
		ShowTips(GetTips(arg_41_0.result))
	end
end

function var_0_0.SaveEliteCombatResult(arg_42_0)
	local var_42_0 = {
		is_save = arg_42_0
	}

	manager.net:SendWithLoadingNew(36026, var_42_0, 36027, var_0_0.OnSaveEliteCombatResultCallback)
end

function var_0_0.OnSaveEliteCombatResultCallback(arg_43_0, arg_43_1)
	if isSuccess(arg_43_0.result) then
		-- block empty
	else
		ShowTips(GetTips(arg_43_0.result))
	end
end

function var_0_0.GetCoin()
	local var_44_0 = {}

	manager.net:SendWithLoadingNew(36034, var_44_0, 36035, var_0_0.OnGetCoinCallback)
end

function var_0_0.OnGetCoinCallback(arg_45_0, arg_45_1)
	if isSuccess(arg_45_0.result) then
		GuildActivityData:OnGetCoin(arg_45_0.last_receive_time)
		manager.notify:CallUpdateFunc(GUILD_ACTIVITY_CHECK_RATE_UPGRADE)
		manager.notify:Invoke(GUILD_ACTIVITY_COIN_GET_FINISH, {})
		var_0_0.UpdateCoinRedPoint(ActivityConst.GUILD_ACTIVITY_START)
		GuildActivityData:RefreshAffixRedPoint(ActivityConst.GUILD_ACTIVITY_START)
	else
		ShowTips(GetTips(arg_45_0.result))
	end
end

function var_0_0.ExitGuildActivity()
	manager.windowBar:ClearWhereTag()

	local var_46_0 = {}

	manager.net:SendWithLoadingNew(36014, var_46_0, 36015, var_0_0.OnExitGuildActivityCallback)
end

function var_0_0.OnExitGuildActivityCallback(arg_47_0, arg_47_1)
	if isSuccess(arg_47_0.result) then
		-- block empty
	else
		ShowTips(GetTips(arg_47_0.result))
	end
end

function var_0_0.OnLogout()
	if whereami == "guildActivity" then
		SceneManager.UnloadSceneAsync("GuildActivity")
	end
end

manager.notify:RegistListener(HISTORY_UPDATE, function()
	if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) == true then
		GuildActivityData:RefreshRateRedPoint(ActivityConst.GUILD_ACTIVITY_START)
	end
end)

return var_0_0
