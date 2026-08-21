ys = ys or {}
ys.Battle.BattleFleetBuffFixSubRefLine = class("BattleFleetBuffFixSubRefLine", ys.Battle.BattleFleetBuffEffect)
ys.Battle.BattleFleetBuffFixSubRefLine.__name = "BattleFleetBuffFixSubRefLine"

local var_0_0 = ys.Battle.BattleFleetBuffFixSubRefLine

function ys.Battle.BattleFleetBuffFixSubRefLine.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleFleetBuffFixSubRefLine.onAttach(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1:FixSubRefLine(arg_2_0._tempData.arg_list.line)

	return
end

function ys.Battle.BattleFleetBuffFixSubRefLine.onRemove(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:FixSubRefLine()

	return
end

return
