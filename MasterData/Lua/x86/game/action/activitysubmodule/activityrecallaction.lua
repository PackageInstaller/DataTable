local var_0_0 = {
	Init = function()
		manager.net:Bind(64087, function(arg_2_0)
			ActivityRecallData:InitActivityRecallData(arg_2_0)
			manager.notify:CallUpdateFunc(RECALL_REWARD_UPDATE)
		end)
		manager.net:Bind(64095, function(arg_3_0)
			ActivityRecallData:InitActivityRecalledData(arg_3_0)
		end)
		manager.net:Bind(64115, function(arg_4_0)
			ActivityRecallData:InitRecalledSignData(arg_4_0)
			manager.notify:CallUpdateFunc(RECALL_SIGN_UPDATE)
		end)
	end
}

function var_0_0.RequireRecallReward(arg_5_0, arg_5_1)
	manager.net:SendWithLoadingNew(64088, {
		activity_id = arg_5_0,
		id = arg_5_1
	}, 64089, var_0_0.RequireRecallRewardCallback)
end

function var_0_0:RequireRecallRewardCallback(arg_6_1)
	if isSuccess(self.result) then
		ActivityRecallData:UpdateRecallRewardList(arg_6_1.id)
		JumpTools.GoToSystem("RecallRewardPop", {
			list = self.reward_list
		})
		manager.notify:CallUpdateFunc(RECALL_REWARD_UPDATE)
		ActivityRecallData:UpdateRecallRewardRedPoint()
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.RequireRecallInfo(arg_7_0)
	manager.net:SendWithLoadingNew(64090, {
		activity_id = arg_7_0
	}, 64091, var_0_0.RequireRecallInfoCallback)
end

function var_0_0:RequireRecallInfoCallback(arg_8_1)
	if isSuccess(self.result) then
		ActivityRecallData:UpdateUserInfoList(self)
		JumpTools.GoToSystem("RecallInfoPop", nil)
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.RequireRecallShareCode(arg_9_0)
	manager.net:SendWithLoadingNew(64092, {
		activity_id = arg_9_0
	}, 64093, var_0_0.RequireRecallShareCodeCallback)
end

function var_0_0:RequireRecallShareCodeCallback(arg_10_1)
	if isSuccess(self.result) then
		UnityEngine.GUIUtility.systemCopyBuffer = ActivityRecallData:GetDataByPara("recallCode")

		ActivityRecallData:UpdateTaskData()
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.RequireWriteRecallCode(arg_11_0, arg_11_1)
	manager.net:SendWithLoadingNew(64096, {
		activity_id = arg_11_0,
		recall_code = arg_11_1
	}, 64097, var_0_0.RequireWriteRecallCodeCallback)
end

function var_0_0:RequireWriteRecallCodeCallback(arg_12_1)
	if isSuccess(self.result) then
		ActivityRecallData:UpdateRecallUserInfo(self)
		manager.notify:CallUpdateFunc(RECALL_CODE_UPDATE)
		JumpTools.GoToSystem("RecallRewardPop", {
			list = self.reward_list
		})
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.RequireRecalledSign(arg_13_0, arg_13_1)
	manager.net:SendWithLoadingNew(64098, {
		activity_id = arg_13_0,
		sign_day = arg_13_1
	}, 64099, var_0_0.RequireRecalledSignCallback)
end

function var_0_0:RequireRecalledSignCallback(arg_14_1)
	if isSuccess(self.result) then
		ActivityRecallData:UpdateSignData(arg_14_1.sign_day)

		local var_14_0 = ActivityRecallData:GetDataByPara("signData")

		JumpTools.GoToSystem("RecallRewardPop", {
			list = self.reward_list
		})
		ActivityRecallData:UpdateSignRedPoint()
		manager.notify:CallUpdateFunc(RECALL_SIGN_UPDATE)
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.RecallShare(arg_15_0, arg_15_1)
	manager.net:SendWithLoadingNew(27600, {
		recommend = arg_15_0
	}, 27601, function(arg_16_0)
		arg_15_1(arg_16_0)
	end)
end

function var_0_0.RequestOpenRecallView(arg_17_0, arg_17_1)
	manager.net:SendWithLoadingNew(64116, {
		main_activity_id = arg_17_0
	}, 64117, function(arg_18_0, arg_18_1)
		if isSuccess(arg_18_0.result) and arg_17_1 then
			arg_17_1()
		end
	end)
end

return var_0_0
