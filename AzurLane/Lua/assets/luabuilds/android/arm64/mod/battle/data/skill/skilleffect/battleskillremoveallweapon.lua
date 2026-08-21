ys = ys or {}

local var_0_0 = class("BattleSkillRemoveAllWeapon", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillRemoveAllWeapon = var_0_0
var_0_0.__name = "BattleSkillRemoveAllWeapon"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, lv)

	return
end

function var_0_0.DoDataEffect(arg_2_0, arg_2_1)
	arg_2_0:doRemove(arg_2_1)

	return
end

function var_0_0.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doRemove(arg_3_1)

	return
end

function var_0_0.doRemove(arg_4_0, arg_4_1)
	arg_4_1:RemoveAllAutoWeapon()

	return
end

return
