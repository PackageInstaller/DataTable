local var_0_0 = class("NewEducateEndingState", import(".NewEducateStateBase"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.endings = arg_1_1.ends or {}
	arg_1_0.selEnding = arg_1_1.select or 0

	return
end

function var_0_0.SetEndings(arg_2_0, arg_2_1)
	arg_2_0.endings = arg_2_1

	return
end

function var_0_0.GetEndings(arg_3_0)
	return arg_3_0.endings
end

function var_0_0.SelEnding(arg_4_0, arg_4_1)
	arg_4_0.selEnding = arg_4_1

	return
end

function var_0_0.IsFinish(arg_5_0)
	return arg_5_0.selEnding ~= 0
end

function var_0_0.Reset(arg_6_0)
	arg_6_0.endings = {}
	arg_6_0.selEnding = 0

	return
end

return var_0_0
