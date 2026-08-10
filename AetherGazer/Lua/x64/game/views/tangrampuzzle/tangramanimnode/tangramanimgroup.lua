local var_0_0 = import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")
local var_0_1 = class("TangramAutoPutNode", var_0_0)

function var_0_1.Ctor(arg_1_0)
	arg_1_0.nodeDic_ = {}
	arg_1_0.nodeSize_ = 0
end

function var_0_1.Dispose(arg_2_0)
	arg_2_0.root_ = nil
	arg_2_0.nodeDic_ = nil
end

function var_0_1.Add(arg_3_0, arg_3_1)
	arg_3_0.nodeSize_ = arg_3_0.nodeSize_ + 1
	arg_3_0.nodeDic_[arg_3_1] = true
end

function var_0_1.RunFunc(arg_4_0)
	arg_4_0.runningNodeCount_ = arg_4_0.nodeSize_

	for iter_4_0, iter_4_1 in pairs(arg_4_0.nodeDic_) do
		iter_4_0:RunFunc()
	end
end

function var_0_1.SetNodeRunComplete(arg_5_0)
	arg_5_0.runningNodeCount_ = arg_5_0.runningNodeCount_ - 1

	if arg_5_0.runningNodeCount_ == 0 then
		arg_5_0.root_:SetNodeRunComplete()
	end
end

return var_0_1
