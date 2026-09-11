local var_0_0 = singletonClass("MomoTalkData")

function var_0_0.Init(arg_1_0)
	arg_1_0.icon = 0
	arg_1_0.background = 0
	arg_1_0.chatList = {}
	arg_1_0.chatDataDic = {}
	arg_1_0.sessionOrderDic = {}
	arg_1_0.noRemindSessionDic = {}
	arg_1_0.activeUnreadChatCount = 0
	arg_1_0.taskList = {}
	arg_1_0.background_list = {}
	arg_1_0.icon_list = {}
end

function var_0_0:InitData(arg_2_1)
	self.icon = arg_2_1.icon or 0
	self.background = arg_2_1.background or 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.type_hero or {}) do
		self.chatDataDic[iter_2_1.type] = self.chatDataDic[iter_2_1.type] or {}
		self.sessionOrderDic[iter_2_1.type] = self.sessionOrderDic[iter_2_1.type] or {}

		local var_2_0 = {}
		local var_2_1 = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.hero_session or {}) do
			local var_2_2 = {}
			local var_2_3 = {}

			for iter_2_4, iter_2_5 in ipairs(iter_2_3.session_list or {}) do
				var_2_2[iter_2_5.id] = iter_2_5

				table.insert(var_2_3, iter_2_5.id)
			end

			var_2_0[iter_2_3.sender_id] = var_2_2
			var_2_1[iter_2_3.sender_id] = var_2_3
		end

		self.chatDataDic[iter_2_1.type] = var_2_0
		self.sessionOrderDic[iter_2_1.type] = var_2_1
	end

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.icon_list) do
		self.icon_list[iter_2_7] = {
			state = 1,
			id = iter_2_7
		}
	end

	self:UpdateMomoChatRedPoint()
end

function var_0_0:GetData1(arg_3_1)
	if self.chatDataDic[arg_3_1] then
		return self.chatDataDic[arg_3_1]
	end

	return {}
end

function var_0_0:GetData2(arg_4_1, arg_4_2)
	if self.chatDataDic[arg_4_1] and self.chatDataDic[arg_4_1][arg_4_2] then
		return self.chatDataDic[arg_4_1][arg_4_2]
	end

	return {}
end

function var_0_0:GetData3(arg_5_1, arg_5_2, arg_5_3)
	if self.chatDataDic[arg_5_1] and self.chatDataDic[arg_5_1][arg_5_2] and self.chatDataDic[arg_5_1][arg_5_2][arg_5_3] then
		return self.chatDataDic[arg_5_1][arg_5_2][arg_5_3]
	end

	return {}
end

function var_0_0:GetSessionOrder(arg_6_1, arg_6_2)
	if self.sessionOrderDic[arg_6_1] and self.sessionOrderDic[arg_6_1][arg_6_2] then
		return self.sessionOrderDic[arg_6_1][arg_6_2]
	end

	return {}
end

function var_0_0:GetPreviousSessionID(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = self:GetSessionOrder(arg_7_1, arg_7_2)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1 == arg_7_3 then
			return var_7_0[iter_7_0 + 1]
		end
	end

	return nil
end

function var_0_0:GetLatestSessionID(arg_8_1, arg_8_2)
	return self:GetSessionOrder(arg_8_1, arg_8_2)[1]
end

function var_0_0:RefreshSessionOrder(arg_9_1, arg_9_2, arg_9_3)
	self.sessionOrderDic[arg_9_1] = self.sessionOrderDic[arg_9_1] or {}

	local var_9_0 = self.sessionOrderDic[arg_9_1][arg_9_2] or {}

	for iter_9_0 = #var_9_0, 1, -1 do
		if var_9_0[iter_9_0] == arg_9_3 then
			table.remove(var_9_0, iter_9_0)
		end
	end

	table.insert(var_9_0, 1, arg_9_3)

	self.sessionOrderDic[arg_9_1][arg_9_2] = var_9_0
end

function var_0_0:UpdateData(arg_10_1)
	if arg_10_1 then
		local var_10_0 = arg_10_1.session or arg_10_1
		local var_10_1 = arg_10_1.type
		local var_10_2 = arg_10_1.sender_id

		if var_10_0 then
			local var_10_3 = var_10_0.id or 0

			if (var_10_1 == nil or var_10_2 == nil) and var_10_3 ~= 0 then
				if ChatMessageCfg[var_10_3] then
					var_10_1 = ChatMessageCfg[var_10_3].type
					var_10_2 = ChatMessageCfg[var_10_3].sender
				end
			end

			if var_10_1 and var_10_2 and var_10_3 ~= 0 and self.chatDataDic[var_10_1] and self.chatDataDic[var_10_1][var_10_2] then
				self.chatDataDic[var_10_1][var_10_2][var_10_3] = var_10_0

				self:RefreshSessionOrder(var_10_1, var_10_2, var_10_3)
			end
		end

		self:UpdateMomoChatRedPoint()
	end
end

function var_0_0:GetUnreadChatCount()
	return self.activeUnreadChatCount or 0
end

function var_0_0:UpdateMomoChatRedPoint()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MOMO_TALK) then
		manager.redPoint:setTip(RedPointConst.MOMO_CHAT_RED, 0)

		return
	end

	self:RefreshNoRemindSessions()
	manager.redPoint:setTip(RedPointConst.MOMO_CHAT_RED, self:GetUnreadChatCount() > 0 and 1 or 0)
end

function var_0_0:RefreshNoRemindSessions()
	self.noRemindSessionDic = {}
	self.activeUnreadChatCount = 0

	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(self.chatDataDic[MomoTalkConst.DATA_TYPE.CHAT] or {}) do
		for iter_13_2, iter_13_3 in pairs(iter_13_1 or {}) do
			if iter_13_3 and self:IsSessionPending(iter_13_3, iter_13_2) then
				local var_13_1 = self:GetSessionID(iter_13_3, iter_13_2)
				local var_13_2 = ChatMessageCfg[var_13_1] and ChatMessageCfg[var_13_1].trigger_type

				if MomoTalkConst.NO_REMIND_LIMIT[ChatMessageCfg[var_13_1] and ChatMessageCfg[var_13_1].trigger_type] then
					var_13_0[var_13_2] = var_13_0[var_13_2] or {}

					self:InsertRemindSession(var_13_0[var_13_2], MomoTalkConst.NO_REMIND_LIMIT[ChatMessageCfg[var_13_1] and ChatMessageCfg[var_13_1].trigger_type], var_13_1)
				else
					self.activeUnreadChatCount = self.activeUnreadChatCount + 1
				end
			end
		end
	end

	for iter_13_4, iter_13_5 in pairs(var_13_0) do
		self.activeUnreadChatCount = self.activeUnreadChatCount + #iter_13_5
	end
end

function var_0_0:InsertRemindSession(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = #arg_14_1 + 1

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if iter_14_1 < arg_14_3 then
			var_14_0 = iter_14_0

			break
		end
	end

	table.insert(arg_14_1, var_14_0, arg_14_3)

	if arg_14_2 < #arg_14_1 then
		self.noRemindSessionDic[table.remove(arg_14_1)] = true
	end
end

function var_0_0.GetSessionID(arg_15_0, arg_15_1, arg_15_2)
	return (arg_15_1 or nil) and (arg_15_1.id or arg_15_2)
end

function var_0_0:IsNoRemindSession(arg_16_1, arg_16_2)
	if not arg_16_1 or not var_0_0:IsSessionPending(arg_16_1, arg_16_2) then
		return false
	end

	return self.noRemindSessionDic[self:GetSessionID(arg_16_1, arg_16_2)] == true
end

function var_0_0:IsActiveUnreadSession(arg_17_1, arg_17_2)
	return arg_17_1 and self:IsSessionPending(arg_17_1, arg_17_2) and not self:IsNoRemindSession(arg_17_1, arg_17_2)
end

function var_0_0.IsSessionPending(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 then
		return false
	end

	return MomoTalkTools.HasSessionPendingContent(arg_18_1)
end

function var_0_0:GetFrameData(arg_19_1)
	return self.icon_list[arg_19_1]
end

function var_0_0:GetBgData(arg_20_1)
	return self.background_list[arg_20_1]
end

function var_0_0:UpdateFrameData(arg_21_1, arg_21_2)
	self.icon_list[arg_21_1] = {
		id = arg_21_1,
		state = arg_21_2
	}
end

function var_0_0:UpdateBgData(arg_22_1, arg_22_2)
	self.background_list[arg_22_1] = {
		id = arg_22_1,
		state = arg_22_2
	}
end

return var_0_0
