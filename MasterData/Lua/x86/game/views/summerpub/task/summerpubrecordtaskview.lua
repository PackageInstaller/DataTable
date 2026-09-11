local SummerPubRecordTaskView = class("SummerPubRecordTaskView", (import("game.views.task.activityTaskCommon.ActivityTaskCommonModule")))

function SummerPubRecordTaskView:UIName()
	return "Widget/System/Activity_SummerPub/MainPub/Com/Activity_SummerPub_RewardTrustUI"
end

function SummerPubRecordTaskView:SetActivityID()
	self.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_NYA_SUMMER_PUB
end

function SummerPubRecordTaskView:GetLevelInfo()
	local var_3_0, var_3_1 = SummerPubTool:GetTaskInfo()

	return var_3_0, var_3_1
end

return SummerPubRecordTaskView
