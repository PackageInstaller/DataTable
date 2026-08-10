require("game.data.ActivitySubmodule.ActivityMatrixDataTemplata")

local var_0_0 = singletonClass("MatrixData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
	var_0_5 = {}
end

function var_0_0.InitMatrixClue(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	var_0_3[var_2_0] = {}

	local var_2_1 = arg_2_1.clue_list

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		table.insert(var_0_3[var_2_0], {
			source_id = iter_2_1.source_id,
			clue_id = iter_2_1.clue_id
		})
	end
end

function var_0_0.InitMatrixUser(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activity_id

	if var_0_1[var_3_0] then
		var_0_1[var_3_0]:SetData(arg_3_1)
	else
		var_0_1[var_3_0] = ActivityMartixUserTemplata.New(arg_3_1)
	end

	manager.notify:Invoke(ACTIVITY_MATRIX_PROCESS_CHANGE)
end

function var_0_0.InitMatrixOver(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.activity_id

	if var_0_2[var_4_0] then
		var_0_2[var_4_0]:SetData(arg_4_1)

		return
	end

	var_0_2[var_4_0] = ActivityMartixOverTemplata.New(arg_4_1)
end

function var_0_0.UpdateMatrixProcess(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not var_0_1[arg_5_1] then
		return
	end

	var_0_1[arg_5_1].game_state = arg_5_2

	var_0_1[arg_5_1]:UpdateProcess(arg_5_3)
	manager.notify:Invoke(ACTIVITY_MATRIX_PROCESS_CHANGE)
end

function var_0_0.GetMatrixData(arg_6_0, arg_6_1)
	return var_0_1[arg_6_1]
end

function var_0_0.GetGameState(arg_7_0, arg_7_1)
	return var_0_1[arg_7_1].game_state
end

function var_0_0.GetMatrixPhaseData(arg_8_0, arg_8_1)
	return var_0_1[arg_8_1].phase
end

function var_0_0.GetIsClearance(arg_9_0, arg_9_1)
	if not var_0_1[arg_9_1] then
		return true
	end

	return var_0_1[arg_9_1]:GetIsClearance()
end

function var_0_0.GetMatrixHeroTeam(arg_10_0, arg_10_1)
	return var_0_1[arg_10_1].matrix_hero_id_net_rec
end

function var_0_0.GetMatrixBattleHeroTeam(arg_11_0, arg_11_1)
	return var_0_1[arg_11_1].battle_hero_id_list_cache or var_0_1[arg_11_1].matrix_hero_id_net_rec
end

function var_0_0.SetMatrixBattleHeroTeam(arg_12_0, arg_12_1, arg_12_2)
	var_0_1[arg_12_1].battle_hero_id_list_cache = arg_12_2
end

function var_0_0.GetHeroData(arg_13_0, arg_13_1, arg_13_2)
	return var_0_1[arg_13_1].matrix_hero_net_rec[arg_13_2]
end

function var_0_0.GetTierID(arg_14_0, arg_14_1)
	return var_0_1[arg_14_1].tier_id
end

function var_0_0.GetArtifactList(arg_15_0, arg_15_1)
	return var_0_1[arg_15_1].artifact_list
end

function var_0_0.GetCustomAffix(arg_16_0, arg_16_1)
	return var_0_1[arg_16_1].custom_affix_id_list
end

function var_0_0.GetHeroSkin(arg_17_0, arg_17_1, arg_17_2)
	return HeroTools.HeroUsingSkinInfo(arg_17_2).id
end

function var_0_0.GetCurrentClearTime(arg_18_0, arg_18_1)
	return var_0_2[arg_18_1].currentClearTime_
end

function var_0_0.GetMinClearTime(arg_19_0, arg_19_1)
	return var_0_2[arg_19_1].minClearTime_
end

function var_0_0.GetMatrixCurrencyList(arg_20_0, arg_20_1)
	return var_0_2[arg_20_1].currencyList_
end

function var_0_0.GetMatrixOverPoint(arg_21_0, arg_21_1)
	return var_0_2[arg_21_1].point
end

function var_0_0.GetMatrixIsFirstClear(arg_22_0, arg_22_1)
	return var_0_2[arg_22_1].success_times == 1
end

function var_0_0.GetWeaponServantLevel(arg_23_0, arg_23_1)
	return var_0_1[arg_23_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.WEAPON_LEVEL] or 0
end

function var_0_0.GetHeroEquipMaxCount(arg_24_0, arg_24_1)
	return var_0_1[arg_24_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.MAX_EQUIP_COUNT] or 0
end

function var_0_0.GetAstrolabeMaxCount(arg_25_0, arg_25_1)
	return var_0_1[arg_25_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.MAX_ASTROLABE_COUNT] or 0
end

function var_0_0.GetShoRefreshTimes(arg_26_0, arg_26_1)
	return var_0_1[arg_26_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_REFRESH_TIMES] or 0
end

function var_0_0.GetShopFressRefreshTimes(arg_27_0, arg_27_1)
	return var_0_1[arg_27_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_FRESS_REFRESH_TIMES] or 0
end

function var_0_0.GetFirstGoodsDiscount(arg_28_0, arg_28_1)
	return var_0_1[arg_28_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_FIRST_GOODS_DISCOUNT] or 1
end

function var_0_0.GetCanChangeCaptain(arg_29_0, arg_29_1)
	if var_0_1[arg_29_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.CHANGE_TEAM_LEADER] == 1 then
		return true
	end

	return false
end

function var_0_0.GetScoreAddition(arg_30_0, arg_30_1)
	local var_30_0 = var_0_1[arg_30_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SCORE_ADDITION]

	if not var_30_0 then
		return 0
	end

	return var_30_0 / 1000
end

function var_0_0.GetGiveUpRewardAddition(arg_31_0, arg_31_1)
	local var_31_0 = var_0_1[arg_31_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.GIVE_UP_REWARD_ADDITION]

	if not var_31_0 then
		return 0
	end

	return var_31_0 / 1000
end

function var_0_0.GetRaceEffect(arg_32_0, arg_32_1)
	return false
end

function var_0_0.GetAffixList(arg_33_0, arg_33_1)
	if var_0_1[arg_33_1] then
		local var_33_0 = {}
		local var_33_1 = var_0_1[arg_33_1].custom_affix_id_list

		for iter_33_0, iter_33_1 in ipairs(var_33_1) do
			local var_33_2 = ActivityAffixPoolCfg[iter_33_1]

			if var_33_2 then
				table.insert(var_33_0, var_33_2.affix)
			end
		end

		return var_33_0
	end

	return {}
end

function var_0_0.GetArtifactAffixList(arg_34_0, arg_34_1)
	if var_0_1[arg_34_1] then
		local var_34_0 = {}
		local var_34_1 = var_0_1[arg_34_1].artifact_list

		for iter_34_0, iter_34_1 in ipairs(var_34_1) do
			local var_34_2 = iter_34_1.id
			local var_34_3 = iter_34_1.wins
			local var_34_4 = MatrixItemCfg[var_34_2]

			if var_34_4 then
				local var_34_5 = var_34_4.params[1]
				local var_34_6 = MatrixTools.GetAffixByEffectId(var_34_5, var_34_3)

				if var_34_6 then
					table.insert(var_34_0, var_34_6)
				end
			end
		end

		return var_34_0
	end

	return {}
end

function var_0_0.GetInitAffixList(arg_35_0, arg_35_1)
	local var_35_0 = {}

	if ActivityMatrixCfg[arg_35_1] then
		local var_35_1 = ActivityMatrixCfg[arg_35_1].init_effect_template_id
		local var_35_2 = ActivityMatrixInitEffectTemplateCfg[var_35_1].effect_list

		for iter_35_0, iter_35_1 in pairs(var_35_2) do
			local var_35_3 = MatrixTools.GetAffixByEffectId(iter_35_1)

			if var_35_3 then
				table.insert(var_35_0, var_35_3)
			end
		end
	end

	return var_35_0
end

function var_0_0.GetTotalAffix(arg_36_0, arg_36_1)
	local var_36_0 = {}

	table.insertto(var_36_0, arg_36_0:GetAffixList(arg_36_1))
	table.insertto(var_36_0, arg_36_0:GetArtifactAffixList(arg_36_1))
	table.insertto(var_36_0, arg_36_0:GetInitAffixList(arg_36_1))

	return var_36_0
end

function var_0_0.CalMatrixAttribute(arg_37_0, arg_37_1)
	local var_37_0 = {}

	if ActivityMatrixCfg[arg_37_1] then
		local var_37_1 = ActivityMatrixCfg[arg_37_1].init_effect_template_id
		local var_37_2 = ActivityMatrixInitEffectTemplateCfg[var_37_1].effect_list

		for iter_37_0, iter_37_1 in pairs(var_37_2) do
			MatrixTools.GetAttrByEffectId(var_37_0, iter_37_1)
		end
	end

	return var_37_0
end

function var_0_0.GetMatrixCoint(arg_38_0, arg_38_1)
	return var_0_1[arg_38_1] and var_0_1[arg_38_1]:GetMatrixCoint() or 0
end

function var_0_0.GetMatrixScore(arg_39_0, arg_39_1)
	return var_0_1[arg_39_1] and var_0_1[arg_39_1]:GetMatrixScore() or 0
end

function var_0_0.GetMatrixPointRewardState(arg_40_0, arg_40_1, arg_40_2)
	if not var_0_1[arg_40_1] then
		return false
	end

	return table.indexof(var_0_1[arg_40_1].got_reward_list, arg_40_2)
end

function var_0_0.OnReceivePointReward(arg_41_0, arg_41_1, arg_41_2)
	if var_0_1[arg_41_1] then
		var_0_1[arg_41_1]:OnReceivePointReward(arg_41_2)
	end
end

function var_0_0.GetMatrixPointCanReward(arg_42_0, arg_42_1)
	if var_0_1[arg_42_1] then
		local var_42_0 = var_0_1[arg_42_1].point
		local var_42_1 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_42_1] or {}

		for iter_42_0, iter_42_1 in ipairs(var_42_1) do
			if var_42_0 >= ActivityPointRewardCfg[iter_42_1].need and not table.indexof(var_0_1[arg_42_1].got_reward_list, iter_42_1) then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetMainActivityId(arg_43_0, arg_43_1)
	return ActivityConst.VOLUME_MATRIX
end

function var_0_0.GetMatrixClue(arg_44_0, arg_44_1)
	return var_0_3[arg_44_1] or {}
end

function var_0_0.GetMatrixClueCount(arg_45_0, arg_45_1, arg_45_2)
	if not var_0_3[arg_45_1] then
		return 0
	end

	local var_45_0 = 0

	for iter_45_0, iter_45_1 in ipairs(var_0_3[arg_45_1]) do
		if iter_45_1.source_id == arg_45_2 then
			var_45_0 = var_45_0 + 1
		end
	end

	return var_45_0
end

function var_0_0.SetRead(arg_46_0, arg_46_1)
	table.insert(var_0_4, arg_46_1)
end

function var_0_0.GetRead(arg_47_0, arg_47_1)
	return table.indexof(var_0_4, arg_47_1)
end

function var_0_0.SetClueRead(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0:GetReadClueList(arg_48_1)

	if not table.indexof(var_48_0, arg_48_2) then
		table.insert(var_48_0, arg_48_2)
		saveData("AcvityMatrixClue", tostring(arg_48_1), var_48_0)
	end
end

function var_0_0.GetClueRead(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = arg_49_0:GetReadClueList(arg_49_1)

	return table.indexof(var_49_0, arg_49_2)
end

function var_0_0.GetReadClueList(arg_50_0, arg_50_1)
	if not var_0_5[arg_50_1] then
		var_0_5[arg_50_1] = getData("AcvityMatrixClue", tostring(arg_50_1))
	end

	if type(var_0_5[arg_50_1]) ~= "table" then
		var_0_5[arg_50_1] = {}
	end

	return var_0_5[arg_50_1]
end

return var_0_0
