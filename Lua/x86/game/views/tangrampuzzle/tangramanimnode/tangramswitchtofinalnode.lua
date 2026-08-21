local var_0_0 = import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")
local var_0_1 = class("TangramSwitchToFinalNode", var_0_0)

function var_0_1.RunFunc(arg_1_0)
	ShowTips("ACTIVITY_PUZZLE_FINISH")
	arg_1_0.manager_:SwitchToFinal()
	arg_1_0.root_:SetNodeRunComplete()
end

return var_0_1
