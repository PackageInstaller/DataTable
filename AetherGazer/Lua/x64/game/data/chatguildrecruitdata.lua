local var_0_0 = singletonClass("ChatGuildRecruitData")

function var_0_0.Init(arg_1_0)
	arg_1_0.guildRecruitData_ = {}
	arg_1_0.unsortRecruitData_ = {}
	arg_1_0.guildRecruitTempData_ = {}
	arg_1_0.requireGuildList_ = {}
	arg_1_0.lastTimestamp_ = 0
end

function var_0_0.GetLastTimestamp(arg_2_0)
	return arg_2_0.lastTimestamp_
end

function var_0_0.GetChatData(arg_3_0)
	return arg_3_0.guildRecruitTempData_ or {}
end

function var_0_0.GetOriginChatData(arg_4_0)
	return arg_4_0.guildRecruitData_
end

function var_0_0.AddChatRecord(arg_5_0, arg_5_1)
	table.insert(arg_5_0.unsortRecruitData_, arg_5_0:ParseMsg(arg_5_1))
end

function var_0_0.SortMsg(arg_6_0, arg_6_1)
	table.sort(arg_6_0.unsortRecruitData_, function(arg_7_0, arg_7_1)
		return arg_7_0.timestamp < arg_7_1.timestamp
	end)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.unsortRecruitData_) do
		arg_6_0.guildRecruitData_ = arg_6_0.guildRecruitData_ or {}

		table.insert(arg_6_0.guildRecruitData_, iter_6_1)
		arg_6_0:AddChatMsg(iter_6_1, table.keyof(arg_6_1, iter_6_1.id))

		if iter_6_0 == #arg_6_0.unsortRecruitData_ then
			arg_6_0.lastTimestamp_ = iter_6_1.timestamp
		end
	end

	if #arg_6_0.unsortRecruitData_ <= 0 then
		arg_6_0.lastTimestamp_ = manager.time:GetServerTime()
	end

	arg_6_0.unsortRecruitData_ = {}
end

function var_0_0.InitCacheContent(arg_8_0)
	local var_8_0 = clone(arg_8_0.guildRecruitData_ or {})

	arg_8_0.guildRecruitTempData_ = {}

	local var_8_1 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		arg_8_0:AddChatMsg(iter_8_1, table.keyof(var_8_1, iter_8_1.id))
	end
end

function var_0_0.AddChatMsg(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_2 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.guildRecruitTempData_) do
			if iter_9_1.guildID and iter_9_1.guildID == arg_9_1.guildID then
				table.remove(arg_9_0.guildRecruitTempData_, iter_9_0)

				if arg_9_0.guildRecruitTempData_[iter_9_0 - 1] and arg_9_0.guildRecruitTempData_[iter_9_0 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
					if arg_9_0.guildRecruitTempData_[iter_9_0] and arg_9_0.guildRecruitTempData_[iter_9_0].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(arg_9_0.guildRecruitTempData_, iter_9_0 - 1)

						break
					end

					if iter_9_0 == #arg_9_0.guildRecruitTempData_ + 1 then
						table.remove(arg_9_0.guildRecruitTempData_, iter_9_0 - 1)
					end
				end

				break
			end
		end

		local var_9_0 = #arg_9_0.guildRecruitTempData_

		if var_9_0 <= 0 or arg_9_1.timestamp - arg_9_0.guildRecruitTempData_[var_9_0 - 1].timestamp > ChatConst.MESSAGE_SPACE then
			local var_9_1 = {
				timestamp = arg_9_1.timestamp,
				contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
			}

			table.insert(arg_9_0.guildRecruitTempData_, var_9_1)
		end

		table.insert(arg_9_0.guildRecruitTempData_, arg_9_1)
	end
end

function var_0_0.RemoveChatRecord(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.guildRecruitData_) do
		if iter_10_1.contentType == ChatConst.CHAT_CONTENT_TYPE.GUILD_RECRUIT and iter_10_1.msgID == arg_10_1 then
			if arg_10_0.guildRecruitData_[iter_10_0 + 1] == nil and arg_10_0.guildRecruitData_[iter_10_0 - 1] and arg_10_0.guildRecruitData_[iter_10_0 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(arg_10_0.guildRecruitData_, iter_10_0)
				table.remove(arg_10_0.guildRecruitData_, iter_10_0 - 1)

				break
			end

			table.remove(arg_10_0.guildRecruitData_, iter_10_0)

			break
		end
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.guildRecruitTempData_) do
		if iter_10_3.contentType == ChatConst.CHAT_CONTENT_TYPE.GUILD_RECRUIT and iter_10_3.msgID == arg_10_1 then
			if arg_10_0.guildRecruitTempData_[iter_10_2 + 1] and arg_10_0.guildRecruitTempData_[iter_10_2 - 1] and arg_10_0.guildRecruitTempData_[iter_10_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(arg_10_0.guildRecruitTempData_, iter_10_2)
				table.remove(arg_10_0.guildRecruitTempData_, iter_10_2 - 1)

				break
			end

			table.remove(arg_10_0.guildRecruitTempData_, iter_10_2)

			break
		end
	end
end

function var_0_0.ParseMsg(arg_11_0, arg_11_1)
	return {
		id = arg_11_1.sender_uid,
		msgID = arg_11_1.club_base_info.id,
		nick = arg_11_1.user_profile_base.nick,
		icon = arg_11_1.user_profile_base.icon,
		iconFrame = arg_11_1.user_profile_base.icon_frame,
		timestamp = arg_11_1.send_timestamp,
		contentType = ChatConst.CHAT_CONTENT_TYPE.GUILD_RECRUIT,
		content = arg_11_1.recommend,
		guildID = arg_11_1.club_base_info.id,
		ip = GetTips("IP_UNKNOWN")
	}
end

function var_0_0.AddRequireGuild(arg_12_0, arg_12_1)
	if not table.keyof(arg_12_0.requireGuildList_, arg_12_1) then
		table.insert(arg_12_0.requireGuildList_, arg_12_1)
	end
end

function var_0_0.GetRequireGuild(arg_13_0)
	return arg_13_0.requireGuildList_
end

function var_0_0.RemoveRequireData(arg_14_0)
	arg_14_0.requireGuildList_ = {}
end

return var_0_0
