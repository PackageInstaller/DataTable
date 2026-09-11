local AutoChessTaskView = class("AutoChessTaskView", (import("game.views.task.activityTaskCommon.ActivityTaskCommonModule")))

function AutoChessTaskView:UIName()
	return "Widget/System/Activity_OsirisHorus/Com/Activity_OsirisHorus_RewardTrustUI"
end

function AutoChessTaskView:SetActivityID()
	self.activityPointRewardActivityID_ = AutoChessData:GetActivityID()
end

function AutoChessTaskView:SetLevelText()
	self.curLv_, self.maxLv_ = TaskTools.GetTaskNumInfo(self.activityPointRewardActivityID_)
	self.levelText_.text = GetTipsF("AUTO_CHESS_PROGRESS_NUMBER", self.curLv_, self.maxLv_)
	self.levelTitle_.text = GetTips("AUTO_CHESS_PROGRESS_TITLE")
end

return AutoChessTaskView
