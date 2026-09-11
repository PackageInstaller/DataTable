local var_0_0 = singletonClass("ChatGuildRecruitData")

function var_0_0.Init(arg_1_0)
	arg_1_0.guildRecruitData_ = {}
	arg_1_0.unsortRecruitData_ = {}
	arg_1_0.guildRecruitTempData_ = {}
	arg_1_0.requireGuildList_ = {}
	arg_1_0.lastTimestamp_ = 0
end

function var_0_0:GetLastTimestamp()
	return self.lastTimestamp_
end

function var_0_0:GetChatData()
	return self.guildRecruitTempData_ or {}
end

function var_0_0:GetOriginChatData()
	return self.guildRecruitData_
end

function var_0_0:AddChatRecord(arg_5_1)
	table.insert(self.unsortRecruitData_, self:ParseMsg(arg_5_1))
end

function var_0_0:SortMsg(arg_6_1)
	table.sort(self.unsortRecruitData_, function(arg_7_0, arg_7_1)
		return arg_7_0.timestamp < arg_7_1.timestamp
	end)

	for iter_6_0, iter_6_1 in ipairs(self.unsortRecruitData_) do
		self.guildRecruitData_ = self.guildRecruitData_ or {}

		table.insert(self.guildRecruitData_, iter_6_1)
		self:AddChatMsg(iter_6_1, table.keyof(arg_6_1, iter_6_1.id))

		if iter_6_0 == #self.unsortRecruitData_ then
			self.lastTimestamp_ = iter_6_1.timestamp
		end
	end

	if #self.unsortRecruitData_ <= 0 then
		self.lastTimestamp_ = manager.time:GetServerTime()
	end

	self.unsortRecruitData_ = {}
end

function var_0_0:InitCacheContent()
	local var_8_1 = clone(self.guildRecruitData_ or {})

	self.guildRecruitTempData_ = {}

	local var_8_2 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		self:AddChatMsg(iter_8_1, table.keyof(var_8_2, iter_8_1.id))
	end
end

function var_0_0:AddChatMsg(arg_9_1, arg_9_2)
	if not arg_9_2 then
		for iter_9_0, iter_9_1 in ipairs(self.guildRecruitTempData_) do
			if iter_9_1.guildID and iter_9_1.guildID == arg_9_1.guildID then
				table.remove(self.guildRecruitTempData_, iter_9_0)

				if self.guildRecruitTempData_[iter_9_0 - 1] and self.guildRecruitTempData_[iter_9_0 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
					if self.guildRecruitTempData_[iter_9_0] and self.guildRecruitTempData_[iter_9_0].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(self.guildRecruitTempData_, iter_9_0 - 1)

						break
					end

					if iter_9_0 == #self.guildRecruitTempData_ + 1 then
						table.remove(self.guildRecruitTempData_, iter_9_0 - 1)
					end
				end

				break
			end
		end

		if #self.guildRecruitTempData_ > 0 then
			if arg_9_1.timestamp - self.guildRecruitTempData_[#self.guildRecruitTempData_ - 1].timestamp > ChatConst.MESSAGE_SPACE then
				table.insert(self.guildRecruitTempData_, {
					timestamp = arg_9_1.timestamp,
					contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
				})
			end
		end

		table.insert(self.guildRecruitTempData_, arg_9_1)
	end
end

function var_0_0:RemoveChatRecord(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.guildRecruitData_) do
		if iter_10_1.contentType == ChatConst.CHAT_CONTENT_TYPE.GUILD_RECRUIT and iter_10_1.msgID == arg_10_1 then
			if self.guildRecruitData_[iter_10_0 + 1] == nil and self.guildRecruitData_[iter_10_0 - 1] and self.guildRecruitData_[iter_10_0 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(self.guildRecruitData_, iter_10_0)
				table.remove(self.guildRecruitData_, iter_10_0 - 1)

				break
			end

			table.remove(self.guildRecruitData_, iter_10_0)

			break
		end
	end

	for iter_10_2, iter_10_3 in ipairs(self.guildRecruitTempData_) do
		if iter_10_3.contentType == ChatConst.CHAT_CONTENT_TYPE.GUILD_RECRUIT and iter_10_3.msgID == arg_10_1 then
			if self.guildRecruitTempData_[iter_10_2 + 1] and self.guildRecruitTempData_[iter_10_2 - 1] and self.guildRecruitTempData_[iter_10_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(self.guildRecruitTempData_, iter_10_2)
				table.remove(self.guildRecruitTempData_, iter_10_2 - 1)

				break
			end

			table.remove(self.guildRecruitTempData_, iter_10_2)

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

function var_0_0:AddRequireGuild(arg_12_1)
	if not table.keyof(self.requireGuildList_, arg_12_1) then
		table.insert(self.requireGuildList_, arg_12_1)
	end
end

function var_0_0:GetRequireGuild()
	return self.requireGuildList_
end

function var_0_0.RemoveRequireData(arg_14_0)
	arg_14_0.requireGuildList_ = {}
end

return var_0_0
