local var_0_0 = singletonClass("ActivityRecallData")

function var_0_0.InitActivityRecallData(arg_1_0, arg_1_1)
	arg_1_0.recallCode = arg_1_1.recall_code
	arg_1_0.recallActivityID = arg_1_1.activity_id
	arg_1_0.codeUseNum = tonumber(arg_1_1.code_use_num)
	arg_1_0.recallRewardList = {}

	for iter_1_0 = 1, 3 do
		if arg_1_1.got_recall_reward_id_list[iter_1_0] then
			arg_1_0.recallRewardList[arg_1_1.got_recall_reward_id_list[iter_1_0]] = 1
		end
	end

	local var_1_0 = ActivityData:GetActivityData(arg_1_0.recallActivityID)
	local var_1_1 = manager.time:STimeDescS(var_1_0.startTime, "!%Y/%m/%d %H:%M:%S")
	local var_1_2 = manager.time:STimeDescS(var_1_0.stopTime, "!%Y/%m/%d %H:%M:%S")

	arg_1_0.recallTime = string.format("%s-%s", var_1_1, var_1_2)

	arg_1_0:UpdateRecallRewardRedPoint()
	arg_1_0:UpdateTaskData()
	arg_1_0:UpdateShopData()
end

function var_0_0.UpdateUserInfoList(arg_2_0, arg_2_1)
	arg_2_0.userInfoList = arg_2_1.info_list
end

function var_0_0.UpdateRecallRewardList(arg_3_0, arg_3_1)
	arg_3_0.recallRewardList[arg_3_1] = 1
end

function var_0_0.UpdateRecallUserInfo(arg_4_0, arg_4_1)
	arg_4_0.isSubmit = true
	arg_4_0.recallUserInfo = arg_4_1.recall_user_info
end

function var_0_0.UpdateTaskData(arg_5_0)
	arg_5_0.taskList = {}

	local var_5_0 = TaskTools:GetActivityTaskList(ActivityConst.RECALL_TASK) or {}
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		local var_5_2 = AssignmentCfg[iter_5_0]

		if iter_5_1.progress >= var_5_2.need and iter_5_1.complete_flag == 0 then
			var_5_1 = 1
		end

		table.insert(arg_5_0.taskList, iter_5_1)
	end

	local var_5_3 = ActivityData:GetActivityData(ActivityConst.RECALL_TASK)
	local var_5_4 = manager.time:STimeDescS(var_5_3.startTime, "!%Y/%m/%d %H:%M:%S")
	local var_5_5 = manager.time:STimeDescS(var_5_3.stopTime, "!%Y/%m/%d %H:%M:%S")

	arg_5_0.taskTime = string.format("%s-%s", var_5_4, var_5_5)

	manager.redPoint:setTip(RedPointConst.RECALL_TASK, var_5_1)
end

function var_0_0.TaskSort(arg_6_0)
	table.sort(arg_6_0.taskList, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_6_0:GetTaskStatus(arg_7_0)
		local var_7_1 = arg_6_0:GetTaskStatus(arg_7_1)

		if var_7_0 ~= var_7_1 then
			return var_7_0 < var_7_1
		end

		if AssignmentCfg[arg_7_0.id].type ~= AssignmentCfg[arg_7_1.id].type then
			return AssignmentCfg[arg_7_0.id].type < AssignmentCfg[arg_7_1.id].type
		end

		return arg_7_0.id > arg_7_1.id
	end)
end

function var_0_0.GetTaskStatus(arg_8_0, arg_8_1)
	local var_8_0 = AssignmentCfg[arg_8_1.id]
	local var_8_1 = arg_8_1.progress
	local var_8_2 = var_8_0.need

	if arg_8_1.complete_flag == 1 then
		return 3
	elseif var_8_2 <= var_8_1 then
		return 1
	else
		return 2
	end
end

function var_0_0.UpdateRecallRewardRedPoint(arg_9_0)
	for iter_9_0 = 1, 3 do
		if iter_9_0 <= arg_9_0.codeUseNum and arg_9_0.recallRewardList[iter_9_0] == nil then
			manager.redPoint:setTip(RedPointConst.RECALL_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.RECALL_REWARD, 0)
end

function var_0_0.InitActivityRecalledData(arg_10_0, arg_10_1)
	arg_10_0.recalledActivityID = arg_10_1.activity_id
	arg_10_0.isSubmit = arg_10_1.is_submit
	arg_10_0.recallUserInfo = arg_10_1.recall_user_info

	local var_10_0 = ActivityData:GetActivityData(arg_10_0.recalledActivityID)
	local var_10_1 = manager.time:STimeDescS(var_10_0.startTime, "!%Y/%m/%d %H:%M:%S")
	local var_10_2 = manager.time:STimeDescS(var_10_0.stopTime, "!%Y/%m/%d %H:%M:%S")

	arg_10_0.recalledTime = string.format("%s-%s", var_10_1, var_10_2)
	arg_10_0.firstPage = arg_10_0.recalledActivityID ~= nil
end

function var_0_0.UpdateSignState(arg_11_0)
	arg_11_0.signState = SignData:GetSevenDaySignInfo(arg_11_0.signActivityID)
end

function var_0_0.UpdateSignRedPoint(arg_12_0)
	for iter_12_0 = 1, #arg_12_0.signData do
		if iter_12_0 <= arg_12_0.signCount and arg_12_0.getRewardList[iter_12_0] == nil then
			manager.redPoint:setTip(RedPointConst.RECALL_SIGN, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.RECALL_SIGN, 0)
end

function var_0_0.UpdateShopData(arg_13_0)
	local var_13_0 = ActivityCfg[ActivityConst.RECALL_MAIN].activity_theme
	local var_13_1 = {}
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in pairs(ActivityShopCfg.get_id_list_by_activity_theme[var_13_0]) do
		table.insert(var_13_2, ShopListCfg[ActivityShopCfg[iter_13_1].shop_id].activity_id)
		table.insert(var_13_1, ActivityShopCfg[iter_13_1].shop_id)
	end

	local var_13_3 = 0

	arg_13_0.shopID = var_13_1[1]

	for iter_13_2, iter_13_3 in ipairs(var_13_2) do
		local var_13_4 = ActivityData:GetActivityData(iter_13_3)
		local var_13_5 = var_13_4.stopTime - manager.time:GetServerTime()

		if var_13_5 > 0 then
			local var_13_6 = manager.time:STimeDescS(var_13_4.startTime, "!%Y/%m/%d %H:%M:%S")
			local var_13_7 = manager.time:STimeDescS(var_13_4.stopTime, "!%Y/%m/%d %H:%M:%S")

			arg_13_0.shopTime = string.format("%s-%s", var_13_6, var_13_7)

			if var_13_3 == 0 or var_13_5 < var_13_3 then
				var_13_3 = var_13_5
				arg_13_0.shopID = var_13_1[iter_13_2]
			end
		end
	end

	local var_13_8 = ShopListCfg[arg_13_0.shopID].chain_last_visible == 1

	arg_13_0.shopData = ShopTools.FilterShopDataList(arg_13_0.shopID, var_13_8)
end

function var_0_0.InitRecalledSignData(arg_14_0, arg_14_1)
	arg_14_0.getRewardList = {}
	arg_14_0.signActivityID = arg_14_1.activity_id
	arg_14_0.signCount = arg_14_1.sign_count
	arg_14_0.lastSignTime = arg_14_1.last_sign_time

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.got_reward_sign_day_list) do
		arg_14_0.getRewardList[iter_14_1] = 1
	end

	arg_14_0:UpdateSignRedPoint()
end

function var_0_0.UpdateSignData(arg_15_0, arg_15_1)
	arg_15_0.getRewardList[arg_15_1] = 1
end

function var_0_0.GetSevenDaySignIndex(arg_16_0, arg_16_1)
	if arg_16_1 <= arg_16_0.signCount and arg_16_0.getRewardList[arg_16_1] == nil then
		return 1
	end

	return 0
end

function var_0_0.Init(arg_17_0)
	arg_17_0.recalledActivityID = nil
	arg_17_0.firstPage = false
	arg_17_0.isSubmit = false
	arg_17_0.recallUserInfo = nil
	arg_17_0.recallCode = nil
	arg_17_0.recallActivityID = nil
	arg_17_0.codeUseNum = nil
	arg_17_0.recallRewardList = {}
	arg_17_0.getRewardList = {}
	arg_17_0.recallReward = GameSetting.recall_reward.value
	arg_17_0.codeLimit = GameSetting.recall_code_limit.value
	arg_17_0.recalledReward = GameSetting.recalled_reward.value
	arg_17_0.recallLevel = GameSetting.recall_level.value[1]

	local var_17_0 = ActivityCfg.get_id_list_by_activity_template[ActivityConst.RECALL_SIGN][1]

	arg_17_0.signActivityID = var_17_0

	local var_17_1 = ActivityCumulativeSignCfg[var_17_0].config_list

	arg_17_0.signData = {}

	for iter_17_0, iter_17_1 in pairs(var_17_1) do
		table.insert(arg_17_0.signData, SignCfg[iter_17_1])
	end

	arg_17_0.recallChatOrData_ = {}
	arg_17_0.unsortRecallData_ = {}
	arg_17_0.recallChatTempData_ = {}
	arg_17_0.lastTimestamp_ = 0
	arg_17_0.lastShareTimestamp_ = 0
end

function var_0_0.GetDataByPara(arg_18_0, arg_18_1)
	return arg_18_0[arg_18_1]
end

function var_0_0.SetLastShareTimestamp(arg_19_0)
	arg_19_0.lastShareTimestamp_ = manager.time:GetServerTime()
end

function var_0_0.GetLastShareTimestamp(arg_20_0)
	return arg_20_0.lastShareTimestamp_ or 0
end

function var_0_0.GetLastTimestamp(arg_21_0)
	return arg_21_0.lastTimestamp_
end

function var_0_0.GetChatData(arg_22_0)
	return arg_22_0.recallChatTempData_ or {}
end

function var_0_0.GetOriginChatData(arg_23_0)
	return arg_23_0.recallChatOrData_
end

function var_0_0.AddChatRecord(arg_24_0, arg_24_1)
	table.insert(arg_24_0.unsortRecallData_, arg_24_0:ParseMsg(arg_24_1))
end

function var_0_0.SortMsg(arg_25_0, arg_25_1)
	table.sort(arg_25_0.unsortRecallData_, function(arg_26_0, arg_26_1)
		return arg_26_0.timestamp < arg_26_1.timestamp
	end)

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.unsortRecallData_) do
		arg_25_0.recallChatOrData_ = arg_25_0.recallChatOrData_ or {}

		table.insert(arg_25_0.recallChatOrData_, iter_25_1)
		arg_25_0:AddChatMsg(iter_25_1, table.keyof(arg_25_1, iter_25_1.id))

		if iter_25_0 == #arg_25_0.unsortRecallData_ then
			arg_25_0.lastTimestamp_ = iter_25_1.timestamp
		end
	end

	if #arg_25_0.unsortRecallData_ <= 0 then
		arg_25_0.lastTimestamp_ = manager.time:GetServerTime()
	end

	arg_25_0.unsortRecallData_ = {}
end

function var_0_0.InitCacheContent(arg_27_0)
	local var_27_0 = clone(arg_27_0.recallChatOrData_ or {})

	arg_27_0.recallChatTempData_ = {}

	local var_27_1 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		arg_27_0:AddChatMsg(iter_27_1, table.keyof(var_27_1, iter_27_1.id))
	end
end

function var_0_0.AddChatMsg(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_2 then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0.recallChatTempData_) do
			if iter_28_1.id and iter_28_1.id == arg_28_1.id then
				table.remove(arg_28_0.recallChatTempData_, iter_28_0)

				if arg_28_0.recallChatTempData_[iter_28_0 - 1] and arg_28_0.recallChatTempData_[iter_28_0 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
					if arg_28_0.recallChatTempData_[iter_28_0] and arg_28_0.recallChatTempData_[iter_28_0].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(arg_28_0.recallChatTempData_, iter_28_0 - 1)

						break
					end

					if iter_28_0 == #arg_28_0.recallChatTempData_ + 1 then
						table.remove(arg_28_0.recallChatTempData_, iter_28_0 - 1)
					end
				end

				break
			end
		end

		local var_28_0 = #arg_28_0.recallChatTempData_

		if var_28_0 <= 0 or arg_28_1.timestamp - arg_28_0.recallChatTempData_[var_28_0 - 1].timestamp > ChatConst.MESSAGE_SPACE then
			local var_28_1 = {
				timestamp = arg_28_1.timestamp,
				contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
			}

			table.insert(arg_28_0.recallChatTempData_, var_28_1)
		end

		table.insert(arg_28_0.recallChatTempData_, arg_28_1)
	end
end

function var_0_0.RemoveChatRecord(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0.recallChatOrData_) do
		if iter_29_1.contentType == ChatConst.CHAT_CONTENT_TYPE.RECALL and iter_29_1.id == arg_29_1 then
			if arg_29_0.recallChatOrData_[iter_29_0 + 1] == nil and arg_29_0.recallChatOrData_[iter_29_0 - 1] and arg_29_0.recallChatOrData_[iter_29_0 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(arg_29_0.recallChatOrData_, iter_29_0)
				table.remove(arg_29_0.recallChatOrData_, iter_29_0 - 1)

				break
			end

			table.remove(arg_29_0.recallChatOrData_, iter_29_0)

			break
		end
	end

	for iter_29_2, iter_29_3 in ipairs(arg_29_0.recallChatTempData_) do
		if iter_29_3.contentType == ChatConst.CHAT_CONTENT_TYPE.RECALL and iter_29_3.id == arg_29_1 then
			if arg_29_0.recallChatTempData_[iter_29_2 + 1] and arg_29_0.recallChatTempData_[iter_29_2 - 1] and arg_29_0.recallChatTempData_[iter_29_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(arg_29_0.recallChatTempData_, iter_29_2)
				table.remove(arg_29_0.recallChatTempData_, iter_29_2 - 1)

				break
			end

			table.remove(arg_29_0.recallChatTempData_, iter_29_2)

			break
		end
	end
end

function var_0_0.ParseMsg(arg_30_0, arg_30_1)
	return {
		id = arg_30_1.sender_id,
		nick = arg_30_1.user_base.nick,
		icon = arg_30_1.user_base.icon,
		iconFrame = arg_30_1.user_base.icon_frame,
		timestamp = arg_30_1.timestamp,
		contentType = ChatConst.CHAT_CONTENT_TYPE.RECALL,
		content = arg_30_1.content,
		ip = (arg_30_1.ip_location == nil or arg_30_1.ip_location == "") and GetTips("IP_UNKNOWN") or arg_30_1.ip_location
	}
end

return var_0_0
