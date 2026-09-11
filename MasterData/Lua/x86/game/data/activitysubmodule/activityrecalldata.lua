local var_0_0 = singletonClass("ActivityRecallData")

function var_0_0:InitActivityRecallData(arg_1_1)
	self.recallCode = arg_1_1.recall_code
	self.recallActivityID = arg_1_1.activity_id
	self.codeUseNum = tonumber(arg_1_1.code_use_num)
	self.recallRewardList = {}

	for iter_1_0 = 1, 3 do
		if arg_1_1.got_recall_reward_id_list[iter_1_0] then
			self.recallRewardList[arg_1_1.got_recall_reward_id_list[iter_1_0]] = 1
		end
	end

	local var_1_0 = ActivityData:GetActivityData(self.recallActivityID)

	self.recallTime = string.format("%s-%s", manager.time:STimeDescS(var_1_0.startTime, "!%Y/%m/%d %H:%M:%S"), (manager.time:STimeDescS(var_1_0.stopTime, "!%Y/%m/%d %H:%M:%S")))

	self:UpdateRecallRewardRedPoint()
	self:UpdateTaskData()
	self:UpdateShopData()
end

function var_0_0.UpdateUserInfoList(arg_2_0, arg_2_1)
	arg_2_0.userInfoList = arg_2_1.info_list
end

function var_0_0:UpdateRecallRewardList(arg_3_1)
	self.recallRewardList[arg_3_1] = 1
end

function var_0_0.UpdateRecallUserInfo(arg_4_0, arg_4_1)
	arg_4_0.isSubmit = true
	arg_4_0.recallUserInfo = arg_4_1.recall_user_info
end

function var_0_0:UpdateTaskData()
	self.taskList = {}

	local var_5_0 = 0

	for iter_5_0, iter_5_1 in pairs(TaskTools:GetActivityTaskList(ActivityConst.RECALL_TASK) or {}) do
		if iter_5_1.progress >= AssignmentCfg[iter_5_0].need and iter_5_1.complete_flag == 0 then
			var_5_0 = 1
		end

		table.insert(self.taskList, iter_5_1)
	end

	local var_5_1 = ActivityData:GetActivityData(ActivityConst.RECALL_TASK)

	self.taskTime = string.format("%s-%s", manager.time:STimeDescS(var_5_1.startTime, "!%Y/%m/%d %H:%M:%S"), (manager.time:STimeDescS(var_5_1.stopTime, "!%Y/%m/%d %H:%M:%S")))

	manager.redPoint:setTip(RedPointConst.RECALL_TASK, var_5_0)
end

function var_0_0:TaskSort()
	table.sort(self.taskList, function(arg_7_0, arg_7_1)
		local var_7_0 = self:GetTaskStatus(arg_7_0)
		local var_7_1 = self:GetTaskStatus(arg_7_1)

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
	if arg_8_1.complete_flag == 1 then
		return 3
	elseif AssignmentCfg[arg_8_1.id].need <= arg_8_1.progress then
		return 1
	else
		return 2
	end
end

function var_0_0:UpdateRecallRewardRedPoint()
	for iter_9_0 = 1, 3 do
		if iter_9_0 <= self.codeUseNum and self.recallRewardList[iter_9_0] == nil then
			manager.redPoint:setTip(RedPointConst.RECALL_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.RECALL_REWARD, 0)
end

function var_0_0:InitActivityRecalledData(arg_10_1)
	self.recalledActivityID = arg_10_1.activity_id
	self.isSubmit = arg_10_1.is_submit
	self.recallUserInfo = arg_10_1.recall_user_info

	local var_10_0 = ActivityData:GetActivityData(self.recalledActivityID)

	self.recalledTime = string.format("%s-%s", manager.time:STimeDescS(var_10_0.startTime, "!%Y/%m/%d %H:%M:%S"), (manager.time:STimeDescS(var_10_0.stopTime, "!%Y/%m/%d %H:%M:%S")))
	self.firstPage = self.recalledActivityID ~= nil
end

function var_0_0:UpdateSignState()
	self.signState = SignData:GetSevenDaySignInfo(self.signActivityID)
end

function var_0_0:UpdateSignRedPoint()
	for iter_12_0 = 1, #self.signData do
		if iter_12_0 <= self.signCount and self.getRewardList[iter_12_0] == nil then
			manager.redPoint:setTip(RedPointConst.RECALL_SIGN, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.RECALL_SIGN, 0)
end

function var_0_0:UpdateShopData()
	local var_13_0 = {}
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityCfg[ActivityConst.RECALL_MAIN].activity_theme]) do
		table.insert(var_13_1, ShopListCfg[ActivityShopCfg[iter_13_1].shop_id].activity_id)
		table.insert(var_13_0, ActivityShopCfg[iter_13_1].shop_id)
	end

	self.shopID = var_13_0[1]

	for iter_13_2, iter_13_3 in ipairs(var_13_1) do
		local var_13_2 = ActivityData:GetActivityData(iter_13_3)
		local var_13_3 = var_13_2.stopTime - manager.time:GetServerTime()

		if var_13_3 > 0 then
			self.shopTime = string.format("%s-%s", manager.time:STimeDescS(var_13_2.startTime, "!%Y/%m/%d %H:%M:%S"), (manager.time:STimeDescS(var_13_2.stopTime, "!%Y/%m/%d %H:%M:%S")))

			if 0 == 0 or var_13_3 < 0 then
				self.shopID = var_13_0[iter_13_2]
			end
		end
	end

	self.shopData = ShopTools.FilterShopDataList(self.shopID, ShopListCfg[self.shopID].chain_last_visible == 1)
end

function var_0_0:InitRecalledSignData(arg_14_1)
	self.getRewardList = {}
	self.signActivityID = arg_14_1.activity_id
	self.signCount = arg_14_1.sign_count
	self.lastSignTime = arg_14_1.last_sign_time

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.got_reward_sign_day_list) do
		self.getRewardList[iter_14_1] = 1
	end

	self:UpdateSignRedPoint()
end

function var_0_0:UpdateSignData(arg_15_1)
	self.getRewardList[arg_15_1] = 1
end

function var_0_0:GetSevenDaySignIndex(arg_16_1)
	if arg_16_1 <= self.signCount and self.getRewardList[arg_16_1] == nil then
		return 1
	end

	return 0
end

function var_0_0:Init()
	self.recalledActivityID = nil
	self.firstPage = false
	self.isSubmit = false
	self.recallUserInfo = nil
	self.recallCode = nil
	self.recallActivityID = nil
	self.codeUseNum = nil
	self.recallRewardList = {}
	self.getRewardList = {}
	self.recallReward = GameSetting.recall_reward.value
	self.codeLimit = GameSetting.recall_code_limit.value
	self.recalledReward = GameSetting.recalled_reward.value
	self.recallLevel = GameSetting.recall_level.value[1]
	self.signActivityID = ActivityCfg.get_id_list_by_activity_template[ActivityConst.RECALL_SIGN][1]
	self.signData = {}

	for iter_17_0, iter_17_1 in pairs(ActivityCumulativeSignCfg[ActivityCfg.get_id_list_by_activity_template[ActivityConst.RECALL_SIGN][1]].config_list) do
		table.insert(self.signData, SignCfg[iter_17_1])
	end

	self.recallChatOrData_ = {}
	self.unsortRecallData_ = {}
	self.recallChatTempData_ = {}
	self.lastTimestamp_ = 0
	self.lastShareTimestamp_ = 0
end

function var_0_0:GetDataByPara(arg_18_1)
	return self[arg_18_1]
end

function var_0_0.SetLastShareTimestamp(arg_19_0)
	arg_19_0.lastShareTimestamp_ = manager.time:GetServerTime()
end

function var_0_0:GetLastShareTimestamp()
	return self.lastShareTimestamp_ or 0
end

function var_0_0:GetLastTimestamp()
	return self.lastTimestamp_
end

function var_0_0:GetChatData()
	return self.recallChatTempData_ or {}
end

function var_0_0:GetOriginChatData()
	return self.recallChatOrData_
end

function var_0_0:AddChatRecord(arg_24_1)
	table.insert(self.unsortRecallData_, self:ParseMsg(arg_24_1))
end

function var_0_0:SortMsg(arg_25_1)
	table.sort(self.unsortRecallData_, function(arg_26_0, arg_26_1)
		return arg_26_0.timestamp < arg_26_1.timestamp
	end)

	for iter_25_0, iter_25_1 in ipairs(self.unsortRecallData_) do
		self.recallChatOrData_ = self.recallChatOrData_ or {}

		table.insert(self.recallChatOrData_, iter_25_1)
		self:AddChatMsg(iter_25_1, table.keyof(arg_25_1, iter_25_1.id))

		if iter_25_0 == #self.unsortRecallData_ then
			self.lastTimestamp_ = iter_25_1.timestamp
		end
	end

	if #self.unsortRecallData_ <= 0 then
		self.lastTimestamp_ = manager.time:GetServerTime()
	end

	self.unsortRecallData_ = {}
end

function var_0_0:InitCacheContent()
	local var_27_1 = clone(self.recallChatOrData_ or {})

	self.recallChatTempData_ = {}

	local var_27_2 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	for iter_27_0, iter_27_1 in ipairs(var_27_1) do
		self:AddChatMsg(iter_27_1, table.keyof(var_27_2, iter_27_1.id))
	end
end

function var_0_0:AddChatMsg(arg_28_1, arg_28_2)
	if not arg_28_2 then
		for iter_28_0, iter_28_1 in ipairs(self.recallChatTempData_) do
			if iter_28_1.id and iter_28_1.id == arg_28_1.id then
				table.remove(self.recallChatTempData_, iter_28_0)

				if self.recallChatTempData_[iter_28_0 - 1] and self.recallChatTempData_[iter_28_0 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
					if self.recallChatTempData_[iter_28_0] and self.recallChatTempData_[iter_28_0].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(self.recallChatTempData_, iter_28_0 - 1)

						break
					end

					if iter_28_0 == #self.recallChatTempData_ + 1 then
						table.remove(self.recallChatTempData_, iter_28_0 - 1)
					end
				end

				break
			end
		end

		if #self.recallChatTempData_ > 0 then
			if arg_28_1.timestamp - self.recallChatTempData_[#self.recallChatTempData_ - 1].timestamp > ChatConst.MESSAGE_SPACE then
				table.insert(self.recallChatTempData_, {
					timestamp = arg_28_1.timestamp,
					contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
				})
			end
		end

		table.insert(self.recallChatTempData_, arg_28_1)
	end
end

function var_0_0:RemoveChatRecord(arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(self.recallChatOrData_) do
		if iter_29_1.contentType == ChatConst.CHAT_CONTENT_TYPE.RECALL and iter_29_1.id == arg_29_1 then
			if self.recallChatOrData_[iter_29_0 + 1] == nil and self.recallChatOrData_[iter_29_0 - 1] and self.recallChatOrData_[iter_29_0 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(self.recallChatOrData_, iter_29_0)
				table.remove(self.recallChatOrData_, iter_29_0 - 1)

				break
			end

			table.remove(self.recallChatOrData_, iter_29_0)

			break
		end
	end

	for iter_29_2, iter_29_3 in ipairs(self.recallChatTempData_) do
		if iter_29_3.contentType == ChatConst.CHAT_CONTENT_TYPE.RECALL and iter_29_3.id == arg_29_1 then
			if self.recallChatTempData_[iter_29_2 + 1] and self.recallChatTempData_[iter_29_2 - 1] and self.recallChatTempData_[iter_29_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(self.recallChatTempData_, iter_29_2)
				table.remove(self.recallChatTempData_, iter_29_2 - 1)

				break
			end

			table.remove(self.recallChatTempData_, iter_29_2)

			break
		end
	end
end

function var_0_0.ParseMsg(arg_30_0, arg_30_1)
	local var_30_0 = {
		id = arg_30_1.sender_id,
		nick = arg_30_1.user_base.nick,
		icon = arg_30_1.user_base.icon,
		iconFrame = arg_30_1.user_base.icon_frame,
		timestamp = arg_30_1.timestamp,
		contentType = ChatConst.CHAT_CONTENT_TYPE.RECALL,
		content = arg_30_1.content
	}

	var_30_0.ip = (arg_30_1.ip_location == nil or arg_30_1.ip_location == "") and GetTips("IP_UNKNOWN") or arg_30_1.ip_location

	return var_30_0
end

return var_0_0
