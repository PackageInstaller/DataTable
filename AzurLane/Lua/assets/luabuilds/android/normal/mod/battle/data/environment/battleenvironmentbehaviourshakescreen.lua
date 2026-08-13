ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleEnvironmentBehaviourShakeScreen", var_0.Battle.BattleEnvironmentBehaviour)

var_0.Battle.BattleEnvironmentBehaviourShakeScreen = var_0_3
var_0_3.__name = "BattleEnvironmentBehaviourShakeScreen"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.SetTemplate(arg_2_0, arg_2_1)
	var_0_3.super.SetTemplate(arg_2_0, arg_2_1)

	arg_2_0._shakeID = arg_2_0._tmpData.shake_ID

	return
end

function var_0_3.doBehaviour(arg_3_0)
	local var_3_0 = var_0.Battle.BattleCameraUtil.GetInstance()
	local var_3_1 = var_1.StartShake

	pg = var_1_10003

	var_3_1(var_3_0, var_1_10003.shake_template[arg_3_0._shakeID])

	arg_3_0._state = var_0_3.STATE_OVERHEAT

	if arg_3_0._tmpData.reload_time then
		pg = var_1

		local var_3_2 = var_1.TimeMgr.GetInstance()

		arg_3_0._CDstartTime = var_1.GetCombatTime(var_3_2)
	end

	return
end

return
