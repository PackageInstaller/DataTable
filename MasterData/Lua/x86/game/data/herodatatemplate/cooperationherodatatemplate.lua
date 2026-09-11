local CooperationHeroDataTemplate = class("CooperationHeroDataTemplate", BaseHeroDataTemplate)

function CooperationHeroDataTemplate:Ctor(arg_1_1)
	CooperationHeroDataTemplate.super.Ctor(self, arg_1_1)

	self.trust = {
		exp = 0,
		mood = 1,
		level = 0
	}
	self.clear_mission_list = {}
	self.clear_times = 0
	self.piece = 0
	self.unlocked_skin = {}
	self.equipDataList = {}
	self.dormLevel = 0
	self.equip_list = {}
end

function CooperationHeroDataTemplate:Init(arg_2_1)
	local var_2_0 = arg_2_1.hero_base_info.using_skin

	if arg_2_1.hero_type == 2 then
		self.trialID = arg_2_1.hero_base_info.id
		self.id = HeroStandardSystemCfg[arg_2_1.hero_base_info.id].hero_id
	else
		self.id = arg_2_1.hero_base_info.id

		if arg_2_1.hero_type == 3 then
			self.oathOverride = ForeignInfoData:GetHeroData(self.id):IsOath()
		end
	end

	self.unlock = 1
	self.skin = var_2_0
	self.battle_using_skin = arg_2_1.hero_base_info.battle_using_skin
	self.star = arg_2_1.hero_base_info.star
	self.exp = arg_2_1.hero_base_info.exp
	self.level = HeroTools.CheckExp(1, arg_2_1.hero_base_info.exp)
	self.equip_list = {}
	self.using_astrolabe = {}
	self.skill = {}
	self.skillAttrList = {}
	self.break_level = arg_2_1.hero_base_info.break_level
	self.weapon_info = {
		exp = arg_2_1.hero_base_info.weapon.exp,
		breakthrough = arg_2_1.hero_base_info.weapon.breakthrough
	}
	self.transition = {}
	self.weapon_module_level = arg_2_1.hero_base_info.weapon_module_level
	self.dormLevel = arg_2_1.dorm_level
	self.servantInfo = {
		id = arg_2_1.hero_base_info.servant.id,
		stage = arg_2_1.hero_base_info.servant.stage
	}
	self.equip = self:InitHeroEquip(arg_2_1.hero_base_info.id, arg_2_1.equip_list)

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.hero_base_info.using_astrolabe) do
		self.using_astrolabe[iter_2_0] = iter_2_1
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.hero_base_info.skill) do
		self.skill[iter_2_2] = {
			skill_id = iter_2_3.skill_id,
			skill_level = iter_2_3.skill_level
		}
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.hero_base_info.skill_intensify_attribute_list) do
		self.skillAttrList[iter_2_4] = {
			index = iter_2_5.index,
			level = iter_2_5.level
		}
	end

	local var_2_1 = {}
	local var_2_2 = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.hero_base_info.exclusive_skill_list) do
		var_2_1[iter_2_7.slot_id] = {}
		var_2_2[iter_2_7.slot_id] = {}

		for iter_2_8, iter_2_9 in ipairs(iter_2_7.skill_list) do
			table.insert(var_2_1[iter_2_7.slot_id], iter_2_9.skill_id)
			table.insert(var_2_2[iter_2_7.slot_id], iter_2_9.skill_level)
		end
	end

	self.transition = HeroTools.InitTransitionByCfg(var_2_1, var_2_2)
	self.trust = {
		level = arg_2_1.trust.level,
		exp = arg_2_1.trust.exp,
		mood = arg_2_1.trust.mood
	}

	local var_2_3 = HeroTrustRelationNet.New(arg_2_1.hero_base_info.id)

	var_2_3:InitData(arg_2_1.trust.relation)

	self.relation = var_2_3
	self.mainDamageType = arg_2_1.main_damage_type
end

function CooperationHeroDataTemplate:ModifyHero(arg_3_1)
	self:Init(arg_3_1)
end

function CooperationHeroDataTemplate:GetServantInfo()
	return self.servantInfo
end

function CooperationHeroDataTemplate:GetWeaponInfo()
	return self.weapon_info
end

function CooperationHeroDataTemplate:GetEquipInfoList()
	return self.equip
end

function CooperationHeroDataTemplate:GetSkillInfoList()
	return self.skill
end

function CooperationHeroDataTemplate:GetSkillAttrList()
	return self.skillAttrList
end

function CooperationHeroDataTemplate:GetTransitionInfoList()
	return self.transition
end

function CooperationHeroDataTemplate:InitTransition(arg_10_1)
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

function CooperationHeroDataTemplate:GetType()
	return HeroConst.HERO_DATA_TYPE.COOPERATION
end

function CooperationHeroDataTemplate:InitHeroEquip(arg_12_1, arg_12_2)
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
		var_12_0[EquipCfg[iter_12_1.prefab_id].pos].equip_id = iter_12_1.prefab_id

		local var_12_1 = {
			race_preview = 0,
			is_lock = true,
			equip_id = iter_12_0,
			prefab_id = iter_12_1.prefab_id,
			exp = iter_12_1.exp,
			hero_id = arg_12_1,
			now_break_level = iter_12_1.now_break_level,
			enchant_slot_list = self:InitEnchantInfo(iter_12_1.enchant_slot_list),
			race = iter_12_1.race
		}
		local var_12_2 = EquipStruct.New(var_12_1.equip_id, var_12_1.prefab_id)

		var_12_2:ParseServerData(var_12_1)

		self.equip_list[iter_12_0] = var_12_2
	end

	return var_12_0
end

function CooperationHeroDataTemplate:InitEnchantInfo(arg_13_1)
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

function CooperationHeroDataTemplate:IsOath()
	if self.trialID then
		return false
	else
		return self.oathOverride or OathTools.IsOath(self.id)
	end
end

return CooperationHeroDataTemplate
