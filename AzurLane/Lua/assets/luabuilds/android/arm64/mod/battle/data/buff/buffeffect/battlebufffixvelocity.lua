ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffFixVelocity", var_0.Battle.BattleBuffAddAttr)

var_0.Battle.BattleBuffFixVelocity = var_0_1
var_0_1.__name = "BattleBuffFixVelocity"
var_0_1.FX_TYPE = var_0.Battle.BattleBuffEffect.FX_TYPE_MOD_VELOCTIY

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.GetEffectType(arg_2_0)
	return var_0.Battle.BattleBuffEffect.FX_TYPE_MOD_VELOCTIY
end

function var_0_1.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0

	if not arg_3_0._tempData.arg_list.group then
		var_3_0 = arg_3_2:GetID()
	end

	arg_3_0._group = var_3_0

	local var_3_1

	if not arg_3_0._tempData.arg_list.add then
		var_3_1 = 0
	end

	arg_3_0._baseAdd = var_0.Battle.BattleFormulas.ConvertShipSpeed(var_3_1)
	arg_3_0._addValue = arg_3_0._baseAdd

	local var_3_2

	if not arg_3_0._tempData.arg_list.mul then
		var_3_2 = 0
	end

	arg_3_0._baseMul = var_3_2 * 0.0001
	arg_3_0._mulValue = arg_3_0._baseMul

	return
end

function var_0_1.onStack(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._addValue = arg_4_0._baseAdd * arg_4_2._stack
	arg_4_0._mulValue = arg_4_0._baseMul * arg_4_2._stack

	arg_4_0:UpdateAttr(arg_4_1)

	return
end

function var_0_1.onRemove(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._addValue = 0
	arg_5_0._mulValue = 0

	arg_5_0:UpdateAttr(arg_5_1)

	return
end

function var_0_1.UpdateAttr(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:calcMulValue(arg_6_1)
	local var_6_1 = arg_6_0:calcAddValue(arg_6_1)

	var_0.Battle.BattleAttr.FlashVelocity(arg_6_1, var_6_0, var_6_1)

	return
end

function var_0_1.calcMulValue(arg_7_0, arg_7_1)
	local var_7_0 = 1
	local var_7_1 = 1
	local var_7_2 = {}
	local var_7_3 = {}
	local var_7_4 = arg_7_1:GetBuffList()

	pairs = var_1_10007

	for iter_7_0, iter_7_1 in var_1_10007(var_7_4) do
		ipairs = var_1_10012

		for iter_7_2, iter_7_3 in var_1_10012(iter_7_1._effectList) do
			if iter_7_3:GetEffectType() == var_0_1.FX_TYPE then
				local var_7_5 = iter_7_3._mulValue
				local var_7_6

				if not var_7_2[iter_7_3._group] then
					var_7_6 = 1
				end

				local var_7_7

				if not var_7_3[var_18] then
					var_7_7 = 1
				end

				local var_7_8 = 1 + var_7_5

				if var_7_5 > 0 and var_7_6 < var_7_8 then
					var_7_0 = var_7_0 / var_7_6 * var_7_8
					var_7_6 = var_7_8
				end

				if var_7_5 < 0 and var_7_8 < var_7_7 then
					var_7_1 = var_7_1 / var_7_7 * var_7_8
					var_7_7 = var_7_8
				end

				var_7_2[var_18] = var_7_6
				var_7_3[var_18] = var_7_7
			end
		end
	end

	return var_7_0 * var_7_1
end

function var_0_1.calcAddValue(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:GetBuffList()
	local var_8_1 = 0
	local var_8_2 = 0
	local var_8_3 = {}
	local var_8_4 = {}

	pairs = var_1_10007

	for iter_8_0, iter_8_1 in var_1_10007(var_8_0) do
		ipairs = var_1_10012

		for iter_8_2, iter_8_3 in var_1_10012(iter_8_1._effectList) do
			if iter_8_3:GetEffectType() == var_0_1.FX_TYPE then
				local var_8_5 = iter_8_3._addValue
				local var_8_6

				if not var_8_3[iter_8_3._group] then
					var_8_6 = 0
				end

				local var_8_7

				if not var_8_4[var_18] then
					var_8_7 = 0
				end

				if var_8_6 < var_8_5 and var_8_5 > 0 then
					var_8_1 = var_8_1 + var_8_5 - var_8_6
					var_8_6 = var_8_5
				end

				if var_8_5 < var_8_7 and var_8_5 < 0 then
					var_8_2 = var_8_2 + var_8_5 - var_8_7
					var_8_7 = var_8_5
				end

				var_8_3[var_18] = var_8_6
				var_8_4[var_18] = var_8_7
			end
		end
	end

	return var_8_1 + var_8_2
end

return
