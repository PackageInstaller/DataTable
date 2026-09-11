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
	if ActivityMatrixSettingTemplateCfg.get_id_list_by_template_id[StrategyMatrixCfg[arg_1_0] and StrategyMatrixCfg[arg_1_0].setting_template_id] then
		for iter_1_0, iter_1_1 in ipairs(ActivityMatrixSettingTemplateCfg.get_id_list_by_template_id[StrategyMatrixCfg[arg_1_0] and StrategyMatrixCfg[arg_1_0].setting_template_id]) do
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

function StrategyMatrixHeroTemplate:InitData(arg_4_1)
	self.health_point = arg_4_1.health_point
	self.max_health_point = arg_4_1.max_health_point
	self.astrolabe_list = {}
	self.astrolabe_count_list = {}
	self.astrolabe_effect_list = nil

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.astrolabe_list) do
		table.insert(self.astrolabe_list, iter_4_1)

		local var_4_0 = MatrixItemCfg[iter_4_1] and MatrixItemCfg[iter_4_1].params[1]

		if not self.astrolabe_count_list[MatrixItemCfg[iter_4_1] and MatrixItemCfg[iter_4_1].params[1]] then
			self.astrolabe_count_list[var_4_0] = 0
		end

		self.astrolabe_count_list[var_4_0] = self.astrolabe_count_list[var_4_0] + 1
	end

	table.sort(self.astrolabe_list, function(arg_5_0, arg_5_1)
		return arg_5_0 < arg_5_1
	end)

	self.equip_list = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.equip_list) do
		table.insert(self.equip_list, iter_4_3)
	end

	table.sort(self.equip_list, function(arg_6_0, arg_6_1)
		return arg_6_0 < arg_6_1
	end)

	self.weapon_servant = arg_4_1.weapon_servant
	self.effect_list = {}

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.effect_list) do
		table.insert(self.effect_list, iter_4_5)
	end

	self.totalDamage_ = arg_4_1.total_damage or 0
	self.totalHurt_ = arg_4_1.total_injured or 0
	self.totalHeal_ = arg_4_1.total_heal or 0
end

function StrategyMatrixHeroTemplate:GetAstrolabeNum(arg_7_1)
	return self.astrolabe_count_list[arg_7_1] or 0
end

function StrategyMatrixHeroTemplate:GetStandardId()
	return self.heroStandardId
end

function StrategyMatrixHeroTemplate:GetAstrolabeList()
	return self.astrolabe_list
end

function StrategyMatrixHeroTemplate:GetAstrolabeEffectList()
	if self.astrolabe_effect_list then
		return self.astrolabe_effect_list
	end

	self.astrolabe_effect_list = {}

	for iter_10_0, iter_10_1 in pairs(self.astrolabe_count_list) do
		if HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_10_0] then
			for iter_10_2 = 1, iter_10_1 do
				table.insert(self.astrolabe_effect_list, HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_10_0][iter_10_2])
			end
		end
	end

	return self.astrolabe_effect_list
end

function StrategyMatrixHeroTemplate:GetEquipList()
	return self.equip_list
end

function StrategyMatrixHeroTemplate:GetEquipEffectList()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self.equip_list) do
		table.insert(var_12_0, MatrixItemCfg[iter_12_1] and MatrixItemCfg[iter_12_1].params[1])
	end

	return var_12_0
end

function StrategyMatrixHeroTemplate:GetWeaponServant()
	return self.weapon_servant
end

function StrategyMatrixHeroTemplate:GetWeaponServantEffect()
	return (MatrixItemCfg[self.weapon_servant] or nil) and (MatrixItemCfg[self.weapon_servant].params[1] or 0)
end

function StrategyMatrixHeroTemplate.GetWeaponServantEffectLevel(arg_15_0)
	return StrategyMatrixData:GetWeaponServantLevel() or 1
end

function StrategyMatrixHeroTemplate:IsDead()
	return self.health_point <= 0
end

function StrategyMatrixHeroTemplate:GetHeroHP()
	return self.health_point
end

function StrategyMatrixHeroTemplate:GetHeroMaxHP()
	return self.max_health_point
end

function StrategyMatrixHeroTemplate:GetEffectCount(arg_19_1)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(self.effect_list) do
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

function StrategyMatrixPhaseTemplate:Ctor(arg_21_1, arg_21_2)
	self.activity_id = arg_21_1
	self.phase_id = arg_21_2.phase_id
	self.cur_event_id = arg_21_2.event.event_id
	self.envent_params = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_2.event.params) do
		table.insert(self.envent_params, iter_21_1)
	end

	self.reward_items = {}

	for iter_21_2, iter_21_3 in ipairs(arg_21_2.reward.matrix_item_id_list) do
		table.insert(self.reward_items, iter_21_3)
	end

	self.give_up_item_id = arg_21_2.reward.give_up_matrix_item_id
end

function StrategyMatrixPhaseTemplate:GetPhase()
	return self.phase_id
end

function StrategyMatrixPhaseTemplate:GetParams()
	if MatrixConst.PHASE_TYPE.ACTION == self.phase_id then
		return {
			self.cur_event_id
		}
	elseif MatrixConst.PHASE_TYPE.REWARD == self.phase_id then
		return self.reward_items
	else
		return {}
	end
end

function StrategyMatrixPhaseTemplate:GetData()
	if MatrixConst.EVENT_TYPE.SHOP == StrategyMatrixEventTemplateCfg[self.cur_event_id].event_type then
		local var_24_0 = {}

		for iter_24_0 = 2, #self.envent_params do
			if self.envent_params[iter_24_0] and self.envent_params[iter_24_0] ~= 0 then
				local var_24_1 = MatrixItemCfg[self.envent_params[iter_24_0]].price[1][2]
				local var_24_2 = 1

				if iter_24_0 - 1 == 1 then
					var_24_2 = 1 - StrategyMatrixData:GetFirstGoodsDiscount(self.activity_id) / 1000
					var_24_1 = math.floor(var_24_1 - var_24_1 * StrategyMatrixData:GetFirstGoodsDiscount(self.activity_id) / 1000)
				end

				table.insert(var_24_0, {
					index = iter_24_0 - 1,
					id = self.envent_params[iter_24_0],
					discount = var_24_2,
					priceId = MatrixItemCfg[self.envent_params[iter_24_0]].price[1][1],
					priceNum = var_24_1,
					priceOriginal = MatrixItemCfg[self.envent_params[iter_24_0]].price[1][2]
				})
			end
		end

		return self.envent_params[1], var_24_0
	else
		return self.envent_params[1] or 0
	end
end

function StrategyMatrixPhaseTemplate.GetShops(arg_25_0)
	return {}
end

function StrategyMatrixPhaseTemplate:GetGiveUpItemId()
	return self.give_up_item_id or 0
end

StrategyMartixUserTemplata = class("StrategyMartixUserTemplata")

function StrategyMartixUserTemplata:Ctor(arg_27_1)
	self:SetData(arg_27_1)

	self.battle_hero_id_list_cache = nil
end

function StrategyMartixUserTemplata:SetData(arg_28_1)
	self.activity_id = arg_28_1.activity_id
	self.roguelike_score = arg_28_1.score
	self.game_state = arg_28_1.matrix.game_state
	self.success_times = arg_28_1.matrix.best_performance.success_times
	self.min_clear_time = arg_28_1.matrix.best_performance.min_clear_time

	self:UpdateProcess(arg_28_1.matrix.progress)
end

function StrategyMartixUserTemplata:UpdateProcess(arg_29_1)
	if MatrixConst.STATE_TYPE.NOTSTARTED == self.game_state then
		return
	end

	self.tier_id = arg_29_1.tier_id
	self.artifact_list = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_1.artifact_list) do
		table.insert(self.artifact_list, {
			id = iter_29_1.id,
			wins = iter_29_1.wins
		})
	end

	self.phase = StrategyMatrixPhaseTemplate.New(self.activity_id, arg_29_1.phase)
	self.matrix_hero_net_rec = {}
	self.matrix_hero_id_net_rec = {}

	for iter_29_2, iter_29_3 in ipairs(arg_29_1.hero_list) do
		if HeroStandardSystemCfg[iter_29_3.hero_id] then
			local var_29_0 = StrategyMatrixHeroTemplate.New(self.activity_id, HeroStandardSystemCfg[iter_29_3.hero_id].hero_id, iter_29_3.hero_id)

			var_29_0:InitData(iter_29_3)

			self.matrix_hero_net_rec[HeroStandardSystemCfg[iter_29_3.hero_id].hero_id] = var_29_0

			table.insert(self.matrix_hero_id_net_rec, HeroStandardSystemCfg[iter_29_3.hero_id].hero_id)
		end
	end

	self.custom_affix_id_list = {}

	for iter_29_4, iter_29_5 in ipairs(arg_29_1.custom_affix_id_list) do
		table.insert(self.custom_affix_id_list, iter_29_5)
	end

	self.attribute_list = {}

	for iter_29_6, iter_29_7 in ipairs(arg_29_1.attribute_list) do
		self.attribute_list[iter_29_7.id] = iter_29_7.value
	end

	self.stackable_item_list = {}

	for iter_29_8, iter_29_9 in ipairs(arg_29_1.stackable_item_list) do
		self.stackable_item_list[iter_29_9.stackable_item_type] = iter_29_9.stackable_item_num
	end

	self.map_id = arg_29_1.map.map_id
	self.node_list = {}

	for iter_29_10, iter_29_11 in ipairs(arg_29_1.map.node_list) do
		self.node_list[iter_29_11.id] = {
			event_id = iter_29_11.event_id,
			state = iter_29_11.state
		}
	end

	self.effect_list = {}

	for iter_29_12, iter_29_13 in ipairs(arg_29_1.effect_list) do
		table.insert(self.effect_list, {
			id = iter_29_13.id,
			level = iter_29_13.level
		})
	end
end

function StrategyMartixUserTemplata:GetMatrixCoint()
	return (self.stackable_item_list or nil) and (self.stackable_item_list[1] or 0)
end

function StrategyMartixUserTemplata:GetIsClearance()
	if self.success_times == nil then
		return false
	end

	return self.success_times > 0
end

function StrategyMartixUserTemplata:GetMapId()
	return self.map_id
end

function StrategyMartixUserTemplata:GetNodeList()
	return self.node_list
end

function StrategyMartixUserTemplata:GetEffectList()
	return self.effect_list or {}
end

function StrategyMartixUserTemplata:RoguelikeScore()
	return self.roguelike_score or 0
end
