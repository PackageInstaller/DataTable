ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffWorldVariable = class("BattleBuffWorldVariable", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffWorldVariable.__name = "BattleBuffWorldVariable"

local var_0_1 = ys.Battle.BattleBuffWorldVariable

function ys.Battle.BattleBuffWorldVariable.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffWorldVariable.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._variable = arg_2_0._tempData.arg_list.variable
	arg_2_0._key = arg_2_0._tempData.arg_list.key
	arg_2_0._number = arg_2_0._tempData.arg_list.number
	arg_2_0._resetNumber = arg_2_0._tempData.arg_list.resetNumber
	arg_2_0._speedFactorName = "buff_" .. arg_2_0._tempData.id

	return
end

function ys.Battle.BattleBuffWorldVariable.onAttach(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._key then
		var_0_0.Battle.BattleVariable.AppendIFFFactor(arg_3_0._key, arg_3_0._speedFactorName, arg_3_0._number)
	else
		var_0_0.Battle.BattleVariable.AppendMapFactor(arg_3_0._speedFactorName, arg_3_0._number)
	end

	return
end

function ys.Battle.BattleBuffWorldVariable.onRemove(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._key then
		var_0_0.Battle.BattleVariable.RemoveIFFFactor(arg_4_0._key, arg_4_0._speedFactorName)
	else
		var_0_0.Battle.BattleVariable.RemoveMapFactor(arg_4_0._speedFactorName)
	end

	return
end

return
