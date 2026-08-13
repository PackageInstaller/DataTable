ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent

class = var_0_10002

local var_0_2 = var_0_10002("BattleDisposableTorpedoUnit", var_0.Battle.BattleManualTorpedoUnit)

var_0.Battle.BattleDisposableTorpedoUnit = var_0_2
var_0_2.__name = "BattleDisposableTorpedoUnit"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.EnterCoolDown(arg_2_0)
	return
end

function var_0_2.Fire(arg_3_0)
	var_0_2.super.Fire(arg_3_0)

	local var_3_0 = arg_3_0._playerTorpedoVO

	var_1.Deduct(var_3_0, arg_3_0)

	local var_3_1 = arg_3_0._playerTorpedoVO

	var_1.DispatchOverLoadChange(var_3_1)

	return true
end

function var_0_2.OverHeat(arg_4_0)
	arg_4_0._currentState = arg_4_0.STATE_OVER_HEAT

	return
end

function var_0_2.GetType(arg_5_0)
	return var_0.Battle.BattleConst.EquipmentType.DISPOSABLE_TORPEDO
end

function var_0_2.createMajorEmitter(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	return var_0_2.super.createMajorEmitter(arg_6_0, 1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
end

return
