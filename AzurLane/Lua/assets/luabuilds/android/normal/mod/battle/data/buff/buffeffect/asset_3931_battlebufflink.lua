ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffLink = var_0_10002("BattleBuffLink", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffLink.__name = "BattleBuffLink"

function var_0.Battle.BattleBuffLink.Ctor(arg_1_0, arg_1_1)
	var_0.Battle.BattleBuffLink.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0.Battle.BattleBuffLink.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._target = arg_2_0._tempData.arg_list.target
	arg_2_0._buff_id = arg_2_0._tempData.arg_list.buff_id

	return
end

function var_0.Battle.BattleBuffLink.Trigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = arg_3_0

	if arg_3_0.getTargetList(var_3_0, arg_3_2, arg_3_0._target, arg_3_0._tempData.arg_list) then
		ipairs = var_3_0

		for iter_3_0, iter_3_1 in var_3_0(var_5) do
			if iter_3_1:GetBuff(arg_3_0._buff_id) then
				var_11:onTrigger(arg_3_1, iter_3_1, arg_3_4)
			end
		end
	end

	return
end

return
