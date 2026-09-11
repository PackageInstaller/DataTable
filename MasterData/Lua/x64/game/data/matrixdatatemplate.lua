MatrixConst = {
	MATRIX_UNLOCK_SPECIAL_DIFFICULTY_CONDITION = 20401,
	MATRIX_UNLOCK_DIFFICULTY_CONDITION = 20301,
	MATRIX_UNLOCK_CUSTOM_AFFIX_CONDITION = 20401,
	EVENT_TYPE = {
		CURRENCY = 5,
		TREASURE_ELITE = 8,
		TREASURE = 7,
		EQUIP = 2,
		BOSS = 9,
		INCIDENT = 12,
		SHOP = 11,
		FINAL = 10,
		ASTROLABE = 1,
		CURRENCY_ELITE = 6,
		WEAPON_SERVANT_ELITE = 4,
		WEAPON_SERVANT = 3
	},
	ITEM_TYPE = {
		TREASURE = 5,
		ASTROLABE = 1,
		EQUIP = 2,
		ITEM = 4,
		EFFECT = 6,
		WEAPON_SERVANT = 3
	},
	STATE_TYPE = {
		SUCCESS = 3,
		STARTED = 2,
		NOTSTARTED = 1,
		FAIL = 4
	},
	PHASE_TYPE = {
		UNDEFINE = 0,
		REWARD = 3,
		CHOSE = 1,
		ACTION = 2
	},
	MATRIX_ATTRIBUTE_TYPE = {
		GIVE_UP_REWARD_ADDITION = 14,
		MAX_EQUIP_COUNT = 2,
		MAX_ASTROLABE_COUNT = 3,
		SHOP_REFRESH_TIMES = 9,
		SHOP_FRESS_REFRESH_TIMES = 10,
		SCORE_ADDITION = 17,
		CHANGE_TEAM_LEADER = 15,
		SHOP_FIRST_GOODS_DISCOUNT = 11,
		WEAPON_LEVEL = 1
	},
	EFFECT_ACTION = {
		AFFIX = 4,
		CURRENCY = 7,
		ATTRIBUTE = 5
	},
	DIFFICULTY_COLOR = {
		"E7E7E7",
		"F25353",
		"F25353"
	},
	DIFFICULTY_OVER_COLOR = {
		"0077B9",
		"B73E3E",
		"B73E3E"
	},
	ARTIFACT_RARE_IMAGE_COLOR = {
		Color.New(0.3921569, 0.5843138, 0.1058824, 0.2),
		Color.New(0, 0.4666667, 0.7254902, 0.2),
		Color.New(0.6901961, 0.2901961, 0.8, 0.2),
		Color.New(0.8470588, 0.682353, 0, 0.2)
	},
	ARTIFACT_RARE_TEXT = {
		"MATRIX_ARTIFACT_RARE1",
		"MATRIX_ARTIFACT_RARE2",
		"MATRIX_ARTIFACT_RARE3",
		"MATRIX_ARTIFACT_RARE4"
	},
	ARTIFACT_RARE_TEXT_COLOR = {
		"97BF5E",
		"008DDB",
		"D190E8",
		"FFEE36"
	},
	MATRIX_GAME_HELP_PAGES = {
		"TextureConfig/ChapterPaint/chapter/matrix_courses_01",
		"TextureConfig/ChapterPaint/chapter/matrix_courses_02",
		"TextureConfig/ChapterPaint/chapter/matrix_courses_03",
		"TextureConfig/ChapterPaint/chapter/matrix_courses_04",
		"TextureConfig/ChapterPaint/chapter/matrix_courses_05",
		"TextureConfig/ChapterPaint/chapter/matrix_courses_06",
		"TextureConfig/ChapterPaint/chapter/matrix_courses_07",
		"TextureConfig/ChapterPaint/chapter/matrix_courses_08"
	},
	MatirxRankType = {
		ALL = 1,
		GUILD = 2
	},
	MatirxRankSubType = {
		SPECIAL = 2,
		COMMON = 1
	}
}
MatrixTools = {}

function MatrixTools.GetMatrixItemSprite(arg_1_0)
	if MatrixItemCfg[arg_1_0].matrix_item_type == MatrixConst.ITEM_TYPE.TREASURE or MatrixItemCfg[arg_1_0].matrix_item_type == MatrixConst.ITEM_TYPE.EFFECT then
		return getSpriteWithoutAtlas("TextureConfig/MatrixItem/MatrixArtifact/" .. MatrixItemCfg[arg_1_0].icon)
	elseif MatrixItemCfg[arg_1_0].matrix_item_type == MatrixConst.ITEM_TYPE.WEAPON_SERVANT then
		return getSpriteWithoutAtlas(SpritePathCfg.ServantIcon.path .. MatrixItemCfg[arg_1_0].icon)
	elseif MatrixItemCfg[arg_1_0].matrix_item_type == MatrixConst.ITEM_TYPE.EQUIP then
		return getSpriteWithoutAtlas(SpritePathCfg.EquipIcon_s.path .. MatrixItemCfg[arg_1_0].icon)
	elseif MatrixItemCfg[arg_1_0].matrix_item_type == MatrixConst.ITEM_TYPE.ITEM then
		return ItemTools.getItemSprite(tonumber(MatrixItemCfg[arg_1_0].icon))
	elseif MatrixItemCfg[arg_1_0].matrix_item_type == MatrixConst.ITEM_TYPE.ASTROLABE then
		if MatrixItemCfg[arg_1_0].icon == "red" then
			return getSprite("Atlas/MatrixlUIAtlas", "icon_red_a")
		elseif MatrixItemCfg[arg_1_0].icon == "blue" then
			return getSprite("Atlas/MatrixlUIAtlas", "icon_blue_a")
		elseif MatrixItemCfg[arg_1_0].icon == "yellow" then
			return getSprite("Atlas/MatrixlUIAtlas", "icon_yellow_a")
		end
	end

	return nil
end

function MatrixTools.GetMatrixItemDes(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = MatrixItemCfg[arg_2_0]

	if MatrixItemCfg[arg_2_0].matrix_item_type == MatrixConst.ITEM_TYPE.ASTROLABE then
		if arg_2_1 then
			return (GetCfgDescription(AstrolabeEffectCfg[HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[var_2_0.params[1]][math.min(3, arg_2_1)]].desc[1], 1))
		end
	elseif var_2_0.matrix_item_type == MatrixConst.ITEM_TYPE.EQUIP then
		return EquipTools.GetEffectDesc(EquipSuitCfg[var_2_0.params[1]].suit_effect[1])
	elseif var_2_0.matrix_item_type == MatrixConst.ITEM_TYPE.WEAPON_SERVANT then
		local var_2_1 = WeaponEffectCfg[WeaponServantCfg[var_2_0.params[1]].effect[1]]
		local var_2_2

		if arg_2_2 and arg_2_2 ~= 0 then
			local var_2_3 = ActivityTools.GetActivityType(arg_2_2)

			if var_2_3 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
				var_2_2 = ActivityMatrixData:GetWeaponServantLevel(arg_2_2)
			elseif var_2_3 == ActivityTemplateConst.STRATEGY_MATRIX then
				var_2_2 = StrategyMatrixData:GetWeaponServantLevel(arg_2_2)
			else
				error("GetMatrixItemDes can not find current weapon level")

				var_2_2 = 1
			end
		else
			var_2_2 = MatrixData:GetWeaponServantLevel()
		end

		return GetCfgDescription(var_2_1.description[1], var_2_2)
	elseif var_2_0.matrix_item_type == MatrixConst.ITEM_TYPE.TREASURE then
		if MatrixConst.EFFECT_ACTION.AFFIX == MatrixEffectCfg[var_2_0.params[1]].action then
			return getAffixDesc(MatrixEffectCfg[var_2_0.params[1]].params)
		end
	end

	return var_2_0.desc
end

function MatrixTools.GetWeaponSpecHero(arg_3_0)
	return WeaponEffectCfg[WeaponServantCfg[arg_3_0].effect[1]].spec_char[1] or 0
end

function MatrixTools.MatrixExpToLevel(arg_4_0)
	local var_4_0 = -1

	while 1 <= #MatrixTerminalLevelCfg.all do
		local var_4_1 = 1 + math.floor((#MatrixTerminalLevelCfg.all - 1) / 2)
		local var_4_2, var_4_3

		if arg_4_0 < MatrixTerminalLevelCfg[MatrixTerminalLevelCfg.all[var_4_1]].exp then
			var_4_2 = var_4_1 - 1
		else
			var_4_0 = var_4_1
			var_4_3 = var_4_1 + 1
		end
	end

	return MatrixTerminalLevelCfg.all[var_4_0], arg_4_0 - MatrixTerminalLevelCfg[MatrixTerminalLevelCfg.all[var_4_0]].exp
end

local var_0_0 = {}

function MatrixTools.GetGiftListByGroup(arg_5_0)
	if var_0_0[arg_5_0] then
		return var_0_0[arg_5_0]
	end

	var_0_0[arg_5_0] = {}

	local var_5_0 = MatrixTerminalGiftCfg.get_id_list_by_group[arg_5_0] or {}
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if MatrixTerminalGiftCfg[iter_5_1].pre_id and MatrixTerminalGiftCfg[iter_5_1].pre_id ~= 0 then
			var_5_1[MatrixTerminalGiftCfg[iter_5_1].pre_id] = true
		end
	end

	local var_5_2 = {}

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		if not var_5_1[iter_5_3] then
			local var_5_3 = {}

			if MatrixTerminalGiftCfg[iter_5_3].pre_id and MatrixTerminalGiftCfg[iter_5_3].pre_id ~= 0 then
				while iter_5_3 and iter_5_3 ~= 0 do
					table.insert(var_5_3, 1, iter_5_3)

					iter_5_3 = MatrixTerminalGiftCfg[iter_5_3] and MatrixTerminalGiftCfg[iter_5_3].pre_id or nil
				end

				table.insert(var_0_0[arg_5_0], {
					type = 1,
					list = var_5_3
				})
			else
				table.insert(var_5_2, iter_5_3)
			end
		end
	end

	local var_5_4 = math.floor(#var_5_2 / 5) * 2

	if #var_5_2 % 5 == 0 then
		-- block empty
	else
		var_5_4 = #var_5_2 % 5 >= 4 and var_5_4 + 2 or var_5_4 + 1
	end

	for iter_5_4 = 1, var_5_4 do
		local var_5_5 = 0
		local var_5_6 = #var_5_2

		if iter_5_4 % 2 == 0 then
			var_5_5 = math.max(1, iter_5_4 / 2 * 5 - 1)
			var_5_6 = math.min(#var_5_2, var_5_5 + 1)
		else
			var_5_5 = math.max(1, math.ceil(iter_5_4 / 2) * 5 - 4)
			var_5_6 = math.min(#var_5_2, var_5_5 + 2)
		end

		local var_5_7 = {}

		for iter_5_5 = var_5_5, var_5_6 do
			table.insert(var_5_7, var_5_2[iter_5_5])
		end

		table.insert(var_0_0[arg_5_0], {
			type = 2,
			list = var_5_7,
			row = iter_5_4 % 2 == 0
		})
	end

	return var_0_0[arg_5_0]
end

function MatrixTools.GetAffixByEffectId(arg_6_0, arg_6_1)
	if MatrixEffectCfg[arg_6_0] and MatrixConst.EFFECT_ACTION.AFFIX == MatrixEffectCfg[arg_6_0].action then
		if arg_6_1 then
			return {
				MatrixEffectCfg[arg_6_0].params[1],
				arg_6_1,
				MatrixEffectCfg[arg_6_0].params[3]
			}
		else
			return MatrixEffectCfg[arg_6_0].params
		end
	end

	return nil
end

function MatrixTools:GetAttrByEffectId(arg_7_1)
	if MatrixEffectCfg[arg_7_1] and MatrixConst.EFFECT_ACTION.ATTRIBUTE == MatrixEffectCfg[arg_7_1].action then
		for iter_7_0, iter_7_1 in ipairs(MatrixEffectCfg[arg_7_1].params) do
			if self[iter_7_1[1]] == nil then
				self[iter_7_1[1]] = 0
			end

			self[iter_7_1[1]] = self[iter_7_1[1]] + iter_7_1[2]
		end
	end
end

function MatrixTools.UpdateSortScoreList()
	local var_8_0 = MatrixData:GetTerminalLevel()

	table.sort(MatrixData:GetPointRewardList(), function(arg_9_0, arg_9_1)
		local var_9_0 = var_8_0 >= arg_9_0.need_level

		if arg_9_1.is_got_reward == arg_9_0.is_got_reward then
			if var_9_0 == (var_8_0 >= arg_9_1.need_level) then
				return arg_9_1.rank > arg_9_0.rank
			end

			return var_9_0
		else
			return arg_9_1.is_got_reward > arg_9_0.is_got_reward
		end
	end)
end

function MatrixTools.GetBeaconIsUnlockCondition(arg_10_0)
	if MatrixBeaconCfg[arg_10_0] and MatrixBeaconCfg[arg_10_0].new_condition ~= 0 then
		return IsConditionAchieved(MatrixBeaconCfg[arg_10_0].new_condition)
	end

	return true
end

MatrixDifficultyTemplate = class("MatrixHeroTemplate")

function MatrixDifficultyTemplate:Ctor(arg_11_1)
	self.difficulty = arg_11_1.difficulty
	self.regularAffixs = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.regular_affix_list) do
		table.insert(self.regularAffixs, iter_11_1)
	end

	self.allCustomAffixs = {}

	for iter_11_2, iter_11_3 in ipairs(arg_11_1.custom_affix_list) do
		table.insert(self.allCustomAffixs, iter_11_3)
	end

	self.affixs = nil
	self.chipManagerID_ = arg_11_1.ai_chip_list[1] or 0
	self.chipIDList_ = {}

	for iter_11_4 = 2, 3 do
		self.chipIDList_[iter_11_4 - 1] = arg_11_1.ai_chip_list[iter_11_4] or 0
	end

	self.price_template_id = arg_11_1.price_template_id
end

function MatrixDifficultyTemplate:GetDifficulty()
	return self.difficulty
end

function MatrixDifficultyTemplate:GetRegularAffix()
	return self.regularAffixs
end

function MatrixDifficultyTemplate:GetAllCustomAffix()
	return self.allCustomAffixs
end

function MatrixDifficultyTemplate:GetChipManagerID()
	return self.chipManagerID_
end

function MatrixDifficultyTemplate:GetChipIDList()
	return self.chipIDList_
end

MatrixHeroTemplate = class("MatrixHeroTemplate")

function MatrixHeroTemplate.Ctor(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.hero_id = arg_17_1
	arg_17_0.heroStandardId = arg_17_2
	arg_17_0.health_point = 0
	arg_17_0.max_health_point = 0
	arg_17_0.astrolabe_list = {}
	arg_17_0.equip_list = {}
	arg_17_0.weapon_servant = 0
	arg_17_0.buff_list = {}
	arg_17_0.astrolabe_count_list = {}
	arg_17_0.astrolabe_effect_list = nil
end

function MatrixHeroTemplate:InitData(arg_18_1)
	self.health_point = arg_18_1.health_point
	self.max_health_point = arg_18_1.max_health_point
	self.astrolabe_list = {}
	self.astrolabe_count_list = {}
	self.astrolabe_effect_list = nil

	for iter_18_0, iter_18_1 in ipairs(arg_18_1.astrolabe_list) do
		table.insert(self.astrolabe_list, iter_18_1)

		local var_18_0 = MatrixItemCfg[iter_18_1] and MatrixItemCfg[iter_18_1].params[1]

		if not self.astrolabe_count_list[MatrixItemCfg[iter_18_1] and MatrixItemCfg[iter_18_1].params[1]] then
			self.astrolabe_count_list[var_18_0] = 0
		end

		self.astrolabe_count_list[var_18_0] = self.astrolabe_count_list[var_18_0] + 1
	end

	table.sort(self.astrolabe_list, function(arg_19_0, arg_19_1)
		return arg_19_0 < arg_19_1
	end)

	self.equip_list = {}

	for iter_18_2, iter_18_3 in ipairs(arg_18_1.equip_list) do
		table.insert(self.equip_list, iter_18_3)
	end

	table.sort(self.equip_list, function(arg_20_0, arg_20_1)
		return arg_20_0 < arg_20_1
	end)

	self.weapon_servant = arg_18_1.weapon_servant
	self.effect_list = {}

	for iter_18_4, iter_18_5 in ipairs(arg_18_1.effect_list) do
		table.insert(self.effect_list, iter_18_5)
	end

	self.totalDamage_ = arg_18_1.total_damage or 0
	self.totalHurt_ = arg_18_1.total_injured or 0
	self.totalHeal_ = arg_18_1.total_heal or 0
end

function MatrixHeroTemplate:GetAstrolabeNum(arg_21_1)
	return self.astrolabe_count_list[arg_21_1] or 0
end

function MatrixHeroTemplate:GetStandardId()
	return self.heroStandardId
end

function MatrixHeroTemplate:GetAstrolabeList()
	return self.astrolabe_list
end

function MatrixHeroTemplate:GetAstrolabeEffectList()
	if self.astrolabe_effect_list then
		return self.astrolabe_effect_list
	end

	self.astrolabe_effect_list = {}

	for iter_24_0, iter_24_1 in pairs(self.astrolabe_count_list) do
		if HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_24_0] then
			for iter_24_2 = 1, iter_24_1 do
				table.insert(self.astrolabe_effect_list, HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_24_0][iter_24_2])
			end
		end
	end

	return self.astrolabe_effect_list
end

function MatrixHeroTemplate:GetEquipList()
	return self.equip_list
end

function MatrixHeroTemplate:GetEquipEffectList()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(self.equip_list) do
		table.insert(var_26_0, MatrixItemCfg[iter_26_1] and MatrixItemCfg[iter_26_1].params[1])
	end

	return var_26_0
end

function MatrixHeroTemplate:GetWeaponServant()
	return self.weapon_servant
end

function MatrixHeroTemplate:GetWeaponServantEffect()
	return (MatrixItemCfg[self.weapon_servant] or nil) and (MatrixItemCfg[self.weapon_servant].params[1] or 0)
end

function MatrixHeroTemplate.GetWeaponServantEffectLevel(arg_29_0)
	return MatrixData:GetWeaponServantLevel() or 1
end

function MatrixHeroTemplate:IsDead()
	return self.health_point <= 0
end

function MatrixHeroTemplate:GetHeroHP()
	return self.health_point
end

function MatrixHeroTemplate:GetHeroMaxHP()
	return self.max_health_point
end

function MatrixHeroTemplate:GetEffectCount(arg_33_1)
	local var_33_0 = 0

	for iter_33_0, iter_33_1 in ipairs(self.effect_list) do
		if arg_33_1 == iter_33_1 then
			var_33_0 = var_33_0 + 1
		end
	end

	return var_33_0
end

function MatrixHeroTemplate.GetIsOwnerHero(arg_34_0)
	return false
end

MatrixOwnerHeroTemplate = class("MatrixOwnerHeroTemplate", MatrixHeroTemplate)

function MatrixOwnerHeroTemplate.Ctor(arg_35_0, arg_35_1, arg_35_2)
	MatrixOwnerHeroTemplate.super.Ctor(arg_35_0, arg_35_1, arg_35_2)

	arg_35_0.entry_snapshot = nil
end

function MatrixOwnerHeroTemplate.InitData(arg_36_0, arg_36_1)
	MatrixOwnerHeroTemplate.super.InitData(arg_36_0, arg_36_1)

	local var_36_0 = arg_36_1.entry_snapshot
	local var_36_1 = {
		skin = 0,
		trialID = 0,
		id = arg_36_1.entry_snapshot.hero_id,
		star = arg_36_1.entry_snapshot.star,
		exp = arg_36_1.entry_snapshot.exp,
		level = HeroTools.CheckExp(1, arg_36_1.entry_snapshot.exp),
		equip_list = {},
		using_astrolabe = {},
		skill = {},
		break_level = arg_36_1.entry_snapshot.break_level,
		weapon_info = {
			exp = arg_36_1.entry_snapshot.weapon.exp,
			breakthrough = arg_36_1.entry_snapshot.weapon.breakthrough
		}
	}

	var_36_1.servantInfo = arg_36_1.entry_snapshot.weapon.servant and {
		id = var_36_0.weapon.servant.id,
		stage = var_36_0.weapon.servant.stage
	} or {}

	if var_36_0.equip_list then
		for iter_36_0, iter_36_1 in ipairs(var_36_0.equip_list) do
			local var_36_2 = {}

			if iter_36_1.enchant_slot_list then
				for iter_36_2, iter_36_3 in ipairs(iter_36_1.enchant_slot_list) do
					local var_36_4 = {}

					for iter_36_4, iter_36_5 in ipairs(iter_36_3.effect_list) do
						table.insert(var_36_4, {
							id = iter_36_5.id,
							num = iter_36_5.level
						})
					end

					if #var_36_4 > 0 then
						var_36_2[iter_36_2] = var_36_4
					end
				end
			end

			local var_36_5 = {}
			local var_36_6 = {}

			if var_36_0.hero_id == iter_36_1.race and iter_36_1.hero_exclusive_skill then
				for iter_36_6, iter_36_7 in ipairs(iter_36_1.hero_exclusive_skill) do
					table.insert(var_36_5, iter_36_7.id)

					var_36_6[iter_36_7.id] = {
						id = iter_36_7.id,
						level = iter_36_7.skill_level
					}
				end
			end

			local var_36_7 = {
				equip_id = 1,
				prefab_id = iter_36_1.prefab_id,
				exp = iter_36_1.exp
			}

			var_36_7.now_break_level = iter_36_1.now_break_level or 0
			var_36_7.enchant = var_36_2
			var_36_7.useList = var_36_5
			var_36_7.skillList = var_36_6
			var_36_7.race = iter_36_1.race
			var_36_1.equip_list[iter_36_0] = var_36_7
		end
	end

	if var_36_0.astrolabe_list then
		for iter_36_8, iter_36_9 in ipairs(var_36_0.astrolabe_list) do
			var_36_1.using_astrolabe[iter_36_8] = iter_36_9
		end
	end

	if var_36_0.skill_list then
		for iter_36_10, iter_36_11 in ipairs(var_36_0.skill_list) do
			var_36_1.skill[iter_36_10] = {
				skill_id = iter_36_11.id,
				skill_level = iter_36_11.level
			}
		end
	end

	arg_36_0.entry_snapshot = var_36_1
end

function MatrixOwnerHeroTemplate.GetIsOwnerHero(arg_37_0)
	return true
end

function MatrixOwnerHeroTemplate:GetEntrySnapShot()
	return self.entry_snapshot
end

MatrixPhaseTemplate = class("MatrixPhaseTemplate")

function MatrixPhaseTemplate:Ctor(arg_39_1, arg_39_2)
	self.phase_id = arg_39_1.phase_id
	self.event_id_list = {}

	for iter_39_0, iter_39_1 in ipairs(arg_39_1.event_id_list) do
		table.insert(self.event_id_list, iter_39_1)
	end

	self.cur_event_id = arg_39_1.event.event_id
	self.envent_params = {}

	for iter_39_2, iter_39_3 in ipairs(arg_39_1.event.params) do
		table.insert(self.envent_params, iter_39_3)
	end

	self.reward_items = {}

	for iter_39_4, iter_39_5 in ipairs(arg_39_1.reward.matrix_item_id_list) do
		table.insert(self.reward_items, iter_39_5)
	end

	self.give_up_item_id = arg_39_1.reward.give_up_matrix_item_id
	self.price_template_id = arg_39_2
end

function MatrixPhaseTemplate:GetPhase()
	return self.phase_id
end

function MatrixPhaseTemplate:GetParams()
	if MatrixConst.PHASE_TYPE.CHOSE == self.phase_id then
		return self.event_id_list
	elseif MatrixConst.PHASE_TYPE.ACTION == self.phase_id then
		return {
			self.cur_event_id
		}
	elseif MatrixConst.PHASE_TYPE.REWARD == self.phase_id then
		return self.reward_items
	else
		return {}
	end
end

function MatrixPhaseTemplate:GetData()
	local var_42_0 = MatrixPriceTemplateCfg.get_id_list_by_template_id[self.price_template_id] or {}

	if MatrixConst.EVENT_TYPE.SHOP == MatrixEventCfg[self.cur_event_id].event_type then
		local var_42_1 = {}

		for iter_42_0 = 2, #self.envent_params do
			if self.envent_params[iter_42_0] and self.envent_params[iter_42_0] ~= 0 then
				local var_42_2 = MatrixItemCfg[self.envent_params[iter_42_0]].price[1]
				local var_42_3 = MatrixItemCfg[self.envent_params[iter_42_0]].price[1][1]
				local var_42_4 = MatrixItemCfg[self.envent_params[iter_42_0]].price[1][2]

				for iter_42_1, iter_42_2 in ipairs(var_42_0) do
					if self.envent_params[iter_42_0] == MatrixPriceTemplateCfg[iter_42_2].matrix_item_id then
						var_42_2 = MatrixPriceTemplateCfg[iter_42_2].price[1]
						var_42_3 = MatrixPriceTemplateCfg[iter_42_2].price[1][1]
						var_42_4 = MatrixPriceTemplateCfg[iter_42_2].price[1][2]
					end
				end

				local var_42_5 = 1

				if iter_42_0 - 1 == 1 then
					var_42_5 = 1 - MatrixData:GetFirstGoodsDiscount() / 1000
					var_42_4 = math.floor(var_42_4 - var_42_4 * MatrixData:GetFirstGoodsDiscount() / 1000)
				end

				table.insert(var_42_1, {
					index = iter_42_0 - 1,
					id = self.envent_params[iter_42_0],
					discount = var_42_5,
					priceId = var_42_3,
					priceNum = var_42_4,
					priceOriginal = var_42_2[2]
				})
			end
		end

		return self.envent_params[1], var_42_1
	else
		return self.envent_params[1] or 0
	end
end

function MatrixPhaseTemplate.GetShops(arg_43_0)
	return {}
end

function MatrixPhaseTemplate:GetGiveUpItemId()
	return self.give_up_item_id or 0
end

MatrixRankTemplate = class("MatrixRankTemplate")

function MatrixRankTemplate:Ctor(arg_45_1)
	self.user_id = arg_45_1.user_id
	self.score = arg_45_1.score
	self.difficulty = arg_45_1.difficulty
	self.rank = arg_45_1.rank
	self.timestamp = arg_45_1.timestamp

	local var_45_0 = PlayerData:GetPlayerInfo()

	if var_45_0 and self.user_id == var_45_0.userID then
		self.nick = var_45_0.nick
		self.icon = var_45_0.portrait
		self.icon_frame = var_45_0.icon_frame
	else
		self.nick = arg_45_1.nick
		self.icon = arg_45_1.portrait
		self.icon_frame = arg_45_1.frame
	end

	self.select_hero_id_list = {}

	for iter_45_0, iter_45_1 in ipairs((arg_45_1.team_info[1] or nil) and (arg_45_1.team_info[1].hero_info_list or {})) do
		table.insert(self.select_hero_id_list, {
			id = iter_45_1.hero_id,
			skin_id = iter_45_1.skin_id
		})
	end
end
