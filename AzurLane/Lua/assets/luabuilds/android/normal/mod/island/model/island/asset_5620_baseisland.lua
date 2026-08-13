class = var_0_10000

local var_0_0 = "BaseIsland"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.IslandDispatcher"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.id = arg_1_1.id

	local var_1_0

	if not arg_1_1.level then
		var_1_0 = 1
	end

	arg_1_0.level = var_1_0
	arg_1_0.configId = arg_1_0.level

	local var_1_1

	if not arg_1_1.exp then
		var_1_1 = 0
	end

	arg_1_0.exp = var_1_1

	local var_1_2

	if not arg_1_1.name then
		var_1_2 = "1"
	end

	arg_1_0.name = var_1_2

	local var_1_3

	if not arg_1_1.prosperity then
		var_1_3 = 0
	end

	arg_1_0.prosperity = var_1_3

	local var_1_4

	if not arg_1_1.signature then
		var_1_4 = ""
	end

	arg_1_0.manifesto = var_1_4
	arg_1_0.prosperityList = {}
	ipairs = var_2

	local var_1_5

	if not arg_1_1.prosperity_rewarded then
		var_1_5 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_5) do
		arg_1_0.prosperityList[iter_1_1] = true
	end

	IslandAblityAgency = var_2
	arg_1_0.ablityAgency = var_2.New(arg_1_0, arg_1_1)
	IslandCharacterAgency = var_2
	arg_1_0.characterAgency = var_2.New(arg_1_0, arg_1_1)
	IslandVisitorAgency = var_2
	arg_1_0.visitorAgency = var_2.New(arg_1_0, arg_1_1)
	IslandTechnologyAgency = var_2
	arg_1_0.technologyAgency = var_2.New(arg_1_0, arg_1_1)
	IslandSignInAgency = var_2
	arg_1_0.signInAgency = var_2.New(arg_1_0, arg_1_1)
	IslandTaskAgency = var_2
	arg_1_0.taskAgency = var_2.New(arg_1_0, arg_1_1)
	IslandAccessAgency = var_2
	arg_1_0.accessAgency = var_2.New(arg_1_0, arg_1_1)
	IslandGatherCollectAgency = var_2
	arg_1_0.gatherCollectAgency = var_2.New(arg_1_0, arg_1_1)
	IslandBuildingAgency = var_2
	arg_1_0.buildingAgency = var_2.New(arg_1_0, arg_1_1)
	IslandFollowerAgency = var_2
	arg_1_0.followerAgency = var_2.New(arg_1_0)
	IslandActivityNpcAgency = var_2
	arg_1_0.activityNpcAgency = var_2.New(arg_1_0)
	IslandTradegency = var_2
	arg_1_0.tradeAgency = var_2.New(arg_1_0, arg_1_1)
	IslandAgoraAgency = var_2
	arg_1_0.agoraAgency = var_2.New(arg_1_0, arg_1_1)
	IslandManageAgecny = var_2
	arg_1_0.manageAgency = var_2.New(arg_1_0, arg_1_1)
	IslandCheaterTavernAgency = var_2
	arg_1_0.cheaterTavernAgency = var_2.New(arg_1_0)
	pg = var_2
	arg_1_0.mapID = var_2.island_set.initial_scene.key_value_int

	local var_1_6 = {
		mapId = 0
	}

	Vector3 = var_3
	var_1_6.position = var_3.zero
	Vector3 = var_3
	var_1_6.rotation = var_3.zero
	arg_1_0.lastExitPosition = var_1_6

	local var_1_7 = arg_1_0.taskAgency
	local var_1_8 = var_2.IsFinishTask

	IslandGuideChecker = var_4

	if not var_1_8(var_1_7, var_4.MOVE_TASK_ID) then
		local var_1_9 = arg_1_0
		local var_1_10 = arg_1_0.SetSpawnPointId

		pg = var_4

		var_1_10(var_1_9, var_4.island_set.initial_spawn_point.key_value_int)
	end

	return
end

function var_0_1.GetTradeAgency(arg_2_0)
	return arg_2_0.tradeAgency
end

function var_0_1.GetActivityNpcAgency(arg_3_0)
	return arg_3_0.activityNpcAgency
end

function var_0_1.GetFollowerAgency(arg_4_0)
	return arg_4_0.followerAgency
end

function var_0_1.GetAccessAgency(arg_5_0)
	return arg_5_0.accessAgency
end

function var_0_1.IsPrivate(arg_6_0)
	return false
end

function var_0_1.GetVisitorAgency(arg_7_0)
	return arg_7_0.visitorAgency
end

function var_0_1.GetAgoraAgency(arg_8_0)
	return arg_8_0.agoraAgency
end

function var_0_1.GetCharacterAgency(arg_9_0)
	return arg_9_0.characterAgency
end

function var_0_1.GetTechnologyAgency(arg_10_0)
	return arg_10_0.technologyAgency
end

function var_0_1.GetAblityAgency(arg_11_0)
	return arg_11_0.ablityAgency
end

function var_0_1.GetSignInAgency(arg_12_0)
	return arg_12_0.signInAgency
end

function var_0_1.GetTaskAgency(arg_13_0)
	return arg_13_0.taskAgency
end

function var_0_1.GetCheaterTavernAgency(arg_14_0)
	return arg_14_0.cheaterTavernAgency
end

function var_0_1.GetManageAgency(arg_15_0)
	return arg_15_0.manageAgency
end

function var_0_1.GetWildCollectAgency(arg_16_0)
	return arg_16_0.gatherCollectAgency
end

function var_0_1.GetBuildingAgency(arg_17_0)
	return arg_17_0.buildingAgency
end

function var_0_1.SetSpawnPointId(arg_18_0, arg_18_1)
	arg_18_0.spawnPointId = arg_18_1

	return
end

function var_0_1.GetSpawnPointId(arg_19_0)
	local var_19_0 = arg_19_0.spawnPointId

	arg_19_0.spawnPointId = nil

	return var_19_0
end

function var_0_1.SetLastExitPosition(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
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

function var_0_1.GetLastExitPosition(arg_21_0)
	return arg_21_0.lastExitPosition
end

function var_0_1.GetMapId(arg_22_0)
	return arg_22_0.mapID
end

function var_0_1.SetMapId(arg_23_0, arg_23_1)
	pg = var_1_10002

	if not var_1_10002.island_map[arg_23_1] then
		return
	end

	pg = var_1_10003

	local var_23_0 = var_1_10003.TimeMgr.GetInstance()

	if not var_3.inTime(var_23_0, var_2.time) then
		return
	end

	arg_23_0.mapID = arg_23_1

	return
end

function var_0_1.GetUnlockBuildingList(arg_24_0)
	if arg_24_0:IsMaxLevel() then
		return {}
	end

	pg = var_1

	return var_1.island_level[arg_24_0.level].island_level_award
end

function var_0_1.IsNew(arg_25_0)
	return arg_25_0.name == ""
end

function var_0_1.CanModifyName(arg_26_0)
	return true
end

function var_0_1.SetName(arg_27_0, arg_27_1)
	arg_27_0.name = arg_27_1

	return
end

function var_0_1.GetName(arg_28_0)
	if arg_28_0.name == "" then
		getProxy = var_1
		PlayerProxy = var_1_10002

		local var_28_0 = var_1(var_1_10002)
		local var_28_1 = var_1.getRawData(var_28_0).name

		i18n = var_28_0

		return var_28_0("island_default_name", var_28_1)
	else
		return arg_28_0.name
	end

	return
end

function var_0_1.SetManifesto(arg_29_0, arg_29_1)
	arg_29_0.manifesto = arg_29_1

	return
end

function var_0_1.GetManifesto(arg_30_0)
	return arg_30_0.manifesto
end

function var_0_1.AddExp(arg_31_0, arg_31_1)
	if arg_31_0:IsMaxLevel() then
		return
	end

	arg_31_0.exp = arg_31_0.exp + arg_31_1

	return
end

function var_0_1.Upgrade(arg_32_0)
	if arg_32_0:IsMaxLevel() then
		return
	end

	if arg_32_0:CanLevelUp() then
		arg_32_0.exp = arg_32_0:IsMaxLevel() and 0 or arg_32_0.exp - arg_32_0:GetTargeExp()

		arg_32_0:LevelUp()
	end

	return
end

function var_0_1.LevelUp(arg_33_0)
	arg_33_0.level = arg_33_0.level + 1
	arg_33_0.configId = arg_33_0.level

	return
end

function var_0_1.GetTargeExp(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.island_level[arg_34_0.level]

	assert = var_2

	var_2(var_34_0)

	return var_34_0.island_exp
end

function var_0_1.CanLevelUp(arg_35_0)
	if arg_35_0:IsMaxLevel() then
		return false
	end

	return arg_35_0:GetTargeExp() <= arg_35_0.exp
end

function var_0_1.IsMaxLevel(arg_36_0)
	pg = var_1_10001

	local var_36_0 = #var_1_10001.island_level.all

	pg = var_1_10003

	return var_1_10003.island_level.all[var_36_0] <= arg_36_0.level
end

function var_0_1.StaticIsMaxLevel(arg_37_0, arg_37_1)
	pg = var_1_10002

	local var_37_0 = #var_1_10002.island_level.all

	pg = var_1_10004

	return arg_37_1 >= var_1_10004.island_level.all[var_37_0]
end

function var_0_1.GetLevel(arg_38_0)
	return arg_38_0.level
end

function var_0_1.GetExp(arg_39_0)
	return arg_39_0.exp
end

function var_0_1.GetUpgradeAwardsByLevel(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0

	if arg_40_0.StaticIsMaxLevel(var_40_0, arg_40_1) then
		return {}
	end

	pg = var_2

	local var_40_1 = var_2.island_level[arg_40_1]

	assert = var_40_0

	var_40_0(var_40_1)

	local var_40_2 = {}

	ipairs = var_4

	for iter_40_0, iter_40_1 in var_4(var_40_1.island_level_award) do
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_40_3 = var_40_2
		local var_40_4 = {}

		DROP_TYPE_ISLAND_ITEM = var_1_10012
		var_40_4[1] = var_1_10012
		var_40_4[2] = iter_40_1[1]
		var_40_4[3] = iter_40_1[2]

		var_1_10009(var_40_3, var_40_4)
	end

	return var_40_2
end

function var_0_1.GetUpgradeAwards(arg_41_0)
	return (arg_41_0:GetUpgradeAwardsByLevel(arg_41_0.level))
end

function var_0_1.AddProsperity(arg_42_0, arg_42_1)
	if not arg_42_0:CanAddProsperity() then
		return
	end

	arg_42_0.prosperity = arg_42_0.prosperity + arg_42_1

	return
end

function var_0_1.CanAddProsperity(arg_43_0)
	local var_43_0 = arg_43_0
	local var_43_1 = arg_43_0.GetMaxProsperityLevel(var_43_0)

	pg = var_43_0

	return var_43_0.island_prosperity[var_43_1].prosperity > arg_43_0.prosperity
end

function var_0_1.GetProsperity(arg_44_0)
	return arg_44_0.prosperity
end

function var_0_1.GetMaxProsperityLevel(arg_45_0)
	pg = var_1_10001

	return var_1[#var_1_10001.island_prosperity.all]
end

function var_0_1.GetTargetProsperityByLevel(arg_46_0, arg_46_1)
	assert = var_1_10002
	pg = var_1_10003

	var_1_10002(var_1_10003.island_prosperity[arg_46_1])

	pg = var_1_10002

	return var_1_10002.island_prosperity[arg_46_1].prosperity
end

function var_0_1.GetTargetProsperity(arg_47_0)
	local var_47_0 = 0
	local var_47_1 = arg_47_0
	local var_47_2 = arg_47_0.GetProsperity(var_47_1)

	ipairs = var_47_1
	pg = var_1_10004

	for iter_47_0, iter_47_1 in var_47_1(var_1_10004.island_prosperity.all) do
		if var_47_2 < arg_47_0:GetTargetProsperityByLevel(iter_47_1) then
			return var_8
		end
	end

	return var_47_0
end

function var_0_1.GetProsperityLevel(arg_48_0)
	local var_48_0 = arg_48_0
	local var_48_1 = arg_48_0.GetProsperity(var_48_0)

	ipairs = var_48_0
	pg = var_1_10003

	for iter_48_0, iter_48_1 in var_48_0(var_1_10003.island_prosperity.all) do
		if var_48_1 < arg_48_0:GetTargetProsperityByLevel(iter_48_1) then
			return iter_48_1
		end
	end

	return arg_48_0:GetMaxProsperityLevel()
end

function var_0_1.CanGetProsperityAwards(arg_49_0, arg_49_1)
	if arg_49_0:IsReceiveProsperityAwards(arg_49_1) then
		return false
	end

	pg = var_2

	if not var_2.island_prosperity[arg_49_1] then
		return false
	end

	return var_2.prosperity <= arg_49_0:GetProsperity()
end

function var_0_1.AnyProsperityAwardCanGet(arg_50_0)
	ipairs = var_1_10001
	pg = var_1_10002

	for iter_50_0, iter_50_1 in var_1_10001(var_1_10002.island_prosperity.all) do
		if arg_50_0:CanGetProsperityAwards(iter_50_1) then
			return true
		end
	end

	return false
end

function var_0_1.IsReceiveProsperityAwards(arg_51_0, arg_51_1)
	return arg_51_0.prosperityList[arg_51_1] == true
end

function var_0_1.ReceiveProsperityAwards(arg_52_0, arg_52_1)
	arg_52_0.prosperityList[arg_52_1] = true

	return
end

function var_0_1.GetProsperityAward(arg_53_0, arg_53_1)
	pg = var_1_10002

	return var_1_10002.island_prosperity[arg_53_1].award_display
end

function var_0_1.getConfig(arg_54_0, arg_54_1)
	pg = var_1_10002

	return var_1_10002.island_level[arg_54_0.configId][arg_54_1]
end

function var_0_1.UpdatePerDay(arg_55_0)
	local var_55_0 = arg_55_0:GetSignInAgency()

	var_1.ResetSignInCnt(var_55_0)

	local var_55_1 = arg_55_0:GetAccessAgency()

	var_1.ResetFreshInviteCodeFlag(var_55_1)

	local var_55_2 = arg_55_0:GetCharacterAgency()

	var_1.ResetShipSkillUsed(var_55_2)

	return
end

function var_0_1.UpdatePerSecond(arg_56_0)
	if arg_56_0.buildingAgency then
		local var_56_0 = arg_56_0.buildingAgency

		var_1.UpdatePerSecond(var_56_0)
	end

	return
end

function var_0_1.UpdatePerHour(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0:GetTradeAgency()

	var_2.UpdatePerHour(var_57_0, arg_57_1)

	return
end

return var_0_1
