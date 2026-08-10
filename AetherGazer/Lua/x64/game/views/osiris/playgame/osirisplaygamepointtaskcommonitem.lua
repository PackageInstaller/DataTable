local var_0_0 = import("game.views.task.activityPointTaskCommon.ActivityPointTaskCommonItem")
local var_0_1 = class("OsirisPlayGamePointTaskCommonItem", var_0_0)

function var_0_1.AddUIListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.receiveBtn_, nil, function()
		OsirisPlayGameAction.GetPointReward({
			arg_1_0.ID_
		})
	end)
end

function var_0_1.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.ID_ = arg_3_1
	arg_3_0.titleText_.text = arg_3_2 > 9 and arg_3_2 or "0" .. arg_3_2

	arg_3_0.controller_:SetSelectedState(arg_3_3)

	local var_3_0 = "ACTIVITY_POINT_TASK_COMMON_NAME_" .. arg_3_4

	if TipsCfg.get_id_list_by_define[var_3_0] then
		arg_3_0.descText_.text = GetTipsF(var_3_0, arg_3_2)
	else
		arg_3_0.descText_.text = arg_3_2
	end

	local var_3_1 = ActivityPointRewardCfg[arg_3_1]

	for iter_3_0 = 1, 3 do
		if var_3_1.reward_item_list[iter_3_0] then
			local var_3_2 = cfgToItemTemplate(var_3_1.reward_item_list[iter_3_0])

			var_3_2.grayFlag = arg_3_3 == "complete"

			function var_3_2.clickFun(arg_4_0)
				ShowPopItem(POP_ITEM, arg_4_0)
			end

			arg_3_0.commonItemList_[iter_3_0]:SetData(var_3_2)
		end
	end

	if arg_3_3 == "go" or arg_3_3 == "receive" or arg_3_3 == "complete" then
		arg_3_0.progressText_.text = "1/1"
		arg_3_0.progressBar_.value = 1
	else
		arg_3_0.progressText_.text = "0/1"
		arg_3_0.progressBar_.value = 0
	end
end

return var_0_1
