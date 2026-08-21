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

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.icon = arg_2_1.icon or 0
	arg_2_0.background = arg_2_1.background or 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.type_hero or {}) do
		if not arg_2_0.chatDataDic[iter_2_1.type] then
			arg_2_0.chatDataDic[iter_2_1.type] = {}
		end

		if not arg_2_0.sessionOrderDic[iter_2_1.type] then
			arg_2_0.sessionOrderDic[iter_2_1.type] = {}
		end

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

		arg_2_0.chatDataDic[iter_2_1.type] = var_2_0
		arg_2_0.sessionOrderDic[iter_2_1.type] = var_2_1
	end

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.icon_list) do
		arg_2_0.icon_list[iter_2_7] = {
			state = 1,
			id = iter_2_7
		}
	end

	arg_2_0:UpdateMomoChatRedPoint()
end

function var_0_0.GetData1(arg_3_0, arg_3_1)
	if arg_3_0.chatDataDic[arg_3_1] then
		return arg_3_0.chatDataDic[arg_3_1]
	end

	return {}
end

function var_0_0.GetData2(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.chatDataDic[arg_4_1] and arg_4_0.chatDataDic[arg_4_1][arg_4_2] then
		return arg_4_0.chatDataDic[arg_4_1][arg_4_2]
	end

	return {}
end

function var_0_0.GetData3(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_0.chatDataDic[arg_5_1] and arg_5_0.chatDataDic[arg_5_1][arg_5_2] and arg_5_0.chatDataDic[arg_5_1][arg_5_2][arg_5_3] then
		return arg_5_0.chatDataDic[arg_5_1][arg_5_2][arg_5_3]
	end

	return {}
end

function var_0_0.GetSessionOrder(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.sessionOrderDic[arg_6_1] and arg_6_0.sessionOrderDic[arg_6_1][arg_6_2] then
		return arg_6_0.sessionOrderDic[arg_6_1][arg_6_2]
	end

	return {}
end

function var_0_0.GetPreviousSessionID(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0:GetSessionOrder(arg_7_1, arg_7_2)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1 == arg_7_3 then
			return var_7_0[iter_7_0 + 1]
		end
	end

	return nil
end

function var_0_0.GetLatestSessionID(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0:GetSessionOrder(arg_8_1, arg_8_2)[1]
end

function var_0_0.RefreshSessionOrder(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.sessionOrderDic[arg_9_1] = arg_9_0.sessionOrderDic[arg_9_1] or {}

	local var_9_0 = arg_9_0.sessionOrderDic[arg_9_1][arg_9_2] or {}

	for iter_9_0 = #var_9_0, 1, -1 do
		if var_9_0[iter_9_0] == arg_9_3 then
			table.remove(var_9_0, iter_9_0)
		end
	end

	table.insert(var_9_0, 1, arg_9_3)

	arg_9_0.sessionOrderDic[arg_9_1][arg_9_2] = var_9_0
end

function var_0_0.UpdateData(arg_10_0, arg_10_1)
	if arg_10_1 then
		local var_10_0 = arg_10_1.session or arg_10_1
		local var_10_1 = arg_10_1.type
		local var_10_2 = arg_10_1.sender_id
		local var_10_3 = var_10_0 and var_10_0.id or 0

		if (var_10_1 == nil or var_10_2 == nil) and var_10_3 ~= 0 then
			local var_10_4 = ChatMessageCfg[var_10_3]

			if var_10_4 then
				var_10_1 = var_10_4.type
				var_10_2 = var_10_4.sender
			end
		end

		if var_10_1 and var_10_2 and var_10_3 ~= 0 and arg_10_0.chatDataDic[var_10_1] and arg_10_0.chatDataDic[var_10_1][var_10_2] then
			arg_10_0.chatDataDic[var_10_1][var_10_2][var_10_3] = var_10_0

			arg_10_0:RefreshSessionOrder(var_10_1, var_10_2, var_10_3)
		end

		arg_10_0:UpdateMomoChatRedPoint()
	end
end

function var_0_0.GetUnreadChatCount(arg_11_0)
	return arg_11_0.activeUnreadChatCount or 0
end

function var_0_0.UpdateMomoChatRedPoint(arg_12_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MOMO_TALK) then
		manager.redPoint:setTip(RedPointConst.MOMO_CHAT_RED, 0)

		return
	end

	arg_12_0:RefreshNoRemindSessions()
	manager.redPoint:setTip(RedPointConst.MOMO_CHAT_RED, arg_12_0:GetUnreadChatCount() > 0 and 1 or 0)
end

function var_0_0.RefreshNoRemindSessions(arg_13_0)
	arg_13_0.noRemindSessionDic = {}
	arg_13_0.activeUnreadChatCount = 0

	local var_13_0 = MomoTalkConst.DATA_TYPE.CHAT
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0.chatDataDic[var_13_0] or {}) do
		for iter_13_2, iter_13_3 in pairs(iter_13_1 or {}) do
			if iter_13_3 and arg_13_0:IsSessionPending(iter_13_3, iter_13_2) then
				local var_13_2 = arg_13_0:GetSessionID(iter_13_3, iter_13_2)
				local var_13_3 = ChatMessageCfg[var_13_2]
				local var_13_4 = var_13_3 and var_13_3.trigger_type
				local var_13_5 = MomoTalkConst.NO_REMIND_LIMIT[var_13_4]

				if var_13_5 then
					var_13_1[var_13_4] = var_13_1[var_13_4] or {}

					arg_13_0:InsertRemindSession(var_13_1[var_13_4], var_13_5, var_13_2)
				else
					arg_13_0.activeUnreadChatCount = arg_13_0.activeUnreadChatCount + 1
				end
			end
		end
	end

	for iter_13_4, iter_13_5 in pairs(var_13_1) do
		arg_13_0.activeUnreadChatCount = arg_13_0.activeUnreadChatCount + #iter_13_5
	end
end

function var_0_0.InsertRemindSession(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = #arg_14_1 + 1

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if iter_14_1 < arg_14_3 then
			var_14_0 = iter_14_0

			break
		end
	end

	table.insert(arg_14_1, var_14_0, arg_14_3)

	if arg_14_2 < #arg_14_1 then
		local var_14_1 = table.remove(arg_14_1)

		arg_14_0.noRemindSessionDic[var_14_1] = true
	end
end

function var_0_0.GetSessionID(arg_15_0, arg_15_1, arg_15_2)
	return arg_15_1 and arg_15_1.id or arg_15_2
end

function var_0_0.IsNoRemindSession(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1 or not var_0_0:IsSessionPending(arg_16_1, arg_16_2) then
		return false
	end

	return arg_16_0.noRemindSessionDic[arg_16_0:GetSessionID(arg_16_1, arg_16_2)] == true
end

function var_0_0.IsActiveUnreadSession(arg_17_0, arg_17_1, arg_17_2)
	return arg_17_1 and arg_17_0:IsSessionPending(arg_17_1, arg_17_2) and not arg_17_0:IsNoRemindSession(arg_17_1, arg_17_2)
end

function var_0_0.IsSessionPending(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 then
		return false
	end

	return MomoTalkTools.HasSessionPendingContent(arg_18_1)
end

function var_0_0.GetFrameData(arg_19_0, arg_19_1)
	return arg_19_0.icon_list[arg_19_1]
end

function var_0_0.GetBgData(arg_20_0, arg_20_1)
	return arg_20_0.background_list[arg_20_1]
end

function var_0_0.UpdateFrameData(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.icon_list[arg_21_1] = {
		id = arg_21_1,
		state = arg_21_2
	}
end

function var_0_0.UpdateBgData(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.background_list[arg_22_1] = {
		id = arg_22_1,
		state = arg_22_2
	}
end

return var_0_0
