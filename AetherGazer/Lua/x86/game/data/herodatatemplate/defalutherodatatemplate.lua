local var_0_0 = class("DefaultHeroDataTemplate", BaseHeroDataTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.relation = HeroTrustRelationNet.New(arg_1_1)
	arg_1_0.trust = {
		exp = 0,
		mood = 1,
		level = 0
	}
	arg_1_0.clear_mission_list = {}
	arg_1_0.clear_times = 0
	arg_1_0.piece = 0
	arg_1_0.unlocked_skin = {}
	arg_1_0.timeValid_skin = {}
end

function var_0_0.Init(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.hero_base_info

	arg_2_0.id = var_2_0.id
	arg_2_0.exp = var_2_0.exp
	arg_2_0.level = var_2_0.level
	arg_2_0.star = var_2_0.star
	arg_2_0.skill = cleanProtoTable(var_2_0.skill, {
		"skill_id",
		"skill_level"
	})
	arg_2_0.skillAttrList = cleanProtoTable(var_2_0.skill_intensify_attribute_list, {
		"index",
		"level"
	})
	arg_2_0.unlocked_astrolabe = cleanProtoTable(var_2_0.unlock_astrolabe)
	arg_2_0.using_astrolabe = cleanProtoTable(var_2_0.using_astrolabe)
	arg_2_0.break_level = var_2_0.break_level
	arg_2_0.weapon_info = {
		level = WeaponTools.ExpToLv(var_2_0.weapon.exp),
		exp = var_2_0.weapon.exp,
		breakthrough = var_2_0.weapon.breakthrough
	}
	arg_2_0.using_skin = var_2_0.using_skin
	arg_2_0.battle_using_skin = var_2_0.battle_using_skin
	arg_2_0.moduleLevel = var_2_0.weapon_module_level
	arg_2_0.servant_uid = tonumber(var_2_0.weapon.servant_uid) or 0
	arg_2_0.transition = arg_2_0:InitTransition(var_2_0.exclusive_skill_list or {})
	arg_2_0.unlock = arg_2_1.unlock
	arg_2_0.equip = cleanProtoTable(arg_2_1.equip, {
		"pos",
		"equip_id"
	})
	arg_2_0.clear_mission_list = cleanProtoTable(arg_2_1.clear_mission_list)
	arg_2_0.clear_times = arg_2_1.clear_times or 0
	arg_2_0.moduleAssignment = arg_2_1.weapon_module_assignment
	arg_2_0.unlocked_skin = cleanProtoTable(arg_2_1.unlocked_skin, {
		"skin_id",
		"time"
	})
	arg_2_0.trust = {
		level = arg_2_1.trust.level,
		exp = arg_2_1.trust.exp,
		mood = arg_2_1.trust.mood
	}

	local var_2_1 = HeroTrustRelationNet.New(var_2_0.id)

	var_2_1:InitData(arg_2_1.trust.relation)

	arg_2_0.relation = var_2_1
end

function var_0_0.ModifyHero(arg_3_0, arg_3_1)
	arg_3_0:Init(arg_3_1)
end

function var_0_0.GetServantInfo(arg_4_0)
	return WeaponServantData.GetWeaponServantList()[arg_4_0.servant_uid] or {
		id = 0,
		uid = 0,
		lock = true,
		stage = 1
	}
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
	return HeroConst.HERO_DATA_TYPE.DEFAULT
end

function var_0_0.SetPicece(arg_12_0, arg_12_1)
	arg_12_0.piece = arg_12_1
end

function var_0_0.IsOath(arg_13_0)
	return OathTools.IsOath(arg_13_0.id)
end

return var_0_0
