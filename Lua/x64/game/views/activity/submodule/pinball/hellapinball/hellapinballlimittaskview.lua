local var_0_0 = import("game.views.task.limitTime.LimitTimeTaskBaseView")
local var_0_1 = class("HellaPinballLimitTaskView", var_0_0)

function var_0_1.BindRedPoint(arg_1_0)
	for iter_1_0 = 1, #arg_1_0.subActivityIDList_ do
		local var_1_0 = arg_1_0.subActivityIDList_[iter_1_0]
		local var_1_1 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_1_0)

		manager.redPoint:bindUIandKey(arg_1_0.tabList_[iter_1_0].transform_, var_1_1)
	end
end

function var_0_1.UnBindRedPoint(arg_2_0)
	for iter_2_0 = 1, #arg_2_0.subActivityIDList_ do
		local var_2_0 = arg_2_0.subActivityIDList_[iter_2_0]
		local var_2_1 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_2_0)

		manager.redPoint:unbindUIandKey(arg_2_0.tabList_[iter_2_0].transform_, var_2_1)
	end
end

return var_0_1
