local var_0_0 = class("AutoChessActionBaseDataTemplate")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.round = 0
	arg_1_0.actionId = 0
	arg_1_0.actionType = AutoChessConst.ACTION_TYPE.MOVE
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.actionId = arg_2_1.action_id
	arg_2_0.actionType = arg_2_1.action_type
end

function var_0_0.SetRound(arg_3_0, arg_3_1)
	arg_3_0.round = arg_3_1
end

return var_0_0
