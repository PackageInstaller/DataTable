require("game.data.ActivitySubmodule.StrategyMatrixDataTemplata")

local var_0_0 = singletonClass("StrategyMatrixData", BaseHeroViewData)
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5
local var_0_6 = 0

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_4 = {}
	var_0_5 = nil
end

function var_0_0.InitMatrixUser(arg_2_0, arg_2_1)
	var_0_6 = arg_2_1.activity_id

	local var_2_0 = arg_2_1.activity_id

	if var_0_1[var_2_0] then
		var_0_1[var_2_0]:SetData(arg_2_1)
	else
		var_0_1[var_2_0] = StrategyMartixUserTemplata.New(arg_2_1)
	end

	manager.notify:Invoke(ACTIVITY_MATRIX_PROCESS_CHANGE)
end

function var_0_0.UpdateMatrixProcess(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not var_0_1[arg_3_1] then
		return
	end

	var_0_1[arg_3_1].game_state = arg_3_2

	var_0_1[arg_3_1]:UpdateProcess(arg_3_3)
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

function var_0_0.GetMatrixData(arg_5_0)
	return var_0_1[var_0_6]
end

function var_0_0.SetActivityId(arg_6_0, arg_6_1)
	var_0_6 = arg_6_1
end

function var_0_0.GetActivityId(arg_7_0)
	return var_0_6
end

function var_0_0.GetGameState(arg_8_0, arg_8_1)
	return var_0_1[arg_8_1].game_state
end

function var_0_0.GetMatrixPhaseData(arg_9_0, arg_9_1)
	return var_0_1[arg_9_1].phase
end

function var_0_0.GetIsClearance(arg_10_0, arg_10_1)
	if not var_0_1[arg_10_1] then
		return false
	end

	return var_0_1[arg_10_1]:GetIsClearance()
end

function var_0_0.GetMatrixHeroTeam(arg_11_0, arg_11_1)
	return var_0_1[arg_11_1].matrix_hero_id_net_rec
end

function var_0_0.GetMatrixBattleHeroTeam(arg_12_0, arg_12_1)
	return var_0_1[arg_12_1].battle_hero_id_list_cache or var_0_1[arg_12_1].matrix_hero_id_net_rec
end

function var_0_0.SetMatrixBattleHeroTeam(arg_13_0, arg_13_1, arg_13_2)
	var_0_1[arg_13_1].battle_hero_id_list_cache = arg_13_2
end

function var_0_0.GetHeroTeam(arg_14_0)
	local var_14_0 = {
		0,
		0,
		0
	}
	local var_14_1 = {
		false,
		false,
		false
	}
	local var_14_2 = {}
	local var_14_3 = {
		0,
		0,
		0
	}
	local var_14_4 = false

	return var_0_0.GetHeroIDList(), var_14_1, var_14_2, var_14_3, var_14_4
end

function var_0_0.GetHeroData(arg_15_0, arg_15_1)
	local var_15_0 = var_0_1[var_0_6].matrix_hero_net_rec[arg_15_1]
	local var_15_1 = var_15_0:GetStandardId()
	local var_15_2 = HeroStandardSystemCfg[var_15_1]
	local var_15_3 = var_15_0.equip_list
	local var_15_4 = {}

	for iter_15_0, iter_15_1 in pairs(var_15_0.astrolabe_count_list) do
		local var_15_5 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_15_0]

		for iter_15_2 = 1, iter_15_1 do
			table.insert(var_15_4, var_15_5[iter_15_2])
		end
	end

	local var_15_6 = {
		uid = 0,
		locked = true,
		id = var_15_0:GetWeaponServantEffect(),
		stage = var_15_0:GetWeaponServantEffectLevel()
	}
	local var_15_7 = SkinCfg[var_15_2.skin_id].hero

	if not var_0_3[var_15_7] then
		var_0_3[var_15_7] = StrategyMatrixHeroDataTemplate.New(var_15_7)
	end

	var_0_3[var_15_7]:Init(var_15_2, var_15_3, var_15_4, var_15_6)

	return var_0_3[var_15_7]
end

function var_0_0.GetHeroDataNew(arg_16_0, arg_16_1)
	return var_0_1[var_0_6].matrix_hero_net_rec[arg_16_1]
end

function var_0_0.GetHeroIDList(arg_17_0)
	return var_0_1[var_0_6].matrix_hero_id_net_rec
end

function var_0_0.GetEquipDataList(arg_18_0, arg_18_1)
	return arg_18_0:GetHeroData(arg_18_1).equip_list
end

function var_0_0.GetEquipDataListNew(arg_19_0, arg_19_1)
	return arg_19_0:GetHeroData(arg_19_1).equip_list_data
end

function var_0_0.GetTierID(arg_20_0, arg_20_1)
	return var_0_1[arg_20_1].tier_id
end

function var_0_0.GetArtifactList(arg_21_0, arg_21_1)
	return var_0_1[arg_21_1].artifact_list
end

function var_0_0.GetCustomAffix(arg_22_0, arg_22_1)
	return var_0_1[arg_22_1].custom_affix_id_list
end

function var_0_0.GetHeroSkin(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = HeroData:GetHeroData(arg_23_2)
	local var_23_1 = var_23_0 and var_23_0.using_skin or 0

	if var_23_1 == 0 then
		var_23_1 = arg_23_2
	end

	return var_23_1
end

function var_0_0.GetHeroSkinCfg(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = HeroData:GetHeroData(arg_24_2)
	local var_24_1 = var_24_0 and var_24_0.using_skin or 0

	if var_24_1 == 0 then
		var_24_1 = arg_24_2
	end

	return SkinCfg[var_24_1]
end

function var_0_0.GetCurrentClearTime(arg_25_0, arg_25_1)
	return var_0_2[arg_25_1].currentClearTime_
end

function var_0_0.GetMinClearTime(arg_26_0, arg_26_1)
	return var_0_2[arg_26_1].minClearTime_
end

function var_0_0.GetMatrixCurrencyList(arg_27_0, arg_27_1)
	return var_0_2[arg_27_1].currencyList_
end

function var_0_0.GetMatrixOverPoint(arg_28_0, arg_28_1)
	return var_0_2[arg_28_1].point
end

function var_0_0.GetMatrixIsFirstClear(arg_29_0, arg_29_1)
	return not var_0_2[arg_29_1].success_times == 0
end

function var_0_0.GetWeaponServantLevel(arg_30_0)
	return var_0_1[var_0_6].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.WEAPON_LEVEL] or 0
end

function var_0_0.GetHeroEquipMaxCount(arg_31_0)
	return var_0_1[var_0_6].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.MAX_EQUIP_COUNT] or 0
end

function var_0_0.GetAstrolabeMaxCount(arg_32_0, arg_32_1)
	return var_0_1[arg_32_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.MAX_ASTROLABE_COUNT] or 0
end

function var_0_0.GetShoRefreshTimes(arg_33_0, arg_33_1)
	return var_0_1[arg_33_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_REFRESH_TIMES] or 0
end

function var_0_0.GetShopFressRefreshTimes(arg_34_0, arg_34_1)
	return var_0_1[arg_34_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_FRESS_REFRESH_TIMES] or 0
end

function var_0_0.GetFirstGoodsDiscount(arg_35_0, arg_35_1)
	return var_0_1[arg_35_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_FIRST_GOODS_DISCOUNT] or 1
end

function var_0_0.GetCanChangeCaptain(arg_36_0, arg_36_1)
	if var_0_1[arg_36_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.CHANGE_TEAM_LEADER] == 1 then
		return true
	end

	return false
end

function var_0_0.GetScoreAddition(arg_37_0, arg_37_1)
	local var_37_0 = var_0_1[arg_37_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SCORE_ADDITION]

	if not var_37_0 then
		return 0
	end

	return var_37_0 / 1000
end

function var_0_0.GetGiveUpRewardAddition(arg_38_0, arg_38_1)
	local var_38_0 = var_0_1[arg_38_1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.GIVE_UP_REWARD_ADDITION]

	if not var_38_0 then
		return 0
	end

	return var_38_0 / 1000
end

function var_0_0.GetRaceEffect(arg_39_0, arg_39_1)
	return false
end

function var_0_0.GetAffixList(arg_40_0, arg_40_1)
	if var_0_1[arg_40_1] then
		local var_40_0 = {}
		local var_40_1 = var_0_1[arg_40_1].custom_affix_id_list

		for iter_40_0, iter_40_1 in ipairs(var_40_1) do
			local var_40_2 = ActivityAffixPoolCfg[iter_40_1]

			if var_40_2 then
				table.insert(var_40_0, var_40_2.affix)
			end
		end

		return var_40_0
	end

	return {}
end

function var_0_0.GetArtifactAffixList(arg_41_0, arg_41_1)
	if var_0_1[arg_41_1] then
		local var_41_0 = {}
		local var_41_1 = var_0_1[arg_41_1].artifact_list

		for iter_41_0, iter_41_1 in ipairs(var_41_1) do
			local var_41_2 = iter_41_1.id
			local var_41_3 = iter_41_1.wins
			local var_41_4 = MatrixItemCfg[var_41_2]

			if var_41_4 then
				local var_41_5 = var_41_4.params[1]
				local var_41_6 = MatrixTools.GetAffixByEffectId(var_41_5, var_41_3)

				if var_41_6 then
					table.insert(var_41_0, var_41_6)
				end
			end
		end

		return var_41_0
	end

	return {}
end

function var_0_0.GetInitAffixList(arg_42_0, arg_42_1)
	local var_42_0 = {}

	if var_0_1[arg_42_1] then
		local var_42_1 = var_0_1[arg_42_1]:GetEffectList()

		for iter_42_0, iter_42_1 in ipairs(var_42_1) do
			local var_42_2 = MatrixTools.GetAffixByEffectId(iter_42_1.id, iter_42_1.level)

			if var_42_2 then
				table.insert(var_42_0, var_42_2)
			end
		end
	end

	return var_42_0
end

function var_0_0.GetTotalAffix(arg_43_0, arg_43_1)
	local var_43_0 = {}

	table.insertto(var_43_0, arg_43_0:GetAffixList(arg_43_1))
	table.insertto(var_43_0, arg_43_0:GetInitAffixList(arg_43_1))

	return var_43_0
end

function var_0_0.CalMatrixAttribute(arg_44_0, arg_44_1)
	local var_44_0 = {}

	if var_0_1[arg_44_1] then
		local var_44_1 = var_0_1[arg_44_1]:GetEffectList()

		for iter_44_0, iter_44_1 in ipairs(var_44_1) do
			MatrixTools.GetAttrByEffectId(var_44_0, iter_44_1.id)
		end
	end

	return var_44_0
end

function var_0_0.GetMatrixCoint(arg_45_0, arg_45_1)
	return var_0_1[arg_45_1] and var_0_1[arg_45_1]:GetMatrixCoint() or 0
end

function var_0_0.GetMatrixScore(arg_46_0, arg_46_1)
	return var_0_1[arg_46_1] and var_0_1[arg_46_1]:GetMapId() or 0
end

function var_0_0.GetRoguelikeScore(arg_47_0, arg_47_1)
	return var_0_1[arg_47_1] and var_0_1[arg_47_1]:RoguelikeScore() or 0
end

function var_0_0.GetMapId(arg_48_0, arg_48_1)
	return var_0_1[arg_48_1]:GetMapId()
end

function var_0_0.GetNodeList(arg_49_0, arg_49_1)
	return var_0_1[arg_49_1]:GetNodeList()
end

function var_0_0.GetRead(arg_50_0, arg_50_1)
	return getData("STRATEGY_MATRIX_OPEN_RECORD", tostring(arg_50_1)) == 1
end

function var_0_0.SetRead(arg_51_0, arg_51_1)
	saveData("STRATEGY_MATRIX_OPEN_RECORD", tostring(arg_51_1), 1)
end

function var_0_0.SetDifficultySelect(arg_52_0, arg_52_1)
	var_0_5 = arg_52_1

	saveData("StrategyMatrix", "difficulty", var_0_5)
end

function var_0_0.GetDifficultySelect(arg_53_0)
	if var_0_5 then
		return var_0_5
	else
		var_0_5 = getData("StrategyMatrix", "difficulty") or 1

		return var_0_5
	end
end

function var_0_0.GetViewDataType(arg_54_0)
	return arg_54_0.viewDataType
end

return var_0_0
