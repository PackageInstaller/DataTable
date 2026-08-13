ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleSkillSetCloak = var_0_10002("BattleSkillSetCloak", var_0.Battle.BattleSkillEffect)
var_0.Battle.BattleSkillSetCloak.__name = "BattleSkillSetCloak"

local var_0_2 = var_0.Battle.BattleSkillSetCloak

function var_0_2.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0_2.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10005

	var_1_0(var_1_1, var_1_2, var_1_10005)

	local var_1_3

	if not arg_1_0._tempData.arg_list.cloak_rate then
		var_1_3 = 0
	end

	arg_1_0._rate = var_1_3

	return
end

function var_0_2.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:doSetCloakValue(arg_2_2)

	return
end

function var_0_2.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doSetCloakValue(arg_3_1)

	return
end

function var_0_2.doSetCloakValue(arg_4_0, arg_4_1)
	if arg_4_1:GetCloak() then
		var_2:ForceToRate(arg_4_0._rate)
	end

	return
end

return
