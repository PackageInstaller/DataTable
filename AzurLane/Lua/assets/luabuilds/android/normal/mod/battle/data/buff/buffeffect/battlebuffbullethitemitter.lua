ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffBulletHitEmitter = var_0_10002("BattleBuffBulletHitEmitter", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffBulletHitEmitter.__name = "BattleBuffBulletHitEmitter"

function var_0.Battle.BattleBuffBulletHitEmitter.Ctor(arg_1_0, arg_1_1)
	var_0.Battle.BattleBuffBulletHitEmitter.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0.Battle.BattleBuffBulletHitEmitter.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._number = arg_2_0._tempData.arg_list.number

	local var_2_0

	if not arg_2_0._tempData.arg_list.rate then
		var_2_0 = 10000
	end

	arg_2_0._rate = var_2_0
	arg_2_0._hitEmitterArgs = arg_2_0._tempData.arg_list

	return
end

function var_0.Battle.BattleBuffBulletHitEmitter.onBulletCreate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_3._bullet

	if var_0.Battle.BattleFormulas.IsHappen(arg_3_0._rate) then
		assert = var_5

		var_5(false, "子弹弹射功能已经屏蔽")
	end

	return
end

return
