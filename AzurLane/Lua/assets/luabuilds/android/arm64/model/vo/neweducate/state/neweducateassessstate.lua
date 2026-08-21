local var_0_0 = class("NewEducateAssessState", import(".NewEducateStateBase"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.finishFlag = arg_1_1.is_finished == 1

	return
end

function var_0_0.MarkFinish(arg_2_0)
	arg_2_0.finishFlag = true

	return
end

function var_0_0.IsFinish(arg_3_0)
	if getProxy(NewEducateProxy):GetCurChar():GetAssessRankIdx() == 0 then
		return true
	end

	return arg_3_0.finishFlag
end

function var_0_0.Reset(arg_4_0)
	arg_4_0.finishFlag = false

	return
end

return var_0_0
