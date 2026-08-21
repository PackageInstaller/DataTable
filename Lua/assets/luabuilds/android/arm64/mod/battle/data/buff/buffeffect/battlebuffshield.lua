ys = ys or {}
ys.Battle.BattleBuffShield = class("BattleBuffShield", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffShield.__name = "BattleBuffShield"

local var_0_0 = ys.Battle.BattleBuffShield

function ys.Battle.BattleBuffShield.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffShield.GetEffectAttachData(arg_2_0)
	return arg_2_0._shield
end

function ys.Battle.BattleBuffShield.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._number = arg_3_0._tempData.arg_list.number or 0
	arg_3_0._maxHPRatio = arg_3_0._tempData.arg_list.maxHPRatio or 0
	arg_3_0._curretHPRatio = arg_3_0._tempData.arg_list.currentHPRatio or 0
	arg_3_0._casterMaxHPRatio = arg_3_0._tempData.arg_list.casterMaxHPRatio or 0
	arg_3_0._casterCurrentHPRatio = arg_3_0._tempData.arg_list.casterCurretnHPRatio or 0
	arg_3_0._shield = arg_3_0:CalcNumber(arg_3_1)

	return
end

function ys.Battle.BattleBuffShield.onStack(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._shield = arg_4_0:CalcNumber(arg_4_1)

	return
end

function ys.Battle.BattleBuffShield.onTakeDamage(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_3.ignoreShield and arg_5_0:damageCheck(arg_5_3) then
		arg_5_0._shield = arg_5_0._shield - arg_5_3.damage

		if arg_5_0._shield > 0 then
			arg_5_3.damage = 0
		else
			arg_5_3.damage = -arg_5_0._shield

			arg_5_2:SetToCancel()
		end
	end

	return
end

function ys.Battle.BattleBuffShield.CalcNumber(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = arg_6_1:GetHP()
	local var_6_2, var_6_3 = arg_6_0._caster:GetHP()

	return math.max(0, math.floor(var_6_1 * arg_6_0._maxHPRatio + arg_6_0._casterMaxHPRatio * var_6_3 + arg_6_0._number + var_6_0 * arg_6_0._curretHPRatio + var_6_2 * arg_6_0._casterCurrentHPRatio))
end

return
