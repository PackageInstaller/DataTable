local var_0_0 = {
	SKILL_BIG_TYPE = {
		ACTIVE = 1,
		PASSIVE = 2,
		NONE = 0
	},
	SKILL_STATE = {
		IS_ACTIVE = 0,
		NOT_ACTIVE = 1
	},
	SKILL_KEY = {
		MR_SKILL = "energy_skill_id",
		NORMAL_ATTACK = "common_id",
		ARMY_SKILL = "army_skill_id",
		ACTIVE_SKILL = "active_skill_id",
		UR_SKILL = "energy_skill_id"
	},
	SKILL_SHIELD_KEY = {
		ACTIVE_SKILL = "shield_active",
		NORMAL_ATTACK = "shield_common"
	},
	SKILL_PROMOTE_COND = {
		ADVANCE = 2,
		STAR_UP = 1
	},
	SKILL_PROMOTE_TYPE = {
		LEVEL_UP = 2,
		UNLOCK = 1
	},
	SKILL_TYPE_ENUM = {
		MR_SKILL = 32,
		NORMAL_ATTACK = 1,
		ARMY_SKILL = 44,
		COMMON_PASSIVE = 29,
		ACTIVE_SKILL = 2,
		UR_SKILL = 12
	}
}

function var_0_0.getSkillBigType(arg_1_0)
	if arg_1_0 == 1 or arg_1_0 == 2 or arg_1_0 == 12 or arg_1_0 == 32 or arg_1_0 == 44 then
		return var_0_0.SKILL_BIG_TYPE.ACTIVE
	elseif arg_1_0 == 17 or arg_1_0 == 29 then
		return var_0_0.SKILL_BIG_TYPE.PASSIVE
	end
end

function var_0_0.getSkillKeysBySkillType(arg_2_0)
	if arg_2_0 == var_0_0.SKILL_TYPE_ENUM.NORMAL_ATTACK then
		return {
			skillKey = var_0_0.SKILL_KEY.NORMAL_ATTACK,
			shieldKey = var_0_0.SKILL_SHIELD_KEY.NORMAL_ATTACK,
			promoteCond = var_0_0.SKILL_PROMOTE_COND.STAR_UP
		}
	end

	if arg_2_0 == var_0_0.SKILL_TYPE_ENUM.ACTIVE_SKILL then
		return {
			skillKey = var_0_0.SKILL_KEY.ACTIVE_SKILL,
			shieldKey = var_0_0.SKILL_SHIELD_KEY.ACTIVE_SKILL,
			promoteCond = var_0_0.SKILL_PROMOTE_COND.STAR_UP
		}
	end

	if arg_2_0 == var_0_0.SKILL_TYPE_ENUM.UR_SKILL then
		return {
			skillKey = var_0_0.SKILL_KEY.UR_SKILL,
			shieldKey = var_0_0.SKILL_SHIELD_KEY.UR_SKILL,
			promoteCond = var_0_0.SKILL_PROMOTE_COND.STAR_UP
		}
	end

	if arg_2_0 == var_0_0.SKILL_TYPE_ENUM.MR_SKILL then
		return {
			skillKey = var_0_0.SKILL_KEY.MR_SKILL,
			shieldKey = var_0_0.SKILL_SHIELD_KEY.MR_SKILL,
			promoteCond = var_0_0.SKILL_PROMOTE_COND.STAR_UP
		}
	end

	if arg_2_0 == var_0_0.SKILL_TYPE_ENUM.ARMY_SKILL then
		return {
			skillKey = var_0_0.SKILL_KEY.ARMY_SKILL,
			promoteCond = var_0_0.SKILL_PROMOTE_COND.STAR_UP
		}
	end
end

return var_0_0
