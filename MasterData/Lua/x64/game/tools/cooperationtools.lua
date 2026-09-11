local var_0_0 = {}
local var_0_1 = {}

function var_0_0.GotoCooperation()
	local var_1_0 = CooperationData:GetRoomData()

	if not var_1_0 then
		error("GotoCooperation with nil room")

		return
	end

	local var_1_1 = var_1_0.type

	if BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO == var_1_0.type then
		OpenPageUntilLoaded("/cooperationBlank/cooperation")
	elseif BattleConst.STAGE_TYPE_NEW.STRONGHOLD == var_1_1 then
		OpenPageUntilLoaded("/cooperationBlank/strongholdCooperation")
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION == var_1_1 then
		OpenPageUntilLoaded("/cooperationBlank/cooperationSectionSelectHero", {
			stageType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION,
			heroDataType = HeroConst.HERO_DATA_TYPE.COOPERATION
		})
	else
		OpenPageUntilLoaded("/cooperationBlank/cooperation")
	end
end

function var_0_0.GotoCooperationEntry(arg_2_0, arg_2_1, arg_2_2)
	if BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO == arg_2_0 then
		OpenPageUntilLoaded("/cooperationBlank/demoCooperationEntry")
	elseif BattleConst.STAGE_TYPE_NEW.STRONGHOLD == arg_2_0 then
		OpenPageUntilLoaded("/cooperationBlank/strongholdMain")
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION == arg_2_0 then
		OpenPageUntilLoaded("/cooperationBlank/summerWaterMain")
	end
end

function var_0_0.GetCooperationRoomName(arg_3_0, arg_3_1, arg_3_2)
	if BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION == arg_3_0 then
		return BattleActivityWaterCooperationCfg[arg_3_1].name
	elseif BattleConst.STAGE_TYPE_NEW.STRONGHOLD == arg_3_0 then
		return (ActivityStrongholdCfg[arg_3_1] or nil) and (ActivityStrongholdCfg[arg_3_1].room_name or "")
	else
		return ""
	end
end

function var_0_0.GetCooperationTeamHeroList(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {}
	local var_4_1 = {}
	local var_4_2 = false

	if arg_4_0 == BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO then
		if ActivityCooperationDemoCfg[arg_4_1] then
			var_4_2 = true
		end

		for iter_4_0, iter_4_1 in ipairs(ActivityCooperationDemoCfg[arg_4_1].hero_standard_system_id_list) do
			table.insert(var_4_0, {
				id = HeroStandardSystemCfg[iter_4_1].hero_id,
				trialID = iter_4_1
			})
		end
	elseif arg_4_0 == BattleConst.STAGE_TYPE_NEW.STRONGHOLD then
		for iter_4_2, iter_4_3 in pairs((HeroTools.Sort(HeroData:GetHeroList()))) do
			if table.indexof(ActivityStrongholdCfg[arg_4_1].limit_heros, iter_4_3) then
				table.insert(var_4_0, {
					trialID = 0,
					id = iter_4_3
				})
			end
		end

		for iter_4_4, iter_4_5 in ipairs(ActivityStrongholdCfg[arg_4_1].standard_heros) do
			table.insert(var_4_0, {
				id = HeroStandardSystemCfg[iter_4_5].hero_id,
				trialID = iter_4_5
			})
		end
	elseif arg_4_0 == BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION then
		local var_4_3 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.COOPERATION)

		for iter_4_6, iter_4_7 in ipairs(ActivitySummerWaterData:GetCurrentScheduleCfg().online_hero_id_list) do
			table.insert(var_4_0, {
				id = HeroStandardSystemCfg[iter_4_7].hero_id,
				trialID = iter_4_7,
				type = HeroConst.HERO_DATA_TYPE.COOPERATION,
				heroViewProxy = var_4_3
			})
			table.insert(var_4_1, iter_4_7)
		end

		var_4_3:SetTempHeroList(var_4_1)
	end

	if var_4_2 then
		for iter_4_8, iter_4_9 in pairs((HeroTools.Sort(HeroData:GetHeroList()))) do
			table.insert(var_4_0, {
				trialID = 0,
				id = iter_4_9
			})
		end
	end

	return var_4_0, var_4_1
end

function var_0_0.CheckRepeatHero(arg_5_0)
	local var_5_0 = CooperationData:GetRoomData()

	if not var_5_0 then
		return false
	end

	for iter_5_0, iter_5_1 in ipairs((var_5_0:GetRoomPlayerIdList())) do
		local var_5_1 = var_5_0:GetRoomPlayerData(iter_5_1)

		if var_5_1.is_ready == 1 then
			for iter_5_2, iter_5_3 in ipairs(var_5_1.heroList) do
				if arg_5_0 == iter_5_3.id then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.CheckInTeam(arg_6_0, arg_6_1)
	local var_6_0 = CooperationData:GetRoomData()

	if not var_6_0 then
		return false
	end

	local var_6_1, var_6_2 = var_6_0:GetSelfHero()

	return arg_6_0 == var_6_1 and arg_6_1 == var_6_2
end

function var_0_0.RegisterInvitationValidation(arg_7_0, arg_7_1)
	var_0_1[arg_7_0] = arg_7_1
end

function var_0_0.IsInvitationValid(arg_8_0, arg_8_1, arg_8_2)
	if not var_0_1[arg_8_0] then
		return true
	end

	if var_0_1[arg_8_0](arg_8_1, arg_8_2) then
		return true
	end

	return false
end

function var_0_0.GetShowInviteRoot()
	for iter_9_0, iter_9_1 in ipairs(GameSetting.cooperation_invite_root_show_activity_template.value) do
		for iter_9_2, iter_9_3 in ipairs(ActivityCfg.get_id_list_by_activity_template[iter_9_1] or {}) do
			if ActivityData:GetActivityIsOpen(iter_9_3) then
				return true
			end
		end
	end

	return false
end

function var_0_0.CanShowHero(arg_10_0)
	local var_10_0 = CooperationData:GetRoomData()
	local var_10_1 = var_10_0 and var_10_0:GetRoomPlayerData(arg_10_0)

	if var_10_1 == nil then
		return
	end

	local var_10_2 = var_10_1.heroList[1].trialID

	if var_10_1.heroList[1].trialID and var_10_2 ~= 0 then
		if HeroRecordCfg[HeroStandardSystemCfg[var_10_2].hero_id] then
			return true
		end
	elseif HeroRecordCfg[var_10_1.heroList[1].id] then
		return true
	end

	return false
end

function var_0_0.ShowHeroView(arg_11_0)
	local var_11_0 = CooperationData:GetRoomData()
	local var_11_1 = var_11_0 and var_11_0:GetRoomPlayerData(arg_11_0)

	if var_11_1 == nil then
		return
	end

	local var_11_2 = var_11_1.heroList[1].trialID

	if var_11_1.heroList[1].trialID and var_11_2 ~= 0 then
		gameContext:Go("/newHero", {
			isEnter = true,
			hid = var_11_1.heroList[1].id,
			tempHeroList = {
				var_11_2
			},
			type = HeroConst.HERO_DATA_TYPE.TRIAL
		})
	else
		CooperationData.show_player = clone(var_11_1)

		JumpTools.OpenPageByJump("/newHero", {
			isEnter = true,
			hid = var_11_1.heroList[1].id,
			type = HeroConst.HERO_DATA_TYPE.COOPERATION
		}, ViewConst.SYSTEM_ID.PLAYER_INFO)
	end
end

return var_0_0
