local var_0_0 = class("BaseIsland", import("Mod.Island.IslandDispatcher"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.id = arg_1_1.id
	arg_1_0.level = arg_1_1.level or 1
	arg_1_0.configId = arg_1_0.level
	arg_1_0.exp = arg_1_1.exp or 0
	arg_1_0.name = arg_1_1.name or "1"
	arg_1_0.prosperity = arg_1_1.prosperity or 0
	arg_1_0.manifesto = arg_1_1.signature or ""
	arg_1_0.prosperityList = {}

	local var_1_0 = arg_1_1.prosperity_rewarded or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.prosperityList[iter_1_1] = true
	end

	arg_1_0.ablityAgency = IslandAblityAgency.New(arg_1_0, arg_1_1)
	arg_1_0.characterAgency = IslandCharacterAgency.New(arg_1_0, arg_1_1)
	arg_1_0.visitorAgency = IslandVisitorAgency.New(arg_1_0, arg_1_1)
	arg_1_0.technologyAgency = IslandTechnologyAgency.New(arg_1_0, arg_1_1)
	arg_1_0.signInAgency = IslandSignInAgency.New(arg_1_0, arg_1_1)
	arg_1_0.taskAgency = IslandTaskAgency.New(arg_1_0, arg_1_1)
	arg_1_0.accessAgency = IslandAccessAgency.New(arg_1_0, arg_1_1)
	arg_1_0.gatherCollectAgency = IslandGatherCollectAgency.New(arg_1_0, arg_1_1)
	arg_1_0.buildingAgency = IslandBuildingAgency.New(arg_1_0, arg_1_1)
	arg_1_0.followerAgency = IslandFollowerAgency.New(arg_1_0)
	arg_1_0.activityNpcAgency = IslandActivityNpcAgency.New(arg_1_0)
	arg_1_0.tradeAgency = IslandTradegency.New(arg_1_0, arg_1_1)
	arg_1_0.agoraAgency = IslandAgoraAgency.New(arg_1_0, arg_1_1)
	arg_1_0.manageAgency = IslandManageAgecny.New(arg_1_0, arg_1_1)
	arg_1_0.cheaterTavernAgency = IslandCheaterTavernAgency.New(arg_1_0)
	arg_1_0.mapID = pg.island_set.initial_scene.key_value_int
	arg_1_0.lastExitPosition = {
		mapId = 0,
		position = Vector3.zero,
		rotation = Vector3.zero
	}

	if not arg_1_0.taskAgency:IsFinishTask(IslandGuideChecker.MOVE_TASK_ID) then
		arg_1_0:SetSpawnPointId(pg.island_set.initial_spawn_point.key_value_int)
	end

	return
end

function var_0_0.GetTradeAgency(arg_2_0)
	return arg_2_0.tradeAgency
end

function var_0_0.GetActivityNpcAgency(arg_3_0)
	return arg_3_0.activityNpcAgency
end

function var_0_0.GetFollowerAgency(arg_4_0)
	return arg_4_0.followerAgency
end

function var_0_0.GetAccessAgency(arg_5_0)
	return arg_5_0.accessAgency
end

function var_0_0.IsPrivate(arg_6_0)
	return false
end

function var_0_0.GetVisitorAgency(arg_7_0)
	return arg_7_0.visitorAgency
end

function var_0_0.GetAgoraAgency(arg_8_0)
	return arg_8_0.agoraAgency
end

function var_0_0.GetCharacterAgency(arg_9_0)
	return arg_9_0.characterAgency
end

function var_0_0.GetTechnologyAgency(arg_10_0)
	return arg_10_0.technologyAgency
end

function var_0_0.GetAblityAgency(arg_11_0)
	return arg_11_0.ablityAgency
end

function var_0_0.GetSignInAgency(arg_12_0)
	return arg_12_0.signInAgency
end

function var_0_0.GetTaskAgency(arg_13_0)
	return arg_13_0.taskAgency
end

function var_0_0.GetCheaterTavernAgency(arg_14_0)
	return arg_14_0.cheaterTavernAgency
end

function var_0_0.GetManageAgency(arg_15_0)
	return arg_15_0.manageAgency
end

function var_0_0.GetWildCollectAgency(arg_16_0)
	return arg_16_0.gatherCollectAgency
end

function var_0_0.GetBuildingAgency(arg_17_0)
	return arg_17_0.buildingAgency
end

function var_0_0.SetSpawnPointId(arg_18_0, arg_18_1)
	arg_18_0.spawnPointId = arg_18_1

	return
end

function var_0_0.GetSpawnPointId(arg_19_0)
	arg_19_0.spawnPointId = nil

	return arg_19_0.spawnPointId
end

function var_0_0.SetLastExitPosition(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_1 <= 0 then
		return
	end

	arg_20_0.lastExitPosition = {
		mapId = arg_20_1,
		position = arg_20_2,
		rotation = arg_20_3
	}

	return
end

function var_0_0.GetLastExitPosition(arg_21_0)
	return arg_21_0.lastExitPosition
end

function var_0_0.GetMapId(arg_22_0)
	return arg_22_0.mapID
end

function var_0_0.SetMapId(arg_23_0, arg_23_1)
	if not pg.island_map[arg_23_1] then
		return
	end

	local var_23_0 = pg.TimeMgr.GetInstance()

	if not var_23_0:inTime(pg.island_map[arg_23_1].time) then
		return
	end

	arg_23_0.mapID = arg_23_1

	return
end

function var_0_0.GetUnlockBuildingList(arg_24_0)
	if arg_24_0:IsMaxLevel() then
		return {}
	end

	return pg.island_level[arg_24_0.level].island_level_award
end

function var_0_0.IsNew(arg_25_0)
	return arg_25_0.name == ""
end

function var_0_0.CanModifyName(arg_26_0)
	return true
end

function var_0_0.SetName(arg_27_0, arg_27_1)
	arg_27_0.name = arg_27_1

	return
end

function var_0_0.GetName(arg_28_0)
	if arg_28_0.name == "" then
		return i18n("island_default_name", getProxy(PlayerProxy):getRawData().name)
	else
		return arg_28_0.name
	end

	return
end

function var_0_0.SetManifesto(arg_29_0, arg_29_1)
	arg_29_0.manifesto = arg_29_1

	return
end

function var_0_0.GetManifesto(arg_30_0)
	return arg_30_0.manifesto
end

function var_0_0.AddExp(arg_31_0, arg_31_1)
	if arg_31_0:IsMaxLevel() then
		return
	end

	arg_31_0.exp = arg_31_0.exp + arg_31_1

	return
end

function var_0_0.Upgrade(arg_32_0)
	if arg_32_0:IsMaxLevel() then
		return
	end

	if arg_32_0:CanLevelUp() then
		arg_32_0.exp = arg_32_0:IsMaxLevel() and 0 or arg_32_0.exp - arg_32_0:GetTargeExp()

		arg_32_0:LevelUp()
	end

	return
end

function var_0_0.LevelUp(arg_33_0)
	arg_33_0.level = arg_33_0.level + 1
	arg_33_0.configId = arg_33_0.level

	return
end

function var_0_0.GetTargeExp(arg_34_0)
	assert(pg.island_level[arg_34_0.level])

	return pg.island_level[arg_34_0.level].island_exp
end

function var_0_0.CanLevelUp(arg_35_0)
	if arg_35_0:IsMaxLevel() then
		return false
	end

	return arg_35_0:GetTargeExp() <= arg_35_0.exp
end

function var_0_0.IsMaxLevel(arg_36_0)
	return pg.island_level.all[#pg.island_level.all] <= arg_36_0.level
end

function var_0_0.StaticIsMaxLevel(arg_37_0, arg_37_1)
	return arg_37_1 >= pg.island_level.all[#pg.island_level.all]
end

function var_0_0.GetLevel(arg_38_0)
	return arg_38_0.level
end

function var_0_0.GetExp(arg_39_0)
	return arg_39_0.exp
end

function var_0_0.GetUpgradeAwardsByLevel(arg_40_0, arg_40_1)
	if arg_40_0:StaticIsMaxLevel(arg_40_1) then
		return {}
	end

	local var_40_0 = pg.island_level[arg_40_1]

	assert(pg.island_level[arg_40_1])

	for iter_40_0, iter_40_1 in ipairs(var_40_0.island_level_award) do
		table.insert({}, {
			DROP_TYPE_ISLAND_ITEM,
			iter_40_1[1],
			iter_40_1[2]
		})
	end

	return {}
end

function var_0_0.GetUpgradeAwards(arg_41_0)
	return (arg_41_0:GetUpgradeAwardsByLevel(arg_41_0.level))
end

function var_0_0.AddProsperity(arg_42_0, arg_42_1)
	if not arg_42_0:CanAddProsperity() then
		return
	end

	arg_42_0.prosperity = arg_42_0.prosperity + arg_42_1

	return
end

function var_0_0.CanAddProsperity(arg_43_0)
	return pg.island_prosperity[arg_43_0:GetMaxProsperityLevel()].prosperity > arg_43_0.prosperity
end

function var_0_0.GetProsperity(arg_44_0)
	return arg_44_0.prosperity
end

function var_0_0.GetMaxProsperityLevel(arg_45_0)
	return pg.island_prosperity.all[#pg.island_prosperity.all]
end

function var_0_0.GetTargetProsperityByLevel(arg_46_0, arg_46_1)
	assert(pg.island_prosperity[arg_46_1])

	return pg.island_prosperity[arg_46_1].prosperity
end

function var_0_0.GetTargetProsperity(arg_47_0)
	local var_47_0 = arg_47_0:GetProsperity()

	for iter_47_0, iter_47_1 in ipairs(pg.island_prosperity.all) do
		local var_47_1 = arg_47_0:GetTargetProsperityByLevel(iter_47_1)

		if var_47_0 < var_47_1 then
			return var_47_1
		end
	end

	return 0
end

function var_0_0.GetProsperityLevel(arg_48_0)
	local var_48_0 = arg_48_0:GetProsperity()

	for iter_48_0, iter_48_1 in ipairs(pg.island_prosperity.all) do
		if var_48_0 < arg_48_0:GetTargetProsperityByLevel(iter_48_1) then
			return iter_48_1
		end
	end

	return arg_48_0:GetMaxProsperityLevel()
end

function var_0_0.CanGetProsperityAwards(arg_49_0, arg_49_1)
	if arg_49_0:IsReceiveProsperityAwards(arg_49_1) then
		return false
	end

	local var_49_0 = pg.island_prosperity[arg_49_1]

	if not pg.island_prosperity[arg_49_1] then
		return false
	end

	return var_49_0.prosperity <= arg_49_0:GetProsperity()
end

function var_0_0.AnyProsperityAwardCanGet(arg_50_0)
	for iter_50_0, iter_50_1 in ipairs(pg.island_prosperity.all) do
		if arg_50_0:CanGetProsperityAwards(iter_50_1) then
			return true
		end
	end

	return false
end

function var_0_0.IsReceiveProsperityAwards(arg_51_0, arg_51_1)
	return arg_51_0.prosperityList[arg_51_1] == true
end

function var_0_0.ReceiveProsperityAwards(arg_52_0, arg_52_1)
	arg_52_0.prosperityList[arg_52_1] = true

	return
end

function var_0_0.GetProsperityAward(arg_53_0, arg_53_1)
	return pg.island_prosperity[arg_53_1].award_display
end

function var_0_0.getConfig(arg_54_0, arg_54_1)
	return pg.island_level[arg_54_0.configId][arg_54_1]
end

function var_0_0.UpdatePerDay(arg_55_0)
	arg_55_0:GetSignInAgency():ResetSignInCnt()
	arg_55_0:GetAccessAgency():ResetFreshInviteCodeFlag()
	arg_55_0:GetCharacterAgency():ResetShipSkillUsed()

	return
end

function var_0_0.UpdatePerSecond(arg_56_0)
	if arg_56_0.buildingAgency then
		arg_56_0.buildingAgency:UpdatePerSecond()
	end

	return
end

function var_0_0.UpdatePerHour(arg_57_0, arg_57_1)
	arg_57_0:GetTradeAgency():UpdatePerHour(arg_57_1)

	return
end

return var_0_0
