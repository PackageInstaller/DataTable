local var_0_0 = class("AutoChessActionBaseNode")

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Reset()
	arg_1_0:OnCtor()
end

function var_0_0.Reset(arg_2_0)
	arg_2_0.nextNode = nil
	arg_2_0.status = AutoChessConst.ACTION_NODE_STATUS.NEW
	arg_2_0.player = nil
	arg_2_0.blackboard = nil
	arg_2_0.actionData = nil
end

function var_0_0.Init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.player = arg_3_1
	arg_3_0.blackboard = arg_3_2
	arg_3_0.actionData = arg_3_3
end

function var_0_0.Enter(arg_4_0)
	if arg_4_0.actionData then
		AutoChessBattleRecord.PrintRecord(arg_4_0.actionData)
	end

	arg_4_0.status = AutoChessConst.ACTION_NODE_STATUS.RUNNING

	arg_4_0:OnEnter()
end

function var_0_0.Execute(arg_5_0)
	arg_5_0:OnExecute()

	return arg_5_0.status
end

function var_0_0.Exit(arg_6_0)
	arg_6_0:OnExit()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:Reset()
	arg_7_0:OnDispose()
end

function var_0_0.OnCtor(arg_8_0)
	return
end

function var_0_0.OnEnter(arg_9_0)
	return
end

function var_0_0.OnExecute(arg_10_0)
	return
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.OnDispose(arg_12_0)
	return
end

return var_0_0
