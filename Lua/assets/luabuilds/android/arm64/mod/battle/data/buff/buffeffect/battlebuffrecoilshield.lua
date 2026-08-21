ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffRecoilShield = class("BattleBuffRecoilShield", ys.Battle.BattleBuffShield)
ys.Battle.BattleBuffRecoilShield.__name = "BattleBuffRecoilShield"

local var_0_1 = ys.Battle.BattleBuffRecoilShield

function ys.Battle.BattleBuffRecoilShield.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffRecoilShield.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.SetArgs(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._recoilRate = arg_2_0._tempData.arg_list.recoilRate or 1
	arg_2_0._proxy = var_0_0.Battle.BattleDataProxy.GetInstance()

	return
end

function ys.Battle.BattleBuffRecoilShield.onFinishGame(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._totalShield - arg_3_0._shield >= 1 then
		arg_3_0._proxy:HandleDirectDamage(arg_3_1, math.floor((arg_3_0._totalShield - arg_3_0._shield) * arg_3_0._recoilRate), nil, nil, false, false, true)
	end

	return
end

function ys.Battle.BattleBuffRecoilShield.onAttach(arg_4_0, arg_4_1, arg_4_2)
	var_0_1.super.onAttach(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleBuffEvent.BUFF_EFFECT_RECOIL_SHIELD))

	return
end

function ys.Battle.BattleBuffRecoilShield.CalcNumber(arg_5_0, arg_5_1)
	arg_5_0._totalShield = var_0_1.super.CalcNumber(arg_5_0, arg_5_1)

	return arg_5_0._totalShield
end

function ys.Battle.BattleBuffRecoilShield.GetCurrentRate(arg_6_0)
	return arg_6_0._shield / arg_6_0._totalShield
end

return
