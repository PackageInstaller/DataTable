ys = ys or {}

local var_0_1 = class("BattleSkillPlayFX", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillPlayFX = var_0_1
var_0_1.__name = "BattleSkillPlayFX"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._FXID = arg_1_0._tempData.arg_list.effect

	return
end

function var_0_1.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	var_0.Battle.BattleDataProxy.GetInstance():SpawnEffect(arg_2_0._FXID, (arg_2_0.calcCorrdinate(arg_2_0._tempData.arg_list, arg_2_1, arg_2_2)))

	return
end

function var_0_1.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	var_0.Battle.BattleDataProxy.GetInstance():SpawnEffect(arg_3_0._FXID, (arg_3_0.calcCorrdinate(arg_3_0._tempData.arg_list, arg_3_1)))

	return
end

return
