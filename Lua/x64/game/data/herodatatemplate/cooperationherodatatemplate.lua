local var_0_0 = class("CooperationHeroDataTemplate", BaseHeroDataTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.trust = {
		exp = 0,
		mood = 1,
		level = 0
	}
	arg_1_0.clear_mission_list = {}
	arg_1_0.clear_times = 0
	arg_1_0.piece = 0
	arg_1_0.unlocked_skin = {}
	arg_1_0.equipDataList = {}
	arg_1_0.dormLevel = 0
	arg_1_0.equip_list = {}
end

function var_0_0.Init(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.hero_base_info
	local var_2_1 = var_2_0.id
	local var_2_2 = var_2_0.using_skin

	if arg_2_1.hero_type == 2 then
		local var_2_3 = HeroStandardSystemCfg[var_2_1].hero_id

		arg_2_0.trialID = var_2_0.id
		arg_2_0.id = HeroStandardSystemCfg[var_2_0.id].hero_id
	else
		arg_2_0.id = var_2_0.id

		if arg_2_1.hero_type == 3 then
			arg_2_0.oathOverride = ForeignInfoData:GetHeroData(arg_2_0.id):IsOath()
		end
	end

	arg_2_0.unlock = 1
	arg_2_0.skin = var_2_2
	arg_2_0.battle_using_skin = var_2_0.battle_using_skin
	arg_2_0.star = var_2_0.star
	arg_2_0.exp = var_2_0.exp
	arg_2_0.level = HeroTools.CheckExp(1, var_2_0.exp)
	arg_2_0.equip_list = {}
	arg_2_0.using_astrolabe = {}
	arg_2_0.skill = {}
	arg_2_0.skillAttrList = {}
	arg_2_0.break_level = var_2_0.break_level
	arg_2_0.weapon_info = {
		exp = var_2_0.weapon.exp,
		breakthrough = var_2_0.weapon.breakthrough
	}
	arg_2_0.transition = {}
	arg_2_0.weapon_module_level = var_2_0.weapon_module_level
	arg_2_0.dormLevel = arg_2_1.dorm_level
	arg_2_0.servantInfo = {
		id = var_2_0.servant.id,
		stage = var_2_0.servant.stage
	}
	arg_2_0.equip = arg_2_0:InitHeroEquip(var_2_0.id, arg_2_1.equip_list)

	for iter_2_0, iter_2_1 in ipairs(var_2_0.using_astrolabe) do
		arg_2_0.using_astrolabe[iter_2_0] = iter_2_1
	end

	for iter_2_2, iter_2_3 in ipairs(var_2_0.skill) do
		arg_2_0.skill[iter_2_2] = {
			skill_id = iter_2_3.skill_id,
			skill_level = iter_2_3.skill_level
		}
	end

	for iter_2_4, iter_2_5 in ipairs(var_2_0.skill_intensify_attribute_list) do
		arg_2_0.skillAttrList[iter_2_4] = {
			index = iter_2_5.index,
			level = iter_2_5.level
		}
	end

	local var_2_4 = {}
	local var_2_5 = {}

	for iter_2_6, iter_2_7 in ipairs(var_2_0.exclusive_skill_list) do
		local var_2_6 = iter_2_7.slot_id

		var_2_4[var_2_6] = {}
		var_2_5[var_2_6] = {}

		for iter_2_8, iter_2_9 in ipairs(iter_2_7.skill_list) do
			table.insert(var_2_4[var_2_6], iter_2_9.skill_id)
			table.insert(var_2_5[var_2_6], iter_2_9.skill_level)
		end
	end

	arg_2_0.transition = HeroTools.InitTransitionByCfg(var_2_4, var_2_5)
	arg_2_0.trust = {
		level = arg_2_1.trust.level,
		exp = arg_2_1.trust.exp,
		mood = arg_2_1.trust.mood
	}

	local var_2_7 = HeroTrustRelationNet.New(var_2_0.id)

	var_2_7:InitData(arg_2_1.trust.relation)

	arg_2_0.relation = var_2_7
	arg_2_0.mainDamageType = arg_2_1.main_damage_type
end

function var_0_0.ModifyHero(arg_3_0, arg_3_1)
	arg_3_0:Init(arg_3_1)
end

function var_0_0.GetServantInfo(arg_4_0)
	return arg_4_0.servantInfo
end

function var_0_0.GetWeaponInfo(arg_5_0)
	return arg_5_0.weapon_info
end

function var_0_0.GetEquipInfoList(arg_6_0)
	return arg_6_0.equip
end

function var_0_0.GetSkillInfoList(arg_7_0)
	return arg_7_0.skill
end

function var_0_0.GetSkillAttrList(arg_8_0)
	return arg_8_0.skillAttrList
end

function var_0_0.GetTransitionInfoList(arg_9_0)
	return arg_9_0.transition
end

function var_0_0.InitTransition(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		var_10_0[iter_10_0] = {
			slot_id = iter_10_1.slot_id,
			skill_list = cleanProtoTable(iter_10_1.skill_list, {
				"skill_id",
				"skill_level"
			}),
			talent_points = iter_10_1.talent_points
		}
	end

	return var_10_0
end

function var_0_0.GetType(arg_11_0)
	return HeroConst.HERO_DATA_TYPE.COOPERATION
end

function var_0_0.InitHeroEquip(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {
		{
			pos = 1,
			prefab_id = 0
		},
		{
			pos = 2,
			prefab_id = 0
		},
		{
			pos = 3,
			prefab_id = 0
		},
		{
			pos = 4,
			prefab_id = 0
		},
		{
			pos = 5,
			prefab_id = 0
		},
		{
			pos = 6,
			prefab_id = 0
		}
	}

	for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
		local var_12_1 = iter_12_1.prefab_id

		var_12_0[EquipCfg[var_12_1].pos].equip_id = var_12_1

		local var_12_2 = {
			race_preview = 0,
			is_lock = true,
			equip_id = iter_12_0,
			prefab_id = var_12_1,
			exp = iter_12_1.exp,
			hero_id = arg_12_1,
			now_break_level = iter_12_1.now_break_level,
			enchant_slot_list = arg_12_0:InitEnchantInfo(iter_12_1.enchant_slot_list),
			race = iter_12_1.race
		}
		local var_12_3 = EquipStruct.New(var_12_2.equip_id, var_12_2.prefab_id)

		var_12_3:ParseServerData(var_12_2)

		arg_12_0.equip_list[iter_12_0] = var_12_3
	end

	return var_12_0
end

function var_0_0.InitEnchantInfo(arg_13_0, arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		var_13_0[iter_13_1.id] = {
			id = iter_13_1.id,
			effect_list = cleanProtoTable(iter_13_1.effect_list, {
				"id",
				"level"
			}),
			preview_list = {}
		}
	end

	return var_13_0
end

function var_0_0.IsOath(arg_14_0)
	if arg_14_0.trialID then
		return false
	else
		return arg_14_0.oathOverride or OathTools.IsOath(arg_14_0.id)
	end
end

return var_0_0
