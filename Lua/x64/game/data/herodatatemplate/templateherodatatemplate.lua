local var_0_0 = class("TemplateHeroDataTemplate", BaseHeroDataTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	TemplateHeroDataTemplate.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.piece = 0
	arg_1_0.unlocked_skin = {}
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.tempID = arg_2_1.id
	arg_2_0.id = SkinCfg[arg_2_1.skin_id].hero
	arg_2_0.exp = LvTools.LevelToExp(arg_2_1.hero_lv, "hero_level_exp1")
	arg_2_0.level = arg_2_1.hero_lv
	arg_2_0.star = arg_2_1.star_lv
	arg_2_0.unlock = 1
	arg_2_0.skill = arg_2_0:GetSkillTable(arg_2_0.id, arg_2_1.skill_lv)
	arg_2_0.skillAttrList = arg_2_0:GetSkillAttrTable(arg_2_1.skill_element)
	arg_2_0.unlocked_astrolabe = arg_2_1.astrolabe_id ~= "" and arg_2_1.astrolabe_id or {}
	arg_2_0.using_astrolabe = arg_2_1.astrolabe_id ~= "" and arg_2_1.astrolabe_id or {}
	arg_2_0.equip = arg_2_0:GetEquipTable(arg_2_1.equip_list)
	arg_2_0.equip_list = arg_2_0:GetConstructVirtualEquips(arg_2_1.id)
	arg_2_0.clear_mission_list = {}
	arg_2_0.clear_times = 0
	arg_2_0.break_level = arg_2_1.hero_break
	arg_2_0.weapon_info = {
		level = arg_2_1.weapon_level,
		exp = GameLevelSetting[arg_2_1.weapon_level].weapon_lv_exp_sum,
		breakthrough = arg_2_1.weapon_break
	}
	arg_2_0.transition = HeroTools.InitTransitionByCfg(arg_2_1.equip_exclusive_id_list, arg_2_1.equip_exclusive_lv_list)
	arg_2_0.servant_uid = arg_2_1.weapon_key
	arg_2_0.servantInfo = {
		uid = 0,
		locked = true,
		id = arg_2_1.weapon_key,
		stage = arg_2_1.weapon_stage
	}
	arg_2_0.moduleLevel = arg_2_1.weapon_module_level
	arg_2_0.using_skin = arg_2_1.skin_id
	arg_2_0.battle_using_skin = arg_2_1.skin_id
	arg_2_0.weapon_module_level = arg_2_1.weapon_module_level
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

function var_0_0.GetTransitionInfoList(arg_8_0)
	return arg_8_0.transition
end

function var_0_0.GetType(arg_9_0)
	return HeroConst.HERO_DATA_TYPE.TRIAL
end

function var_0_0.GetSkillTable(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}
	local var_10_1 = HeroCfg[arg_10_1].skills

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		var_10_0[iter_10_0] = {}
		var_10_0[iter_10_0].skill_id = iter_10_1
		var_10_0[iter_10_0].skill_level = arg_10_2

		if iter_10_1 == HeroCfg[arg_10_1].avoid[1] then
			var_10_0[iter_10_0].skill_level = 1
		end
	end

	return var_10_0
end

function var_0_0.GetSkillAttrTable(arg_11_0, arg_11_1)
	local var_11_0 = {}

	if type(arg_11_1) ~= "table" then
		return var_11_0
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		table.insert(var_11_0, {
			index = iter_11_0,
			level = iter_11_1
		})
	end

	return var_11_0
end

function var_0_0.GetEquipTable(arg_12_0, arg_12_1)
	local var_12_0 = {}

	for iter_12_0 = 1, 6 do
		var_12_0[iter_12_0] = {}
		var_12_0[iter_12_0].pos = iter_12_0
		var_12_0[iter_12_0].prefab_id = arg_12_1[iter_12_0] and arg_12_1[iter_12_0] or 0
	end

	return var_12_0
end

function var_0_0.GetConstructVirtualEquips(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = HeroStandardSystemCfg[arg_13_1]

	if type(var_13_1.equip_list) ~= "table" then
		return var_13_0
	end

	for iter_13_0, iter_13_1 in ipairs(var_13_1.equip_list) do
		local var_13_2 = EquipCfg[iter_13_1]
		local var_13_3 = EquipStruct.New(0, iter_13_1)

		var_13_3.equip_id = 1
		var_13_3.prefab_id = iter_13_1
		var_13_3.exp = EquipExpCfg[var_13_1.equip_lv]["exp_sum_" .. var_13_2.starlevel]
		var_13_3.race = var_13_1.hero_id
		var_13_3.now_break_level = var_13_1.break_lv - 1
		var_13_3.enchant = {}

		for iter_13_2, iter_13_3 in ipairs(var_13_1.equip_pool_list[iter_13_0] or {}) do
			for iter_13_4, iter_13_5 in ipairs(EquipSkillPoolCfg[iter_13_3].skill_id) do
				table.insert(var_13_3.enchant, {
					{
						id = iter_13_5[1],
						num = iter_13_5[2]
					}
				})
			end
		end

		table.insert(var_13_0, var_13_3)
	end

	return var_13_0
end

function var_0_0.IsOath(arg_14_0)
	return false
end

return var_0_0
