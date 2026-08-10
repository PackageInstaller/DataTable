local var_0_0 = class("LinkMethod")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.methodList_ = {}
	arg_1_0.peek_ = 100
end

function var_0_0.AddMethod(arg_2_0, arg_2_1)
	table.insert(arg_2_0.methodList_, arg_2_1)
end

function var_0_0.AddMethodList(arg_3_0, arg_3_1)
	arg_3_0.methodList_ = arg_3_1
end

function var_0_0.StartNext(arg_4_0)
	arg_4_0.peek_ = 1

	arg_4_0:DoNext()
end

function var_0_0.DoNext(arg_5_0)
	local var_5_0 = arg_5_0.methodList_[arg_5_0.peek_]

	if var_5_0 then
		arg_5_0.peek_ = arg_5_0.peek_ + 1

		var_5_0()
	end
end

function var_0_0.IsFree(arg_6_0)
	return arg_6_0.peek_ > #arg_6_0.methodList_
end

function var_0_0.Stop(arg_7_0)
	arg_7_0.peek_ = #arg_7_0.methodList_ + 1
end

return var_0_0
