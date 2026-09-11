local WaterPipeSelectView = class("WaterPipeSelectView", ReduxView)

function WaterPipeSelectView:UIName()
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipeUI/WaterPipeStageSelectUI"
end

function WaterPipeSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function WaterPipeSelectView:Init()
	self:InitUI()
end

function WaterPipeSelectView:InitUI()
	self:BindCfgUI()

	self.stageMap = WaterPipeStageMapView.New(self.stageGo_)
end

function WaterPipeSelectView:OnEnter()
	self.stageMap:RefreshUI()
	self.stageMap:BindRedPoint()
	self.stageMap:MoveToOptimal()
	self:StartTimer()
	self:UpdateTimeShow()

	if self.params_ and self.params_.finishStageID then
		self.stageMap:PlaySettleAni(self.params_.finishStageID)
	end
end

function WaterPipeSelectView:UpdateTimeShow()
	local var_6_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_WATER_PIPE)

	self.textTimeText_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_6_0.stopTime, true))

	if not var_6_0 or not var_6_0:IsActivitying() then
		ShowTips("TIME_OVER")
		JumpTools.Back()
	end
end

function WaterPipeSelectView:StartTimer()
	self:DisposeTimer()

	self.timer = Timer.New(function()
		self:UpdateTimeShow()
	end, 1, -1)

	self.timer:Start()
end

function WaterPipeSelectView:DisposeTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function WaterPipeSelectView:OnExit()
	self:DisposeTimer()
	manager.windowBar:HideBar()
	self.stageMap:UnBindRedPoint()
end

function WaterPipeSelectView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function()
		local var_12_0 = {
			content = GetTips("ACTIVITY_WATER_PIPE_GAME_TIP")
		}

		var_12_0.key = "ACTIVITY_WATER_PIPE_GAME_TIP"

		JumpTools.OpenPageByJump("gameHelp", var_12_0)
	end)
end

function WaterPipeSelectView:Dispose()
	self.stageMap:Dispose()
	WaterPipeSelectView.super.Dispose(self)
end

return WaterPipeSelectView
