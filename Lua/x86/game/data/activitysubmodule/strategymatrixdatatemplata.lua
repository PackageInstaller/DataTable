StrategyMatrixConst = {
	NODE_STATE = {
		COMPLETE = 2,
		INVALID = 3,
		CURRENT = 1,
		SELECT = 4,
		STATELESS = 5
	}
}
StrategyMatrixTools = {}

function StrategyMatrixTools.GetCoinItem(arg_1_0)
	local var_1_0 = StrategyMatrixCfg[arg_1_0]
	local var_1_1 = var_1_0 and var_1_0.setting_template_id
	local var_1_2 = ActivityMatrixSettingTemplateCfg.get_id_list_by_template_id[var_1_1]

	if var_1_2 then
		for iter_1_0, iter_1_1 in ipairs(var_1_2) do
			if ActivityMatrixSettingTemplateCfg[iter_1_1].type == 15 then
				return ActivityMatrixSettingTemplateCfg[iter_1_1].value[1] or 0
			end
		end
	end

	return 26
end

function StrategyMatrixTools.GetGameTipKey(arg_2_0)
	local var_2_0 = ActivityTools.GetActivityTheme(arg_2_0)

	if var_2_0 == ActivityConst.THEME.VOLUME_DOWN then
		return "ACTIVITY_STRATEGY_MATRIX_DESCRIBE"
	elseif var_2_0 == ActivityConst.THEME.DREAM then
		return "ACTIVITY_THOR_STRATEGY_MATRIX_DESCRIBE"
	elseif var_2_0 == ActivityConst.THEME.ACTIVITY_2_1 then
		return "ACTIVITY_ROGUELIKE_DESCRIBE_" .. ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1
	elseif var_2_0 == ActivityConst.THEME.ACTIVITY_2_6 then
		return "ACTIVITY_ROGUELIKE_DESCRIBE_" .. ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6
	elseif var_2_0 == ActivityConst.THEME.ACTIVITY_3_5 then
		return "ACTIVITY_ROGUELIKE_3_5_DESCRIBE" .. ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5
	end

	return ""
end

StrategyMatrixHeroTemplate = class("StrategyMatrixHeroTemplate")

function StrategyMatrixHeroTemplate.Ctor(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.activity_id = arg_3_1
	arg_3_0.hero_id = arg_3_2
	arg_3_0.heroStandardId = arg_3_3
	arg_3_0.health_point = 0
	arg_3_0.max_health_point = 0
	arg_3_0.astrolabe_list = {}
	arg_3_0.equip_list = {}
	arg_3_0.weapon_servant = 0
	arg_3_0.buff_list = {}
	arg_3_0.astrolabe_count_list = {}
	arg_3_0.astrolabe_effect_list = nil
end

function StrategyMatrixHeroTemplate.InitData(arg_4_0, arg_4_1)
	arg_4_0.health_point = arg_4_1.health_point
	arg_4_0.max_health_point = arg_4_1.max_health_point
	arg_4_0.astrolabe_list = {}
	arg_4_0.astrolabe_count_list = {}
	arg_4_0.astrolabe_effect_list = nil

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.astrolabe_list) do
		table.insert(arg_4_0.astrolabe_list, iter_4_1)

		local var_4_0 = MatrixItemCfg[iter_4_1]
		local var_4_1 = var_4_0 and var_4_0.params[1]

		if not arg_4_0.astrolabe_count_list[var_4_1] then
			arg_4_0.astrolabe_count_list[var_4_1] = 0
		end

		arg_4_0.astrolabe_count_list[var_4_1] = arg_4_0.astrolabe_count_list[var_4_1] + 1
	end

	table.sort(arg_4_0.astrolabe_list, function(arg_5_0, arg_5_1)
		return arg_5_0 < arg_5_1
	end)

	arg_4_0.equip_list = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.equip_list) do
		table.insert(arg_4_0.equip_list, iter_4_3)
	end

	table.sort(arg_4_0.equip_list, function(arg_6_0, arg_6_1)
		return arg_6_0 < arg_6_1
	end)

	arg_4_0.weapon_servant = arg_4_1.weapon_servant
	arg_4_0.effect_list = {}

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.effect_list) do
		table.insert(arg_4_0.effect_list, iter_4_5)
	end

	arg_4_0.totalDamage_ = arg_4_1.total_damage or 0
	arg_4_0.totalHurt_ = arg_4_1.total_injured or 0
	arg_4_0.totalHeal_ = arg_4_1.total_heal or 0
end

function StrategyMatrixHeroTemplate.GetAstrolabeNum(arg_7_0, arg_7_1)
	return arg_7_0.astrolabe_count_list[arg_7_1] or 0
end

function StrategyMatrixHeroTemplate.GetStandardId(arg_8_0)
	return arg_8_0.heroStandardId
end

function StrategyMatrixHeroTemplate.GetAstrolabeList(arg_9_0)
	return arg_9_0.astrolabe_list
end

function StrategyMatrixHeroTemplate.GetAstrolabeEffectList(arg_10_0)
	if arg_10_0.astrolabe_effect_list then
		return arg_10_0.astrolabe_effect_list
	end

	arg_10_0.astrolabe_effect_list = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.astrolabe_count_list) do
		local var_10_0 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_10_0]

		if var_10_0 then
			for iter_10_2 = 1, iter_10_1 do
				table.insert(arg_10_0.astrolabe_effect_list, var_10_0[iter_10_2])
			end
		end
	end

	return arg_10_0.astrolabe_effect_list
end

function StrategyMatrixHeroTemplate.GetEquipList(arg_11_0)
	return arg_11_0.equip_list
end

function StrategyMatrixHeroTemplate.GetEquipEffectList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.equip_list) do
		local var_12_1 = MatrixItemCfg[iter_12_1]
		local var_12_2 = var_12_1 and var_12_1.params[1]

		table.insert(var_12_0, var_12_2)
	end

	return var_12_0
end

function StrategyMatrixHeroTemplate.GetWeaponServant(arg_13_0)
	return arg_13_0.weapon_servant
end

function StrategyMatrixHeroTemplate.GetWeaponServantEffect(arg_14_0)
	local var_14_0 = MatrixItemCfg[arg_14_0.weapon_servant]

	return var_14_0 and var_14_0.params[1] or 0
end

function StrategyMatrixHeroTemplate.GetWeaponServantEffectLevel(arg_15_0)
	return StrategyMatrixData:GetWeaponServantLevel() or 1
end

function StrategyMatrixHeroTemplate.IsDead(arg_16_0)
	return arg_16_0.health_point <= 0
end

function StrategyMatrixHeroTemplate.GetHeroHP(arg_17_0)
	return arg_17_0.health_point
end

function StrategyMatrixHeroTemplate.GetHeroMaxHP(arg_18_0)
	return arg_18_0.max_health_point
end

function StrategyMatrixHeroTemplate.GetEffectCount(arg_19_0, arg_19_1)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.effect_list) do
		if arg_19_1 == iter_19_1 then
			var_19_0 = var_19_0 + 1
		end
	end

	return var_19_0
end

function StrategyMatrixHeroTemplate.GetIsOwnerHero(arg_20_0)
	return false
end

StrategyMatrixPhaseTemplate = class("StrategyMatrixPhaseTemplate")

function StrategyMatrixPhaseTemplate.Ctor(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.activity_id = arg_21_1
	arg_21_0.phase_id = arg_21_2.phase_id

	local var_21_0 = arg_21_2.event

	arg_21_0.cur_event_id = var_21_0.event_id
	arg_21_0.envent_params = {}

	for iter_21_0, iter_21_1 in ipairs(var_21_0.params) do
		table.insert(arg_21_0.envent_params, iter_21_1)
	end

	local var_21_1 = arg_21_2.reward

	arg_21_0.reward_items = {}

	for iter_21_2, iter_21_3 in ipairs(var_21_1.matrix_item_id_list) do
		table.insert(arg_21_0.reward_items, iter_21_3)
	end

	arg_21_0.give_up_item_id = var_21_1.give_up_matrix_item_id
end

function StrategyMatrixPhaseTemplate.GetPhase(arg_22_0)
	return arg_22_0.phase_id
end

function StrategyMatrixPhaseTemplate.GetParams(arg_23_0)
	if MatrixConst.PHASE_TYPE.ACTION == arg_23_0.phase_id then
		return {
			arg_23_0.cur_event_id
		}
	elseif MatrixConst.PHASE_TYPE.REWARD == arg_23_0.phase_id then
		return arg_23_0.reward_items
	else
		return {}
	end
end

function StrategyMatrixPhaseTemplate.GetData(arg_24_0)
	local var_24_0 = StrategyMatrixEventTemplateCfg[arg_24_0.cur_event_id]

	if MatrixConst.EVENT_TYPE.SHOP == var_24_0.event_type then
		local var_24_1 = arg_24_0.envent_params[1]
		local var_24_2 = {}
		local var_24_3 = #arg_24_0.envent_params

		for iter_24_0 = 2, var_24_3 do
			local var_24_4 = arg_24_0.envent_params[iter_24_0]

			if var_24_4 and var_24_4 ~= 0 then
				local var_24_5 = MatrixItemCfg[var_24_4].price[1]
				local var_24_6 = var_24_5[1]
				local var_24_7 = var_24_5[2]
				local var_24_8 = 1
				local var_24_9 = iter_24_0 - 1

				if var_24_9 == 1 then
					var_24_8 = 1 - StrategyMatrixData:GetFirstGoodsDiscount(arg_24_0.activity_id) / 1000

					local var_24_10 = var_24_7 * StrategyMatrixData:GetFirstGoodsDiscount(arg_24_0.activity_id) / 1000

					var_24_7 = math.floor(var_24_7 - var_24_10)
				end

				table.insert(var_24_2, {
					index = var_24_9,
					id = var_24_4,
					discount = var_24_8,
					priceId = var_24_6,
					priceNum = var_24_7,
					priceOriginal = var_24_5[2]
				})
			end
		end

		return var_24_1, var_24_2
	else
		return arg_24_0.envent_params[1] or 0
	end
end

function StrategyMatrixPhaseTemplate.GetShops(arg_25_0)
	return {}
end

function StrategyMatrixPhaseTemplate.GetGiveUpItemId(arg_26_0)
	return arg_26_0.give_up_item_id or 0
end

StrategyMartixUserTemplata = class("StrategyMartixUserTemplata")

function StrategyMartixUserTemplata.Ctor(arg_27_0, arg_27_1)
	arg_27_0:SetData(arg_27_1)

	arg_27_0.battle_hero_id_list_cache = nil
end

function StrategyMartixUserTemplata.SetData(arg_28_0, arg_28_1)
	arg_28_0.activity_id = arg_28_1.activity_id
	arg_28_0.roguelike_score = arg_28_1.score

	local var_28_0 = arg_28_1.matrix

	arg_28_0.game_state = var_28_0.game_state

	local var_28_1 = var_28_0.best_performance

	arg_28_0.success_times = var_28_1.success_times
	arg_28_0.min_clear_time = var_28_1.min_clear_time

	local var_28_2 = var_28_0.progress

	arg_28_0:UpdateProcess(var_28_2)
end

function StrategyMartixUserTemplata.UpdateProcess(arg_29_0, arg_29_1)
	if MatrixConst.STATE_TYPE.NOTSTARTED == arg_29_0.game_state then
		return
	end

	arg_29_0.tier_id = arg_29_1.tier_id
	arg_29_0.artifact_list = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_1.artifact_list) do
		local var_29_0 = iter_29_1.id
		local var_29_1 = iter_29_1.wins

		table.insert(arg_29_0.artifact_list, {
			id = var_29_0,
			wins = var_29_1
		})
	end

	arg_29_0.phase = StrategyMatrixPhaseTemplate.New(arg_29_0.activity_id, arg_29_1.phase)
	arg_29_0.matrix_hero_net_rec = {}
	arg_29_0.matrix_hero_id_net_rec = {}

	for iter_29_2, iter_29_3 in ipairs(arg_29_1.hero_list) do
		local var_29_2 = iter_29_3.hero_id
		local var_29_3 = HeroStandardSystemCfg[var_29_2]

		if var_29_3 then
			local var_29_4 = var_29_3.hero_id
			local var_29_5 = StrategyMatrixHeroTemplate.New(arg_29_0.activity_id, var_29_4, var_29_2)

			var_29_5:InitData(iter_29_3)

			arg_29_0.matrix_hero_net_rec[var_29_4] = var_29_5

			table.insert(arg_29_0.matrix_hero_id_net_rec, var_29_4)
		end
	end

	arg_29_0.custom_affix_id_list = {}

	for iter_29_4, iter_29_5 in ipairs(arg_29_1.custom_affix_id_list) do
		table.insert(arg_29_0.custom_affix_id_list, iter_29_5)
	end

	arg_29_0.attribute_list = {}

	for iter_29_6, iter_29_7 in ipairs(arg_29_1.attribute_list) do
		local var_29_6 = iter_29_7.id
		local var_29_7 = iter_29_7.value

		arg_29_0.attribute_list[var_29_6] = var_29_7
	end

	arg_29_0.stackable_item_list = {}

	for iter_29_8, iter_29_9 in ipairs(arg_29_1.stackable_item_list) do
		arg_29_0.stackable_item_list[iter_29_9.stackable_item_type] = iter_29_9.stackable_item_num
	end

	local var_29_8 = arg_29_1.map

	arg_29_0.map_id = var_29_8.map_id
	arg_29_0.node_list = {}

	for iter_29_10, iter_29_11 in ipairs(var_29_8.node_list) do
		local var_29_9 = iter_29_11.id

		arg_29_0.node_list[var_29_9] = {
			event_id = iter_29_11.event_id,
			state = iter_29_11.state
		}
	end

	arg_29_0.effect_list = {}

	for iter_29_12, iter_29_13 in ipairs(arg_29_1.effect_list) do
		local var_29_10 = iter_29_13.id
		local var_29_11 = iter_29_13.level

		table.insert(arg_29_0.effect_list, {
			id = var_29_10,
			level = var_29_11
		})
	end
end

function StrategyMartixUserTemplata.GetMatrixCoint(arg_30_0)
	return arg_30_0.stackable_item_list and arg_30_0.stackable_item_list[1] or 0
end

function StrategyMartixUserTemplata.GetIsClearance(arg_31_0)
	if arg_31_0.success_times == nil then
		return false
	end

	return arg_31_0.success_times > 0
end

function StrategyMartixUserTemplata.GetMapId(arg_32_0)
	return arg_32_0.map_id
end

function StrategyMartixUserTemplata.GetNodeList(arg_33_0)
	return arg_33_0.node_list
end

function StrategyMartixUserTemplata.GetEffectList(arg_34_0)
	return arg_34_0.effect_list or {}
end

function StrategyMartixUserTemplata.RoguelikeScore(arg_35_0)
	return arg_35_0.roguelike_score or 0
end
