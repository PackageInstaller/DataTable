local var_0_0 = import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")
local var_0_1 = class("TangramSwitchToPlayNode", var_0_0)

function var_0_1.RunFunc(arg_1_0)
	arg_1_0.manager_:SwitchToPlay()
	arg_1_0.root_:SetNodeRunComplete()
end

return var_0_1
