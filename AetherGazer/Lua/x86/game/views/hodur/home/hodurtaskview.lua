local var_0_0 = import("game.views.task.activityTaskCommon.ActivityTaskCommonModule")
local var_0_1 = class("HodurTaskView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_Hodur/Com/Activity_Hodur_RewardTrustUI"
end

function var_0_1.SetActivityID(arg_2_0)
	arg_2_0.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_HODUR_MAIN
end

function var_0_1.UpdateView(arg_3_0)
	arg_3_0:SetLevelText()

	arg_3_0.receiveList_ = {}
	arg_3_0.showIdList_ = {}

	local var_3_0 = 1
	local var_3_1 = true

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.idList_) do
		local var_3_2 = TaskData2:GetTask(iter_3_1)
		local var_3_3 = "lock"

		if var_3_2.progress >= AssignmentCfg[iter_3_1].need then
			if var_3_2.complete_flag < 1 then
				table.insert(arg_3_0.receiveList_, iter_3_1)

				var_3_3 = "receive"
				var_3_1 = false
			else
				var_3_3 = "complete"

				if var_3_1 then
					var_3_0 = iter_3_0 + 1
				end
			end
		end

		table.insert(arg_3_0.showIdList_, {
			id = iter_3_1,
			ind = iter_3_0,
			state = var_3_3
		})
	end

	if var_3_0 > #arg_3_0.showIdList_ then
		var_3_0 = 1
	end

	arg_3_0.levelLuaList_:StartScroll(#arg_3_0.showIdList_, var_3_0)
	arg_3_0.onekeyController_:SetSelectedState(#arg_3_0.receiveList_ > 0 and "true" or "false")
end

function var_0_1.SetLevelText(arg_4_0)
	local var_4_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_HODUR_MAIN]

	arg_4_0.curLv_ = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_HODUR_MAIN)
	arg_4_0.maxLv_ = #var_4_0
	arg_4_0.levelText_.text = arg_4_0.curLv_ .. "/" .. arg_4_0.maxLv_
	arg_4_0.progressImg_.fillAmount = arg_4_0.curLv_ / arg_4_0.maxLv_
end

return var_0_1
