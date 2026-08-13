ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFormulas

class = var_0_10002

local var_0_2 = var_0_10002("BattleSkillPlayCameraFX", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillPlayCameraFX = var_0_2
var_0_2.__name = "BattleSkillPlayCameraFX"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._FXID = arg_1_0._tempData.arg_list.effect
	arg_1_0._scale = arg_1_0._tempData.arg_list.scale
	arg_1_0._order = arg_1_0._tempData.arg_list.order

	return
end

function var_0_2.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.calcCorrdinate(arg_2_0._tempData.arg_list, arg_2_1, arg_2_2)
	local var_2_1 = var_0.Battle.BattleDataProxy.GetInstance()

	var_4.SpawnCameraFX(var_2_1, arg_2_0._FXID, var_2_0, arg_2_0._scale, arg_2_0._order)

	return
end

function var_0_2.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.calcCorrdinate(arg_3_0._tempData.arg_list, arg_3_1)
	local var_3_1 = var_0.Battle.BattleDataProxy.GetInstance()

	var_3.SpawnCameraFX(var_3_1, arg_3_0._FXID, var_3_0, arg_3_0._scale, arg_3_0._order)

	return
end

return
