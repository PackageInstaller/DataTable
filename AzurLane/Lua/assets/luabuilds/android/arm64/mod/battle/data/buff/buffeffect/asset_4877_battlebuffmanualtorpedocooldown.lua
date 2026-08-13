ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffManualTorpedoCoolDown = var_0_10002("BattleBuffManualTorpedoCoolDown", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffManualTorpedoCoolDown.__name = "BattleBuffManualTorpedoCoolDown"

local var_0_2 = var_0.Battle.BattleBuffManualTorpedoCoolDown

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if not arg_2_0._tempData.arg_list.rant then
		var_2_0 = 10000
	end

	arg_2_0._rant = var_2_0

	return
end

function var_0_2.onTrigger(arg_3_0, arg_3_1)
	local var_3_0 = var_0_2.super.onTrigger
	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_1

	buff = var_1_10006
	attach = var_1_10007

	var_3_0(var_3_1, var_3_2, var_1_10006, var_1_10007)

	if var_0.Battle.BattleFormulas.IsHappen(arg_3_0._rant) then
		local var_3_3 = arg_3_1:GetTorpedoQueue()

		if var_2.GetQueueHead(var_3_3) then
			var_2:QuickCoolDown()
		end
	end

	return
end

return
