local ArtifactView = class("ArtifactView", ReduxView)

function ArtifactView:UIName()
	return "UI/VersionUI/SummerUI/SummeDivinepersonalityUI"
end

function ArtifactView:UIParent()
	return manager.ui.uiMain.transform
end

function ArtifactView:Init()
	self:InitUI()
	self:AddBtnListener(self.startBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(ActivityConst.SUMMER_ARTIFACT) then
			self:Go("/artifactLevel")
		elseif manager.time:GetServerTime() < ActivityData:GetActivityData(ActivityConst.SUMMER_ARTIFACT).stopTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(ActivityConst.SUMMER_ARTIFACT).startTime))))
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
end

function ArtifactView:InitUI()
	self:BindCfgUI()
end

function ArtifactView:OnEnter()
	self.stopTime_ = ActivityData:GetActivityData(ActivityConst.SUMMER_ARTIFACT).stopTime
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() < self.stopTime_ then
			self.timeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
		else
			self:StopTimer()

			self.timeText_.text = GetTips("TIME_OVER")

			return
		end
	end, -1, 1)

	self.timer_:Start()
	manager.redPoint:bindUIandKey(self.startTrs_, string.format("%s_%s", RedPointConst.ARTIFACT, ActivityConst.SUMMER_ARTIFACT))
end

function ArtifactView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SUMMER_ARTIFACT_DESCRIPE")
end

function ArtifactView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	manager.redPoint:unbindUIandKey(self.startTrs_, string.format("%s_%s", RedPointConst.ARTIFACT, ActivityConst.SUMMER_ARTIFACT))
end

function ArtifactView:Dispose()
	self.super.Dispose(self)
end

function ArtifactView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ArtifactView
