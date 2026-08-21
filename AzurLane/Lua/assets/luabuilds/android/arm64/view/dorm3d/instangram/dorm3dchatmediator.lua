local var_0_0 = class("Dorm3dChatMediator", import("view.base.ContextMediator"))

var_0_0.CHANGE_CARE = "Dorm3dChatMediator:CHANGE_CARE"
var_0_0.REPLY = "Dorm3dChatMediator:REPLY"
var_0_0.GET_REDPACKET = "Dorm3dChatMediator:GET_REDPACKET"
var_0_0.SET_CURRENT_TOPIC = "Dorm3dChatMediator:SET_CURRENT_TOPIC"
var_0_0.SET_CURRENT_BACKGROUND = "Dorm3dChatMediator:SET_CURRENT_BACKGROUND"
var_0_0.SET_READED = "Dorm3dChatMediator:SET_READED"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.CHANGE_CARE, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.APARTMENT_CHAT_OP, {
			operation = Dorm3dChatProxy.APARTMENT_CHAT_SET_CARE,
			characterId = arg_2_1,
			care = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.REPLY, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		arg_1_0:sendNotification(GAME.APARTMENT_CHAT_OP, {
			isRedPacket = false,
			operation = Dorm3dChatProxy.APARTMENT_CHAT_REPLY,
			characterId = arg_3_1,
			topicId = arg_3_2,
			wordId = arg_3_3,
			replyId = arg_3_4
		})

		return
	end)
	arg_1_0:bind(var_0_0.GET_REDPACKET, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		arg_1_0:sendNotification(GAME.APARTMENT_CHAT_OP, {
			isRedPacket = true,
			operation = Dorm3dChatProxy.APARTMENT_CHAT_REPLY,
			characterId = arg_4_1,
			topicId = arg_4_2,
			wordId = arg_4_3,
			replyId = arg_4_4
		})

		return
	end)
	arg_1_0:bind(var_0_0.SET_CURRENT_TOPIC, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:sendNotification(GAME.APARTMENT_CHAT_OP, {
			operation = Dorm3dChatProxy.APARTMENT_CHAT_SET_TOPIC,
			characterId = arg_5_1,
			topicId = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.SET_CURRENT_BACKGROUND, function(arg_6_0, arg_6_1, arg_6_2)
		arg_1_0:sendNotification(GAME.APARTMENT_CHAT_OP, {
			operation = Dorm3dChatProxy.APARTMENT_CHAT_SET_SKIN,
			characterId = arg_6_1,
			skinId = arg_6_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.SET_READED, function(arg_7_0, arg_7_1, arg_7_2)
		arg_1_0:sendNotification(GAME.APARTMENT_CHAT_OP, {
			operation = Dorm3dChatProxy.APARTMENT_CHAT_SET_READTIP,
			characterId = arg_7_1,
			topicIdList = arg_7_2
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		GAME.APARTMENT_CHAT_OP_DONE
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getBody()

	if arg_9_1:getName() == GAME.APARTMENT_CHAT_OP_DONE then
		local var_9_1 = getProxy(Dorm3dChatProxy)
		local var_9_2 = false
		local var_9_3 = false

		if var_9_0.operation == var_9_1.APARTMENT_CHAT_REPLY then
			if var_9_0.awards ~= nil then
				arg_9_0.viewComponent:SetEndAniEvent(arg_9_0.viewComponent.redPacketGot, function()
					arg_9_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_0.awards)

					return
				end)
				arg_9_0.viewComponent:UpdateRedPacketUI(var_9_0.redPacketId)
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
				arg_9_0.viewComponent:ChangeFresh()
			else
				arg_9_0.viewComponent:SetEndAniEvent(arg_9_0.viewComponent.optionPanel, function()
					arg_9_0.viewComponent:UpdateChat(var_9_2, var_9_3)

					return
				end)
				arg_9_0.viewComponent.optionPanel:GetComponent(typeof(Animation)):Play("anim_newinstagram_option_out")
			end
		else
			arg_9_0.viewComponent:UpdateChat(var_9_2, var_9_3)
		end
	end

	return
end

return var_0_0
