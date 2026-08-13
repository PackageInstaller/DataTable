class = var_0_10000

local var_0_0 = "Dorm3dChatProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

pg = var_0_10001

local var_0_2 = var_0_10001.dorm3d_ins_chat_group

var_0_1.APARTMENT_CHAT_REPLY = 1
var_0_1.APARTMENT_CHAT_SET_SKIN = 2
var_0_1.APARTMENT_CHAT_SET_CARE = 3
var_0_1.APARTMENT_CHAT_SET_TOPIC = 4
var_0_1.APARTMENT_CHAT_SET_READTIP = 5
var_0_1.APARTMENT_CHAT_TRIGGER_EVENT = 6

function var_0_1.register(arg_1_0)
	arg_1_0.chatList = {}

	return
end

function var_0_1.HandleAct(arg_2_0, arg_2_1)
	if arg_2_0:GetCharacterChatByTopicId(arg_2_1.act_id) then
		if arg_2_0:GetTopicById(arg_2_1.act_id) then
			var_2:Activate(arg_2_1.time)
		end
	else
		arg_2_0:CreateNewChat(arg_2_1.act_id, arg_2_1.time)
	end

	return
end

function var_0_1.CreateChat(arg_3_0, arg_3_1)
	Dorm3dChat = var_1_10002

	local var_3_0 = var_1_10002.New(arg_3_1)

	table = var_1_10003

	var_1_10003.insert(arg_3_0.chatList, var_3_0)

	return
end

function var_0_1.SetChatList(arg_4_0, arg_4_1)
	arg_4_0.chatList = arg_4_1

	return
end

function var_0_1.GetChatList(arg_5_0)
	return arg_5_0.chatList
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
		cur_back = 0,
		care_flag = 0,
		ship_group = var_9_0,
		cur_comm_id = arg_9_1,
		comm_list = {
			{
				read_flag = 0,
				id = arg_9_1,
				time = arg_9_2,
				reply_list = {}
			}
		}
	}

	Dorm3dChat = var_5

	local var_9_2 = var_5.New(var_9_1)

	table = var_6

	var_6.insert(arg_9_0.chatList, var_9_2)

	return
end

function var_0_1.SetTopicOperationTime(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:GetTopicById(arg_10_1).operationTime = arg_10_2

	return
end

function var_0_1.SetCurrentTopic(arg_11_0, arg_11_1)
	if arg_11_0:GetTopicById(arg_11_1) and arg_11_0:GetCharacterChatById(var_2.characterId) then
		var_3:SetCurrentTopic(arg_11_1)
	end

	return
end

function var_0_1.UpdateTopicDisplayWordList(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0:GetTopicById(arg_12_1) then
		table = var_1_10005

		var_1_10005.insert(var_4.replyList, {
			key = arg_12_2,
			value = arg_12_3
		})
		var_4:SetDisplayWordList()
	end

	return
end

function var_0_1.GetAllTopicIds(arg_13_0)
	Clone = var_1_10001

	return var_1_10001(var_0_2.all)
end

function var_0_1.SetChatSkin(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:GetCharacterChatById(arg_14_1).skinId = arg_14_2

	return
end

function var_0_1.UpdateAllChatBackGrounds(arg_15_0)
	ipairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0.chatList) do
		if iter_15_1.type == 1 then
			iter_15_1:SetBackgrounds()
		end
	end

	return
end

function var_0_1.SetTopicReaded(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:GetTopicById(arg_16_1).readFlag = arg_16_2

	return
end

function var_0_1.ShouldShowTip(arg_17_0)
	ipairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0.chatList) do
		local var_17_0 = iter_17_1

		if iter_17_1.GetCharacterEndFlag(var_17_0) == 0 then
			getProxy = var_6
			Dorm3dInsProxy = var_17_0

			local var_17_1 = var_6(var_17_0)
			local var_17_2 = var_6.GetRoomByGroupId(var_17_1, iter_17_1.characterId)

			if var_6.IsDownloaded(var_17_2) then
				return true
			end
		end
	end

	return false
end

function var_0_1.ShouldShowShipTip(arg_18_0, arg_18_1)
	if arg_18_0:GetCharacterChatById(arg_18_1) and var_2:GetCharacterEndFlag() == 0 then
		return true
	else
		return false
	end

	return
end

function var_0_1.TriggerEvent(arg_19_0, arg_19_1)
	DORM_LOCK_INS = var_1_10002

	if var_1_10002 then
		return
	end

	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.sendNotification

	GAME = var_1_10005

	local var_19_2 = var_1_10005.APARTMENT_CHAT_OP
	local var_19_3 = {}

	Dorm3dChatProxy = var_1_10007
	var_19_3.operation = var_1_10007.APARTMENT_CHAT_TRIGGER_EVENT
	var_19_3.eventList = arg_19_1

	var_19_1(var_19_0, var_19_2, var_19_3)

	return
end

function var_0_1.GetChatCare(arg_20_0, arg_20_1)
	if arg_20_0:GetCharacterChatById(arg_20_1) then
		return var_2.care
	end

	return 0
end

function var_0_1.SetChatCare(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.sendNotification

	GAME = var_1_10006

	local var_21_2 = var_1_10006.APARTMENT_CHAT_OP
	local var_21_3 = {}

	Dorm3dChatProxy = var_1_10008
	var_21_3.operation = var_1_10008.APARTMENT_CHAT_SET_CARE
	var_21_3.characterId = arg_21_1
	var_21_3.care = arg_21_2

	var_21_1(var_21_0, var_21_2, var_21_3)

	return
end

function var_0_1.AutoChangeCurrentTopic(arg_22_0, arg_22_1)
	if arg_22_1 then
		if arg_22_1.currentTopic then
			local var_22_0 = arg_22_1.currentTopic

			if var_2.IsCompleted(var_22_0) then
				local var_22_1 = arg_22_1:GetTopicsSortByActivateTime()

				ipairs = var_1_10003

				for iter_22_0, iter_22_1 in var_1_10003(var_22_1) do
					if iter_22_1.active and not iter_22_1:IsCompleted() then
						local var_22_2 = arg_22_0
						local var_22_3 = arg_22_0.sendNotification

						GAME = var_1_10011
						var_1_10011 = var_1_10011.APARTMENT_CHAT_OP

						local var_22_4 = {}

						Dorm3dChatProxy = var_1_10013
						var_22_4.operation = var_1_10013.APARTMENT_CHAT_SET_TOPIC
						var_22_4.characterId = arg_22_1.characterId
						var_22_4.topicId = iter_22_1.topicId

						var_22_3(var_22_2, var_1_10011, var_22_4)

						break
					end
				end
			end

			return
		end
	end
end

return var_0_1
