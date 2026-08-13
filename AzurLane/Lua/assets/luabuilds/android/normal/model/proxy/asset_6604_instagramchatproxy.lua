class = var_0_10000

local var_0_0 = "InstagramChatProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

pg = var_0_0

local var_0_2 = var_0_0.activity_ins_chat_group

function var_0_1.register(arg_1_0)
	arg_1_0.chatList = {}

	return
end

function var_0_1.SetChatList(arg_2_0, arg_2_1)
	arg_2_0.chatList = arg_2_1

	arg_2_0:SortChatList()

	arg_2_0.notActiveTopicIds = arg_2_0:GetNotActiveTopicIds()

	return
end

function var_0_1.GetChatList(arg_3_0)
	return arg_3_0.chatList
end

function var_0_1.SortChatList(arg_4_0)
	table = var_1_10001

	var_1_10001.sort(arg_4_0.chatList, function(arg_5_0, arg_5_1)
		if arg_5_0.care ~= arg_5_1.care then
			return arg_5_0.care > arg_5_1.care
		end

		if arg_5_0:GetCharacterEndFlag() ~= arg_5_1:GetCharacterEndFlag() then
			return var_2 < var_3
		end

		if arg_5_0:GetLatestOperationTime() ~= arg_5_1:GetLatestOperationTime() then
			return arg_5_0:GetLatestOperationTime() > arg_5_1:GetLatestOperationTime()
		end

		return arg_5_0.characterId < arg_5_1.characterId
	end)

	return
end

function var_0_1.GetCharacterChatById(arg_6_0, arg_6_1)
	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.chatList) do
		if iter_6_1.characterId == arg_6_1 then
			return iter_6_1
		end
	end

	return nil
end

function var_0_1.GetTopicById(arg_7_0, arg_7_1)
	local var_7_0 = var_0_2[arg_7_1].ship_group

	ipairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(arg_7_0.chatList) do
		if iter_7_1.characterId == var_7_0 then
			ipairs = var_8

			for iter_7_2, iter_7_3 in var_8(iter_7_1.topics) do
				if iter_7_3.topicId == arg_7_1 then
					return iter_7_3
				end
			end
		end
	end

	return nil
end

function var_0_1.GetCharacterChatByTopicId(arg_8_0, arg_8_1)
	local var_8_0 = var_0_2[arg_8_1].ship_group

	return arg_8_0:GetCharacterChatById(var_8_0)
end

function var_0_1.CreateNewChat(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = var_0_2[arg_9_1].ship_group
	local var_9_1 = {
		favorite = 0,
		skin_id = 0,
		id = var_9_0,
		cur_chat_group = arg_9_1,
		chat_group_list = {
			{
				read_flag = 0,
				id = arg_9_1,
				op_time = arg_9_2,
				reply_list = {}
			}
		}
	}

	InstagramChat = var_5

	local var_9_2 = var_5.New(var_9_1)

	table = var_6

	var_6.insert(arg_9_0.chatList, var_9_2)

	return
end

function var_0_1.SetTopicOperationTime(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:GetTopicById(arg_10_1).operationTime = arg_10_2

	return
end

function var_0_1.ActivateTopics(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.sendNotification

	GAME = var_1_10004

	local var_11_2 = var_1_10004.ACT_INSTAGRAM_CHAT
	local var_11_3 = {}

	ActivityConst = var_1_10006
	var_11_3.operation = var_1_10006.INSTAGRAM_CHAT_ACTIVATE_TOPIC
	var_11_3.topicIdList = arg_11_1

	var_11_1(var_11_0, var_11_2, var_11_3)

	return
end

function var_0_1.SetCurrentTopic(arg_12_0, arg_12_1)
	if arg_12_0:GetTopicById(arg_12_1) and arg_12_0:GetCharacterChatById(var_2.characterId) then
		var_3:SetCurrentTopic(arg_12_1)
	end

	return
end

function var_0_1.UpdateTopicDisplayWordList(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0

	if arg_13_0.GetTopicById(var_13_0, arg_13_1) then
		table = var_13_0

		var_13_0.insert(var_4.replyList, {
			key = arg_13_2,
			value = arg_13_3
		})
		var_4:SetDisplayWordList()
	end

	return
end

function var_0_1.GetAllTopicIds(arg_14_0)
	Clone = var_1_10001

	return var_1_10001(var_0_2.all)
end

function var_0_1.GetNotActiveTopicIds(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetAllTopicIds(var_15_0)

	ipairs = var_15_0

	for iter_15_0, iter_15_1 in var_15_0(arg_15_0.chatList) do
		ipairs = var_1_10007

		for iter_15_2, iter_15_3 in var_1_10007(iter_15_1.topics) do
			if iter_15_3.active then
				for iter_15_4 = #var_15_1, 1, -1 do
					if var_15_1[iter_15_4] == iter_15_3.topicId then
						table = var_16

						var_16.remove(var_15_1, iter_15_4)
					end
				end
			end
		end
	end

	return var_15_1
end

function var_0_1.RemoveNotActiveTopicId(arg_16_0, arg_16_1)
	for iter_16_0 = #arg_16_0.notActiveTopicIds, 1, -1 do
		if arg_16_0.notActiveTopicIds[iter_16_0] == arg_16_1 then
			table = var_6

			var_6.remove(arg_16_0.notActiveTopicIds, iter_16_0)
		end
	end

	return
end

function var_0_1.GetNotActiveTopicIdsByType(arg_17_0, arg_17_1)
	Clone = var_1_10002

	if var_1_10002(arg_17_0.notActiveTopicIds) and #var_2 > 0 then
		for iter_17_0 = #var_2, 1, -1 do
			if var_0_2[var_2[iter_17_0]].trigger_type ~= arg_17_1 then
				table = var_8

				var_8.remove(var_2, iter_17_0)
			end
		end
	end

	return var_2
end

function var_0_1.SetChatSkin(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:GetCharacterChatById(arg_18_1).skinId = arg_18_2

	return
end

function var_0_1.UpdateAllChatBackGrounds(arg_19_0)
	ipairs = var_1_10001

	for iter_19_0, iter_19_1 in var_1_10001(arg_19_0.chatList) do
		if iter_19_1.type == 1 then
			iter_19_1:SetBackgrounds()
		end
	end

	return
end

function var_0_1.SetTopicReaded(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:GetTopicById(arg_20_1).readFlag = arg_20_2

	return
end

function var_0_1.SetAllTopicsReaded(arg_21_0)
	ipairs = var_1_10001

	for iter_21_0, iter_21_1 in var_1_10001(arg_21_0.chatList) do
		ipairs = var_1_10006

		for iter_21_2, iter_21_3 in var_1_10006(iter_21_1.topics) do
			if iter_21_3.readFlag == 0 then
				iter_21_3.readFlag = 1
			end
		end
	end

	return
end

function var_0_1.ShouldShowTip(arg_22_0)
	ipairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0.chatList) do
		if iter_22_1:GetCharacterEndFlag() == 0 then
			return true
		end
	end

	return false
end

return var_0_1
