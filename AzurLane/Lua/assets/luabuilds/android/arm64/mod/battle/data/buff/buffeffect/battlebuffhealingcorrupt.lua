ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffHealingCorrupt = class("BattleBuffHealingCorrupt", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffHealingCorrupt.__name = "BattleBuffHealingCorrupt"

local var_0_1 = ys.Battle.BattleBuffHealingCorrupt

ys.Battle.BattleBuffHealingCorrupt.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_LINK

function ys.Battle.BattleBuffHealingCorrupt.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffHealingCorrupt.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._corruptRate = arg_2_0._tempData.arg_list.corruptRate or 1
	arg_2_0._damageRate = arg_2_0._tempData.arg_list.damageRate or 1
	arg_2_0._proxy = var_0_0.Battle.BattleDataProxy.GetInstance()

	return
end

function ys.Battle.BattleBuffHealingCorrupt.onTakeHealing(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0

	if arg_3_3.incorrupt then
		do return end

		var_3_0 = math.ceil(arg_3_3.damage * arg_3_0._corruptRate)
	end

	arg_3_3.damage = arg_3_3.damage - var_3_0

	arg_3_0._proxy:HandleDirectDamage(arg_3_1, (math.ceil(var_3_0 * arg_3_0._damageRate)))

	return
end

return
