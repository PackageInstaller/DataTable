local var_0_0 = {}

manager.net:Bind(27005, function(arg_1_0)
	if arg_1_0.room_id == ChatData:GetWorldChannelNum() then
		return
	end

	ChatData:SetWorldChannelNum(arg_1_0.room_id)
	manager.notify:Invoke(CHAT_NEW_CHANNEL)
end)
manager.net:Bind(27009, function(arg_2_0)
	ChatData:UpdateMutedLevel(arg_2_0)
end)
manager.net:Bind(27007, function(arg_3_0)
	local var_3_0 = false
	local var_3_1 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.chat_msg_list) do
		local var_3_2 = table.keyof(var_3_1, iter_3_1.msg.id)

		ChatData:AddWorldChat(iter_3_1, var_3_2)

		if not var_3_2 then
			var_3_0 = true
		end
	end

	if var_3_0 then
		manager.notify:Invoke(CHAT_NEW_MESSAGE, {
			chatToggleID = ChatConst.CHAT_CHANNEL_WORLD
		})
	end
end)
manager.net:Bind(27019, function(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.remove_msg_list) do
		if iter_4_1.channel_type == ChatConst.CHAT_CHANNEL_WORLD then
			var_0_0.RemoveWorldChat(iter_4_1.msg_id)
		elseif iter_4_1.channel_type == ChatConst.CHAT_CHANNEL_FRIEND then
			local var_4_0 = iter_4_1.sender_uid == USER_ID and iter_4_1.channel_id or iter_4_1.sender_uid

			var_0_0.RemoveFriendChat(iter_4_1.msg_id, var_4_0)
		elseif iter_4_1.channel_type == ChatConst.CHAT_CHANNEL_GUILD then
			var_0_0.RemoveGuildChat(iter_4_1.msg_id)
		elseif ChatToggleCfg[iter_4_1.channel_type] ~= nil then
			var_0_0.RemoveChannelChat(iter_4_1)
		end
	end
end)
manager.net:Bind(27407, function(arg_5_0)
	ChatGuildRecruitData:RemoveChatRecord(arg_5_0.club_id)
	manager.notify:Invoke(CHAT_NEW_MESSAGE, {
		chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_RECRUIT
	})
end)
manager.net:Bind(27605, function(arg_6_0)
	ActivityRecallData:RemoveChatRecord(arg_6_0.user_id)
	manager.notify:Invoke(CHAT_NEW_MESSAGE, {
		chatToggleID = ChatConst.CHAT_CHANNEL_RECALL
	})
end)

function var_0_0.RemoveWorldChatAction(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	manager.net:SendWithLoadingNew(27016, {
		msg_id = arg_7_0,
		sender_uid = arg_7_1,
		channel_type = arg_7_2,
		channel_id = arg_7_3
	}, 27017, function(arg_8_0)
		if isSuccess(arg_8_0.result) then
			-- block empty
		else
			ShowTips(arg_8_0.result)
		end
	end)
end

function var_0_0.RemoveWorldChat(arg_9_0)
	ChatData:RemoveWorldChat(arg_9_0)
	manager.notify:Invoke(CHAT_WORLD_RESET)
end

function var_0_0.RemoveFriendChatAction(arg_10_0, arg_10_1, arg_10_2)
	manager.net:SendWithLoadingNew(27016, {
		msg_id = arg_10_0,
		sender_uid = arg_10_1,
		channel_type = ChatConst.CHAT_CHANNEL_FRIEND,
		channel_id = arg_10_2
	}, 27017, function(arg_11_0)
		if isSuccess(arg_11_0.result) then
			-- block empty
		else
			ShowTips(arg_11_0.result)
		end
	end)
end

function var_0_0.RemoveFriendChat(arg_12_0, arg_12_1)
	local var_12_0 = ChatFriendData:RemoveFriendChatContent(arg_12_0, arg_12_1)

	if var_12_0 == 0 then
		return
	end

	if var_12_0 == #ChatFriendData:GetFriendContent(arg_12_1) then
		local var_12_1 = ChatFriendData:GetLastMsgData(arg_12_1)

		FriendsAction:RefreshChat(arg_12_1, var_12_1.content, var_12_1.timestamp)
	end

	FriendsAction:RefreshUnread(arg_12_1, ChatFriendData:GetUnreadMsgCnt(arg_12_1))
	manager.notify:Invoke(CHAT_FRIEND_CHAT_RESET, arg_12_1)
end

function var_0_0.RemoveGuildChat(arg_13_0)
	if ChatGuildData:RemoveGuildChatContent(arg_13_0) == 0 then
		return
	end

	manager.notify:Invoke(CHAT_GUILD_RESET)
end

function var_0_0.RemoveChannelChat(arg_14_0)
	ChatChannelData:RemoveChatContent(arg_14_0)
	manager.notify:Invoke(CHAT_WORLD_RESET)
end

function var_0_0.SetWorldChannelNum(arg_15_0, arg_15_1)
	manager.net:SendWithLoadingNew(27010, {
		room_id = arg_15_0
	}, 27011, function(arg_16_0)
		arg_15_1(arg_16_0.result)
	end)
end

function var_0_0.EnterChatUI(arg_17_0)
	if manager.net:GetTCPState("game") ~= "connected" then
		return
	end

	manager.net:Push(27012, {
		operation = arg_17_0
	})
end

function var_0_0.SendMsg(arg_18_0, arg_18_1, arg_18_2)
	if manager.time:GetServerTime() - ChatData:GetSendTextTimestamp() < 10 then
		ShowTips("SEND_MESSAGE_FREQUENTLY")

		return
	end

	local var_18_0 = ActivityRecallData:GetDataByPara("recallCode")

	if var_18_0 ~= nil and string.find(arg_18_0, var_18_0) then
		ShowTips("RECALL_CHAT_RECOMMEND")

		return
	end

	if string.sub(arg_18_0, 1, 2) == "$ " then
		local var_18_1 = {
			content = arg_18_0
		}

		manager.net:SendWithLoadingNew(27100, var_18_1, 27101, PrintResult)
	else
		manager.net:SendWithLoadingNew(27014, {
			type = ChatConst.CHAT_CONTENT_TYPE.TEXT,
			content = arg_18_0
		}, 27015, function(arg_19_0)
			arg_18_2(arg_19_0)
		end)
	end
end

function var_0_0.SendSticker(arg_20_0, arg_20_1)
	manager.net:SendWithLoadingNew(27014, {
		type = ChatConst.CHAT_CONTENT_TYPE.STICKER,
		content = tostring(arg_20_0)
	}, 27015, function(arg_21_0)
		arg_20_1(arg_21_0)
	end)
end

function var_0_0.RefreshWorldChatData()
	local var_22_0 = {}
	local var_22_1 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	for iter_22_0, iter_22_1 in pairs(ChatData:GetWorldOriginChatData()) do
		if (iter_22_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or iter_22_1.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER) and table.keyof(var_22_1, iter_22_1.id) then
			-- block empty
		else
			table.insert(var_22_0, iter_22_1)
		end
	end

	ChatData:ResetWorldTempData(var_22_0)
	manager.notify:Invoke(CHAT_WORLD_RESET)
	manager.notify:Invoke(CHAT_GUILD_RESET)
	manager.notify:Invoke(CHAT_COOPERATION_RESET)
end

manager.net:Bind(27023, function(arg_23_0)
	if #arg_23_0.msg <= 0 then
		return
	end

	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.msg) do
		ChatGuildData:AddChat(iter_23_1)
		table.insert(var_23_0, iter_23_1.msg_id)
	end

	local var_23_1 = arg_23_0.msg[#arg_23_0.msg]
	local var_23_2 = var_23_1.content

	if var_23_1.type == ChatConst.CHAT_CONTENT_TYPE.STICKER then
		local var_23_3 = string.format("[%s]", ChatStickerCfg[tonumber(var_23_1.content)].name)
	end

	ChatTools.SaveGuildChatCache(GuildData:GetGuildInfo().id or 0)
	manager.notify:Invoke(CHAT_GUILD_NEW_MESSAGE)
	manager.net:Push(19036, {
		channel = ChatConst.CHAT_CHANNEL_GUILD,
		msg_id_list = var_23_0
	})
end)

function var_0_0.SendGuildMsg(arg_24_0, arg_24_1, arg_24_2)
	manager.net:SendWithLoadingNew(27020, {
		type = ChatConst.CHAT_CONTENT_TYPE.TEXT,
		content = arg_24_0
	}, 27021, function(arg_25_0)
		arg_24_2(arg_25_0)
	end)
end

function var_0_0.SendGuildSticker(arg_26_0, arg_26_1)
	manager.net:SendWithLoadingNew(27020, {
		type = ChatConst.CHAT_CONTENT_TYPE.STICKER,
		content = tostring(arg_26_0)
	}, 27021, function(arg_27_0)
		arg_26_1(arg_27_0)
	end)
end

function var_0_0.GuildChatInitData()
	local var_28_0 = GuildData:GetGuildInfo()

	if var_28_0.id == nil or var_28_0.id ~= getData("guildInfo", "guildID") then
		ChatGuildData:RemoveChatData()
	end

	if var_28_0.id then
		ChatTools.LoadGuildLocalChatCache(var_28_0.id)
		ChatTools.DeleteGuildChatRecord(var_28_0.id)
	end
end

function var_0_0.SendGuildRecruitMsg(arg_29_0, arg_29_1, arg_29_2)
	print("功能未实现")
	arg_29_2({
		result = 0
	})
end

function var_0_0.SendGuildRecruitSticker(arg_30_0, arg_30_1)
	print("功能未实现")
	arg_30_1({
		result = 0
	})
end

manager.net:Bind(19039, function(arg_31_0)
	local var_31_0 = {}
	local var_31_1 = USER_ID
	local var_31_2 = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.friend_msg_list) do
		ChatFriendData:AddChat(iter_31_1)

		local var_31_3 = iter_31_1.chat_base_info.content

		if iter_31_1.chat_base_info.type == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			var_31_3 = string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(iter_31_1.chat_base_info.content)].name))
		end

		local var_31_4 = var_31_1 == iter_31_1.chat_base_info.id and iter_31_1.receive_uid or iter_31_1.chat_base_info.id

		if not table.keyof(var_31_2, var_31_4) then
			table.insert(var_31_2, var_31_4)
		end

		FriendsAction:RefreshChat(var_31_4, var_31_3, iter_31_1.chat_base_info.timestamp)
		FriendsAction:RefreshUnread(var_31_4, ChatFriendData:GetUnreadMsgCnt(var_31_4))
		manager.notify:Invoke(CHAT_FRIEND_NEW_MESSAGE, var_31_4)
		table.insert(var_31_0, iter_31_1.chat_base_info.msg_id)
	end

	ChatTools.SaveFriendsCache(var_31_2)
	manager.net:Push(19036, {
		channel = ChatConst.CHAT_CHANNEL_FRIEND,
		msg_id_list = var_31_0
	})
end)

function var_0_0.SendFriendMsg(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	manager.net:SendWithLoadingNew(19034, {
		receive_uid = arg_32_0,
		type = ChatConst.CHAT_CONTENT_TYPE.TEXT,
		content = arg_32_1
	}, 19035, function(arg_33_0)
		arg_32_3(arg_33_0)
	end)
end

function var_0_0.SendFriendSticker(arg_34_0, arg_34_1, arg_34_2)
	manager.net:SendWithLoadingNew(19034, {
		receive_uid = arg_34_0,
		type = ChatConst.CHAT_CONTENT_TYPE.STICKER,
		content = tostring(arg_34_1)
	}, 19035, function(arg_35_0)
		arg_34_2(arg_35_0)
	end)
end

function var_0_0.FriendChatInitData()
	local var_36_0 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.MY_FRIENDS)

	for iter_36_0, iter_36_1 in pairs(var_36_0) do
		ChatFriendData:InitReadMsgCnt(iter_36_1)
		ChatTools.DeleteFriendChatRecord(iter_36_1)
	end

	local var_36_1 = {}

	for iter_36_2, iter_36_3 in pairs(ChatFriendData:GetAllFriendContent()) do
		if table.keyof(var_36_0, iter_36_2) then
			var_0_0.DeleteInvalidChat(iter_36_2)
		else
			table.insert(var_36_1, iter_36_2)
		end
	end

	for iter_36_4, iter_36_5 in ipairs(var_36_1) do
		var_0_0.DeleteFriendChat(iter_36_5)
	end
end

function var_0_0.DeleteFriendChat(arg_37_0)
	ChatFriendData:RemoveCacheHero(arg_37_0)
	ChatFriendData:RemoveChatData(arg_37_0)
end

function var_0_0.DeleteInvalidChat(arg_38_0)
	local var_38_0 = FriendsData:GetInfoByID(arg_38_0).timestamp
	local var_38_1 = ChatFriendData:GetFriendContent(arg_38_0)
	local var_38_2 = 0

	for iter_38_0 = #var_38_1, 1, -1 do
		if var_38_0 > var_38_1[iter_38_0].timestamp then
			var_38_2 = iter_38_0

			break
		end
	end

	ChatFriendData:DeleteInvalidContent(arg_38_0, var_38_2)
end

function var_0_0.ChatReportMsg(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	manager.net:SendWithLoadingNew(57002, {
		msg_uid = arg_39_0,
		report_type = arg_39_1,
		report_note = arg_39_2
	}, 57003, function(arg_40_0)
		arg_39_3(arg_40_0)
	end)
end

function var_0_0.ChatReportUser(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	manager.net:SendWithLoadingNew(57004, {
		reported_user_id = arg_41_0,
		report_type = arg_41_1,
		report_note = arg_41_2
	}, 57005, function(arg_42_0)
		arg_41_3(arg_42_0)
	end)
end

function var_0_0.DormReportUser(arg_43_0, arg_43_1)
	manager.net:SendWithLoadingNew(57008, arg_43_0, 57009, function(arg_44_0)
		arg_43_1(arg_44_0)
	end)
end

function var_0_0.RequireGuildShareInfo()
	manager.net:SendWithLoadingNew(27402, {
		timestamp = ChatGuildRecruitData:GetLastTimestamp()
	}, 27403, function(arg_46_0)
		local var_46_0 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

		if isSuccess(arg_46_0.result) then
			for iter_46_0, iter_46_1 in ipairs(arg_46_0.msg_list) do
				if iter_46_1.club_base_info.id == nil or iter_46_1.club_base_info.id == GuildData.INVALID_GUILD then
					-- block empty
				else
					ChatGuildRecruitData:AddChatRecord(iter_46_1)
					GuildData:SetCacheGuildInfo(iter_46_1.club_base_info)
				end
			end

			ChatGuildRecruitData:SortMsg(var_46_0)

			if #arg_46_0.msg_list > 0 then
				manager.notify:Invoke(CHAT_NEW_MESSAGE, {
					chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_RECRUIT
				})
			end
		else
			ShowTips(arg_46_0.result)
		end
	end)
end

function var_0_0.RequireRecallInfo()
	manager.net:SendWithLoadingNew(27602, {
		timestamp = ActivityRecallData:GetLastTimestamp()
	}, 27603, function(arg_48_0)
		local var_48_0 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

		if isSuccess(arg_48_0.result) then
			for iter_48_0, iter_48_1 in ipairs(arg_48_0.msg_list) do
				ActivityRecallData:AddChatRecord(iter_48_1)
			end

			ActivityRecallData:SortMsg(var_48_0)

			if #arg_48_0.msg_list > 0 then
				manager.notify:Invoke(CHAT_NEW_MESSAGE, {
					chatToggleID = ChatConst.CHAT_CHANNEL_RECALL
				})
			end
		else
			ShowTips(arg_48_0.result)
		end
	end)
end

manager.net:Bind(27033, function(arg_49_0)
	if #arg_49_0.msg <= 0 then
		return
	end

	local var_49_0 = {}
	local var_49_1 = arg_49_0.channel_type

	for iter_49_0, iter_49_1 in ipairs(arg_49_0.msg) do
		ChatChannelData:AddChat(var_49_1, iter_49_1)
		table.insert(var_49_0, iter_49_1.msg.msg_id)
	end

	local var_49_2 = arg_49_0.msg[#arg_49_0.msg]
	local var_49_3 = var_49_2.msg.content

	if var_49_2.msg.type == ChatConst.CHAT_CONTENT_TYPE.STICKER then
		local var_49_4 = string.format("[%s]", ChatStickerCfg[tonumber(var_49_2.msg.content)].name)
	end

	manager.notify:Invoke(CHAT_NEW_MESSAGE, {
		chatToggleID = var_49_1
	})
	manager.net:Push(19036, {
		channel = var_49_1,
		msg_id_list = var_49_0
	})
	ChatTools.SaveChannelChatCache(var_49_1)
end)

function var_0_0.RequireChatNormalMsg(arg_50_0)
	manager.net:SendWithLoadingNew(27500, {
		channel_type = arg_50_0,
		timestamp = ChatChannelData:GetLastRequireMsgTimestamp(arg_50_0)
	}, 27501, function(arg_51_0)
		if isSuccess(arg_51_0.result) then
			for iter_51_0, iter_51_1 in ipairs(arg_51_0.msg_list) do
				ChatChannelData:AddChat(arg_50_0, iter_51_1)
			end

			ChatChannelData:SetLastRequireMsgTimestamp(arg_50_0, manager.time:GetServerTime())
			ChatChannelData:SortMsg(arg_50_0)

			if #arg_51_0.msg_list > 0 then
				manager.notify:Invoke(CHAT_NEW_MESSAGE, {
					chatToggleID = arg_50_0
				})
			end
		else
			ShowTips(arg_51_0.result)
		end
	end)
end

function var_0_0.SendChatNormalMsg(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	manager.net:SendWithLoadingNew(27030, {
		channel_type = arg_52_0,
		type = ChatConst.CHAT_CONTENT_TYPE.TEXT,
		content = arg_52_1
	}, 27031, function(arg_53_0)
		arg_52_3(arg_53_0)
	end)
end

function var_0_0.SendChatNormalSticker(arg_54_0, arg_54_1, arg_54_2)
	manager.net:SendWithLoadingNew(27030, {
		channel_type = arg_54_0,
		type = ChatConst.CHAT_CONTENT_TYPE.STICKER,
		content = tostring(arg_54_1)
	}, 27031, function(arg_55_0)
		arg_54_2(arg_55_0)
	end)
end

function var_0_0.SendChatNormalJump(arg_56_0, arg_56_1, arg_56_2, arg_56_3, arg_56_4)
	manager.net:SendWithLoadingNew(27030, {
		channel_type = arg_56_0,
		type = ChatConst.CHAT_CONTENT_TYPE.JUMP,
		content = arg_56_1,
		jump_link = arg_56_2
	}, 27031, function(arg_57_0)
		arg_56_4(arg_57_0)
	end)
end

function var_0_0.LoadChannelChatData()
	for iter_58_0, iter_58_1 in ipairs(ChatToggleCfg.all) do
		local var_58_0 = ChatToggleCfg[iter_58_1].activity_id

		if ActivityData:GetActivityIsOpen(var_58_0) then
			ChatTools.LoadLocalChatCache(iter_58_1)
			ChatTools.DeleteChannelChatRecord(iter_58_1)
		end
	end
end

manager.net:Bind(37033, function(arg_59_0)
	ChatCooperationData:AddChat(arg_59_0.msg)
	manager.notify:Invoke(CHAT_COOPERATION_NEW_MESSAGE)
end)

function var_0_0.SendCooperationdMsg(arg_60_0, arg_60_1, arg_60_2)
	manager.net:SendWithLoadingNew(37030, {
		type = ChatConst.CHAT_CONTENT_TYPE.TEXT,
		content = arg_60_0
	}, 37031, function(arg_61_0)
		arg_60_2(arg_61_0)
	end)
end

function var_0_0.SendCooperationSticker(arg_62_0, arg_62_1)
	manager.net:SendWithLoadingNew(37030, {
		type = ChatConst.CHAT_CONTENT_TYPE.STICKER,
		content = tostring(arg_62_0)
	}, 37031, function(arg_63_0)
		arg_62_1(arg_63_0)
	end)
end

function var_0_0.CooperationChatInitData()
	ChatCooperationData:RemoveChatData()
end

manager.net:Bind(12039, function(arg_65_0)
	ChatStickerData:InitData(arg_65_0)
end)

function var_0_0.SaveCustomSticker(arg_66_0)
	local var_66_0 = ChatStickerData:GetCustomStickerUIList()

	manager.net:SendWithLoadingNew(12036, {
		emoticon_id_list = var_66_0
	}, 12037, function(arg_67_0)
		if isSuccess(arg_67_0.result) then
			ChatStickerData:SaveData()
		end

		arg_66_0(arg_67_0)
	end)
end

return var_0_0
