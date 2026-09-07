ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffRecoilShield = class("BattleBuffRecoilShield", ys.Battle.BattleBuffShield)
ys.Battle.BattleBuffRecoilShield.__name = "BattleBuffRecoilShield"

local var_0_1 = ys.Battle.BattleBuffRecoilShield

function ys.Battle.BattleBuffRecoilShield.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffRecoilShield:SetArgs(arg_2_1, arg_2_2)
	var_0_1.super.SetArgs(self, arg_2_1, arg_2_2)

	self._recoilRate = self._tempData.arg_list.recoilRate or 1
	self._proxy = var_0_0.Battle.BattleDataProxy.GetInstance()

	return
end

function ys.Battle.BattleBuffRecoilShield:onFinishGame(arg_3_1, arg_3_2)
	if self._totalShield - self._shield >= 1 then
		self._proxy:HandleDirectDamage(arg_3_1, math.floor((self._totalShield - self._shield) * self._recoilRate), nil, nil, false, false, true)
	end

	return
end

function ys.Battle.BattleBuffRecoilShield.onAttach(arg_4_0, arg_4_1, arg_4_2)
	var_0_1.super.onAttach(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleBuffEvent.BUFF_EFFECT_RECOIL_SHIELD))

	return
end

function ys.Battle.BattleBuffRecoilShield:CalcNumber(arg_5_1)
	self._totalShield = var_0_1.super.CalcNumber(self, arg_5_1)

	return self._totalShield
end

function ys.Battle.BattleBuffRecoilShield:GetCurrentRate()
	return self._shield / self._totalShield
end

return
