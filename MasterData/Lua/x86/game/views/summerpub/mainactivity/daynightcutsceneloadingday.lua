local DayNightCutSceneLoadingDay = class("DayNightCutSceneLoadingDay", ReduxView)

function DayNightCutSceneLoadingDay:UIName()
	return "Widget/System/Activity_SummerPub/MainPub/DayNightCutSceneLoading_Day"
end

function DayNightCutSceneLoadingDay:UIParent()
	return manager.ui.uiPop.transform
end

function DayNightCutSceneLoadingDay:OnEnter()
	self:StopTimer()

	self.timer = Timer.New(function()
		self:StopTimer()
		JumpTools.OpenPageByJump("/summerPubStageView")
	end, 6, 1)

	self.timer:Start()
end

function DayNightCutSceneLoadingDay:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function DayNightCutSceneLoadingDay:Dispose()
	self:StopTimer()
	DayNightCutSceneLoadingDay.super.Dispose(self)
end

return DayNightCutSceneLoadingDay
