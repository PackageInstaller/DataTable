local var_0_0 = {}

local function var_0_1()
	local var_1_0 = math.random() < 0.2

	return {
		atk_style_id = math.random(5),
		skill_id = var_1_0 and IdolTraineeSkillCfg.all[math.random(#IdolTraineeSkillCfg.all)] or 0,
		index_list = {}
	}
end

local function var_0_2()
	manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_musicgame_hitsound")
end

function var_0_0.Enter(arg_3_0, arg_3_1)
	manager.windowBar:SetWhereTag("danceGame")
	manager.ui:SetMainCamera("dance")
	manager.audio:StopAll()

	local var_3_0 = BackHomeCricketBattleData:GetSingleBattleData()

	DanceGame.GetInstance():Init(var_3_0, arg_3_1)
	JumpTools.OpenPageByJump("backHomeCricketBattleView", {
		stage = arg_3_1
	})
end

function var_0_0.Exit(arg_4_0)
	DanceGame.GetInstance():Reset(true)
	DanceGameController.RemoveAddedCueSheets()
end

return var_0_0
