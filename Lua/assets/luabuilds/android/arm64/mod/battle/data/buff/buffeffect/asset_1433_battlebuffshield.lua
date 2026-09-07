ys = ys or {}
ys.Battle.BattleBuffShield = class("BattleBuffShield", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffShield.__name = "BattleBuffShield"

local var_0_0 = ys.Battle.BattleBuffShield

function ys.Battle.BattleBuffShield.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffShield:GetEffectAttachData()
	return self._shield
end

function ys.Battle.BattleBuffShield:SetArgs(arg_3_1, arg_3_2)
	self._number = self._tempData.arg_list.number or 0
	self._maxHPRatio = self._tempData.arg_list.maxHPRatio or 0
	self._curretHPRatio = self._tempData.arg_list.currentHPRatio or 0
	self._casterMaxHPRatio = self._tempData.arg_list.casterMaxHPRatio or 0
	self._casterCurrentHPRatio = self._tempData.arg_list.casterCurretnHPRatio or 0
	self._shield = self:CalcNumber(arg_3_1)

	return
end

function ys.Battle.BattleBuffShield:onStack(arg_4_1, arg_4_2)
	self._shield = self:CalcNumber(arg_4_1)

	return
end

function ys.Battle.BattleBuffShield:onTakeDamage(arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_3.ignoreShield and self:damageCheck(arg_5_3) then
		self._shield = self._shield - arg_5_3.damage

		if self._shield > 0 then
			arg_5_3.damage = 0
		else
			arg_5_3.damage = -self._shield

			arg_5_2:SetToCancel()
		end
	end

	return
end

function ys.Battle.BattleBuffShield:CalcNumber(arg_6_1)
	local var_6_0, var_6_1 = arg_6_1:GetHP()
	local var_6_2, var_6_3 = self._caster:GetHP()

	return math.max(0, math.floor(var_6_1 * self._maxHPRatio + self._casterMaxHPRatio * var_6_3 + self._number + var_6_0 * self._curretHPRatio + var_6_2 * self._casterCurrentHPRatio))
end

return
