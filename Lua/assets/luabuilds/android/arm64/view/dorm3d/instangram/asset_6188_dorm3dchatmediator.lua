local Dorm3dChatMediator = class("Dorm3dChatMediator", import("view.base.ContextMediator"))

Dorm3dChatMediator.CHANGE_CARE = "Dorm3dChatMediator:CHANGE_CARE"
Dorm3dChatMediator.REPLY = "Dorm3dChatMediator:REPLY"
Dorm3dChatMediator.GET_REDPACKET = "Dorm3dChatMediator:GET_REDPACKET"
Dorm3dChatMediator.SET_CURRENT_TOPIC = "Dorm3dChatMediator:SET_CURRENT_TOPIC"
Dorm3dChatMediator.SET_CURRENT_BACKGROUND = "Dorm3dChatMediator:SET_CURRENT_BACKGROUND"
Dorm3dChatMediator.SET_READED = "Dorm3dChatMediator:SET_READED"

function Dorm3dChatMediator:register()
	self:bind(Dorm3dChatMediator.CHANGE_CARE, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.APARTMENT_CHAT_OP, {
			operation = Dorm3dChatProxy.APARTMENT_CHAT_SET_CARE,
			characterId = arg_2_1,
			care = arg_2_2
		})

		return
	end)
	self:bind(Dorm3dChatMediator.REPLY, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		self:sendNotification(GAME.APARTMENT_CHAT_OP, {
			isRedPacket = false,
			operation = Dorm3dChatProxy.APARTMENT_CHAT_REPLY,
			characterId = arg_3_1,
			topicId = arg_3_2,
			wordId = arg_3_3,
			replyId = arg_3_4
		})

		return
	end)
	self:bind(Dorm3dChatMediator.GET_REDPACKET, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		self:sendNotification(GAME.APARTMENT_CHAT_OP, {
			isRedPacket = true,
			operation = Dorm3dChatProxy.APARTMENT_CHAT_REPLY,
			characterId = arg_4_1,
			topicId = arg_4_2,
			wordId = arg_4_3,
			replyId = arg_4_4
		})

		return
	end)
	self:bind(Dorm3dChatMediator.SET_CURRENT_TOPIC, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.APARTMENT_CHAT_OP, {
			operation = Dorm3dChatProxy.APARTMENT_CHAT_SET_TOPIC,
			characterId = arg_5_1,
			topicId = arg_5_2
		})

		return
	end)
	self:bind(Dorm3dChatMediator.SET_CURRENT_BACKGROUND, function(arg_6_0, arg_6_1, arg_6_2)
		self:sendNotification(GAME.APARTMENT_CHAT_OP, {
			operation = Dorm3dChatProxy.APARTMENT_CHAT_SET_SKIN,
			characterId = arg_6_1,
			skinId = arg_6_2
		})

		return
	end)
	self:bind(Dorm3dChatMediator.SET_READED, function(arg_7_0, arg_7_1, arg_7_2)
		self:sendNotification(GAME.APARTMENT_CHAT_OP, {
			operation = Dorm3dChatProxy.APARTMENT_CHAT_SET_READTIP,
			characterId = arg_7_1,
			topicIdList = arg_7_2
		})

		return
	end)

	return
end

function Dorm3dChatMediator:listNotificationInterests()
	return {
		GAME.APARTMENT_CHAT_OP_DONE
	}
end

function Dorm3dChatMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getBody()

	if arg_9_1:getName() == GAME.APARTMENT_CHAT_OP_DONE then
		local var_9_1 = getProxy(Dorm3dChatProxy)
		local var_9_2 = false
		local var_9_3 = false

		if var_9_0.operation == var_9_1.APARTMENT_CHAT_REPLY then
			if var_9_0.awards ~= nil then
				self.viewComponent:SetEndAniEvent(self.viewComponent.redPacketGot, function()
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_0.awards)

					return
				end)
				self.viewComponent:UpdateRedPacketUI(var_9_0.redPacketId)
			end

			var_9_2 = true
		elseif var_9_0.operation == var_9_1.APARTMENT_CHAT_SET_SKIN then
			-- block empty
		elseif var_9_0.operation == var_9_1.APARTMENT_CHAT_SET_CARE then
			-- block empty
		elseif var_9_0.operation == var_9_1.APARTMENT_CHAT_SET_TOPIC then
			-- block empty
		elseif var_9_0.operation == var_9_1.APARTMENT_CHAT_SET_READTIP then
			var_9_3 = true
		end

		if var_9_0.operation == var_9_1.APARTMENT_CHAT_REPLY then
			if var_9_0.awards ~= nil then
				self.viewComponent:ChangeFresh()
			else
				self.viewComponent:SetEndAniEvent(self.viewComponent.optionPanel, function()
					self.viewComponent:UpdateChat(var_9_2, var_9_3)

					return
				end)
				self.viewComponent.optionPanel:GetComponent(typeof(Animation)):Play("anim_newinstagram_option_out")
			end
		else
			self.viewComponent:UpdateChat(var_9_2, var_9_3)
		end
	end

	return
end

return Dorm3dChatMediator
