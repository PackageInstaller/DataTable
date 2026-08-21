local var_0_0 = class("BaseHeroDataTemplate")

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

	for iter_1_0, iter_1_1 in ipairs(var_1_0.skills) do
		table.insert(var_1_2, {
			skill_level = 1,
			skill_id = iter_1_1
		})

		if iter_1_0 <= 5 then
			table.insert(var_1_3, {
				level = 0,
				index = iter_1_0
			})
		end
	end

	arg_1_0.id = arg_1_1
	arg_1_0.exp = 0
	arg_1_0.level = 1
	arg_1_0.star = var_1_0.unlock_star
	arg_1_0.using_skin = 0
	arg_1_0.battle_using_skin = 0
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
end

function var_0_0.Init(arg_2_0, arg_2_1)
	Debug.LogError("heroDataTeamplate Type：" .. arg_2_0:GetType() .. "need to override function Init(data)")
end

function var_0_0.ModifyHero(arg_3_0, arg_3_1)
	Debug.LogError("heroDataTeamplate Type：" .. arg_3_0:GetType() .. "need to override function ModifyHero()")
end

function var_0_0.GetServantInfo(arg_4_0)
	Debug.LogError("heroDataTeamplate Type：" .. arg_4_0:GetType() .. "need to override function GetServantInfo()")
end

function var_0_0.GetWeaponInfo(arg_5_0)
	Debug.LogError("heroDataTeamplate Type：" .. arg_5_0:GetType() .. "need to override function GetWeaponInfo()")
end

function var_0_0.GetEquipInfoList(arg_6_0)
	Debug.LogError("heroDataTeamplate Type：" .. arg_6_0:GetType() .. "need to override function GetEquipInfoList()")
end

function var_0_0.GetSkillInfoList(arg_7_0)
	Debug.LogError("heroDataTeamplate Type：" .. arg_7_0:GetType() .. "need to override function GetSkillInfoList()")
end

function var_0_0.GetSkillAttrList(arg_8_0)
	Debug.LogError("heroDataTeamplate Type：" .. arg_8_0:GetType() .. "need to override function GetSkillAttrList()")
end

function var_0_0.GetTransitionInfoList(arg_9_0)
	Debug.LogError("heroDataTeamplate Type：" .. arg_9_0:GetType() .. "need to override function GetTransitionInfoList()")
end

function var_0_0.GetType(arg_10_0)
	Debug.LogError("heroDataTeamplate Type：" .. arg_10_0:GetType() .. "need to override function GetType()")

	return HeroConst.HERO_DATA_TYPE.UNDEFINED
end

function var_0_0.IsOath(arg_11_0)
	Debug.LogError("heroDataTeamplate Type：" .. arg_11_0:GetType() .. "need to override function IsOath()")

	return false
end

return var_0_0
