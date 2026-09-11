local var_0_0 = {}
local var_0_1
local var_0_2

function var_0_0.Init()
	var_0_1 = false
	var_0_2 = false
end

manager.net:Bind(70001, function(arg_2_0)
	GuildActivitySPData:InitActivityID(arg_2_0.activity_id)
	GuildActivitySPData:InitMainDataFromServer(arg_2_0)
	var_0_0.UpdateRedPoint()
	var_0_0.UpdataOutActivityAffix()
end)
manager.net:Bind(70003, function(arg_3_0)
	GuildActivitySPData:InitActivityID(arg_3_0.activity_id)
	GuildActivitySPData:UpdateGridsDataFromServer(arg_3_0.grid_status)
	var_0_0.UpdateRedPoint()
end)
manager.net:Bind(70005, function(arg_4_0)
	GuildActivitySPData:InitActivityID(arg_4_0.activity_id)
	GuildActivitySPData:UpdateGuildActivityHeroes(arg_4_0.hero_list)

	local var_4_0 = GuildActivitySPData:GetCurMainActivityID()

	var_0_0.UpdateOnFightNotFullRedPoint(var_4_0)
	var_0_0.UpdateOnHeroFightFullRedPoint(var_4_0)
end)
manager.net:Bind(70007, function(arg_5_0)
	GuildActivitySPData:InitActivityID(arg_5_0.activity_id)
	GuildActivitySPData:UpdateSelfGridDataFromServer(arg_5_0)
	var_0_0.UpdateRedPoint()
end)
manager.net:Bind(70009, function(arg_6_0)
	GuildActivitySPData:InitActivityID(arg_6_0.activity_id)
	GuildActivitySPData:SetIsSignFromServer(arg_6_0.is_sign)
	var_0_0.UpdateRedPoint()
end)
manager.notify:RegistListener(HERO_UNLOCK_SUCCESS, function()
	var_0_0.UpdateOnFightNotFullRedPoint((GuildActivitySPData:GetCurRunActivityID()))
end)

function var_0_0.UpdateRedPoint()
	local var_8_0 = GuildActivitySPData:GetCurMainActivityID()

	if var_8_0 and ActivityData:GetActivityIsOpen(var_8_0) then
		local var_8_1 = GuildActivitySPTools.GetCurActivityIDInfo(var_8_0).start

		if ActivityData:GetActivityIsOpen(GuildActivitySPTools.GetCurActivityIDInfo(var_8_0).register) then
			var_0_0.UpdateUnregisterRedPoint()
		end

		if ActivityData:GetActivityIsOpen(var_8_0) then
			var_0_0.UpdateUnregisterRedPoint()
			var_0_0.UpdateCoinRedPoint()
			var_0_0.UpdataImmediatelyRedPoint()
		end
	end
end

function var_0_0.UpdataImmediatelyRedPoint()
	if ActivityData:GetActivityIsOpen((GuildActivitySPData:GetCurMainActivityID())) then
		var_0_0.UpdateOnFightNotFullRedPoint()
		var_0_0.UpdateOnHeroFightFullRedPoint()
		var_0_0.UpdataHadAwardRedPoint()
	end
end

function var_0_0.UpdateUnregisterRedPoint()
	manager.redPoint:setTip(RedPointConst.GUILD_ACTIVITY_SP_UNREGISTER, not (GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0) and not var_0_0.GetUnRegisterRedPointClicked() and not GuildActivitySPData:HaveRegister() and ActivityData:GetActivityIsOpen((GuildActivitySPData:GetCurMainActivityID())) and 1 or 0)
end

function var_0_0.UpdateCoinRedPoint()
	local var_11_0 = GuildActivitySPData:GetCurRunActivityID()

	if not var_11_0 or not ActivityData:GetActivityIsOpen(var_11_0) then
		return
	end

	local var_11_1 = not (GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0)

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_UNGET_COIN, var_11_0), var_11_1 and not GuildActivitySPData:IsAllAffixMax(var_11_0) and ActivityData:GetActivityIsOpen(var_11_0) and not var_0_0.GetCoinRedPointClicked() and GameSetting.activity_club_sp_red_dot_need.value[1] <= GuildActivitySPData:GetTotalCoinToGet() and 1 or 0)
end

function var_0_0.UpdateOnFightNotFullRedPoint()
	local var_12_0 = GuildActivitySPData:GetCurRunActivityID()

	if not var_12_0 or not ActivityData:GetActivityIsOpen(var_12_0) then
		return
	end

	local var_12_3

	if not (GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0) and ActivityData:GetActivityIsOpen(var_12_0) then
		::label_12_1::

		var_12_3 = GuildActivitySPData:HaveRegister()
		var_12_3 = var_12_3 and GuildActivitySPData:HaveTakeOnFightNum() < math.min(GuildActivitySPData:CanTakeOnFightNum(), HeroData:GetHeroNum())
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_ON_FIGHT_NOT_FULL, var_12_0), var_12_3 and 1 or 0)
end

function var_0_0.UpdataOutActivityAffix()
	local var_13_0 = GuildActivitySPData:GetCurRunActivityID()

	if not var_13_0 or not ActivityData:GetActivityIsOpen(var_13_0) then
		if not var_13_0 then
			return
		end

		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, var_13_0), 0)

		return
	end

	if GuildActivitySPData:RefreshAffixRedPoint() then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_AFFIX_OUT, var_13_0), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_AFFIX_OUT, var_13_0), 0)
	end
end

function var_0_0.UpdataHadAwardRedPoint()
	local var_14_0 = GuildActivitySPData:GetCurRunActivityID()

	if not var_14_0 or not ActivityData:GetActivityIsOpen(var_14_0) then
		return
	end

	local var_14_1 = GuildActivitySPData:GetReceivedList()

	for iter_14_0, iter_14_1 in ipairs((GuildActivitySPData:GetSortedRateIDList(var_14_0))) do
		if table.keyof(var_14_1, ActivityClubSPLevelSettingCfg[iter_14_1].user_level) == nil and ActivityClubSPLevelSettingCfg[GuildActivitySPData:GetCurRateID(var_14_0)].user_level >= ActivityClubSPLevelSettingCfg[iter_14_1].user_level then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_BONUS, var_14_0), 1)

			return
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_BONUS, var_14_0), 0)
end

function var_0_0.UpdateOnHeroFightFullRedPoint()
	local var_15_0 = GuildActivitySPData:GetCurRunActivityID()

	if not var_15_0 or not ActivityData:GetActivityIsOpen(var_15_0) then
		return
	end

	local var_15_2

	if ActivityData:GetActivityIsOpen(var_15_0) then
		::label_15_0::

		var_15_2 = GuildActivitySPData:HaveRegister()
		var_15_2 = var_15_2 and GuildActivitySPData:CheckHeroFightIsFull() and GuildActivitySPData:GetCurRateID(var_15_0) ~= ActivityClubSPLevelSettingCfg.all[#ActivityClubSPLevelSettingCfg.all]
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_HERO_FIGHT, var_15_0), var_15_2 and 1 or 0)
end

function var_0_0.SetUnRegisterRedPointClicked(arg_16_0)
	var_0_1 = arg_16_0

	var_0_0.UpdateUnregisterRedPoint()
end

function var_0_0.GetUnRegisterRedPointClicked()
	return var_0_1
end

function var_0_0.SetCoinRedPointClicked(arg_18_0, arg_18_1)
	var_0_2 = arg_18_0

	var_0_0.UpdateCoinRedPoint()
end

function var_0_0.GetCoinRedPointClicked()
	return var_0_2
end

function var_0_0.Register(arg_20_0)
	manager.net:SendWithLoadingNew(70010, {}, 70011, function(arg_21_0, arg_21_1)
		if isSuccess(arg_21_0.result) then
			ShowTips("ACTIVITY_CLUB_REGISTER_SUCCESS")
			GuildActivitySPData:SignUpSuccess()
			arg_20_0()
		else
			ShowTips(GetTips(arg_21_0.result))
		end
	end)
end

function var_0_0.EnterGuildWarField(arg_22_0)
	manager.net:SendWithLoadingNew(70012, {}, 70013, function(arg_23_0, arg_23_1)
		if isSuccess(arg_23_0.result) then
			GuildActivitySPData:InitGridsDataFromServer(arg_23_0.grid_status)
			arg_22_0()
		else
			ShowTips(GetTips(arg_23_0.result))
		end
	end)
end

function var_0_0.ExitGuildWarField(arg_24_0)
	manager.net:SendWithLoadingNew(70014, {}, 70015, function(arg_25_0, arg_25_1)
		if isSuccess(arg_25_0.result) then
			arg_24_0()
		else
			ShowTips(GetTips(arg_25_0.result))
		end
	end)
end

function var_0_0.GetFightRecord(arg_26_0, arg_26_1)
	manager.net:SendWithLoadingNew(70020, {
		id = arg_26_0
	}, 70021, function(arg_27_0, arg_27_1)
		if isSuccess(arg_27_0.result) then
			local var_27_0 = {}

			for iter_27_0, iter_27_1 in ipairs(arg_27_0.records) do
				table.insert(var_27_0, {
					uid = iter_27_1.uid,
					icon = iter_27_1.base_info.icon,
					icon_frame = iter_27_1.base_info.icon_frame,
					name = iter_27_1.base_info.nick,
					damage = iter_27_1.damage,
					hero_list = iter_27_1.hero_list,
					timestamp = iter_27_1.timestamp
				})
			end

			table.sort(var_27_0, function(arg_28_0, arg_28_1)
				return arg_28_0.damage > arg_28_1.damage
			end)
			arg_26_1(var_27_0)
		else
			ShowTips(GetTips(arg_27_0.result))
		end
	end)
end

function var_0_0.SetFightMember(arg_29_0, arg_29_1)
	manager.net:SendWithLoadingNew(70022, {
		up_hero_id_list = arg_29_0,
		down_hero_id_list = arg_29_1
	}, 70023, var_0_0.OnSetFightMemberCallback)
end

function var_0_0:OnSetFightMemberCallback(arg_30_1)
	if isSuccess(self.result) then
		GuildActivitySPData:OnSetFightMember()
		var_0_0.UpdateOnFightNotFullRedPoint()
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.UpgradeAffix(arg_31_0, arg_31_1)
	manager.net:SendWithLoadingNew(70024, {
		id = arg_31_0
	}, 70025, function(arg_32_0, arg_32_1)
		if arg_31_1 ~= nil then
			arg_31_1(arg_32_0, arg_32_1)
		end
	end)
end

function var_0_0.RequireReceive(arg_33_0, arg_33_1)
	manager.net:SendWithLoadingNew(70036, {
		level = ActivityClubSPLevelSettingCfg[arg_33_0].user_level
	}, 70037, arg_33_1)
end

function var_0_0.QueryRankList(arg_34_0, arg_34_1)
	manager.net:SendWithLoadingNew(70032, {
		id = arg_34_0
	}, 70033, function(arg_35_0, arg_35_1)
		if isSuccess(arg_35_0.result) then
			GuildActivitySPData:SetRankData(arg_35_0)
			arg_34_1()
		else
			ShowTips(arg_35_0.result)
		end
	end)
end

function var_0_0.GiveUpNode(arg_36_0)
	manager.net:SendWithLoadingNew(70030, {
		id = arg_36_0
	}, 70031, var_0_0.OnGiveUpNodeCallback)
end

function var_0_0:OnGiveUpNodeCallback(arg_37_1)
	if isSuccess(self.result) then
		GuildActivitySPData:OnGridGiveUp(arg_37_1.id)

		if itemNum and itemNum > 0 then
			var_0_0.UpdataOutActivityAffix()
		end

		GuildActivitySPData:RefreshAffixRedPoint()
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.EnterNext(arg_38_0)
	manager.net:SendWithLoadingNew(70028, {
		id = arg_38_0
	}, 70029, var_0_0.OnEnterNextCallback)
end

function var_0_0:OnEnterNextCallback(arg_39_1)
	if isSuccess(self.result) then
		manager.notify:CallUpdateFunc(GUILD_ACTIVITY_SP_ENTER_NEW_LEVEL)
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.SaveEliteCombatResult(arg_40_0)
	manager.net:SendWithLoadingNew(70026, {
		is_save = arg_40_0
	}, 70027, var_0_0.OnSaveEliteCombatResultCallback)
end

function var_0_0:OnSaveEliteCombatResultCallback(arg_41_1)
	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.GetCoin()
	manager.net:SendWithLoadingNew(70034, {}, 70035, var_0_0.OnGetCoinCallback)
end

function var_0_0:OnGetCoinCallback(arg_43_1)
	if isSuccess(self.result) then
		GuildActivitySPData:OnGetCoin(self.last_receive_time)
		manager.notify:CallUpdateFunc(GUILD_ACTIVITY_SP_CHECK_RATE_UPGRADE)
		manager.notify:Invoke(GUILD_ACTIVITY_SP_COIN_GET_FINISH, {})
		GuildActivitySPData:RefreshAffixRedPoint()

		if itemNum and itemNum > 0 then
			var_0_0.UpdataOutActivityAffix()
		end
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.ExitGuildActivity()
	manager.windowBar:ClearWhereTag()
	manager.net:SendWithLoadingNew(70014, {}, 70015, var_0_0.OnExitGuildActivityCallback)
end

function var_0_0:OnExitGuildActivityCallback(arg_45_1)
	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.OnLogout()
	if whereami == "guildActivitySP" then
		SceneManager.UnloadSceneAsync("guildActivitySP")
	end
end

manager.notify:RegistListener(HISTORY_UPDATE, function()
	var_0_0.UpdataImmediatelyRedPoint()
end)

function var_0_0.Dispatch(arg_48_0, arg_48_1)
	manager.net:SendWithLoadingNew(70016, {
		id = arg_48_0,
		cat_id = arg_48_1
	}, 70017, var_0_0.OnDispatchCallback)
end

function var_0_0:OnDispatchCallback(arg_49_1)
	if isSuccess(self.result) then
		GuildActivitySPData:OnDispatch(arg_49_1.id, arg_49_1.cat_id)
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.CancelDispatch(arg_50_0)
	manager.net:SendWithLoadingNew(70018, {
		id = arg_50_0
	}, 70019, var_0_0.OnCancelDispatchCallback)
end

function var_0_0:OnCancelDispatchCallback(arg_51_1)
	if isSuccess(self.result) then
		GuildActivitySPData:OnCancelDispatch(arg_51_1.id)
	else
		ShowTips(GetTips(self.result))
	end
end

return var_0_0
