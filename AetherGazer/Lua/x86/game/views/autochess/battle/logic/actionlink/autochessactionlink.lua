local var_0_0 = class("AutoChessActionLink")

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Reset()
end

function var_0_0.Reset(arg_2_0)
	arg_2_0.rootNode = nil
	arg_2_0.lastNode = arg_2_0.rootNode
	arg_2_0.runningNode = nil
	arg_2_0.status = AutoChessConst.ACTION_NODE_STATUS.NEW
end

function var_0_0.AddNode(arg_3_0, arg_3_1)
	if arg_3_0.rootNode == nil then
		arg_3_0.rootNode = arg_3_1
	else
		arg_3_0.lastNode.nextNode = arg_3_1
	end

	arg_3_0.lastNode = arg_3_1
end

function var_0_0.Start(arg_4_0)
	if arg_4_0:GetNextRunningNode() then
		arg_4_0.status = AutoChessConst.ACTION_NODE_STATUS.RUNNING

		arg_4_0:StartNode()
	else
		arg_4_0:Finish()
	end
end

function var_0_0.StartNode(arg_5_0)
	arg_5_0.runningNode:Enter()
end

function var_0_0.Execute(arg_6_0)
	if arg_6_0.status == AutoChessConst.ACTION_NODE_STATUS.RUNNING then
		arg_6_0:ExecuteNode()
	end

	return arg_6_0.status
end

function var_0_0.ExecuteNode(arg_7_0)
	if arg_7_0.runningNode:Execute() == AutoChessConst.ACTION_NODE_STATUS.FINISH then
		arg_7_0.runningNode:Exit()

		if arg_7_0:GetNextRunningNode() then
			arg_7_0:StartNode()
		else
			arg_7_0:Finish()
		end
	end
end

function var_0_0.Finish(arg_8_0)
	arg_8_0.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
end

function var_0_0.GetNextRunningNode(arg_9_0)
	if arg_9_0.status == AutoChessConst.ACTION_NODE_STATUS.NEW then
		if arg_9_0.rootNode then
			arg_9_0.runningNode = arg_9_0.rootNode

			return true
		else
			arg_9_0.runningNode = nil

			return false
		end
	elseif arg_9_0.runningNode.nextNode then
		arg_9_0.runningNode = arg_9_0.runningNode.nextNode

		return true
	else
		arg_9_0.runningNode = nil

		return false
	end
end

function var_0_0.Dispose(arg_10_0)
	local var_10_0 = arg_10_0.rootNode

	while var_10_0 do
		var_10_0:Dispose()

		var_10_0 = var_10_0.nextNode
	end

	arg_10_0:Reset()
end

return var_0_0
