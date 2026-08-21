local var_0_0 = import("game.views.task.activityTaskCommon.ActivityTaskCommonModule")
local var_0_1 = class("AutoChessTaskView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Com/Activity_OsirisHorus_RewardTrustUI"
end

function var_0_1.SetActivityID(arg_2_0)
	arg_2_0.activityPointRewardActivityID_ = AutoChessData:GetActivityID()
end

function var_0_1.SetLevelText(arg_3_0)
	arg_3_0.curLv_, arg_3_0.maxLv_ = TaskTools.GetTaskNumInfo(arg_3_0.activityPointRewardActivityID_)
	arg_3_0.levelText_.text = GetTipsF("AUTO_CHESS_PROGRESS_NUMBER", arg_3_0.curLv_, arg_3_0.maxLv_)
	arg_3_0.levelTitle_.text = GetTips("AUTO_CHESS_PROGRESS_TITLE")
end

return var_0_1
