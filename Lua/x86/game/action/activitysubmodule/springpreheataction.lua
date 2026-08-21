local var_0_0 = {}

manager.net:Bind(76401, function(arg_1_0)
	SpringPreheatData:InitData(arg_1_0)
	SpringPreheatAction:InitRedPoint(arg_1_0)
end)

function var_0_0.SendBlessingLetter(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = SpringPreheatData:GetPlayerLetter()
	local var_2_1 = {
		activity_id = SpringPreheatData:GetActivityId(),
		letter_id = var_2_0.id,
		optional_content_index = arg_2_2,
		sticker_id_list = arg_2_3
	}

	manager.net:SendWithLoadingNew(76402, var_2_1, 76403, function(arg_3_0, arg_3_1)
		arg_2_0:OnSendBlessingLetter(arg_3_0, arg_3_1, arg_2_4)
	end)
end

function var_0_0.OnSendBlessingLetter(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if isSuccess(arg_4_1.result) then
		SpringPreheatData:SendLetter()
		arg_4_3()
	else
		ShowTips(arg_4_1.result)
	end
end

function var_0_0.UploadPraySelection(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = {
		activity_id = SpringPreheatData:GetActivityId(),
		day = arg_5_1,
		select_reward_list = {
			first_reward_id = arg_5_2[1],
			second_reward_id = arg_5_2[2]
		}
	}

	manager.net:SendWithLoadingNew(76404, var_5_0, 76405, function(arg_6_0, arg_6_1)
		arg_5_0:OnUploadPraySelection(arg_6_0, arg_6_1, arg_5_3)
	end)
end

function var_0_0.OnUploadPraySelection(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if isSuccess(arg_7_1.result) then
		local var_7_0 = {
			arg_7_2.select_reward_list.first_reward_id,
			arg_7_2.select_reward_list.second_reward_id
		}

		SpringPreheatData:ModifyPraySelection(var_7_0)
		arg_7_3()
	else
		ShowTips(arg_7_1.result)
	end
end

function var_0_0.RequestProgressReward(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		point_reward_id_list = {
			arg_8_1
		}
	}

	manager.net:SendWithLoadingNew(60054, var_8_0, 60055, function(arg_9_0, arg_9_1)
		if not isSuccess(arg_9_0.result) then
			ShowTips(arg_9_0.result)

			return
		end

		SpringPreheatData:AcquireProgressReward(arg_8_1)
		arg_8_2(arg_9_0)
	end)
end

function var_0_0.InitRedPoint(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.activity_id

	arg_10_0.activityId = var_10_0

	if not ActivityData:GetActivityIsOpen(var_10_0) then
		return
	end

	local var_10_1 = ActivityTools.GetRedPointKey(var_10_0) .. var_10_0
	local var_10_2 = string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_LETTER, var_10_1)
	local var_10_3 = string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_REWARD, var_10_1)
	local var_10_4 = string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_PRAY, var_10_1)
	local var_10_5 = {}

	table.insert(var_10_5, var_10_2)
	table.insert(var_10_5, var_10_3)
	table.insert(var_10_5, var_10_4)
	manager.redPoint:addGroup(var_10_1, var_10_5)
	arg_10_0:UpdateRedPoint(var_10_0)
end

function var_0_0.UpdateRedPoint(arg_11_0, arg_11_1)
	local var_11_0 = ActivityTools.GetRedPointKey(arg_11_1) .. arg_11_1
	local var_11_1 = string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_LETTER, var_11_0)
	local var_11_2 = string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_REWARD, var_11_0)
	local var_11_3 = string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_PRAY, var_11_0)
	local var_11_4 = SpringPreheatData:HasRewardCanAcquire()
	local var_11_5 = SpringPreheatData:GetLetterStorage() ~= math.min(SpringPreheatData:GetMaxProgress(), SpringPreheatData:GetActivityTotalDay()) and not SpringPreheatData:IsTodayWritten()
	local var_11_6 = false
	local var_11_7 = SpringPreheatData:GetMaxProgress()

	for iter_11_0 = 1, var_11_7 do
		local var_11_8 = SpringPreheatData:GetDayState(iter_11_0)

		if var_11_8 == 1 then
			break
		elseif var_11_8 == 2 or var_11_8 == 3 then
			var_11_6 = true

			break
		end
	end

	manager.redPoint:setTip(var_11_1, var_11_5 and 1 or 0)
	manager.redPoint:setTip(var_11_2, var_11_4 and 1 or 0)
	manager.redPoint:setTip(var_11_3, var_11_6 and 1 or 0)
end

function var_0_0.RefreshRedPoint(arg_12_0)
	if arg_12_0.activityId and not ActivityData:GetActivityIsOpen(arg_12_0.activityId) then
		local var_12_0 = ActivityTools.GetRedPointKey(arg_12_0.activityId) .. arg_12_0.activityId
		local var_12_1 = string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_LETTER, var_12_0)
		local var_12_2 = string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_REWARD, var_12_0)
		local var_12_3 = string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_PRAY, var_12_0)

		manager.redPoint:setTip(var_12_1, 0)
		manager.redPoint:setTip(var_12_2, 0)
		manager.redPoint:setTip(var_12_3, 0)

		return
	end
end

return var_0_0
