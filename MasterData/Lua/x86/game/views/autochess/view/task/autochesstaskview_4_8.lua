local AutoChessTaskView_4_8 = class("AutoChessTaskView_4_8", (import("game.views.task.activityTaskCommon.ActivityTaskCommonModule")))

function AutoChessTaskView_4_8:UIName()
	return "Widget/System/Activity_Xihe/Activity_Xihe_RewardTrustUI"
end

function AutoChessTaskView_4_8:SetActivityID()
	self.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_AUTO_CHESS_4_8
end

function AutoChessTaskView_4_8:SetLevelText()
	self.curLv_, self.maxLv_ = TaskTools.GetTaskNumInfo(self.activityPointRewardActivityID_)
	self.levelText_.text = string.format("%d<size=32><color=#FFDE97>/%d</color></size>", self.curLv_, self.maxLv_)
	self.levelTitle_.text = string.format("<color=#FFF6EA>%s</color>", GetTips("AUTO_CHESS_CAREER_ENTRANCE"))
end

return AutoChessTaskView_4_8
