class = var_0_10000

local var_0_0 = "Dorm3dChatMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.CHANGE_CARE = "Dorm3dChatMediator:CHANGE_CARE"
var_0_1.REPLY = "Dorm3dChatMediator:REPLY"
var_0_1.GET_REDPACKET = "Dorm3dChatMediator:GET_REDPACKET"
var_0_1.SET_CURRENT_TOPIC = "Dorm3dChatMediator:SET_CURRENT_TOPIC"
var_0_1.SET_CURRENT_BACKGROUND = "Dorm3dChatMediator:SET_CURRENT_BACKGROUND"
var_0_1.SET_READED = "Dorm3dChatMediator:SET_READED"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.CHANGE_CARE, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_2_2 = var_2_10006.APARTMENT_CHAT_OP
		local var_2_3 = {}

		Dorm3dChatProxy = var_2_10008
		var_2_3.operation = var_2_10008.APARTMENT_CHAT_SET_CARE
		var_2_3.characterId = arg_2_1
		var_2_3.care = arg_2_2

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.REPLY, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		local var_3_0 = arg_1_0
		local var_3_1 = var_5.sendNotification

		GAME = var_2_10008

		local var_3_2 = var_2_10008.APARTMENT_CHAT_OP
		local var_3_3 = {
			isRedPacket = false
		}

		Dorm3dChatProxy = var_2_10010
		var_3_3.operation = var_2_10010.APARTMENT_CHAT_REPLY
		var_3_3.characterId = arg_3_1
		var_3_3.topicId = arg_3_2
		var_3_3.wordId = arg_3_3
		var_3_3.replyId = arg_3_4

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.GET_REDPACKET, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		local var_4_0 = arg_1_0
		local var_4_1 = var_5.sendNotification

		GAME = var_2_10008

		local var_4_2 = var_2_10008.APARTMENT_CHAT_OP
		local var_4_3 = {
			isRedPacket = true
		}

		Dorm3dChatProxy = var_2_10010
		var_4_3.operation = var_2_10010.APARTMENT_CHAT_REPLY
		var_4_3.characterId = arg_4_1
		var_4_3.topicId = arg_4_2
		var_4_3.wordId = arg_4_3
		var_4_3.replyId = arg_4_4

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.SET_CURRENT_TOPIC, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_5_2 = var_2_10006.APARTMENT_CHAT_OP
		local var_5_3 = {}

		Dorm3dChatProxy = var_2_10008
		var_5_3.operation = var_2_10008.APARTMENT_CHAT_SET_TOPIC
		var_5_3.characterId = arg_5_1
		var_5_3.topicId = arg_5_2

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)
	arg_1_0:bind(var_0_1.SET_CURRENT_BACKGROUND, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_1_0
		local var_6_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_6_2 = var_2_10006.APARTMENT_CHAT_OP
		local var_6_3 = {}

		Dorm3dChatProxy = var_2_10008
		var_6_3.operation = var_2_10008.APARTMENT_CHAT_SET_SKIN
		var_6_3.characterId = arg_6_1
		var_6_3.skinId = arg_6_2

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)
	arg_1_0:bind(var_0_1.SET_READED, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0
		local var_7_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_7_2 = var_2_10006.APARTMENT_CHAT_OP
		local var_7_3 = {}

		Dorm3dChatProxy = var_2_10008
		var_7_3.operation = var_2_10008.APARTMENT_CHAT_SET_READTIP
		var_7_3.characterId = arg_7_1
		var_7_3.topicIdList = arg_7_2

		var_7_1(var_7_0, var_7_2, var_7_3)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	GAME = var_1_10002
	var_8_0[1] = var_1_10002.APARTMENT_CHAT_OP_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getName(var_9_0)
	local var_9_2 = arg_9_1:getBody()

	GAME = var_9_0

	if var_9_1 == var_9_0.APARTMENT_CHAT_OP_DONE then
		getProxy = var_4
		Dorm3dChatProxy = var_1_10006

		local var_9_3 = var_4(var_1_10006)
		local var_9_4 = false
		local var_9_5 = false

		if var_9_2.operation == var_9_3.APARTMENT_CHAT_REPLY then
			if var_9_2.awards ~= nil then
				local var_9_6 = arg_9_0.viewComponent

				var_7.SetEndAniEvent(var_9_6, arg_9_0.viewComponent.redPacketGot, function()
					local var_10_0 = arg_9_0.viewComponent
					local var_10_1 = var_0.emit

					BaseUI = var_2_10003

					var_10_1(var_10_0, var_2_10003.ON_ACHIEVE, var_9_2.awards)

					return
				end)

				local var_9_7 = arg_9_0.viewComponent

				var_7.UpdateRedPacketUI(var_9_7, var_9_2.redPacketId)
			end

			var_9_4 = true
		elseif var_9_2.operation == var_9_3.APARTMENT_CHAT_SET_SKIN then
			-- block empty
		elseif var_9_2.operation == var_9_3.APARTMENT_CHAT_SET_CARE then
			-- block empty
		elseif var_9_2.operation == var_9_3.APARTMENT_CHAT_SET_TOPIC then
			-- block empty
		elseif var_9_2.operation == var_9_3.APARTMENT_CHAT_SET_READTIP then
			var_9_5 = true
		end

		if var_9_2.operation == var_9_3.APARTMENT_CHAT_REPLY then
			if var_9_2.awards ~= nil then
				local var_9_8 = arg_9_0.viewComponent

				var_7.ChangeFresh(var_9_8)
			else
				local var_9_9 = arg_9_0.viewComponent

				var_7.SetEndAniEvent(var_9_9, arg_9_0.viewComponent.optionPanel, function()
					local var_11_0 = arg_9_0.viewComponent

					var_0.UpdateChat(var_11_0, var_9_4, var_9_5)

					return
				end)

				local var_9_10 = arg_9_0.viewComponent.optionPanel
				local var_9_11 = var_7.GetComponent

				typeof = var_10
				Animation = var_1_10012

				local var_9_12 = var_9_11(var_9_10, var_10(var_1_10012))

				var_7.Play(var_9_12, "anim_newinstagram_option_out")
			end
		else
			local var_9_13 = arg_9_0.viewComponent

			var_7.UpdateChat(var_9_13, var_9_4, var_9_5)
		end
	end

	return
end

return var_0_1
