ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffShield = var_0_10002("BattleBuffShield", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffShield.__name = "BattleBuffShield"

local var_0_2 = var_0.Battle.BattleBuffShield

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.GetEffectAttachData(arg_2_0)
	return arg_2_0._shield
end

function var_0_2.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0

	if not arg_3_0._tempData.arg_list.number then
		var_3_0 = 0
	end

	arg_3_0._number = var_3_0

	local var_3_1

	if not var_3.maxHPRatio then
		var_3_1 = 0
	end

	arg_3_0._maxHPRatio = var_3_1

	local var_3_2

	if not var_3.currentHPRatio then
		var_3_2 = 0
	end

	arg_3_0._curretHPRatio = var_3_2

	local var_3_3

	if not var_3.casterMaxHPRatio then
		var_3_3 = 0
	end

	arg_3_0._casterMaxHPRatio = var_3_3

	local var_3_4

	if not var_3.casterCurretnHPRatio then
		var_3_4 = 0
	end

	arg_3_0._casterCurrentHPRatio = var_3_4
	arg_3_0._shield = arg_3_0:CalcNumber(arg_3_1)

	return
end

function var_0_2.onStack(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._shield = arg_4_0:CalcNumber(arg_4_1)

	return
end

function var_0_2.onTakeDamage(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_3.ignoreShield and arg_5_0:damageCheck(arg_5_3) then
		local var_5_0 = arg_5_3.damage

		arg_5_0._shield = arg_5_0._shield - var_5_0

		if arg_5_0._shield > 0 then
			arg_5_3.damage = 0
		else
			arg_5_3.damage = -arg_5_0._shield

			arg_5_2:SetToCancel()
		end
	end

	return
end

function var_0_2.CalcNumber(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = arg_6_1:GetHP()
	local var_6_2 = arg_6_0._caster
	local var_6_3, var_6_4 = var_4.GetHP(var_6_2)
	local var_6_5 = var_6_1 * arg_6_0._maxHPRatio + arg_6_0._casterMaxHPRatio * var_6_4 + arg_6_0._number + var_6_0 * arg_6_0._curretHPRatio + var_6_3 * arg_6_0._casterCurrentHPRatio

	math = var_7

	local var_6_6 = var_7.max
	local var_6_7 = 0

	math = var_1_10009

	return var_6_6(var_6_7, var_1_10009.floor(var_6_5))
end

return
