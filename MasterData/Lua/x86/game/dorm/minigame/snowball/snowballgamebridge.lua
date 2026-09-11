local var_0_0 = {}

local function var_0_1()
	gameContext:Go("/snowballGameLevelUI")
end

function var_0_0:Enter()
	manager.ui:SetMainCamera("snowball")
	DormMinigame.AdjustCameraFOV(0.5625)

	self.listener = EventListener.New()

	local var_2_0 = SnowballGameMgr.GetInstance()

	var_2_0:Init()
	SnowballGameTargetAI.GetInstance():Init()
	var_2_0:SetPlayer(SnowballGameData:GetLastSelectedPlayer())
	self.listener:Register(DORM_FRAME_TICK, handler(SnowballGameTargetAI.GetInstance(), SnowballGameTargetAI.Update))
	self.listener:Register(ON_FINISH_STORY, var_0_0.OnFinishStory)

	Dorm.globalSubtitleView = SubtitleBubbleView.New()
	Dorm.overrideSubtitleGetContentFunc = SubtitleBubbleView.UseRawContent

	Dorm.globalSubtitleView:OnEnter()

	if SnowballGameData:IsFirstEnterGame() and not nullable(GameSetting.activity_snowball_first_enter_story.value2, 1) then
		SnowballGameData:SetAlreadyEnter()
		Dorm.LuaBridge.MiniGameBridge.PlayStory(GameSetting.activity_snowball_first_enter_story.value[1], GameSetting.activity_snowball_story_actor.value)

		var_0_0.OnFinishStoryCallback = var_0_1
	else
		var_0_1()
	end
end

function var_0_0:Exit()
	Dorm.globalSubtitleView:OnExit()

	Dorm.overrideSubtitleGetContentFunc = nil
	Dorm.globalSubtitleView = Dorm.globalSubtitleView:Dispose()

	self.listener:RemoveAll()
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
