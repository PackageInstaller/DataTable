local ForeignHeroDataTemplate = class("ForeignHeroDataTemplate", BaseHeroDataTemplate)

function ForeignHeroDataTemplate:Ctor(arg_1_1)
	ForeignHeroDataTemplate.super.Ctor(self, arg_1_1)

	self.relation = HeroTrustRelationNet.New(arg_1_1)
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

function ForeignHeroDataTemplate:Init(arg_2_1)
	self.id = arg_2_1.hero_base_info.id
	self.exp = arg_2_1.hero_base_info.exp
	self.level = arg_2_1.hero_base_info.level
	self.star = arg_2_1.hero_base_info.star
	self.skill = cleanProtoTable(arg_2_1.hero_base_info.skill, {
		"skill_id",
		"skill_level"
	})
	self.skillAttrList = cleanProtoTable(arg_2_1.hero_base_info.skill_intensify_attribute_list, {
		"index",
		"level"
	})
	self.unlocked_astrolabe = cleanProtoTable(arg_2_1.hero_base_info.unlock_astrolabe)
	self.using_astrolabe = cleanProtoTable(arg_2_1.hero_base_info.using_astrolabe)
	self.break_level = arg_2_1.hero_base_info.break_level
	self.weapon_info = {
		level = WeaponTools.ExpToLv(arg_2_1.hero_base_info.weapon.exp),
		exp = arg_2_1.hero_base_info.weapon.exp,
		breakthrough = arg_2_1.hero_base_info.weapon.breakthrough
	}
	self.using_skin = arg_2_1.hero_base_info.using_skin
	self.battle_using_skin = arg_2_1.hero_base_info.battle_using_skin
	self.moduleLevel = arg_2_1.hero_base_info.weapon_module_level
	self.servantInfo = {
		uid = 0,
		locked = true,
		id = arg_2_1.hero_base_info.servant.id,
		stage = arg_2_1.hero_base_info.servant.stage
	}
	self.transition = self:InitTransition(arg_2_1.hero_base_info.exclusive_skill_list or {})
	self.unlock = 1
	self.using_hero_chip = cleanProtoTable(arg_2_1.using_hero_chip)
	self.equip = self:InitHeroEquip(arg_2_1.hero_base_info.id, arg_2_1.equip_list)
	self.servant_uid = 0
	self.moduleAssignment = {}
	self.unlocked_skin = {}
	self.dormLevel = arg_2_1.dorm_level
	self.trust = {
		level = arg_2_1.trust.level,
		exp = arg_2_1.trust.exp,
		mood = arg_2_1.trust.mood
	}

	local var_2_0 = HeroTrustRelationNet.New(arg_2_1.hero_base_info.id)

	var_2_0:InitData(arg_2_1.trust.relation)

	self.relation = var_2_0
	self.hero_oath_display = nil
end

function ForeignHeroDataTemplate:SetOathInfo(arg_3_1)
	self.hero_oath_display = arg_3_1
end

function ForeignHeroDataTemplate:ModifyHero(arg_4_1)
	self:Init(arg_4_1)
end

function ForeignHeroDataTemplate:GetServantInfo()
	return self.servantInfo
end

function ForeignHeroDataTemplate:GetWeaponInfo()
	return self.weapon_info
end

function ForeignHeroDataTemplate:GetEquipInfoList()
	return self.equip
end

function ForeignHeroDataTemplate:GetSkillInfoList()
	return self.skill
end

function ForeignHeroDataTemplate:GetSkillAttrList()
	return self.skillAttrList
end

function ForeignHeroDataTemplate:GetTransitionInfoList()
	return self.transition
end

function ForeignHeroDataTemplate:InitTransition(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		var_11_0[iter_11_0] = {
			slot_id = iter_11_1.slot_id,
			skill_list = cleanProtoTable(iter_11_1.skill_list, {
				"skill_id",
				"skill_level"
			}),
			talent_points = iter_11_1.talent_points
		}
	end

	return var_11_0
end

function ForeignHeroDataTemplate:GetType()
	return HeroConst.HERO_DATA_TYPE.FOREIGN
end

function ForeignHeroDataTemplate:InitHeroEquip(arg_13_1, arg_13_2)
	local var_13_0 = {
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

	for iter_13_0, iter_13_1 in ipairs(arg_13_2) do
		var_13_0[EquipCfg[iter_13_1.equip_id].pos].equip_id = iter_13_1.equip_id

		local var_13_1 = {
			race_preview = 0,
			is_lock = true,
			equip_id = iter_13_0,
			prefab_id = iter_13_1.equip_id,
			exp = iter_13_1.exp,
			hero_id = arg_13_1,
			now_break_level = iter_13_1.now_break_level,
			enchant_slot_list = self:InitEnchantInfo(iter_13_1.enchant_slot_list),
			race = iter_13_1.race
		}
		local var_13_2 = EquipStruct.New(var_13_1.equip_id, var_13_1.prefab_id)

		var_13_2:ParseServerData(var_13_1)

		self.equip_list[iter_13_0] = var_13_2
	end

	return var_13_0
end

function ForeignHeroDataTemplate:InitEnchantInfo(arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		var_14_0[iter_14_1.id] = {
			id = iter_14_1.id,
			effect_list = cleanProtoTable(iter_14_1.effect_list, {
				"id",
				"level"
			}),
			preview_list = {}
		}
	end

	return var_14_0
end

function ForeignHeroDataTemplate:IsOath()
	return nullable(self.hero_oath_display, "oath")
end

return ForeignHeroDataTemplate
