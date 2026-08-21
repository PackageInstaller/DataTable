ys = ys or {}

local var_0_1 = class("BattleSkillPlayUIFX", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillPlayUIFX = var_0_1
var_0_1.__name = "BattleSkillPlayUIFX"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._FXID = arg_1_0._tempData.arg_list.effect
	arg_1_0._scale = arg_1_0._tempData.arg_list.scale
	arg_1_0._order = arg_1_0._tempData.arg_list.order

	return
end

function var_0_1.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	var_0.Battle.BattleDataProxy.GetInstance():SpawnUIFX(arg_2_0._FXID, arg_2_0.calcCorrdinate(arg_2_0._tempData.arg_list, arg_2_1, arg_2_2), arg_2_0._scale, arg_2_0._order)

	return
end

function var_0_1.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	var_0.Battle.BattleDataProxy.GetInstance():SpawnUIFX(arg_3_0._FXID, arg_3_0.calcCorrdinate(arg_3_0._tempData.arg_list, arg_3_1), arg_3_0._scale, arg_3_0._order)

	return
end

return
