local InstagramChatProxy = class("InstagramChatProxy", import(".NetProxy"))
local var_0_1 = pg.activity_ins_chat_group

function InstagramChatProxy:register()
	self.chatList = {}

	return
end

function InstagramChatProxy:SetChatList(arg_2_1)
	self.chatList = arg_2_1

	self:SortChatList()

	self.notActiveTopicIds = self:GetNotActiveTopicIds()

	return
end

function InstagramChatProxy:GetChatList()
	return self.chatList
end

function InstagramChatProxy:SortChatList()
	table.sort(self.chatList, function(arg_5_0, arg_5_1)
		if arg_5_0.care ~= arg_5_1.care then
			return arg_5_0.care > arg_5_1.care
		end

		local var_5_0 = arg_5_0:GetCharacterEndFlag()
		local var_5_1 = arg_5_1:GetCharacterEndFlag()

		if var_5_0 ~= var_5_1 then
			return var_5_0 < var_5_1
		end

		if arg_5_0:GetLatestOperationTime() ~= arg_5_1:GetLatestOperationTime() then
			return arg_5_0:GetLatestOperationTime() > arg_5_1:GetLatestOperationTime()
		end

		return arg_5_0.characterId < arg_5_1.characterId
	end)

	return
end

function InstagramChatProxy:GetCharacterChatById(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self.chatList) do
		if iter_6_1.characterId == arg_6_1 then
			return iter_6_1
		end
	end

	return nil
end

function InstagramChatProxy:GetTopicById(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(self.chatList) do
		if iter_7_1.characterId == var_0_1[arg_7_1].ship_group then
			for iter_7_2, iter_7_3 in ipairs(iter_7_1.topics) do
				if iter_7_3.topicId == arg_7_1 then
					return iter_7_3
				end
			end
		end
	end

	return nil
end

function InstagramChatProxy:GetCharacterChatByTopicId(arg_8_1)
	return self:GetCharacterChatById(var_0_1[arg_8_1].ship_group)
end

function InstagramChatProxy:CreateNewChat(arg_9_1, arg_9_2)
	table.insert(self.chatList, (InstagramChat.New({
		favorite = 0,
		skin_id = 0,
		id = var_0_1[arg_9_1].ship_group,
		cur_chat_group = arg_9_1,
		chat_group_list = {
			{
				read_flag = 0,
				id = arg_9_1,
				op_time = arg_9_2,
				reply_list = {}
			}
		}
	})))

	return
end

function InstagramChatProxy:SetTopicOperationTime(arg_10_1, arg_10_2)
	self:GetTopicById(arg_10_1).operationTime = arg_10_2

	return
end

function InstagramChatProxy:ActivateTopics(arg_11_1)
	self:sendNotification(GAME.ACT_INSTAGRAM_CHAT, {
		operation = ActivityConst.INSTAGRAM_CHAT_ACTIVATE_TOPIC,
		topicIdList = arg_11_1
	})

	return
end

function InstagramChatProxy:SetCurrentTopic(arg_12_1)
	local var_12_0 = self:GetTopicById(arg_12_1)

	if var_12_0 then
		local var_12_1 = self:GetCharacterChatById(var_12_0.characterId)

		if var_12_1 then
			var_12_1:SetCurrentTopic(arg_12_1)
		end
	end

	return
end

function InstagramChatProxy:UpdateTopicDisplayWordList(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = self:GetTopicById(arg_13_1)

	if var_13_0 then
		table.insert(var_13_0.replyList, {
			key = arg_13_2,
			value = arg_13_3
		})
		var_13_0:SetDisplayWordList()
	end

	return
end

function InstagramChatProxy:GetAllTopicIds()
	return Clone(var_0_1.all)
end

function InstagramChatProxy:GetNotActiveTopicIds()
	local var_15_0 = self:GetAllTopicIds()

	for iter_15_0, iter_15_1 in ipairs(self.chatList) do
		for iter_15_2, iter_15_3 in ipairs(iter_15_1.topics) do
			if iter_15_3.active then
				for iter_15_4 = #var_15_0, 1, -1 do
					if var_15_0[iter_15_4] == iter_15_3.topicId then
						table.remove(var_15_0, iter_15_4)
					end
				end
			end
		end
	end

	return var_15_0
end

function InstagramChatProxy:RemoveNotActiveTopicId(arg_16_1)
	for iter_16_0 = #self.notActiveTopicIds, 1, -1 do
		if self.notActiveTopicIds[iter_16_0] == arg_16_1 then
			table.remove(self.notActiveTopicIds, iter_16_0)
		end
	end

	return
end

function InstagramChatProxy:GetNotActiveTopicIdsByType(arg_17_1)
	local var_17_0 = Clone(self.notActiveTopicIds)

	if var_17_0 and #var_17_0 > 0 then
		for iter_17_0 = #var_17_0, 1, -1 do
			if var_0_1[var_17_0[iter_17_0]].trigger_type ~= arg_17_1 then
				table.remove(var_17_0, iter_17_0)
			end
		end
	end

	return var_17_0
end

function InstagramChatProxy:SetChatSkin(arg_18_1, arg_18_2)
	self:GetCharacterChatById(arg_18_1).skinId = arg_18_2

	return
end

function InstagramChatProxy:UpdateAllChatBackGrounds()
	for iter_19_0, iter_19_1 in ipairs(self.chatList) do
		if iter_19_1.type == 1 then
			iter_19_1:SetBackgrounds()
		end
	end

	return
end

function InstagramChatProxy:SetTopicReaded(arg_20_1, arg_20_2)
	self:GetTopicById(arg_20_1).readFlag = arg_20_2

	return
end

function InstagramChatProxy:SetAllTopicsReaded()
	for iter_21_0, iter_21_1 in ipairs(self.chatList) do
		for iter_21_2, iter_21_3 in ipairs(iter_21_1.topics) do
			if iter_21_3.readFlag == 0 then
				iter_21_3.readFlag = 1
			end
		end
	end

	return
end

function InstagramChatProxy:ShouldShowTip()
	for iter_22_0, iter_22_1 in ipairs(self.chatList) do
		if iter_22_1:GetCharacterEndFlag() == 0 then
			return true
		end
	end

	return false
end

return InstagramChatProxy
