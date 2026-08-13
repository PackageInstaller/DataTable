ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffSize = var_0_10002("BattleBuffSize", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffSize.__name = "BattleBuffSize"

local var_0_2 = var_0.Battle.BattleBuffSize

var_0_2.FX_TYPE = var_0.Battle.BattleBuffEffect.FX_TYPE_MOD_MODEL_SCALE

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.GetEffectType(arg_2_0)
	return var_0_2.FX_TYPE
end

function var_0_2.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0

	if not arg_3_0._tempData.arg_list.group then
		var_3_0 = arg_3_2:GetID()
	end

	arg_3_0._group = var_3_0

	local var_3_1

	if not arg_3_0._tempData.arg_list.number then
		var_3_1 = 1
	end

	arg_3_0._base = var_3_1

	local var_3_2

	if not arg_3_0._tempData.arg_list.hp_scale then
		var_3_2 = 0
	end

	arg_3_0._hpScale = var_3_2
	arg_3_0._attr = "modelScale"

	return
end

function var_0_2.onHPRatioUpdate(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:doScale(arg_4_1)
	arg_4_0:UpdateScale(arg_4_1)

	return
end

function var_0_2.onAttach(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:doScale(arg_5_1)
	arg_5_0:UpdateScale(arg_5_1)

	return
end

function var_0_2.onStack(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:doScale(arg_6_1)

	local var_6_0 = arg_6_0._number

	for iter_6_0 = 1, arg_6_2._stack do
		var_6_0 = var_6_0 * arg_6_0._number
	end

	arg_6_0._number = var_6_0

	arg_6_0:UpdateScale(arg_6_1)

	return
end

function var_0_2.onRemove(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._number = 1

	arg_7_0:UpdateScale(arg_7_1)

	return
end

function var_0_2.UpdateScale(arg_8_0, arg_8_1)
	local var_8_0 = 1
	local var_8_1 = 1
	local var_8_2 = {}
	local var_8_3 = {}
	local var_8_4 = arg_8_1
	local var_8_5 = arg_8_1.GetBuffList(var_8_4)

	pairs = var_8_4

	for iter_8_0, iter_8_1 in var_8_4(var_8_5) do
		ipairs = var_1_10012

		for iter_8_2, iter_8_3 in var_1_10012(iter_8_1._effectList) do
			if iter_8_3:GetEffectType() == var_0_2.FX_TYPE then
				local var_8_6 = iter_8_3._number
				local var_8_7

				if not var_8_2[iter_8_3._group] then
					var_8_7 = 1
				end

				local var_8_8

				if not var_8_3[var_18] then
					var_8_8 = 1
				end

				if var_8_7 < var_8_6 and var_8_6 > 1 then
					var_8_0 = var_8_0 * var_8_6 / var_8_7
					var_8_7 = var_8_6
				end

				if var_8_6 < var_8_8 and var_8_6 < 1 then
					var_8_1 = var_8_1 * var_8_6 / var_8_8
					var_8_8 = var_8_6
				end

				var_8_2[var_18] = var_8_7
				var_8_3[var_18] = var_8_8
			end
		end
	end

	local var_8_9 = var_0.Battle.BattleAttr.GetCurrent(arg_8_1, "baseScale") * var_8_0 * var_8_1

	var_0.Battle.BattleAttr.SetCurrent(arg_8_1, "modelScale", var_8_9)
	arg_8_1:DispatchEvent(var_0.Event.New(var_0.Battle.BattleBuffEvent.BUFF_EFFECT_CHNAGE_SIZE))

	return
end

function var_0_2.doScale(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:GetHPRate()

	arg_9_0._number = arg_9_0._base + var_9_0 * arg_9_0._hpScale

	return
end

return
