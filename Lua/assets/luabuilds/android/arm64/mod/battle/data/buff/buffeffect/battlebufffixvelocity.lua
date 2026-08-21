ys = ys or {}

local var_0_0 = ys
local var_0_1 = class("BattleBuffFixVelocity", ys.Battle.BattleBuffAddAttr)

ys.Battle.BattleBuffFixVelocity = var_0_1
var_0_1.__name = "BattleBuffFixVelocity"
var_0_1.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_MOD_VELOCTIY

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.GetEffectType(arg_2_0)
	return var_0_0.Battle.BattleBuffEffect.FX_TYPE_MOD_VELOCTIY
end

function var_0_1.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._group = arg_3_0._tempData.arg_list.group or arg_3_2:GetID()

	local var_3_0 = arg_3_0._tempData.arg_list.add or 0

	arg_3_0._baseAdd = var_0_0.Battle.BattleFormulas.ConvertShipSpeed(var_3_0)
	arg_3_0._addValue = arg_3_0._baseAdd

	local var_3_1 = arg_3_0._tempData.arg_list.mul or 0

	arg_3_0._baseMul = var_3_1 * 0.0001
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
	var_0_0.Battle.BattleAttr.FlashVelocity(arg_6_1, arg_6_0:calcMulValue(arg_6_1), (arg_6_0:calcAddValue(arg_6_1)))

	return
end

function var_0_1.calcMulValue(arg_7_0, arg_7_1)
	local var_7_0 = 1
	local var_7_1 = 1

	for iter_7_0, iter_7_1 in pairs((arg_7_1:GetBuffList())) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1._effectList) do
			if iter_7_3:GetEffectType() == var_0_1.FX_TYPE then
				local var_7_2 = ({})[iter_7_3._group]

				if not ({})[iter_7_3._group] then
					var_7_2 = 1
				end

				local var_7_3 = ({})[iter_7_3._group]

				if not ({})[iter_7_3._group] then
					var_7_3 = 1
				end

				local var_7_4 = 1 + iter_7_3._mulValue

				if iter_7_3._mulValue > 0 and var_7_2 < var_7_4 then
					var_7_0 = var_7_0 / var_7_2 * var_7_4
					var_7_2 = var_7_4
				end

				if iter_7_3._mulValue < 0 and var_7_4 < var_7_3 then
					var_7_1 = var_7_1 / var_7_3 * var_7_4
					var_7_3 = var_7_4
				end

				;({})[iter_7_3._group] = var_7_2
				;({})[iter_7_3._group] = var_7_3
			end
		end
	end

	return var_7_0 * var_7_1
end

function var_0_1.calcAddValue(arg_8_0, arg_8_1)
	local var_8_0 = 0
	local var_8_1 = 0

	for iter_8_0, iter_8_1 in pairs((arg_8_1:GetBuffList())) do
		for iter_8_2, iter_8_3 in ipairs(iter_8_1._effectList) do
			if iter_8_3:GetEffectType() == var_0_1.FX_TYPE then
				local var_8_2 = ({})[iter_8_3._group]

				if not ({})[iter_8_3._group] then
					var_8_2 = 0
				end

				local var_8_3 = ({})[iter_8_3._group]

				if not ({})[iter_8_3._group] then
					var_8_3 = 0
				end

				if var_8_2 < iter_8_3._addValue and iter_8_3._addValue > 0 then
					var_8_0 = var_8_0 + iter_8_3._addValue - var_8_2
					var_8_2 = iter_8_3._addValue
				end

				if iter_8_3._addValue < var_8_3 and iter_8_3._addValue < 0 then
					var_8_1 = var_8_1 + iter_8_3._addValue - var_8_3
					var_8_3 = iter_8_3._addValue
				end

				;({})[iter_8_3._group] = var_8_2
				;({})[iter_8_3._group] = var_8_3
			end
		end
	end

	return var_8_0 + var_8_1
end

return
