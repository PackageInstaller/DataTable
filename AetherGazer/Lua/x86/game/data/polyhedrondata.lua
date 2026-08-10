require("game.data.PolyhedronDataTemplate")

local var_0_0 = singletonClass("PolyhedronData", BaseHeroViewData)
local var_0_1 = {}
local var_0_2
local var_0_3
local var_0_4 = 0
local var_0_5 = {}
local var_0_6 = 1
local var_0_7 = 0
local var_0_8 = {}
local var_0_9 = 0
local var_0_10 = {}
local var_0_11 = {}
local var_0_12 = {}
local var_0_13 = {}
local var_0_14 = {}
local var_0_15
local var_0_16 = 0
local var_0_17 = 1
local var_0_18 = {}
local var_0_19 = {}
local var_0_20 = {}
local var_0_21 = 1
local var_0_22 = 0

function var_0_0.Init(arg_1_0)
	var_0_2 = nil
	var_0_3 = nil
	var_0_4 = 0
	var_0_1 = {}
	var_0_5 = {}
	var_0_6 = 1
	var_0_7 = 0
	var_0_8 = {}
	var_0_9 = 0
	var_0_10 = {}
	var_0_12 = {}
	var_0_13 = {}
	var_0_14 = {}
	var_0_15 = 0
	var_0_16 = 0
	var_0_17 = 1
	var_0_18 = {}
	var_0_19 = {}
end

function var_0_0.InitPolyhedronGameData(arg_2_0, arg_2_1)
	var_0_4 = arg_2_1.activity_id

	arg_2_0:UpdateTerminalLevel()

	local var_2_0 = arg_2_1.terminal

	var_0_9 = var_2_0.reset_times
	var_0_8 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0.upgrade_id_list) do
		table.insert(var_0_8, iter_2_1)
	end

	var_0_10 = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.beacon_id_list) do
		table.insert(var_0_10, iter_2_3)
	end

	local var_2_1 = arg_2_1.game

	if not var_0_2 then
		var_0_2 = PolyhedronTemplate.New(var_2_1)
	else
		var_0_2:UpdateGame(var_2_1)
	end

	var_0_20 = var_0_2:GetTipsList()
	var_0_5 = {}

	local var_2_2 = arg_2_1.decision

	for iter_2_4, iter_2_5 in ipairs(var_2_2.apply_id_list) do
		var_0_5[iter_2_5] = true
	end

	var_0_11 = {}
	var_0_12 = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.unlocked_hero_list) do
		local var_2_3 = iter_2_7.hero_id

		table.insert(var_0_11, var_2_3)

		local var_2_4 = {}

		for iter_2_8, iter_2_9 in ipairs(iter_2_7.astrolabe_id_list) do
			table.insert(var_2_4, iter_2_9)
		end

		var_0_12[var_2_3] = var_2_4
	end

	var_0_13 = {}

	for iter_2_10, iter_2_11 in ipairs(arg_2_1.clear_difficulty_list) do
		table.insert(var_0_13, iter_2_11)
	end

	table.sort(var_0_13, function(arg_3_0, arg_3_1)
		return arg_3_1 < arg_3_0
	end)

	local var_2_5 = arg_2_1.manual

	var_0_14 = {}

	for iter_2_12, iter_2_13 in ipairs(var_2_5.sample_list) do
		var_0_14[iter_2_13.id] = iter_2_13.state
	end

	var_0_15 = arg_2_1.already_challenge_times or 0
	var_0_22 = arg_2_1.is_new or 0
end

function var_0_0.GetHeroIDList(arg_4_0)
	local var_4_0 = var_0_0:GetActivityID()
	local var_4_1 = PolyhedronHeroShelvesCfg[var_4_0] and PolyhedronHeroShelvesCfg[var_4_0].leader_hero_id or PolyhedronHeroCfg.all

	if PolyhedronHeroShelvesCfg[var_4_0] then
		return var_4_1
	else
		Debug.LogError(string.format("PolyhedronHeroShelvesCfg%s,无配置,", var_4_0))

		return {}
	end
end

function var_0_0.UpdatePolyhedronProcess(arg_5_0, arg_5_1)
	if var_0_2 then
		var_0_2:UpdateProcess(arg_5_1.progress)
	else
		error("UpdatePolyhedronProcess error")
	end

	var_0_20 = var_0_2:GetTipsList()
end

function var_0_0.ResetCacheTipInfoIndex(arg_6_0)
	var_0_21 = 1
end

function var_0_0.UpdatePolyhedronSettlement(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.end_info

	var_0_3 = {
		point = var_7_0.point,
		decision_exp = var_7_0.decision_exp,
		terminal_exp = var_7_0.terminal_exp
	}
end

function var_0_0.GetPolyhedronInfo(arg_8_0)
	return var_0_2
end

function var_0_0.GetPolyhedronSettlement(arg_9_0)
	return var_0_3
end

function var_0_0.GetClearMaxDifficulty(arg_10_0)
	return var_0_13[1] or 0
end

function var_0_0.UpdateTerminalLevel(arg_11_0)
	local var_11_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_POLYHEDRON_TERMINAL_EXP)

	var_0_6, var_0_7 = PolyhedronTools.PolyhedronTerminalExpToLevel(var_11_0)
end

function var_0_0.GetTerminalLevel(arg_12_0)
	return var_0_6
end

function var_0_0.GetTerminalExp(arg_13_0)
	return var_0_7
end

function var_0_0.GetTerminalGift(arg_14_0)
	return var_0_8
end

function var_0_0.SetTerminalGift(arg_15_0, arg_15_1)
	var_0_8 = arg_15_1
end

function var_0_0.GetResetTimes(arg_16_0)
	return var_0_9
end

function var_0_0.AddUnlockBeacon(arg_17_0, arg_17_1)
	if not table.indexof(var_0_10, arg_17_1) then
		table.insert(var_0_10, arg_17_1)
	end
end

function var_0_0.GetUnlockBeaconList(arg_18_0)
	return var_0_10
end

function var_0_0.GetBeaconIsLock(arg_19_0, arg_19_1)
	return not table.indexof(var_0_10, arg_19_1)
end

function var_0_0.GetBeaconMaxBeaconSelect(arg_20_0)
	local var_20_0 = {
		3001,
		3005,
		3011
	}
	local var_20_1 = 0

	for iter_20_0, iter_20_1 in ipairs(var_0_8) do
		if table.indexof(var_20_0, iter_20_1) then
			var_20_1 = var_20_1 + 1
		end
	end

	return var_20_1
end

function var_0_0.GetArtifaceAtlasState(arg_21_0, arg_21_1)
	return var_0_14[arg_21_1] or 0
end

function var_0_0.GetPolyhedronHeroUnlock(arg_22_0, arg_22_1)
	return table.indexof(var_0_11, arg_22_1)
end

function var_0_0.UnlockHero(arg_23_0, arg_23_1)
	if not table.indexof(var_0_11, arg_23_1) then
		table.insert(var_0_11, arg_23_1)
	end

	arg_23_0:GetHeroData(arg_23_1).unlock = 1
end

function var_0_0.GetUnlockHeroList(arg_24_0)
	return var_0_11
end

function var_0_0.GetHeroData(arg_25_0, arg_25_1)
	local var_25_0 = PolyhedronHeroCfg[arg_25_1].standard_id
	local var_25_1 = HeroStandardSystemCfg[var_25_0]
	local var_25_2 = SkinCfg[var_25_1.skin_id].hero

	if not var_0_1[arg_25_1] then
		var_0_1[arg_25_1] = PolyhedronHeroDataTemplate.New(var_25_2, arg_25_1)

		var_0_1[arg_25_1]:Init(var_25_1, arg_25_1)

		var_0_1[arg_25_1].unlock = not arg_25_0:GetPolyhedronHeroUnlock(arg_25_1) and 0 or 1

		local var_25_3 = arg_25_0:GetUseAstrolabe(var_25_2)

		PolyhedronData:SetUseAstrolabe(var_25_2, var_25_3)
	end

	var_0_1[arg_25_1].using_skin = HeroData:GetHeroData(var_25_2).using_skin

	if var_0_1[arg_25_1].using_skin == 0 then
		var_0_1[arg_25_1].using_skin = var_25_2
	end

	return var_0_1[arg_25_1]
end

function var_0_0.GetPolicyApplyList(arg_26_0)
	return var_0_5
end

function var_0_0.SetPolicyApplyList(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		var_0_5[iter_27_1] = true
	end
end

function var_0_0.GetActivityID(arg_28_0)
	return var_0_4
end

function var_0_0.GetSortRankHeroIDList(arg_29_0)
	local var_29_0 = RankData:GetCommonRankList(RankConst.RANK_ID.POLYHERON)
	local var_29_1 = clone(PolyhedronData.GetHeroIDList())

	table.sort(var_29_1, function(arg_30_0, arg_30_1)
		local var_30_0 = var_29_0[arg_30_0]
		local var_30_1 = var_29_0[arg_30_1]
		local var_30_2 = var_30_0 and var_30_0.score or 0
		local var_30_3 = var_30_1 and var_30_1.score or 0

		if var_30_2 ~= var_30_3 then
			return var_30_3 < var_30_2
		else
			return arg_30_0 < arg_30_1
		end
	end)

	return var_29_1
end

function var_0_0.ResetTerminalCallback(arg_31_0)
	var_0_8 = {}

	manager.notify:Invoke(POLYHEDRON_TERMINAL_RESET, {})
end

function var_0_0.SetCacheSelectHero(arg_32_0, arg_32_1)
	var_0_16 = arg_32_1
end

function var_0_0.GetCacheSelectHero(arg_33_0)
	return var_0_16
end

function var_0_0.SetCacheSelectDifficulty(arg_34_0, arg_34_1)
	var_0_17 = arg_34_1
end

function var_0_0.GetCacheSelectDifficulty(arg_35_0)
	return var_0_17
end

function var_0_0.SetCacheBeaconList(arg_36_0, arg_36_1)
	var_0_18 = arg_36_1
end

function var_0_0.GetCacheBeaconList(arg_37_0)
	return var_0_18
end

function var_0_0.GetStandardId(arg_38_0)
	return 1
end

function var_0_0.GetHeroClicked(arg_39_0, arg_39_1)
	return var_0_19[arg_39_1] or false
end

function var_0_0.SetHeroClicked(arg_40_0, arg_40_1)
	if PolyhedronAction:GetPolyhedronHeroRedPointCount(arg_40_1) > 0 then
		var_0_19[arg_40_1] = true

		PolyhedronAction:RefreshHeroesRedPoint()
	end
end

function var_0_0.GetTipsData(arg_41_0)
	if var_0_20[var_0_21] then
		local var_41_0 = deepClone(var_0_20[var_0_21])

		var_0_21 = var_0_21 + 1

		return var_41_0
	else
		return nil
	end
end

function var_0_0.GetUseAstrolabe(arg_42_0, arg_42_1)
	if var_0_12[arg_42_1] then
		return var_0_12[arg_42_1]
	end

	local var_42_0 = PolyhedronHeroCfg[arg_42_1].standard_id
	local var_42_1 = HeroStandardSystemCfg[var_42_0]

	return var_42_1.astrolabe_id ~= "" and var_42_1.astrolabe_id or {}
end

function var_0_0.SetUseAstrolabe(arg_43_0, arg_43_1, arg_43_2)
	var_0_12[arg_43_1] = arg_43_2
	var_0_1[arg_43_1].using_astrolabe = arg_43_2
end

function var_0_0.GetAlreadyChallengeTimes(arg_44_0)
	return var_0_15
end

function var_0_0.ResetAlreadyChallengeTimes(arg_45_0)
	var_0_15 = 0
end

function var_0_0.GetExFilterSorterFunc(arg_46_0)
	return function(arg_47_0, arg_47_1)
		local var_47_0 = not PolyhedronData:GetPolyhedronHeroUnlock(arg_47_0.id) and 0 or 1
		local var_47_1 = not PolyhedronData:GetPolyhedronHeroUnlock(arg_47_1.id) and 0 or 1
		local var_47_2 = HeroData:GetHeroData(arg_47_0.id).unlock
		local var_47_3 = HeroData:GetHeroData(arg_47_1.id).unlock

		if var_47_0 ~= var_47_1 then
			return true, var_47_1 < var_47_0
		elseif var_47_2 ~= var_47_3 then
			return true, var_47_3 < var_47_2
		end

		return false, false
	end
end

function var_0_0.GetHeroList(arg_48_0)
	return var_0_1
end

function var_0_0.GetEquipDataList(arg_49_0, arg_49_1)
	return arg_49_0:GetHeroData(arg_49_1).equip_list
end

function var_0_0.GetIsNewRed(arg_50_0)
	return var_0_22 == 1
end

function var_0_0.SetNewRedValue(arg_51_0, arg_51_1)
	var_0_22 = arg_51_1
end

function var_0_0.GetHeroUsingSkinInfo(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0:GetHeroData(arg_52_1)
	local var_52_1 = HeroData:GetHeroData(arg_52_1).using_skin or 0

	if var_52_1 == 0 then
		var_52_1 = arg_52_1
	end

	return SkinCfg[var_52_1]
end

function var_0_0.GetHeroBattleUsingSkinInfo(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0:GetHeroData(arg_53_1)
	local var_53_1 = HeroData:GetHeroData(arg_53_1).battle_using_skin or 0

	if var_53_1 == 0 then
		var_53_1 = arg_53_1
	end

	return SkinCfg[var_53_1]
end

return var_0_0
