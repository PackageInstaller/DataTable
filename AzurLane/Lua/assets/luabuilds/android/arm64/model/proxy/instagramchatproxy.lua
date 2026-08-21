local var_0_0 = class("InstagramChatProxy", import(".NetProxy"))
local var_0_1 = pg.activity_ins_chat_group

function var_0_0.register(arg_1_0)
	arg_1_0.chatList = {}

	return
end

function var_0_0.SetChatList(arg_2_0, arg_2_1)
	arg_2_0.chatList = arg_2_1

	arg_2_0:SortChatList()

	arg_2_0.notActiveTopicIds = arg_2_0:GetNotActiveTopicIds()

	return
end

function var_0_0.GetChatList(arg_3_0)
	return arg_3_0.chatList
end

function var_0_0.SortChatList(arg_4_0)
	table.sort(arg_4_0.chatList, function(arg_5_0, arg_5_1)
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

function var_0_0.GetCharacterChatById(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.chatList) do
		if iter_6_1.characterId == arg_6_1 then
			return iter_6_1
		end
	end

	return nil
end

function var_0_0.GetTopicById(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.chatList) do
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

function var_0_0.GetCharacterChatByTopicId(arg_8_0, arg_8_1)
	return arg_8_0:GetCharacterChatById(var_0_1[arg_8_1].ship_group)
end

function var_0_0.CreateNewChat(arg_9_0, arg_9_1, arg_9_2)
	table.insert(arg_9_0.chatList, (InstagramChat.New({
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

function var_0_0.SetTopicOperationTime(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:GetTopicById(arg_10_1).operationTime = arg_10_2

	return
end

function var_0_0.ActivateTopics(arg_11_0, arg_11_1)
	arg_11_0:sendNotification(GAME.ACT_INSTAGRAM_CHAT, {
		operation = ActivityConst.INSTAGRAM_CHAT_ACTIVATE_TOPIC,
		topicIdList = arg_11_1
	})

	return
end

function var_0_0.SetCurrentTopic(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:GetTopicById(arg_12_1)

	if var_12_0 then
		local var_12_1 = arg_12_0:GetCharacterChatById(var_12_0.characterId)

		if var_12_1 then
			var_12_1:SetCurrentTopic(arg_12_1)
		end
	end

	return
end

function var_0_0.UpdateTopicDisplayWordList(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0:GetTopicById(arg_13_1)

	if var_13_0 then
		table.insert(var_13_0.replyList, {
			key = arg_13_2,
			value = arg_13_3
		})
		var_13_0:SetDisplayWordList()
	end

	return
end

function var_0_0.GetAllTopicIds(arg_14_0)
	return Clone(var_0_1.all)
end

function var_0_0.GetNotActiveTopicIds(arg_15_0)
	local var_15_0 = arg_15_0:GetAllTopicIds()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.chatList) do
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

function var_0_0.RemoveNotActiveTopicId(arg_16_0, arg_16_1)
	for iter_16_0 = #arg_16_0.notActiveTopicIds, 1, -1 do
		if arg_16_0.notActiveTopicIds[iter_16_0] == arg_16_1 then
			table.remove(arg_16_0.notActiveTopicIds, iter_16_0)
		end
	end

	return
end

function var_0_0.GetNotActiveTopicIdsByType(arg_17_0, arg_17_1)
	local var_17_0 = Clone(arg_17_0.notActiveTopicIds)

	if var_17_0 and #var_17_0 > 0 then
		for iter_17_0 = #var_17_0, 1, -1 do
			if var_0_1[var_17_0[iter_17_0]].trigger_type ~= arg_17_1 then
				table.remove(var_17_0, iter_17_0)
			end
		end
	end

	return var_17_0
end

function var_0_0.SetChatSkin(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:GetCharacterChatById(arg_18_1).skinId = arg_18_2

	return
end

function var_0_0.UpdateAllChatBackGrounds(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.chatList) do
		if iter_19_1.type == 1 then
			iter_19_1:SetBackgrounds()
		end
	end

	return
end

function var_0_0.SetTopicReaded(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:GetTopicById(arg_20_1).readFlag = arg_20_2

	return
end

function var_0_0.SetAllTopicsReaded(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.chatList) do
		for iter_21_2, iter_21_3 in ipairs(iter_21_1.topics) do
			if iter_21_3.readFlag == 0 then
				iter_21_3.readFlag = 1
			end
		end
	end

	return
end

function var_0_0.ShouldShowTip(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.chatList) do
		if iter_22_1:GetCharacterEndFlag() == 0 then
			return true
		end
	end

	return false
end

return var_0_0
