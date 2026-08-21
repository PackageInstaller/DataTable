local var_0_0 = class("NewEducateTalentState", import(".NewEducateStateBase"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.talents = arg_1_1.talents or {}
	arg_1_0.reTalents = arg_1_1.retalents or {}
	arg_1_0.finishFlag = arg_1_1.finished == 1

	return
end

function var_0_0.SetTalents(arg_2_0, arg_2_1)
	arg_2_0.talents = arg_2_1

	return
end

function var_0_0.GetTalents(arg_3_0)
	return arg_3_0.talents
end

function var_0_0.OnRefreshTalent(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.talents) do
		if iter_4_1 == arg_4_1 then
			arg_4_0.talents[iter_4_0] = arg_4_2

			table.insert(arg_4_0.reTalents, arg_4_0.talents[iter_4_0])
		end
	end

	return
end

function var_0_0.GetReTalents(arg_5_0)
	return arg_5_0.reTalents
end

function var_0_0.MarkFinish(arg_6_0)
	arg_6_0.finishFlag = true

	return
end

function var_0_0.IsFinish(arg_7_0)
	return arg_7_0.finishFlag
end

function var_0_0.Reset(arg_8_0)
	arg_8_0.talents = {}
	arg_8_0.reTalents = {}
	arg_8_0.finishFlag = false

	return
end

return var_0_0
