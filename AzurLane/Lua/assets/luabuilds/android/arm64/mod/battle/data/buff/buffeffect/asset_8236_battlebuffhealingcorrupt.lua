ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffHealingCorrupt = var_0_10002("BattleBuffHealingCorrupt", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffHealingCorrupt.__name = "BattleBuffHealingCorrupt"

local var_0_2 = var_0.Battle.BattleBuffHealingCorrupt

var_0_2.FX_TYPE = var_0.Battle.BattleBuffEffect.FX_TYPE_LINK

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if not arg_2_0._tempData.arg_list.corruptRate then
		var_2_0 = 1
	end

	arg_2_0._corruptRate = var_2_0

	local var_2_1

	if not var_3.damageRate then
		var_2_1 = 1
	end

	arg_2_0._damageRate = var_2_1
	arg_2_0._proxy = var_0.Battle.BattleDataProxy.GetInstance()

	return
end

function var_0_2.onTakeHealing(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.incorrupt then
		return
	end

	local var_3_0 = arg_3_3.damage

	math = var_1_10005
	arg_3_3.damage = var_3_0 - var_1_10005.ceil(var_3_0 * arg_3_0._corruptRate)
	math = var_6

	local var_3_1 = var_6.ceil(var_5 * arg_3_0._damageRate)
	local var_3_2 = arg_3_0._proxy

	var_7.HandleDirectDamage(var_3_2, arg_3_1, var_3_1)

	return
end

return
