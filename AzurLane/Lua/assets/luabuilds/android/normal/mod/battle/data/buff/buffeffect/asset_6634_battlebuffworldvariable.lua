ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffWorldVariable = var_0_10002("BattleBuffWorldVariable", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffWorldVariable.__name = "BattleBuffWorldVariable"

local var_0_2 = var_0.Battle.BattleBuffWorldVariable

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._variable = arg_2_0._tempData.arg_list.variable
	arg_2_0._key = arg_2_0._tempData.arg_list.key
	arg_2_0._number = arg_2_0._tempData.arg_list.number
	arg_2_0._resetNumber = arg_2_0._tempData.arg_list.resetNumber
	arg_2_0._speedFactorName = "buff_" .. arg_2_0._tempData.id

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0.Battle.BattleVariable

	if arg_3_0._key then
		var_3_0.AppendIFFFactor(arg_3_0._key, arg_3_0._speedFactorName, arg_3_0._number)
	else
		var_3_0.AppendMapFactor(arg_3_0._speedFactorName, arg_3_0._number)
	end

	return
end

function var_0_2.onRemove(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0.Battle.BattleVariable

	if arg_4_0._key then
		var_4_0.RemoveIFFFactor(arg_4_0._key, arg_4_0._speedFactorName)
	else
		var_4_0.RemoveMapFactor(arg_4_0._speedFactorName)
	end

	return
end

return
