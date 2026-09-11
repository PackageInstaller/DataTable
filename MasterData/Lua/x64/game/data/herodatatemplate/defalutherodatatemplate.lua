local DefaultHeroDataTemplate = class("DefaultHeroDataTemplate", BaseHeroDataTemplate)

function DefaultHeroDataTemplate:Ctor(arg_1_1)
	DefaultHeroDataTemplate.super.Ctor(self, arg_1_1)

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
	self.timeValid_skin = {}
end

function DefaultHeroDataTemplate:Init(arg_2_1)
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
	self.servant_uid = tonumber(arg_2_1.hero_base_info.weapon.servant_uid) or 0
	self.transition = self:InitTransition(arg_2_1.hero_base_info.exclusive_skill_list or {})
	self.unlock = arg_2_1.unlock
	self.equip = cleanProtoTable(arg_2_1.equip, {
		"pos",
		"equip_id"
	})
	self.clear_mission_list = cleanProtoTable(arg_2_1.clear_mission_list)
	self.clear_times = arg_2_1.clear_times or 0
	self.moduleAssignment = arg_2_1.weapon_module_assignment
	self.unlocked_skin = cleanProtoTable(arg_2_1.unlocked_skin, {
		"skin_id",
		"time"
	})
	self.trust = {
		level = arg_2_1.trust.level,
		exp = arg_2_1.trust.exp,
		mood = arg_2_1.trust.mood
	}

	local var_2_0 = HeroTrustRelationNet.New(arg_2_1.hero_base_info.id)

	var_2_0:InitData(arg_2_1.trust.relation)

	self.relation = var_2_0
end

function DefaultHeroDataTemplate:ModifyHero(arg_3_1)
	self:Init(arg_3_1)
end

function DefaultHeroDataTemplate:GetServantInfo()
	return WeaponServantData.GetWeaponServantList()[self.servant_uid] or {
		id = 0,
		uid = 0,
		lock = true,
		stage = 1
	}
end

function DefaultHeroDataTemplate:GetWeaponInfo()
	return self.weapon_info
end

function DefaultHeroDataTemplate:GetEquipInfoList()
	return self.equip
end

function DefaultHeroDataTemplate:GetSkillInfoList()
	return self.skill
end

function DefaultHeroDataTemplate:GetSkillAttrList()
	return self.skillAttrList
end

function DefaultHeroDataTemplate:GetTransitionInfoList()
	return self.transition
end

function DefaultHeroDataTemplate:InitTransition(arg_10_1)
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

function DefaultHeroDataTemplate:GetType()
	return HeroConst.HERO_DATA_TYPE.DEFAULT
end

function DefaultHeroDataTemplate:SetPicece(arg_12_1)
	self.piece = arg_12_1
end

function DefaultHeroDataTemplate:IsOath()
	return OathTools.IsOath(self.id)
end

return DefaultHeroDataTemplate
