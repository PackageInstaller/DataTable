local var_0_0 = class("ChallengeRogueTeamHeroDataTemplate", BaseHeroDataTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = HeroCfg[arg_1_1]
	local var_1_1 = {
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
	local var_1_2 = {}
	local var_1_3 = {}

	arg_1_0.id = arg_1_1
	arg_1_0.exp = 0
	arg_1_0.level = 1
	arg_1_0.star = var_1_0.unlock_star
	arg_1_0.using_skin = 0
	arg_1_0.break_level = 0
	arg_1_0.unlock = 0
	arg_1_0.unlocked_astrolabe = {}
	arg_1_0.using_astrolabe = {}
	arg_1_0.equip = var_1_1
	arg_1_0.skill = var_1_2
	arg_1_0.skillAttrList = var_1_3
	arg_1_0.weapon_info = {
		exp = 0,
		breakthrough = 0,
		level = 1
	}
	arg_1_0.servant_uid = 0
	arg_1_0.servantInfo = {
		id = 0,
		uid = 0,
		lock = true,
		stage = 1
	}
	arg_1_0.transition = {}
	arg_1_0.moduleLevel = 0
	arg_1_0.moduleAssignment = 0
	arg_1_0.piece = 0
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.hpPercent = arg_2_2
	arg_2_0.id = arg_2_1.id
	arg_2_0.exp = arg_2_1.exp
	arg_2_0.level = arg_2_1.level
	arg_2_0.star = arg_2_1.star
	arg_2_0.unlock = arg_2_1.unlock
	arg_2_0.skill = arg_2_1.skill
	arg_2_0.skillAttrList = arg_2_1.skillAttrList
	arg_2_0.unlocked_astrolabe = arg_2_1.unlocked_astrolabe
	arg_2_0.using_astrolabe = arg_2_1.using_astrolabe
	arg_2_0.equip = arg_2_1.equip
	arg_2_0.equip_list = arg_2_1.equip_list
	arg_2_0.clear_mission_list = arg_2_1.clear_mission_list
	arg_2_0.clear_times = arg_2_1.clear_times
	arg_2_0.break_level = arg_2_1.break_level
	arg_2_0.weapon_info = arg_2_1.weapon_info
	arg_2_0.transition = arg_2_1.transition
	arg_2_0.servant_uid = arg_2_1.servant_uid
	arg_2_0.servantInfo = arg_2_1:GetServantInfo()
	arg_2_0.moduleLevel = arg_2_1.moduleLevel
	arg_2_0.using_skin = arg_2_1.using_skin
	arg_2_0.battle_using_skin = arg_2_1.battle_using_skin
	arg_2_0.weapon_module_level = arg_2_1.weapon_module_level
end

function var_0_0.ModifyHero(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:Init(arg_3_1, arg_3_2)
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
	return HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM
end

return var_0_0
