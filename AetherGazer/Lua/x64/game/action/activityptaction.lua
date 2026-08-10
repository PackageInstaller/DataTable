local var_0_0 = {}

manager.net:Bind(28019, function(arg_1_0)
	ActivityPtData:TaskDailyGetRewardInit(arg_1_0.pt_list)
	ActivityPtAction:UpdateActivityPt()
end)

function var_0_0.TaskDailyGetReward(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = ActivityPtData:GetGiftPt(arg_2_2, arg_2_1)

	manager.net:SendWithLoadingNew(28016, {
		need_active_point = var_2_0,
		activity_pt_id = arg_2_2
	}, 28017, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			ActivityPtData:TaskDailySubmit({
				activityID = arg_2_2,
				activityPt = var_2_0
			})
			arg_2_0:UpdateActivityPt()

			local var_3_0 = mergeReward2(arg_3_0.reward_list or {})

			if #var_3_0 > 0 then
				getReward2(var_3_0)
			end
		else
			ShowTips(arg_3_0.result)
		end
	end)
end

function var_0_0.UpdateActivityPt(arg_4_0)
	TaskRedPoint:UpdateDailyTaskRedTip()
	TaskRedPoint:UpdateWeekTaskRedTip()
	MoonBoData:FreshCanGetCount()
	manager.notify:Invoke(ACTIVITY_PT_UPDATE)
	manager.notify:CallUpdateFunc(ACTIVITY_PT_UPDATE)
end

return var_0_0
