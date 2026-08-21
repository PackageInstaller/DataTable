local var_0_0 = {}

local function var_0_1()
	gameContext:Go("/snowballGameLevelUI")
end

function var_0_0.Enter(arg_2_0)
	manager.ui:SetMainCamera("snowball")
	DormMinigame.AdjustCameraFOV(0.5625)

	arg_2_0.listener = EventListener.New()

	local var_2_0 = SnowballGameMgr.GetInstance()

	var_2_0:Init()
	SnowballGameTargetAI.GetInstance():Init()
	var_2_0:SetPlayer(SnowballGameData:GetLastSelectedPlayer())
	arg_2_0.listener:Register(DORM_FRAME_TICK, handler(SnowballGameTargetAI.GetInstance(), SnowballGameTargetAI.Update))
	arg_2_0.listener:Register(ON_FINISH_STORY, var_0_0.OnFinishStory)

	Dorm.globalSubtitleView = SubtitleBubbleView.New()
	Dorm.overrideSubtitleGetContentFunc = SubtitleBubbleView.UseRawContent

	Dorm.globalSubtitleView:OnEnter()

	local var_2_1 = SnowballGameData:IsFirstEnterGame()
	local var_2_2 = nullable(GameSetting.activity_snowball_first_enter_story.value2, 1)

	if var_2_1 and not var_2_2 then
		SnowballGameData:SetAlreadyEnter()

		local var_2_3 = GameSetting.activity_snowball_first_enter_story.value[1]
		local var_2_4 = GameSetting.activity_snowball_story_actor.value

		Dorm.LuaBridge.MiniGameBridge.PlayStory(var_2_3, var_2_4)

		var_0_0.OnFinishStoryCallback = var_0_1
	else
		var_0_1()
	end
end

function var_0_0.Exit(arg_3_0)
	Dorm.globalSubtitleView:OnExit()

	Dorm.overrideSubtitleGetContentFunc = nil
	Dorm.globalSubtitleView = Dorm.globalSubtitleView:Dispose()

	arg_3_0.listener:RemoveAll()
	SnowballGameTargetAI.GetInstance():Dispose()
	SnowballGameMgr.GetInstance():Dispose()
end

function var_0_0.OnFinishStory()
	Dorm.LuaBridge.MiniGameBridge.StopStory()

	if var_0_0.OnFinishStoryCallback then
		var_0_0.OnFinishStoryCallback()

		var_0_0.OnFinishStoryCallback = nil
	end
end

return var_0_0
