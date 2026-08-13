class = var_0_10000

local var_0_0 = "NewEducateTalentState"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewEducateStateBase"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.talents then
		var_1_0 = {}
	end

	arg_1_0.talents = var_1_0

	local var_1_1

	if not arg_1_1.retalents then
		var_1_1 = {}
	end

	arg_1_0.reTalents = var_1_1
	arg_1_0.finishFlag = arg_1_1.finished == 1 and true or false

	return
end

function var_0_1.SetTalents(arg_2_0, arg_2_1)
	arg_2_0.talents = arg_2_1

	return
end

function var_0_1.GetTalents(arg_3_0)
	return arg_3_0.talents
end

function var_0_1.OnRefreshTalent(arg_4_0, arg_4_1, arg_4_2)
	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_0.talents) do
		if iter_4_1 == arg_4_1 then
			local var_4_0 = arg_4_0.talents

			var_4_0[iter_4_0] = arg_4_2
			table = var_4_0

			var_4_0.insert(arg_4_0.reTalents, arg_4_0.talents[iter_4_0])
		end
	end

	return
end

function var_0_1.GetReTalents(arg_5_0)
	return arg_5_0.reTalents
end

function var_0_1.MarkFinish(arg_6_0)
	arg_6_0.finishFlag = true

	return
end

function var_0_1.IsFinish(arg_7_0)
	return arg_7_0.finishFlag
end

function var_0_1.Reset(arg_8_0)
	arg_8_0.talents = {}
	arg_8_0.reTalents = {}
	arg_8_0.finishFlag = false

	return
end

return var_0_1
