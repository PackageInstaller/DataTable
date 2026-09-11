local TemplateHeroDataTemplate = class("TemplateHeroDataTemplate", BaseHeroDataTemplate)

function TemplateHeroDataTemplate:Ctor(arg_1_1)
	TemplateHeroDataTemplate.super.Ctor(self, arg_1_1)

	self.piece = 0
	self.unlocked_skin = {}
end

function TemplateHeroDataTemplate:Init(arg_2_1)
	self.tempID = arg_2_1.id
	self.id = SkinCfg[arg_2_1.skin_id].hero
	self.exp = LvTools.LevelToExp(arg_2_1.hero_lv, "hero_level_exp1")
	self.level = arg_2_1.hero_lv
	self.star = arg_2_1.star_lv
	self.unlock = 1
	self.skill = self:GetSkillTable(self.id, arg_2_1.skill_lv)
	self.skillAttrList = self:GetSkillAttrTable(arg_2_1.skill_element)

	if arg_2_1.astrolabe_id ~= "" then
		self.unlocked_astrolabe = arg_2_1.astrolabe_id or {}
	end

	if arg_2_1.astrolabe_id ~= "" then
		self.using_astrolabe = arg_2_1.astrolabe_id or {}
	end

	self.equip = self:GetEquipTable(arg_2_1.equip_list)
	self.equip_list = self:GetConstructVirtualEquips(arg_2_1.id)
	self.clear_mission_list = {}
	self.clear_times = 0
	self.break_level = arg_2_1.hero_break
	self.weapon_info = {
		level = arg_2_1.weapon_level,
		exp = GameLevelSetting[arg_2_1.weapon_level].weapon_lv_exp_sum,
		breakthrough = arg_2_1.weapon_break
	}
	self.transition = HeroTools.InitTransitionByCfg(arg_2_1.equip_exclusive_id_list, arg_2_1.equip_exclusive_lv_list)
	self.servant_uid = arg_2_1.weapon_key
	self.servantInfo = {
		uid = 0,
		locked = true,
		id = arg_2_1.weapon_key,
		stage = arg_2_1.weapon_stage
	}
	self.moduleLevel = arg_2_1.weapon_module_level
	self.using_skin = arg_2_1.skin_id
	self.battle_using_skin = arg_2_1.skin_id
	self.weapon_module_level = arg_2_1.weapon_module_level
end

function TemplateHeroDataTemplate:ModifyHero(arg_3_1)
	self:Init(arg_3_1)
end

function TemplateHeroDataTemplate:GetServantInfo()
	return self.servantInfo
end

function TemplateHeroDataTemplate:GetWeaponInfo()
	return self.weapon_info
end

function TemplateHeroDataTemplate:GetEquipInfoList()
	return self.equip
end

function TemplateHeroDataTemplate:GetSkillInfoList()
	return self.skill
end

function TemplateHeroDataTemplate:GetTransitionInfoList()
	return self.transition
end

function TemplateHeroDataTemplate:GetType()
	return HeroConst.HERO_DATA_TYPE.TRIAL
end

function TemplateHeroDataTemplate:GetSkillTable(arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(HeroCfg[arg_10_1].skills) do
		var_10_0[iter_10_0] = {}
		var_10_0[iter_10_0].skill_id = iter_10_1
		var_10_0[iter_10_0].skill_level = arg_10_2

		if iter_10_1 == HeroCfg[arg_10_1].avoid[1] then
			var_10_0[iter_10_0].skill_level = 1
		end
	end

	return var_10_0
end

function TemplateHeroDataTemplate:GetSkillAttrTable(arg_11_1)
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

function TemplateHeroDataTemplate:GetEquipTable(arg_12_1)
	local var_12_0 = {}

	for iter_12_0 = 1, 6 do
		var_12_0[iter_12_0] = {}
		var_12_0[iter_12_0].pos = iter_12_0

		if arg_12_1[iter_12_0] then
			var_12_0[iter_12_0].prefab_id = arg_12_1[iter_12_0] or 0
		end
	end

	return var_12_0
end

function TemplateHeroDataTemplate:GetConstructVirtualEquips(arg_13_1)
	local var_13_0 = {}

	if type(HeroStandardSystemCfg[arg_13_1].equip_list) ~= "table" then
		return var_13_0
	end

	for iter_13_0, iter_13_1 in ipairs(HeroStandardSystemCfg[arg_13_1].equip_list) do
		local var_13_1 = EquipStruct.New(0, iter_13_1)

		var_13_1.equip_id = 1
		var_13_1.prefab_id = iter_13_1
		var_13_1.exp = EquipExpCfg[HeroStandardSystemCfg[arg_13_1].equip_lv]["exp_sum_" .. EquipCfg[iter_13_1].starlevel]
		var_13_1.race = HeroStandardSystemCfg[arg_13_1].hero_id
		var_13_1.now_break_level = HeroStandardSystemCfg[arg_13_1].break_lv - 1
		var_13_1.enchant = {}

		for iter_13_2, iter_13_3 in ipairs(HeroStandardSystemCfg[arg_13_1].equip_pool_list[iter_13_0] or {}) do
			for iter_13_4, iter_13_5 in ipairs(EquipSkillPoolCfg[iter_13_3].skill_id) do
				table.insert(var_13_1.enchant, {
					{
						id = iter_13_5[1],
						num = iter_13_5[2]
					}
				})
			end
		end

		table.insert(var_13_0, var_13_1)
	end

	return var_13_0
end

function TemplateHeroDataTemplate:IsOath()
	return false
end

return TemplateHeroDataTemplate
