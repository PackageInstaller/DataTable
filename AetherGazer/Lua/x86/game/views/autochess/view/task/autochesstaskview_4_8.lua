local var_0_0 = import("game.views.task.activityTaskCommon.ActivityTaskCommonModule")
local var_0_1 = class("AutoChessTaskView_4_8", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_Xihe/Activity_Xihe_RewardTrustUI"
end

function var_0_1.SetActivityID(arg_2_0)
	arg_2_0.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_AUTO_CHESS_4_8
end

function var_0_1.SetLevelText(arg_3_0)
	arg_3_0.curLv_, arg_3_0.maxLv_ = TaskTools.GetTaskNumInfo(arg_3_0.activityPointRewardActivityID_)
	arg_3_0.levelText_.text = string.format("%d<size=32><color=#FFDE97>/%d</color></size>", arg_3_0.curLv_, arg_3_0.maxLv_)
	arg_3_0.levelTitle_.text = string.format("<color=#FFF6EA>%s</color>", GetTips("AUTO_CHESS_CAREER_ENTRANCE"))
end

return var_0_1
