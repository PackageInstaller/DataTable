ys = ys or {}

local var_0_1 = class("BattleTriggerAOEData", ys.Battle.BattleAOEData)

ys.Battle.BattleTriggerAOEData = var_0_1
var_0_1.__name = "BattleTriggerAOEData"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return
end

function var_0_1.Settle(arg_2_0)
	if #arg_2_0._cldObjList > 0 then
		arg_2_0.SortCldObjList(arg_2_0._cldObjList)
		arg_2_0._cldComponent:GetCldData().func(arg_2_0._cldObjList)

		arg_2_0._flag = false
	end

	return
end

return
