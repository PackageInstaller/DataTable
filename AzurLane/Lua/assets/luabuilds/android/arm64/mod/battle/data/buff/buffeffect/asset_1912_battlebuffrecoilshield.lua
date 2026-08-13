ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffRecoilShield = var_0_10002("BattleBuffRecoilShield", var_0.Battle.BattleBuffShield)
var_0.Battle.BattleBuffRecoilShield.__name = "BattleBuffRecoilShield"

local var_0_2 = var_0.Battle.BattleBuffRecoilShield

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	var_0_2.super.SetArgs(arg_2_0, arg_2_1, arg_2_2)

	local var_2_0

	if not arg_2_0._tempData.arg_list.recoilRate then
		var_2_0 = 1
	end

	arg_2_0._recoilRate = var_2_0
	arg_2_0._proxy = var_0.Battle.BattleDataProxy.GetInstance()

	return
end

function var_0_2.onFinishGame(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0._totalShield - arg_3_0._shield

	if 1 <= var_3_0 then
		math = var_4

		local var_3_1 = var_4.floor(var_3_0 * arg_3_0._recoilRate)
		local var_3_2 = arg_3_0._proxy

		var_5.HandleDirectDamage(var_3_2, arg_3_1, var_3_1, nil, nil, false, false, true)
	end

	return
end

function var_0_2.onAttach(arg_4_0, arg_4_1, arg_4_2)
	var_0_2.super.onAttach(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1:DispatchEvent(var_0.Event.New(var_0.Battle.BattleBuffEvent.BUFF_EFFECT_RECOIL_SHIELD))

	return
end

function var_0_2.CalcNumber(arg_5_0, arg_5_1)
	arg_5_0._totalShield = var_0_2.super.CalcNumber(arg_5_0, arg_5_1)

	return arg_5_0._totalShield
end

function var_0_2.GetCurrentRate(arg_6_0)
	return arg_6_0._shield / arg_6_0._totalShield
end

return
