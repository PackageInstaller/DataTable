local Dorm3dChatProxy = class("Dorm3dChatProxy", import(".NetProxy"))
local var_0_1 = pg.dorm3d_ins_chat_group

Dorm3dChatProxy.APARTMENT_CHAT_REPLY = 1
Dorm3dChatProxy.APARTMENT_CHAT_SET_SKIN = 2
Dorm3dChatProxy.APARTMENT_CHAT_SET_CARE = 3
Dorm3dChatProxy.APARTMENT_CHAT_SET_TOPIC = 4
Dorm3dChatProxy.APARTMENT_CHAT_SET_READTIP = 5
Dorm3dChatProxy.APARTMENT_CHAT_TRIGGER_EVENT = 6

function Dorm3dChatProxy:register()
	self.chatList = {}

	return
end

function Dorm3dChatProxy:HandleAct(arg_2_1)
	if self:GetCharacterChatByTopicId(arg_2_1.act_id) then
		local var_2_0 = self:GetTopicById(arg_2_1.act_id)

		if var_2_0 then
			var_2_0:Activate(arg_2_1.time)
		end
	else
		self:CreateNewChat(arg_2_1.act_id, arg_2_1.time)
	end

	return
end

function Dorm3dChatProxy:CreateChat(arg_3_1)
	table.insert(self.chatList, (Dorm3dChat.New(arg_3_1)))

	return
end

function Dorm3dChatProxy:SetChatList(arg_4_1)
	self.chatList = arg_4_1

	return
end

function Dorm3dChatProxy:GetChatList()
	return self.chatList
end

function Dorm3dChatProxy:GetCharacterChatById(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self.chatList) do
		if iter_6_1.characterId == arg_6_1 then
			return iter_6_1
		end
	end

	return nil
end

function Dorm3dChatProxy:GetTopicById(arg_7_1)
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

function Dorm3dChatProxy:GetCharacterChatByTopicId(arg_8_1)
	return self:GetCharacterChatById(var_0_1[arg_8_1].ship_group)
end

function Dorm3dChatProxy:CreateNewChat(arg_9_1, arg_9_2)
	table.insert(self.chatList, (Dorm3dChat.New({
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

function Dorm3dChatProxy:SetTopicOperationTime(arg_10_1, arg_10_2)
	self:GetTopicById(arg_10_1).operationTime = arg_10_2

	return
end

function Dorm3dChatProxy:SetCurrentTopic(arg_11_1)
	local var_11_0 = self:GetTopicById(arg_11_1)

	if var_11_0 then
		local var_11_1 = self:GetCharacterChatById(var_11_0.characterId)

		if var_11_1 then
			var_11_1:SetCurrentTopic(arg_11_1)
		end
	end

	return
end

function Dorm3dChatProxy:UpdateTopicDisplayWordList(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = self:GetTopicById(arg_12_1)

	if var_12_0 then
		table.insert(var_12_0.replyList, {
			key = arg_12_2,
			value = arg_12_3
		})
		var_12_0:SetDisplayWordList()
	end

	return
end

function Dorm3dChatProxy:GetAllTopicIds()
	return Clone(var_0_1.all)
end

function Dorm3dChatProxy:SetChatSkin(arg_14_1, arg_14_2)
	self:GetCharacterChatById(arg_14_1).skinId = arg_14_2

	return
end

function Dorm3dChatProxy:UpdateAllChatBackGrounds()
	for iter_15_0, iter_15_1 in ipairs(self.chatList) do
		if iter_15_1.type == 1 then
			iter_15_1:SetBackgrounds()
		end
	end

	return
end

function Dorm3dChatProxy:SetTopicReaded(arg_16_1, arg_16_2)
	self:GetTopicById(arg_16_1).readFlag = arg_16_2

	return
end

function Dorm3dChatProxy:ShouldShowTip()
	for iter_17_0, iter_17_1 in ipairs(self.chatList) do
		if iter_17_1:GetCharacterEndFlag() == 0 then
			if getProxy(Dorm3dInsProxy):GetRoomByGroupId(iter_17_1.characterId):IsDownloaded() then
				return true
			end
		end
	end

	return false
end

function Dorm3dChatProxy:ShouldShowShipTip(arg_18_1)
	local var_18_0 = self:GetCharacterChatById(arg_18_1)

	if var_18_0 and var_18_0:GetCharacterEndFlag() == 0 then
		return true
	else
		return false
	end

	return
end

function Dorm3dChatProxy:TriggerEvent(arg_19_1)
	if DORM_LOCK_INS then
		return
	end

	self:sendNotification(GAME.APARTMENT_CHAT_OP, {
		operation = Dorm3dChatProxy.APARTMENT_CHAT_TRIGGER_EVENT,
		eventList = arg_19_1
	})

	return
end

function Dorm3dChatProxy:GetChatCare(arg_20_1)
	local var_20_0 = self:GetCharacterChatById(arg_20_1)

	if var_20_0 then
		return var_20_0.care
	end

	return 0
end

function Dorm3dChatProxy:SetChatCare(arg_21_1, arg_21_2)
	self:sendNotification(GAME.APARTMENT_CHAT_OP, {
		operation = Dorm3dChatProxy.APARTMENT_CHAT_SET_CARE,
		characterId = arg_21_1,
		care = arg_21_2
	})

	return
end

function Dorm3dChatProxy:AutoChangeCurrentTopic(arg_22_1)
	if arg_22_1 then
		if arg_22_1.currentTopic then
			if arg_22_1.currentTopic:IsCompleted() then
				for iter_22_0, iter_22_1 in ipairs((arg_22_1:GetTopicsSortByActivateTime())) do
					if iter_22_1.active and not iter_22_1:IsCompleted() then
						self:sendNotification(GAME.APARTMENT_CHAT_OP, {
							operation = Dorm3dChatProxy.APARTMENT_CHAT_SET_TOPIC,
							characterId = arg_22_1.characterId,
							topicId = iter_22_1.topicId
						})

						break
					end
				end
			end
		end
	end

	return
end

return Dorm3dChatProxy
