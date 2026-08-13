ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleSkillRemoveAllWeapon", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillRemoveAllWeapon = var_0_1
var_0_1.__name = "BattleSkillRemoveAllWeapon"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10006

	var_1_0(var_1_1, var_1_2, var_1_10006)

	return
end

function var_0_1.DoDataEffect(arg_2_0, arg_2_1)
	arg_2_0:doRemove(arg_2_1)

	return
end

function var_0_1.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doRemove(arg_3_1)

	return
end

function var_0_1.doRemove(arg_4_0, arg_4_1)
	arg_4_1:RemoveAllAutoWeapon()

	return
end

return
