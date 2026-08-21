ys = ys or {}

local var_0_1 = class("BattleDisposableTorpedoUnit", ys.Battle.BattleManualTorpedoUnit)

ys.Battle.BattleDisposableTorpedoUnit = var_0_1
var_0_1.__name = "BattleDisposableTorpedoUnit"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function var_0_1.EnterCoolDown(arg_2_0)
	return
end

function var_0_1.Fire(arg_3_0)
	var_0_1.super.Fire(arg_3_0)
	arg_3_0._playerTorpedoVO:Deduct(arg_3_0)
	arg_3_0._playerTorpedoVO:DispatchOverLoadChange()

	return true
end

function var_0_1.OverHeat(arg_4_0)
	arg_4_0._currentState = arg_4_0.STATE_OVER_HEAT

	return
end

function var_0_1.GetType(arg_5_0)
	return var_0.Battle.BattleConst.EquipmentType.DISPOSABLE_TORPEDO
end

function var_0_1.createMajorEmitter(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	return var_0_1.super.createMajorEmitter(arg_6_0, 1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
end

return
