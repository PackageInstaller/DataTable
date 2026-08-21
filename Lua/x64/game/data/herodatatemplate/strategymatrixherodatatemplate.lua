local var_0_0 = class("StrategyMatrixHeroDataTemplate", TemplateHeroDataTemplate)

function var_0_0.Init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.tempID = arg_1_1.id
	arg_1_0.id = SkinCfg[arg_1_1.skin_id].hero
	arg_1_0.exp = LvTools.LevelToExp(arg_1_1.hero_lv, "hero_level_exp1")
	arg_1_0.level = arg_1_1.hero_lv
	arg_1_0.star = arg_1_1.star_lv
	arg_1_0.unlock = 1
	arg_1_0.skill = arg_1_0:GetSkillTable(arg_1_0.id, arg_1_1.skill_lv)
	arg_1_0.skillAttrList = arg_1_0:GetSkillAttrTable(arg_1_1.skill_element)
	arg_1_0.unlocked_astrolabe = arg_1_1.astrolabe_id ~= "" and arg_1_1.astrolabe_id or {}
	arg_1_0.using_astrolabe = arg_1_3
	arg_1_0.equip = arg_1_0:GetEquipTable(arg_1_1.equip_list)
	arg_1_0.equip_list_data = arg_1_2
	arg_1_0.equip_list = arg_1_0:GetConstructVirtualEquips(arg_1_1.id)
	arg_1_0.clear_mission_list = {}
	arg_1_0.clear_times = 0
	arg_1_0.break_level = arg_1_1.hero_break
	arg_1_0.weapon_info = {
		level = arg_1_1.weapon_level,
		exp = GameLevelSetting[arg_1_1.weapon_level].weapon_lv_exp_sum,
		breakthrough = arg_1_1.weapon_break
	}
	arg_1_0.transition = HeroTools.InitTransitionByCfg(arg_1_1.equip_exclusive_id_list, arg_1_1.equip_exclusive_lv_list)
	arg_1_0.servant_uid = arg_1_1.weapon_key
	arg_1_0.servantInfo = arg_1_4
	arg_1_0.moduleLevel = arg_1_1.weapon_module_level
	arg_1_0.using_skin = HeroData:GetHeroData(arg_1_0.id).using_skin
	arg_1_0.battle_using_skin = HeroData:GetHeroData(arg_1_0.id).battle_using_skin
	arg_1_0.weapon_module_level = arg_1_1.weapon_module_level

	local var_1_0 = HeroCfg[arg_1_0.id]
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0.astrolabe or {}) do
		local var_1_2 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_1_1] or {}

		for iter_1_2, iter_1_3 in pairs(var_1_2) do
			table.insert(var_1_1, iter_1_3)
		end
	end

	arg_1_0.unlocked_astrolabe = var_1_1
end

function var_0_0.GetType(arg_2_0)
	return HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX
end

return var_0_0
