local var_0_0 = {}

function var_0_0.Enter(arg_3_0, arg_3_1)
	manager.windowBar:SetWhereTag("danceGame")
	manager.ui:SetMainCamera("dance")
	manager.audio:StopAll()
	DanceGame.GetInstance():Init(BackHomeCricketBattleData:GetSingleBattleData(), arg_3_1)
	JumpTools.OpenPageByJump("backHomeCricketBattleView", {
		stage = arg_3_1
	})
end

function var_0_0.Exit(arg_4_0)
	DanceGame.GetInstance():Reset(true)
	DanceGameController.RemoveAddedCueSheets()
end

return var_0_0
