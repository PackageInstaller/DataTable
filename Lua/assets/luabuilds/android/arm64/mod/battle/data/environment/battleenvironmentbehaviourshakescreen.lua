ys = ys or {}

local var_0_2 = class("BattleEnvironmentBehaviourShakeScreen", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourShakeScreen = var_0_2
var_0_2.__name = "BattleEnvironmentBehaviourShakeScreen"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.SetTemplate(arg_2_0, arg_2_1)
	var_0_2.super.SetTemplate(arg_2_0, arg_2_1)

	arg_2_0._shakeID = arg_2_0._tmpData.shake_ID

	return
end

function var_0_2.doBehaviour(arg_3_0)
	var_0.Battle.BattleCameraUtil.GetInstance():StartShake(pg.shake_template[arg_3_0._shakeID])

	arg_3_0._state = var_0_2.STATE_OVERHEAT

	if arg_3_0._tmpData.reload_time then
		arg_3_0._CDstartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	end

	return
end

return
