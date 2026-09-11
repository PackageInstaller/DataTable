local HodurHeroDataTemplate = class("HodurHeroDataTemplate", TemplateHeroDataTemplate)

function HodurHeroDataTemplate:Ctor(arg_1_1)
	self.id = arg_1_1
	self.exp = 0
	self.level = 1
	self.star = HeroCfg[arg_1_1].unlock_star
	self.using_skin = 0
	self.break_level = 0
	self.unlock = 0
	self.unlocked_astrolabe = {}
	self.using_astrolabe = {}
	self.equip = {
		{
			pos = 1,
			equip_id = 0
		},
		{
			pos = 2,
			equip_id = 0
		},
		{
			pos = 3,
			equip_id = 0
		},
		{
			pos = 4,
			equip_id = 0
		},
		{
			pos = 5,
			equip_id = 0
		},
		{
			pos = 6,
			equip_id = 0
		}
	}
	self.skill = {}
	self.skillAttrList = {}
	self.weapon_info = {
		exp = 0,
		breakthrough = 0,
		level = 1
	}
	self.servant_uid = 0
	self.servantInfo = {
		id = 0,
		uid = 0,
		lock = true,
		stage = 1
	}
	self.transition = {}
	self.moduleLevel = 0
	self.moduleAssignment = 0
	self.piece = 0
end

function HodurHeroDataTemplate:Init(arg_2_1)
	self.id = arg_2_1.id
	self.exp = arg_2_1.exp
	self.level = arg_2_1.level
	self.star = arg_2_1.star
	self.unlock = arg_2_1.unlock
	self.skill = arg_2_1.skill
	self.skillAttrList = arg_2_1.skillAttrList
	self.unlocked_astrolabe = arg_2_1.unlocked_astrolabe
	self.using_astrolabe = arg_2_1.using_astrolabe
	self.battle_using_skin = arg_2_1.battle_using_skin
	self.equip = arg_2_1.equip
	self.equip_list = arg_2_1.equip_list
	self.clear_mission_list = arg_2_1.clear_mission_list
	self.clear_times = arg_2_1.clear_times
	self.break_level = arg_2_1.break_level
	self.weapon_info = arg_2_1.weapon_info
	self.transition = arg_2_1.transition
	self.servant_uid = arg_2_1.servant_uid
	self.servantInfo = {
		uid = arg_2_1:GetServantInfo().uid,
		id = arg_2_1:GetServantInfo().id,
		stage = arg_2_1:GetServantInfo().stage,
		lock = arg_2_1:GetServantInfo().lock
	}
	self.moduleLevel = arg_2_1.moduleLevel
	self.using_skin = arg_2_1.using_skin
	self.weapon_module_level = arg_2_1.weapon_module_level
end

function HodurHeroDataTemplate:ModifyHero(arg_3_1, arg_3_2)
	self:Init(arg_3_1, arg_3_2)
end

function HodurHeroDataTemplate:GetServantInfo()
	return self.servantInfo
end

function HodurHeroDataTemplate:GetWeaponInfo()
	return self.weapon_info
end

function HodurHeroDataTemplate:GetEquipInfoList()
	return self.equip
end

function HodurHeroDataTemplate:GetSkillInfoList()
	return self.skill
end

function HodurHeroDataTemplate:GetTransitionInfoList()
	return self.transition
end

function HodurHeroDataTemplate:GetType()
	return HeroConst.HERO_DATA_TYPE.HODURGAME
end

return HodurHeroDataTemplate
