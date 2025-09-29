module("bootstrap.flow.base.BoostrapFlowContext", package.seeall)

local var_0_0 = class("BoostrapFlowContext")

function var_0_0.ctor(arg_1_0)
	arg_1_0._shareBlackboard = {}
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._shareBlackboard[arg_2_1] = arg_2_2
end

function var_0_0.getData(arg_3_0, arg_3_1)
	return arg_3_0._shareBlackboard[arg_3_1]
end

function var_0_0.onReset(arg_4_0)
	arg_4_0._shareBlackboard = {}
end

return var_0_0
