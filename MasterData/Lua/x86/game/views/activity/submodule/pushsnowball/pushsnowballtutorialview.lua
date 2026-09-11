local PushSnowBallTutorialView = class("PushSnowBallTutorialView", ReduxView)

function PushSnowBallTutorialView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballTeachingEntrancePopUI"
end

function PushSnowBallTutorialView:UIParent()
	return manager.ui.uiPop.transform
end

function PushSnowBallTutorialView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PushSnowBallTutorialView:InitUI()
	self:BindCfgUI()
end

function PushSnowBallTutorialView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.timer_ then
			return
		end

		self.bgAni_:SetFloat("speed", -1)
		self.bgAni_:Play("EventPopUI1", 0, 1)
		self.bgAni_:Update(0)

		self.timer_ = Timer.New(function()
			self:Back()

			self.timer_ = nil
		end, 0.18, 1)

		self.timer_:Start()
	end)
	self:AddBtnListener(self.playBtn_, nil, function()
		local var_8_0 = PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(1, 1)

		BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE, GameSetting.push_snow_ball_tutorial_stage.value[1], {
			activityID = var_8_0
		})))
	end)
end

function PushSnowBallTutorialView:OnEnter()
	return
end

function PushSnowBallTutorialView:AddTimer()
	return
end

function PushSnowBallTutorialView:OnExit()
	return
end

return PushSnowBallTutorialView
