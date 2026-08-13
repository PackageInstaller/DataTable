ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst

class = var_0_10002

local var_0_2 = var_0_10002("BattleTriggerAOEData", var_0.Battle.BattleAOEData)

var_0.Battle.BattleTriggerAOEData = var_0_2
var_0_2.__name = "BattleTriggerAOEData"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return
end

function var_0_2.Settle(arg_2_0)
	if #arg_2_0._cldObjList > 0 then
		arg_2_0.SortCldObjList(arg_2_0._cldObjList)

		local var_2_0 = arg_2_0._cldComponent

		var_1.GetCldData(var_2_0).func(arg_2_0._cldObjList)

		arg_2_0._flag = false
	end

	return
end

return
