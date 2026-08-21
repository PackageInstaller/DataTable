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
	local var_1_0 = MatrixItemCfg[arg_1_0]

	if var_1_0.matrix_item_type == MatrixConst.ITEM_TYPE.TREASURE or var_1_0.matrix_item_type == MatrixConst.ITEM_TYPE.EFFECT then
		return getSpriteWithoutAtlas("TextureConfig/MatrixItem/MatrixArtifact/" .. var_1_0.icon)
	elseif var_1_0.matrix_item_type == MatrixConst.ITEM_TYPE.WEAPON_SERVANT then
		return getSpriteWithoutAtlas(SpritePathCfg.ServantIcon.path .. var_1_0.icon)
	elseif var_1_0.matrix_item_type == MatrixConst.ITEM_TYPE.EQUIP then
		return getSpriteWithoutAtlas(SpritePathCfg.EquipIcon_s.path .. var_1_0.icon)
	elseif var_1_0.matrix_item_type == MatrixConst.ITEM_TYPE.ITEM then
		return ItemTools.getItemSprite(tonumber(var_1_0.icon))
	elseif var_1_0.matrix_item_type == MatrixConst.ITEM_TYPE.ASTROLABE then
		if var_1_0.icon == "red" then
			return getSprite("Atlas/MatrixlUIAtlas", "icon_red_a")
		elseif var_1_0.icon == "blue" then
			return getSprite("Atlas/MatrixlUIAtlas", "icon_blue_a")
		elseif var_1_0.icon == "yellow" then
			return getSprite("Atlas/MatrixlUIAtlas", "icon_yellow_a")
		end
	end

	return nil
end

function MatrixTools.GetMatrixItemDes(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = MatrixItemCfg[arg_2_0]

	if var_2_0.matrix_item_type == MatrixConst.ITEM_TYPE.ASTROLABE then
		local var_2_1 = var_2_0.params[1]
		local var_2_2 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[var_2_1]

		if arg_2_1 then
			local var_2_3 = var_2_2[math.min(3, arg_2_1)]
			local var_2_4 = AstrolabeEffectCfg[var_2_3].desc[1]

			return (GetCfgDescription(var_2_4, 1))
		end
	elseif var_2_0.matrix_item_type == MatrixConst.ITEM_TYPE.EQUIP then
		local var_2_5 = var_2_0.params[1]
		local var_2_6 = EquipSuitCfg[var_2_5]

		return EquipTools.GetEffectDesc(var_2_6.suit_effect[1])
	elseif var_2_0.matrix_item_type == MatrixConst.ITEM_TYPE.WEAPON_SERVANT then
		local var_2_7 = var_2_0.params[1]
		local var_2_8 = WeaponServantCfg[var_2_7].effect[1]
		local var_2_9 = WeaponEffectCfg[var_2_8]
		local var_2_10

		if arg_2_2 and arg_2_2 ~= 0 then
			local var_2_11 = ActivityTools.GetActivityType(arg_2_2)

			if var_2_11 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
				var_2_10 = ActivityMatrixData:GetWeaponServantLevel(arg_2_2)
			elseif var_2_11 == ActivityTemplateConst.STRATEGY_MATRIX then
				var_2_10 = StrategyMatrixData:GetWeaponServantLevel(arg_2_2)
			else
				error("GetMatrixItemDes can not find current weapon level")

				var_2_10 = 1
			end
		else
			var_2_10 = MatrixData:GetWeaponServantLevel()
		end

		local var_2_12 = var_2_9.description[1]

		return GetCfgDescription(var_2_12, var_2_10)
	elseif var_2_0.matrix_item_type == MatrixConst.ITEM_TYPE.TREASURE then
		local var_2_13 = var_2_0.params[1]
		local var_2_14 = MatrixEffectCfg[var_2_13]

		if MatrixConst.EFFECT_ACTION.AFFIX == var_2_14.action then
			local var_2_15 = var_2_14.params

			return getAffixDesc(var_2_15)
		end
	end

	return var_2_0.desc
end

function MatrixTools.GetWeaponSpecHero(arg_3_0)
	local var_3_0 = WeaponServantCfg[arg_3_0].effect[1]

	return WeaponEffectCfg[var_3_0].spec_char[1] or 0
end

function MatrixTools.MatrixExpToLevel(arg_4_0)
	local var_4_0 = MatrixTerminalLevelCfg.all
	local var_4_1 = 1
	local var_4_2 = #var_4_0
	local var_4_3 = -1

	while var_4_1 <= var_4_2 do
		local var_4_4 = var_4_1 + math.floor((var_4_2 - var_4_1) / 2)

		if arg_4_0 < MatrixTerminalLevelCfg[var_4_0[var_4_4]].exp then
			var_4_2 = var_4_4 - 1
		else
			var_4_3 = var_4_4
			var_4_1 = var_4_4 + 1
		end
	end

	local var_4_5 = arg_4_0 - MatrixTerminalLevelCfg[var_4_0[var_4_3]].exp

	return var_4_0[var_4_3], var_4_5
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
		local var_5_2 = MatrixTerminalGiftCfg[iter_5_1].pre_id

		if var_5_2 and var_5_2 ~= 0 then
			var_5_1[var_5_2] = true
		end
	end

	local var_5_3 = {}

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		if not var_5_1[iter_5_3] then
			local var_5_4 = {}
			local var_5_5 = MatrixTerminalGiftCfg[iter_5_3]

			if var_5_5.pre_id and var_5_5.pre_id ~= 0 then
				while iter_5_3 and iter_5_3 ~= 0 do
					local var_5_6 = MatrixTerminalGiftCfg[iter_5_3]

					table.insert(var_5_4, 1, iter_5_3)

					iter_5_3 = var_5_6 and var_5_6.pre_id or nil
				end

				table.insert(var_0_0[arg_5_0], {
					type = 1,
					list = var_5_4
				})
			else
				table.insert(var_5_3, iter_5_3)
			end
		end
	end

	local var_5_7 = #var_5_3
	local var_5_8 = math.floor(var_5_7 / 5) * 2

	if var_5_7 % 5 == 0 then
		-- block empty
	elseif var_5_7 % 5 >= 4 then
		var_5_8 = var_5_8 + 2
	else
		var_5_8 = var_5_8 + 1
	end

	for iter_5_4 = 1, var_5_8 do
		local var_5_9 = 0
		local var_5_10 = #var_5_3

		if iter_5_4 % 2 == 0 then
			var_5_9 = math.max(1, iter_5_4 / 2 * 5 - 1)
			var_5_10 = math.min(#var_5_3, var_5_9 + 1)
		else
			var_5_9 = math.max(1, math.ceil(iter_5_4 / 2) * 5 - 4)
			var_5_10 = math.min(#var_5_3, var_5_9 + 2)
		end

		local var_5_11 = {}

		for iter_5_5 = var_5_9, var_5_10 do
			table.insert(var_5_11, var_5_3[iter_5_5])
		end

		table.insert(var_0_0[arg_5_0], {
			type = 2,
			list = var_5_11,
			row = iter_5_4 % 2 == 0
		})
	end

	return var_0_0[arg_5_0]
end

function MatrixTools.GetAffixByEffectId(arg_6_0, arg_6_1)
	local var_6_0 = MatrixEffectCfg[arg_6_0]

	if var_6_0 and MatrixConst.EFFECT_ACTION.AFFIX == var_6_0.action then
		if arg_6_1 then
			return {
				var_6_0.params[1],
				arg_6_1,
				var_6_0.params[3]
			}
		else
			return var_6_0.params
		end
	end

	return nil
end

function MatrixTools.GetAttrByEffectId(arg_7_0, arg_7_1)
	local var_7_0 = MatrixEffectCfg[arg_7_1]

	if var_7_0 and MatrixConst.EFFECT_ACTION.ATTRIBUTE == var_7_0.action then
		for iter_7_0, iter_7_1 in ipairs(var_7_0.params) do
			local var_7_1 = iter_7_1[1]
			local var_7_2 = iter_7_1[2]

			if arg_7_0[var_7_1] == nil then
				arg_7_0[var_7_1] = 0
			end

			arg_7_0[var_7_1] = arg_7_0[var_7_1] + var_7_2
		end
	end
end

function MatrixTools.UpdateSortScoreList()
	local var_8_0 = MatrixData:GetPointRewardList()
	local var_8_1 = MatrixData:GetTerminalLevel()

	table.sort(var_8_0, function(arg_9_0, arg_9_1)
		local var_9_0 = var_8_1 >= arg_9_0.need_level
		local var_9_1 = var_8_1 >= arg_9_1.need_level

		if arg_9_1.is_got_reward == arg_9_0.is_got_reward then
			if var_9_0 == var_9_1 then
				return arg_9_1.rank > arg_9_0.rank
			end

			return var_9_0
		else
			return arg_9_1.is_got_reward > arg_9_0.is_got_reward
		end
	end)
end

function MatrixTools.GetBeaconIsUnlockCondition(arg_10_0)
	local var_10_0 = MatrixBeaconCfg[arg_10_0]

	if var_10_0 and var_10_0.new_condition ~= 0 then
		return IsConditionAchieved(var_10_0.new_condition)
	end

	return true
end

MatrixDifficultyTemplate = class("MatrixHeroTemplate")

function MatrixDifficultyTemplate.Ctor(arg_11_0, arg_11_1)
	arg_11_0.difficulty = arg_11_1.difficulty
	arg_11_0.regularAffixs = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.regular_affix_list) do
		table.insert(arg_11_0.regularAffixs, iter_11_1)
	end

	arg_11_0.allCustomAffixs = {}

	for iter_11_2, iter_11_3 in ipairs(arg_11_1.custom_affix_list) do
		table.insert(arg_11_0.allCustomAffixs, iter_11_3)
	end

	arg_11_0.affixs = nil

	local var_11_0 = arg_11_1.ai_chip_list

	arg_11_0.chipManagerID_ = var_11_0[1] or 0
	arg_11_0.chipIDList_ = {}

	for iter_11_4 = 2, 3 do
		arg_11_0.chipIDList_[iter_11_4 - 1] = var_11_0[iter_11_4] or 0
	end

	arg_11_0.price_template_id = arg_11_1.price_template_id
end

function MatrixDifficultyTemplate.GetDifficulty(arg_12_0)
	return arg_12_0.difficulty
end

function MatrixDifficultyTemplate.GetRegularAffix(arg_13_0)
	return arg_13_0.regularAffixs
end

function MatrixDifficultyTemplate.GetAllCustomAffix(arg_14_0)
	return arg_14_0.allCustomAffixs
end

function MatrixDifficultyTemplate.GetChipManagerID(arg_15_0)
	return arg_15_0.chipManagerID_
end

function MatrixDifficultyTemplate.GetChipIDList(arg_16_0)
	return arg_16_0.chipIDList_
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

function MatrixHeroTemplate.InitData(arg_18_0, arg_18_1)
	arg_18_0.health_point = arg_18_1.health_point
	arg_18_0.max_health_point = arg_18_1.max_health_point
	arg_18_0.astrolabe_list = {}
	arg_18_0.astrolabe_count_list = {}
	arg_18_0.astrolabe_effect_list = nil

	for iter_18_0, iter_18_1 in ipairs(arg_18_1.astrolabe_list) do
		table.insert(arg_18_0.astrolabe_list, iter_18_1)

		local var_18_0 = MatrixItemCfg[iter_18_1]
		local var_18_1 = var_18_0 and var_18_0.params[1]

		if not arg_18_0.astrolabe_count_list[var_18_1] then
			arg_18_0.astrolabe_count_list[var_18_1] = 0
		end

		arg_18_0.astrolabe_count_list[var_18_1] = arg_18_0.astrolabe_count_list[var_18_1] + 1
	end

	table.sort(arg_18_0.astrolabe_list, function(arg_19_0, arg_19_1)
		return arg_19_0 < arg_19_1
	end)

	arg_18_0.equip_list = {}

	for iter_18_2, iter_18_3 in ipairs(arg_18_1.equip_list) do
		table.insert(arg_18_0.equip_list, iter_18_3)
	end

	table.sort(arg_18_0.equip_list, function(arg_20_0, arg_20_1)
		return arg_20_0 < arg_20_1
	end)

	arg_18_0.weapon_servant = arg_18_1.weapon_servant
	arg_18_0.effect_list = {}

	for iter_18_4, iter_18_5 in ipairs(arg_18_1.effect_list) do
		table.insert(arg_18_0.effect_list, iter_18_5)
	end

	arg_18_0.totalDamage_ = arg_18_1.total_damage or 0
	arg_18_0.totalHurt_ = arg_18_1.total_injured or 0
	arg_18_0.totalHeal_ = arg_18_1.total_heal or 0
end

function MatrixHeroTemplate.GetAstrolabeNum(arg_21_0, arg_21_1)
	return arg_21_0.astrolabe_count_list[arg_21_1] or 0
end

function MatrixHeroTemplate.GetStandardId(arg_22_0)
	return arg_22_0.heroStandardId
end

function MatrixHeroTemplate.GetAstrolabeList(arg_23_0)
	return arg_23_0.astrolabe_list
end

function MatrixHeroTemplate.GetAstrolabeEffectList(arg_24_0)
	if arg_24_0.astrolabe_effect_list then
		return arg_24_0.astrolabe_effect_list
	end

	arg_24_0.astrolabe_effect_list = {}

	for iter_24_0, iter_24_1 in pairs(arg_24_0.astrolabe_count_list) do
		local var_24_0 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_24_0]

		if var_24_0 then
			for iter_24_2 = 1, iter_24_1 do
				table.insert(arg_24_0.astrolabe_effect_list, var_24_0[iter_24_2])
			end
		end
	end

	return arg_24_0.astrolabe_effect_list
end

function MatrixHeroTemplate.GetEquipList(arg_25_0)
	return arg_25_0.equip_list
end

function MatrixHeroTemplate.GetEquipEffectList(arg_26_0)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.equip_list) do
		local var_26_1 = MatrixItemCfg[iter_26_1]
		local var_26_2 = var_26_1 and var_26_1.params[1]

		table.insert(var_26_0, var_26_2)
	end

	return var_26_0
end

function MatrixHeroTemplate.GetWeaponServant(arg_27_0)
	return arg_27_0.weapon_servant
end

function MatrixHeroTemplate.GetWeaponServantEffect(arg_28_0)
	local var_28_0 = MatrixItemCfg[arg_28_0.weapon_servant]

	return var_28_0 and var_28_0.params[1] or 0
end

function MatrixHeroTemplate.GetWeaponServantEffectLevel(arg_29_0)
	return MatrixData:GetWeaponServantLevel() or 1
end

function MatrixHeroTemplate.IsDead(arg_30_0)
	return arg_30_0.health_point <= 0
end

function MatrixHeroTemplate.GetHeroHP(arg_31_0)
	return arg_31_0.health_point
end

function MatrixHeroTemplate.GetHeroMaxHP(arg_32_0)
	return arg_32_0.max_health_point
end

function MatrixHeroTemplate.GetEffectCount(arg_33_0, arg_33_1)
	local var_33_0 = 0

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.effect_list) do
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
		id = var_36_0.hero_id,
		star = var_36_0.star,
		exp = var_36_0.exp,
		level = HeroTools.CheckExp(1, var_36_0.exp),
		equip_list = {},
		using_astrolabe = {},
		skill = {},
		break_level = var_36_0.break_level,
		weapon_info = {
			exp = var_36_0.weapon.exp,
			breakthrough = var_36_0.weapon.breakthrough
		}
	}

	if var_36_0.weapon.servant then
		var_36_1.servantInfo = {
			id = var_36_0.weapon.servant.id,
			stage = var_36_0.weapon.servant.stage
		}
	else
		var_36_1.servantInfo = {}
	end

	if var_36_0.equip_list then
		for iter_36_0, iter_36_1 in ipairs(var_36_0.equip_list) do
			local var_36_2 = {}

			if iter_36_1.enchant_slot_list then
				for iter_36_2, iter_36_3 in ipairs(iter_36_1.enchant_slot_list) do
					local var_36_3 = iter_36_3.id
					local var_36_4 = iter_36_3.effect_list
					local var_36_5 = {}

					for iter_36_4, iter_36_5 in ipairs(var_36_4) do
						table.insert(var_36_5, {
							id = iter_36_5.id,
							num = iter_36_5.level
						})
					end

					if #var_36_5 > 0 then
						var_36_2[iter_36_2] = var_36_5
					end
				end
			end

			local var_36_6 = {}
			local var_36_7 = {}

			if var_36_0.hero_id == iter_36_1.race and iter_36_1.hero_exclusive_skill then
				for iter_36_6, iter_36_7 in ipairs(iter_36_1.hero_exclusive_skill) do
					table.insert(var_36_6, iter_36_7.id)

					var_36_7[iter_36_7.id] = {
						id = iter_36_7.id,
						level = iter_36_7.skill_level
					}
				end
			end

			var_36_1.equip_list[iter_36_0] = {
				equip_id = 1,
				prefab_id = iter_36_1.prefab_id,
				exp = iter_36_1.exp,
				now_break_level = iter_36_1.now_break_level or 0,
				enchant = var_36_2,
				useList = var_36_6,
				skillList = var_36_7,
				race = iter_36_1.race
			}
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

function MatrixOwnerHeroTemplate.GetEntrySnapShot(arg_38_0)
	return arg_38_0.entry_snapshot
end

MatrixPhaseTemplate = class("MatrixPhaseTemplate")

function MatrixPhaseTemplate.Ctor(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0.phase_id = arg_39_1.phase_id
	arg_39_0.event_id_list = {}

	for iter_39_0, iter_39_1 in ipairs(arg_39_1.event_id_list) do
		table.insert(arg_39_0.event_id_list, iter_39_1)
	end

	local var_39_0 = arg_39_1.event

	arg_39_0.cur_event_id = var_39_0.event_id
	arg_39_0.envent_params = {}

	for iter_39_2, iter_39_3 in ipairs(var_39_0.params) do
		table.insert(arg_39_0.envent_params, iter_39_3)
	end

	local var_39_1 = arg_39_1.reward

	arg_39_0.reward_items = {}

	for iter_39_4, iter_39_5 in ipairs(var_39_1.matrix_item_id_list) do
		table.insert(arg_39_0.reward_items, iter_39_5)
	end

	arg_39_0.give_up_item_id = var_39_1.give_up_matrix_item_id
	arg_39_0.price_template_id = arg_39_2
end

function MatrixPhaseTemplate.GetPhase(arg_40_0)
	return arg_40_0.phase_id
end

function MatrixPhaseTemplate.GetParams(arg_41_0)
	if MatrixConst.PHASE_TYPE.CHOSE == arg_41_0.phase_id then
		return arg_41_0.event_id_list
	elseif MatrixConst.PHASE_TYPE.ACTION == arg_41_0.phase_id then
		return {
			arg_41_0.cur_event_id
		}
	elseif MatrixConst.PHASE_TYPE.REWARD == arg_41_0.phase_id then
		return arg_41_0.reward_items
	else
		return {}
	end
end

function MatrixPhaseTemplate.GetData(arg_42_0)
	local var_42_0 = MatrixEventCfg[arg_42_0.cur_event_id]
	local var_42_1 = MatrixPriceTemplateCfg.get_id_list_by_template_id[arg_42_0.price_template_id] or {}

	if MatrixConst.EVENT_TYPE.SHOP == var_42_0.event_type then
		local var_42_2 = arg_42_0.envent_params[1]
		local var_42_3 = {}
		local var_42_4 = #arg_42_0.envent_params

		for iter_42_0 = 2, var_42_4 do
			local var_42_5 = arg_42_0.envent_params[iter_42_0]

			if var_42_5 and var_42_5 ~= 0 then
				local var_42_6 = MatrixItemCfg[var_42_5].price[1]
				local var_42_7 = var_42_6[1]
				local var_42_8 = var_42_6[2]

				for iter_42_1, iter_42_2 in ipairs(var_42_1) do
					local var_42_9 = MatrixPriceTemplateCfg[iter_42_2]

					if var_42_5 == var_42_9.matrix_item_id then
						var_42_6 = var_42_9.price[1]
						var_42_7 = var_42_6[1]
						var_42_8 = var_42_6[2]
					end
				end

				local var_42_10 = 1
				local var_42_11 = iter_42_0 - 1

				if var_42_11 == 1 then
					var_42_10 = 1 - MatrixData:GetFirstGoodsDiscount() / 1000

					local var_42_12 = var_42_8 * MatrixData:GetFirstGoodsDiscount() / 1000

					var_42_8 = math.floor(var_42_8 - var_42_12)
				end

				table.insert(var_42_3, {
					index = var_42_11,
					id = var_42_5,
					discount = var_42_10,
					priceId = var_42_7,
					priceNum = var_42_8,
					priceOriginal = var_42_6[2]
				})
			end
		end

		return var_42_2, var_42_3
	else
		return arg_42_0.envent_params[1] or 0
	end
end

function MatrixPhaseTemplate.GetShops(arg_43_0)
	return {}
end

function MatrixPhaseTemplate.GetGiveUpItemId(arg_44_0)
	return arg_44_0.give_up_item_id or 0
end

MatrixRankTemplate = class("MatrixRankTemplate")

function MatrixRankTemplate.Ctor(arg_45_0, arg_45_1)
	arg_45_0.user_id = arg_45_1.user_id
	arg_45_0.score = arg_45_1.score
	arg_45_0.difficulty = arg_45_1.difficulty
	arg_45_0.rank = arg_45_1.rank
	arg_45_0.timestamp = arg_45_1.timestamp

	local var_45_0 = PlayerData:GetPlayerInfo()

	if var_45_0 and arg_45_0.user_id == var_45_0.userID then
		arg_45_0.nick = var_45_0.nick
		arg_45_0.icon = var_45_0.portrait
		arg_45_0.icon_frame = var_45_0.icon_frame
	else
		arg_45_0.nick = arg_45_1.nick
		arg_45_0.icon = arg_45_1.portrait
		arg_45_0.icon_frame = arg_45_1.frame
	end

	arg_45_0.select_hero_id_list = {}

	local var_45_1 = arg_45_1.team_info[1] and arg_45_1.team_info[1].hero_info_list or {}

	for iter_45_0, iter_45_1 in ipairs(var_45_1) do
		table.insert(arg_45_0.select_hero_id_list, {
			id = iter_45_1.hero_id,
			skin_id = iter_45_1.skin_id
		})
	end
end
