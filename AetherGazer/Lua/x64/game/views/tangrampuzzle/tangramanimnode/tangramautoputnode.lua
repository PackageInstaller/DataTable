local var_0_0 = import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")
local var_0_1 = class("TangramAutoPutNode", var_0_0)

function var_0_1.RunFunc(arg_1_0)
	arg_1_0.manager_:RefreshPuzzleList()
	SetActive(arg_1_0.manager_.autoPutPanelGo_, true)
	arg_1_0.manager_:PlayAnim(arg_1_0.manager_.autoPutAnim_, "regionContentPanel", function()
		SetActive(arg_1_0.manager_.autoPutPanelGo_, false)
		arg_1_0.root_:SetNodeRunComplete()
	end)
	manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_complete1", "")
end

return var_0_1
