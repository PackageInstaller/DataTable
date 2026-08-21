local var_0_0 = class("TangramPuuzleTestNode")

function var_0_0.OnCtor(arg_1_0)
	arg_1_0.checkConditionFunc_ = nil
	arg_1_0.checkSuccessFunc_ = nil
	arg_1_0.checkFailFunc_ = nil
	arg_1_0.runFunc_ = nil
	arg_1_0.afterRunFunc_ = nil
	arg_1_0.nextNode_ = nil
end

function var_0_0.CheckCondition(arg_2_0)
	if arg_2_0.checkConditionFunc_ then
		local var_2_0 = arg_2_0.checkConditionFunc_()

		if var_2_0 == true then
			if arg_2_0.checkSuccessFunc_ then
				arg_2_0.checkSuccessFunc_()
			end
		elseif arg_2_0.checkFailFunc_ then
			arg_2_0.checkFailFunc_()
		end

		return var_2_0
	else
		return true
	end
end

function var_0_0.Run(arg_3_0)
	if arg_3_0.runFunc_ then
		arg_3_0.runFunc_()
	end
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.checkConditionFunc_ = nil
	arg_4_0.checkSuccessFunc_ = nil
	arg_4_0.checkFailFunc_ = nil
	arg_4_0.runFunc_ = nil
	arg_4_0.afterRunFunc_ = nil
	arg_4_0.nextNode_ = nil
end

return var_0_0
