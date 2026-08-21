local var_0_0 = {}
local var_0_1 = {}
local var_0_2 = {}
local var_0_3

function var_0_0.Enter(arg_1_0)
	manager.ui:SetMainCamera("barbecue")
	JumpTools.OpenPageByJump("/spHeroChallengeBarbuceView", {
		gameManager = arg_1_0.game
	})
end

function var_0_0.Exit(arg_2_0)
	DormRhythmGameData:Dispose()
end

return var_0_0
