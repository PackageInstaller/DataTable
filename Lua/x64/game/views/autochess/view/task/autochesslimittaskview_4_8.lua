local var_0_0 = import("game.views.task.limitTime.LimitTimeTaskBaseView")
local var_0_1 = class("AutoChessLimitTaskView_4_8", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)
	var_0_1.super.SetProgressString(GetTips("AUTO_CHESS_LIMITED_TASK_NUM"))
end

function var_0_1.BindRedPoint(arg_2_0)
	for iter_2_0 = 1, #arg_2_0.subActivityIDList_ do
		local var_2_0 = arg_2_0.subActivityIDList_[iter_2_0]
		local var_2_1 = RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK_TAG .. var_2_0

		manager.redPoint:bindUIandKey(arg_2_0.tabList_[iter_2_0].transform_, var_2_1)
	end
end

function var_0_1.UnBindRedPoint(arg_3_0)
	for iter_3_0 = 1, #arg_3_0.subActivityIDList_ do
		local var_3_0 = arg_3_0.subActivityIDList_[iter_3_0]
		local var_3_1 = RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK_TAG .. var_3_0

		manager.redPoint:unbindUIandKey(arg_3_0.tabList_[iter_3_0].transform_, var_3_1)
	end
end

return var_0_1
