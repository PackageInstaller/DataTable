require("game.data.MatrixDataTemplate")

local var_0_0 = {}
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = 0
local var_0_8 = 0
local var_0_9 = {}
local var_0_10 = {}
local var_0_11 = 0
local var_0_12
local var_0_13 = {}
local var_0_14 = {}
local var_0_15 = {}
local var_0_16 = {}
local var_0_17
local var_0_18 = {}
local var_0_19 = {}
local var_0_20
local var_0_21 = 0
local var_0_22 = 0
local var_0_23 = 0
local var_0_24 = 0
local var_0_25 = {}
local var_0_26 = 0
local var_0_27 = {}
local var_0_28 = 0
local var_0_29 = singletonClass("MatrixData")

function var_0_29.Init(arg_1_0)
	var_0_0 = {}
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = 0
	var_0_4 = 1
	var_0_5 = {}
	var_0_6 = {}
	var_0_7 = 0
	var_0_8 = 0
	var_0_9 = {}
	var_0_10 = {}
	var_0_11 = 0
	var_0_12 = nil
	var_0_13 = {}
	var_0_14 = {}
	var_0_15 = {}
	var_0_16 = {}
	var_0_17 = nil
	var_0_18 = {}
	var_0_19 = {}
	var_0_20 = nil
	var_0_21 = {}
	var_0_22 = 0
	var_0_23 = 0
	var_0_24 = 0
	var_0_26 = 0
	var_0_27 = {}
end

function var_0_29.InitMatrixSystem(arg_2_0, arg_2_1)
	var_0_0 = {}
	var_0_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.ready_hero_list) do
		local var_2_0 = iter_2_1.hero_standard_id
		local var_2_1 = iter_2_1.skin_id
		local var_2_2 = HeroStandardSystemCfg[var_2_0]

		table.insert(var_0_0, var_2_0)

		var_0_1[var_2_2.hero_id] = var_2_1
	end

	var_0_2 = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.difficulty_list) do
		local var_2_3 = MatrixDifficultyTemplate.New(iter_2_3)

		table.insert(var_0_2, var_2_3)
	end

	var_0_3 = arg_2_1.next_refresh_timestamp
end

function var_0_29.InitMatrixUser(arg_3_0, arg_3_1)
	var_0_4 = arg_3_1.game_state

	MatrixData:UpdateTerminalLevel()

	var_0_5 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.point_reward_list) do
		local var_3_0 = {
			rank = iter_3_1.rank,
			item_list = {}
		}

		for iter_3_2 = 1, #iter_3_1.item_list do
			local var_3_1 = iter_3_1.item_list[iter_3_2]

			table.insert(var_3_0.item_list, {
				item_id = var_3_1.item_id,
				item_num = var_3_1.item_num
			})
		end

		var_3_0.is_got_reward = iter_3_1.is_got_reward
		var_3_0.need_level = iter_3_1.need_level

		table.insert(var_0_5, var_3_0)
	end

	MatrixTools.UpdateSortScoreList()

	var_0_9 = {}

	for iter_3_3, iter_3_4 in ipairs(arg_3_1.terminal.gift_list) do
		var_0_9[iter_3_4.id] = iter_3_4.level
	end

	var_0_6 = {}

	for iter_3_5, iter_3_6 in ipairs(arg_3_1.unlocked_beacon_id_list) do
		table.insert(var_0_6, iter_3_6)
	end

	if MatrixConst.STATE_TYPE.NOTSTARTED == var_0_4 then
		return
	end

	local var_3_2 = arg_3_1.current_progress

	if var_3_2 then
		var_0_11 = var_3_2.tier_id
		var_0_13 = {}

		for iter_3_7, iter_3_8 in ipairs(var_3_2.artifact_list) do
			local var_3_3 = iter_3_8.id
			local var_3_4 = iter_3_8.wins

			table.insert(var_0_13, {
				id = var_3_3,
				wins = var_3_4
			})
		end

		var_0_17 = MatrixDifficultyTemplate.New(var_3_2.difficulty)
		var_0_12 = MatrixPhaseTemplate.New(var_3_2.phase, var_0_17.price_template_id)
		var_0_19 = {}
		var_0_18 = {}

		for iter_3_9, iter_3_10 in ipairs(var_3_2.hero_list) do
			local var_3_5 = iter_3_10.hero_id
			local var_3_6 = HeroStandardSystemCfg[var_3_5]

			if var_3_6 then
				local var_3_7 = var_3_6.hero_id
				local var_3_8

				if var_0_17.difficulty == 3 then
					var_3_8 = MatrixOwnerHeroTemplate.New(var_3_7, var_3_5)
				else
					var_3_8 = MatrixHeroTemplate.New(var_3_7, var_3_5)
				end

				var_3_8:InitData(iter_3_10)

				var_0_19[var_3_7] = var_3_8

				table.insert(var_0_18, var_3_7)
			end
		end

		var_0_14 = {}

		for iter_3_11, iter_3_12 in ipairs(var_3_2.custom_affix_id_list) do
			table.insert(var_0_14, iter_3_12)
		end

		var_0_15 = {}

		for iter_3_13, iter_3_14 in ipairs(var_3_2.attribute_list) do
			local var_3_9 = iter_3_14.id
			local var_3_10 = iter_3_14.value

			var_0_15[var_3_9] = var_3_10
		end

		var_0_16 = {}

		for iter_3_15, iter_3_16 in ipairs(var_3_2.beacon_id_list) do
			table.insert(var_0_16, iter_3_16)
		end

		var_0_10 = {}

		for iter_3_17, iter_3_18 in ipairs(var_3_2.current_terminal.gift_list) do
			var_0_10[iter_3_18.id] = iter_3_18.level
		end
	end
end

function var_0_29.MatrixOverData(arg_4_0, arg_4_1)
	var_0_21 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.currency_list) do
		var_0_21[iter_4_1.id] = iter_4_1.num
	end

	var_0_22 = arg_4_1.clear_time
	var_0_23 = arg_4_1.min_clear_time or arg_4_1.clear_time
	var_0_24 = arg_4_1.difficulty_complete_times
	var_0_25 = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.evaluate_id_list) do
		table.insert(var_0_25, iter_4_3)
	end

	if #var_0_25 > 1 then
		table.sort(var_0_25, function(arg_5_0, arg_5_1)
			return MatrixEvaluateCfg[arg_5_0].value > MatrixEvaluateCfg[arg_5_1].value
		end)
	end

	var_0_26 = arg_4_1.score
end

function var_0_29.UpdateTerminalLevel(arg_6_0)
	local var_6_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_MATRIX_TERMINAL_EXP)

	var_0_7, var_0_8 = MatrixTools.MatrixExpToLevel(var_6_0)
end

function var_0_29.GetGameState(arg_7_0)
	return var_0_4
end

function var_0_29.GetMatrixPhaseData(arg_8_0)
	return var_0_12
end

function var_0_29.GetMatrixHeroTeam(arg_9_0)
	return var_0_18
end

function var_0_29.GetMatrixBattleHeroTeam(arg_10_0)
	return var_0_20 or var_0_18
end

function var_0_29.SetMatrixBattleHeroTeam(arg_11_0, arg_11_1)
	var_0_20 = arg_11_1
end

function var_0_29.GetHeroData(arg_12_0, arg_12_1)
	return var_0_19[arg_12_1]
end

function var_0_29.GetTierID(arg_13_0)
	return var_0_11
end

function var_0_29.GetDifficulty(arg_14_0)
	return var_0_17.difficulty
end

function var_0_29.GetDifficultyData(arg_15_0)
	return var_0_17
end

function var_0_29.GetArtifactList(arg_16_0)
	return var_0_13
end

function var_0_29.GetCustomAffix(arg_17_0)
	return var_0_14
end

function var_0_29.GetPointRewardList(arg_18_0)
	return var_0_5
end

function var_0_29.GetTerminalLevel(arg_19_0)
	return var_0_7
end

function var_0_29.GetTerminalExp(arg_20_0)
	return var_0_8
end

function var_0_29.GetTerminalGift(arg_21_0)
	return var_0_9
end

function var_0_29.GetCurrentTerminalGifi(arg_22_0)
	return var_0_10
end

function var_0_29.SetTerminalGift(arg_23_0, arg_23_1)
	var_0_9 = arg_23_1
end

function var_0_29.GetBeaconIsLock(arg_24_0, arg_24_1)
	return not table.indexof(var_0_6, arg_24_1)
end

function var_0_29.GetUnlockBeaconList(arg_25_0)
	return var_0_6
end

function var_0_29.GetUseBeaconList(arg_26_0)
	return var_0_16
end

function var_0_29.GetChipManagerID(arg_27_0)
	return var_0_17:GetChipManagerID()
end

function var_0_29.GetChipList(arg_28_0)
	return var_0_17:GetChipIDList()
end

function var_0_29.GetTierScore(arg_29_0, arg_29_1)
	if arg_29_1 == nil then
		arg_29_1 = var_0_11
	end

	local var_29_0 = MatrixTierCfg[arg_29_1]

	if var_29_0 then
		local var_29_1 = var_29_0.level_reward[arg_29_0:GetDifficulty()]

		if var_29_1 then
			local var_29_2 = arg_29_0:GetAffixDifficultyRate()
			local var_29_3 = arg_29_0:GetScoreAddition()
			local var_29_4 = var_29_1 * (1 + var_29_2 + var_29_3)

			return math.floor(var_29_4)
		end
	end

	return 0
end

function var_0_29.GetAffixDifficultyRate(arg_30_0)
	local var_30_0 = 0
	local var_30_1 = MatrixData:GetDifficultyData():GetRegularAffix()
	local var_30_2 = MatrixData:GetCustomAffix()

	for iter_30_0, iter_30_1 in ipairs(var_30_1) do
		var_30_0 = var_30_0 + ActivityAffixPoolCfg[iter_30_1].multiple
	end

	for iter_30_2, iter_30_3 in ipairs(var_30_2) do
		var_30_0 = var_30_0 + ActivityAffixPoolCfg[iter_30_3].multiple
	end

	return var_30_0 / 1000
end

function var_0_29.GetReadyHeroList(arg_31_0)
	return var_0_0
end

function var_0_29.GetHeroSkin(arg_32_0, arg_32_1)
	local var_32_0 = HeroData:GetHeroData(arg_32_1)
	local var_32_1 = var_32_0 and var_32_0.using_skin or 0

	if var_32_1 == 0 then
		var_32_1 = arg_32_1
	end

	return var_32_1
end

function var_0_29.GetReadyDifficultyData(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in pairs(var_0_2) do
		if iter_33_1:GetDifficulty() == arg_33_1 then
			return iter_33_1
		end
	end

	error("cant find Matrix Difficulty id :" .. arg_33_1)

	return nil
end

function var_0_29.GetNextRefreshTime(arg_34_0)
	return var_0_3
end

function var_0_29.GetEvaluateList(arg_35_0)
	return var_0_25
end

function var_0_29.GetCurrentClearTime(arg_36_0)
	return var_0_22
end

function var_0_29.GetMinClearTime(arg_37_0)
	return var_0_23
end

function var_0_29.GetMatrixCurrencyList(arg_38_0)
	return var_0_21
end

function var_0_29.GetDifficultyClearTime(arg_39_0)
	return var_0_24
end

function var_0_29.GetMatrixOverScore(arg_40_0)
	return var_0_26
end

function var_0_29.GetWeaponServantLevel(arg_41_0)
	return var_0_15[MatrixConst.MATRIX_ATTRIBUTE_TYPE.WEAPON_LEVEL] or 0
end

function var_0_29.GetHeroEquipMaxCount(arg_42_0)
	return var_0_15[MatrixConst.MATRIX_ATTRIBUTE_TYPE.MAX_EQUIP_COUNT] or 0
end

function var_0_29.GetAstrolabeMaxCount(arg_43_0)
	return var_0_15[MatrixConst.MATRIX_ATTRIBUTE_TYPE.MAX_ASTROLABE_COUNT] or 0
end

function var_0_29.GetShoRefreshTimes(arg_44_0)
	return var_0_15[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_REFRESH_TIMES] or 0
end

function var_0_29.GetShopFressRefreshTimes(arg_45_0)
	return var_0_15[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_FRESS_REFRESH_TIMES] or 0
end

function var_0_29.GetFirstGoodsDiscount(arg_46_0)
	return var_0_15[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_FIRST_GOODS_DISCOUNT] or 1
end

function var_0_29.GetCanChangeCaptain(arg_47_0)
	if var_0_15[MatrixConst.MATRIX_ATTRIBUTE_TYPE.CHANGE_TEAM_LEADER] == 1 then
		return true
	end

	return false
end

function var_0_29.GetScoreAddition(arg_48_0)
	local var_48_0 = var_0_15[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SCORE_ADDITION]

	if not var_48_0 then
		return 0
	end

	return var_48_0 / 1000
end

function var_0_29.GetGiveUpRewardAddition(arg_49_0)
	local var_49_0 = var_0_15[MatrixConst.MATRIX_ATTRIBUTE_TYPE.GIVE_UP_REWARD_ADDITION]

	if not var_49_0 then
		return 0
	end

	return var_49_0 / 1000
end

function var_0_29.GetRaceEffect(arg_50_0)
	local var_50_0 = {}

	for iter_50_0, iter_50_1 in pairs(var_0_16) do
		if iter_50_1 == 12 then
			return true
		end
	end

	return false
end

function var_0_29.GetAffixList(arg_51_0)
	if var_0_17 then
		local var_51_0 = {}
		local var_51_1 = var_0_17:GetRegularAffix()

		for iter_51_0, iter_51_1 in ipairs(var_51_1) do
			local var_51_2 = ActivityAffixPoolCfg[iter_51_1]

			if var_51_2 then
				table.insert(var_51_0, var_51_2.affix)
			end
		end

		for iter_51_2, iter_51_3 in ipairs(var_0_14) do
			local var_51_3 = ActivityAffixPoolCfg[iter_51_3]

			if var_51_3 then
				table.insert(var_51_0, var_51_3.affix)
			end
		end

		return var_51_0
	end

	return {}
end

function var_0_29.GetArtifactAffixList(arg_52_0)
	local var_52_0 = {}

	for iter_52_0, iter_52_1 in ipairs(var_0_13) do
		local var_52_1 = iter_52_1.id
		local var_52_2 = iter_52_1.wins
		local var_52_3 = MatrixItemCfg[var_52_1]

		if var_52_3 then
			local var_52_4 = var_52_3.params[1]
			local var_52_5 = MatrixTools.GetAffixByEffectId(var_52_4, var_52_2)

			if var_52_5 then
				table.insert(var_52_0, var_52_5)
			end
		end
	end

	return var_52_0
end

function var_0_29.GetBeaconAffixList(arg_53_0)
	local var_53_0 = {}

	for iter_53_0, iter_53_1 in pairs(var_0_16) do
		local var_53_1 = MatrixBeaconCfg[iter_53_1]

		if var_53_1 then
			for iter_53_2, iter_53_3 in ipairs(var_53_1.effect_id_list) do
				local var_53_2 = MatrixTools.GetAffixByEffectId(iter_53_3)

				if var_53_2 then
					table.insert(var_53_0, var_53_2)
				end
			end
		end
	end

	return var_53_0
end

function var_0_29.GetTerminalAffixList(arg_54_0)
	local var_54_0 = {}

	for iter_54_0, iter_54_1 in pairs(var_0_10) do
		local var_54_1 = MatrixTerminalGiftCfg[iter_54_0]

		if var_54_1 then
			local var_54_2 = var_54_1.effect_id_list[iter_54_1]
			local var_54_3 = MatrixTools.GetAffixByEffectId(var_54_2)

			if var_54_3 then
				table.insert(var_54_0, var_54_3)
			end
		end
	end

	return var_54_0
end

function var_0_29.GetTotalAffix(arg_55_0)
	local var_55_0 = {}

	table.insertto(var_55_0, arg_55_0:GetAffixList())
	table.insertto(var_55_0, arg_55_0:GetArtifactAffixList())
	table.insertto(var_55_0, arg_55_0:GetBeaconAffixList())
	table.insertto(var_55_0, arg_55_0:GetTerminalAffixList())

	return var_55_0
end

function var_0_29.CalMatrixAttribute(arg_56_0)
	local var_56_0 = {}

	for iter_56_0, iter_56_1 in pairs(var_0_10) do
		local var_56_1 = MatrixTerminalGiftCfg[iter_56_0]

		if var_56_1 then
			local var_56_2 = var_56_1.effect_id_list[iter_56_1]

			MatrixTools.GetAttrByEffectId(var_56_0, var_56_2)
		end
	end

	for iter_56_2, iter_56_3 in pairs(var_0_16) do
		local var_56_3 = MatrixBeaconCfg[iter_56_3]

		if var_56_3 then
			for iter_56_4, iter_56_5 in ipairs(var_56_3.effect_id_list) do
				MatrixTools.GetAttrByEffectId(var_56_0, iter_56_5)
			end
		end
	end

	return var_56_0
end

function var_0_29.CalMatrixSelectHeroAttribute(arg_57_0)
	local var_57_0 = {}

	for iter_57_0, iter_57_1 in pairs(var_0_9) do
		local var_57_1 = MatrixTerminalGiftCfg[iter_57_0]

		if var_57_1 then
			local var_57_2 = var_57_1.effect_id_list[iter_57_1]

			MatrixTools.GetAttrByEffectId(var_57_0, var_57_2)
		end
	end

	return var_57_0
end

function var_0_29.GetCacheCustomAffix(arg_58_0)
	return var_0_27
end

function var_0_29.SetCacheCustomAffix(arg_59_0, arg_59_1)
	var_0_27 = arg_59_1
end

local var_0_30

function var_0_29.SetBattleTier(arg_60_0, arg_60_1)
	var_0_30 = arg_60_1
end

function var_0_29.GetBattleTier(arg_61_0)
	return var_0_30
end

return var_0_29
