ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffSetAttr = var_0_10002("BattleBuffSetAttr", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffSetAttr.__name = "BattleBuffSetAttr"

local var_0_2 = var_0.Battle.BattleBuffSetAttr
local var_0_3 = var_0.Battle.BattleAttr

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._attr = arg_2_0._tempData.arg_list.attr
	arg_2_0._value = arg_2_0._tempData.arg_list.value

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._attr == "TargetChoise" then
		var_0_3.AddTargetSelect(arg_3_1, arg_3_0._value)
	else
		var_0_3.SetCurrent(arg_3_1, arg_3_0._attr, arg_3_0._value)
	end

	return
end

function var_0_2.onRemove(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._attr == "TargetChoise" then
		var_0_3.RemoveTargetSelect(arg_4_1, arg_4_0._value)
	else
		var_0_3.SetCurrent(arg_4_1, arg_4_0._attr, 0)
	end

	return
end

return
