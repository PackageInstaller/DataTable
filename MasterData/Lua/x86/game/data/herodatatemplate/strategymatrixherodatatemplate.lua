local StrategyMatrixHeroDataTemplate = class("StrategyMatrixHeroDataTemplate", TemplateHeroDataTemplate)

function StrategyMatrixHeroDataTemplate:Init(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.tempID = arg_1_1.id
	self.id = SkinCfg[arg_1_1.skin_id].hero
	self.exp = LvTools.LevelToExp(arg_1_1.hero_lv, "hero_level_exp1")
	self.level = arg_1_1.hero_lv
	self.star = arg_1_1.star_lv
	self.unlock = 1
	self.skill = self:GetSkillTable(self.id, arg_1_1.skill_lv)
	self.skillAttrList = self:GetSkillAttrTable(arg_1_1.skill_element)

	if arg_1_1.astrolabe_id ~= "" then
		self.unlocked_astrolabe = arg_1_1.astrolabe_id or {}
	end

	self.using_astrolabe = arg_1_3
	self.equip = self:GetEquipTable(arg_1_1.equip_list)
	self.equip_list_data = arg_1_2
	self.equip_list = self:GetConstructVirtualEquips(arg_1_1.id)
	self.clear_mission_list = {}
	self.clear_times = 0
	self.break_level = arg_1_1.hero_break
	self.weapon_info = {
		level = arg_1_1.weapon_level,
		exp = GameLevelSetting[arg_1_1.weapon_level].weapon_lv_exp_sum,
		breakthrough = arg_1_1.weapon_break
	}
	self.transition = HeroTools.InitTransitionByCfg(arg_1_1.equip_exclusive_id_list, arg_1_1.equip_exclusive_lv_list)
	self.servant_uid = arg_1_1.weapon_key
	self.servantInfo = arg_1_4
	self.moduleLevel = arg_1_1.weapon_module_level
	self.using_skin = HeroData:GetHeroData(self.id).using_skin
	self.battle_using_skin = HeroData:GetHeroData(self.id).battle_using_skin
	self.weapon_module_level = arg_1_1.weapon_module_level

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(HeroCfg[self.id].astrolabe or {}) do
		for iter_1_2, iter_1_3 in pairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_1_1] or {}) do
			table.insert(var_1_0, iter_1_3)
		end
	end

	self.unlocked_astrolabe = var_1_0
end

function StrategyMatrixHeroDataTemplate:GetType()
	return HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX
end

return StrategyMatrixHeroDataTemplate
