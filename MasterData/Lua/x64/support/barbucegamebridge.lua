local var_0_0 = {}

function var_0_0:Enter()
	manager.ui:SetMainCamera("barbecue")
	JumpTools.OpenPageByJump("/spHeroChallengeBarbuceView", {
		gameManager = self.game
	})
end

function var_0_0.Exit(arg_2_0)
	DormRhythmGameData:Dispose()
end

return var_0_0
