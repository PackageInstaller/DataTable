local var_0_0 = class("Dorm3dChatProxy", import(".NetProxy"))
local var_0_1 = pg.dorm3d_ins_chat_group

var_0_0.APARTMENT_CHAT_REPLY = 1
var_0_0.APARTMENT_CHAT_SET_SKIN = 2
var_0_0.APARTMENT_CHAT_SET_CARE = 3
var_0_0.APARTMENT_CHAT_SET_TOPIC = 4
var_0_0.APARTMENT_CHAT_SET_READTIP = 5
var_0_0.APARTMENT_CHAT_TRIGGER_EVENT = 6

function var_0_0.register(arg_1_0)
	arg_1_0.chatList = {}

	return
end

function var_0_0.HandleAct(arg_2_0, arg_2_1)
	if arg_2_0:GetCharacterChatByTopicId(arg_2_1.act_id) then
		local var_2_0 = arg_2_0:GetTopicById(arg_2_1.act_id)

		if var_2_0 then
			var_2_0:Activate(arg_2_1.time)
		end
	else
		arg_2_0:CreateNewChat(arg_2_1.act_id, arg_2_1.time)
	end

	return
end

function var_0_0.CreateChat(arg_3_0, arg_3_1)
	table.insert(arg_3_0.chatList, (Dorm3dChat.New(arg_3_1)))

	return
end

function var_0_0.SetChatList(arg_4_0, arg_4_1)
	arg_4_0.chatList = arg_4_1

	return
end

function var_0_0.GetChatList(arg_5_0)
	return arg_5_0.chatList
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
	table.insert(arg_9_0.chatList, (Dorm3dChat.New({
		cur_back = 0,
		care_flag = 0,
		ship_group = var_0_1[arg_9_1].ship_group,
		cur_comm_id = arg_9_1,
		comm_list = {
			{
				read_flag = 0,
				id = arg_9_1,
				time = arg_9_2,
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

function var_0_0.SetCurrentTopic(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:GetTopicById(arg_11_1)

	if var_11_0 then
		local var_11_1 = arg_11_0:GetCharacterChatById(var_11_0.characterId)

		if var_11_1 then
			var_11_1:SetCurrentTopic(arg_11_1)
		end
	end

	return
end

function var_0_0.UpdateTopicDisplayWordList(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0:GetTopicById(arg_12_1)

	if var_12_0 then
		table.insert(var_12_0.replyList, {
			key = arg_12_2,
			value = arg_12_3
		})
		var_12_0:SetDisplayWordList()
	end

	return
end

function var_0_0.GetAllTopicIds(arg_13_0)
	return Clone(var_0_1.all)
end

function var_0_0.SetChatSkin(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:GetCharacterChatById(arg_14_1).skinId = arg_14_2

	return
end

function var_0_0.UpdateAllChatBackGrounds(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.chatList) do
		if iter_15_1.type == 1 then
			iter_15_1:SetBackgrounds()
		end
	end

	return
end

function var_0_0.SetTopicReaded(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:GetTopicById(arg_16_1).readFlag = arg_16_2

	return
end

function var_0_0.ShouldShowTip(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.chatList) do
		if iter_17_1:GetCharacterEndFlag() == 0 then
			local var_17_0 = getProxy(Dorm3dInsProxy):GetRoomByGroupId(iter_17_1.characterId)

			if var_17_0:IsDownloaded() then
				return true
			end
		end
	end

	return false
end

function var_0_0.ShouldShowShipTip(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:GetCharacterChatById(arg_18_1)

	if var_18_0 and var_18_0:GetCharacterEndFlag() == 0 then
		return true
	else
		return false
	end

	return
end

function var_0_0.TriggerEvent(arg_19_0, arg_19_1)
	if DORM_LOCK_INS then
		return
	end

	arg_19_0:sendNotification(GAME.APARTMENT_CHAT_OP, {
		operation = Dorm3dChatProxy.APARTMENT_CHAT_TRIGGER_EVENT,
		eventList = arg_19_1
	})

	return
end

function var_0_0.GetChatCare(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:GetCharacterChatById(arg_20_1)

	if var_20_0 then
		return var_20_0.care
	end

	return 0
end

function var_0_0.SetChatCare(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0:sendNotification(GAME.APARTMENT_CHAT_OP, {
		operation = Dorm3dChatProxy.APARTMENT_CHAT_SET_CARE,
		characterId = arg_21_1,
		care = arg_21_2
	})

	return
end

function var_0_0.AutoChangeCurrentTopic(arg_22_0, arg_22_1)
	if arg_22_1 then
		if arg_22_1.currentTopic then
			if arg_22_1.currentTopic:IsCompleted() then
				for iter_22_0, iter_22_1 in ipairs((arg_22_1:GetTopicsSortByActivateTime())) do
					if iter_22_1.active and not iter_22_1:IsCompleted() then
						arg_22_0:sendNotification(GAME.APARTMENT_CHAT_OP, {
							operation = Dorm3dChatProxy.APARTMENT_CHAT_SET_TOPIC,
							characterId = arg_22_1.characterId,
							topicId = iter_22_1.topicId
						})

						break
					end
				end
			end

			return
		end
	end
end

return var_0_0
