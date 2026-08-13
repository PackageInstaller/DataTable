class = var_0_10000

local var_0_0 = "PlayRoomSendChatCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().channel
	local var_1_1 = var_2.type

	if var_2.msg == "" then
		pg = var_1_10006
		var_1_10007 = var_1_10006.TipsMgr.GetInstance()
		var_1_10006 = var_1_10006.ShowTips
		i18n = var_1_10008

		var_1_10006(var_1_10007, var_1_10008("main_notificationLayer_sendButton"))

		return
	end

	getProxy = var_1_10006
	PlayerProxy = var_1_10007

	local var_1_2 = var_1_10006(var_1_10007)
	local var_1_3 = var_6.getRawData(var_1_2)
	local var_1_4 = 0

	PlayRoomChatConst = var_1_10009

	if var_1_0 == var_1_10009.CHANNEL_PLAYROOM then
		getProxy = var_9
		PlayRoomProxy = var_1_10010
		var_1_10011 = var_9(var_1_10010)

		for iter_1_1 = #var_9.GetChatMsgs(var_1_10011), 1, -1 do
			if var_1_10010[iter_1_1].playerId == var_1_3.id then
				var_1_4 = var_1_10010[iter_1_1].timestamp

				break
			end
		end
	else
		getProxy = var_9
		ChatProxy = var_1_10010
		var_1_10011 = var_9(var_1_10010)

		for iter_1_1 = #var_9.getRawData(var_1_10011), 1, -1 do
			local var_1_5 = var_10[iter_1_1].type

			ChatConst = var_1_10016

			if var_1_5 == var_1_10016.ChannelWorld and var_10[iter_1_1].player.id == var_1_3.id then
				var_1_4 = var_10[iter_1_1].timestamp

				break
			end
		end
	end

	pg = var_9

	local var_1_6 = var_9.TimeMgr.GetInstance()
	local var_1_7

	if var_9.GetServerTime(var_1_6) < var_1_3.chatMsgBanTime then
		os = var_1_7
		var_1_7 = var_1_7.date("%Y/%m/%d %H:%M:%S", var_1_3.chatMsgBanTime)
		pg = var_1_10011
		var_1_10012 = var_1_10011.MsgboxMgr.GetInstance()
		var_1_10011 = var_1_10011.ShowMsgBox
		var_1_10013 = {
			hideNo = true
		}
		i18n = iter_1_1
		var_1_10013.content = iter_1_1("chat_msg_ban", var_1_7)

		var_1_10011(var_1_10012, var_1_10013)
	else
		PLATFORM_CODE = var_1_7
		PLATFORM_CH = var_1_10011

		if var_1_7 == var_1_10011 then
			LuaHelper = var_1_7

			local var_1_8 = var_1_7.GetCHPackageType()

			PACKAGE_TYPE_BILI = var_1_10011

			if var_1_8 ~= var_1_10011 and var_1_3.level < 70 then
				pg = var_10

				local var_1_9 = var_10.TipsMgr.GetInstance()
				local var_1_10 = var_10.ShowTips

				i18n = var_1_10012

				var_1_10(var_1_9, var_1_10012("chat_level_not_enough", 70))

				goto label_1_0
			end
		end

		if var_1_3.level < 10 then
			pg = var_10

			local var_1_11 = var_10.TipsMgr.GetInstance()
			local var_1_12 = var_10.ShowTips

			i18n = var_1_10012

			var_1_12(var_1_11, var_1_10012("chat_level_not_enough", 10))
		elseif var_9 - var_1_4 < 10 then
			local var_1_13 = 10 - (var_9 - var_1_4)

			pg = var_11

			local var_1_14 = var_11.TipsMgr.GetInstance()
			local var_1_15 = var_11.ShowTips

			i18n = var_1_10013

			var_1_15(var_1_14, var_1_10013("dont_send_message_frequently", var_1_13))
		else
			arg_1_0:Send(var_1_0, var_1_1, var_5)
		end
	end

	::label_1_0::

	return
end

function var_0_1.Send(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	wordVer = var_1_10004

	local var_2_0, var_2_1 = var_1_10004(arg_2_3, {
		isReplace = true
	})

	PlayRoomChatConst = var_6

	if arg_2_1 == var_6.CHANNEL_PLAYROOM then
		pg = var_6

		local var_2_2 = var_6.ConnectionMgr.GetInstance()

		var_6.Send(var_2_2, 23023, {
			type = arg_2_2,
			content = var_2_1
		}, 23024, function(arg_3_0)
			if arg_3_0.result == 0 then
				-- block empty
			else
				pg = var_1

				local var_3_0 = var_1.TipsMgr.GetInstance()

				var_1.ShowTips(var_3_0, arg_3_0.tip)
			end

			return
		end)
	else
		PlayRoomChatConst = var_6

		local var_2_4

		if arg_2_1 == var_6.CHANNEL_WORLD then
			local var_2_3 = arg_2_0

			var_2_4 = arg_2_0.sendNotification
			GAME = var_1_10008

			var_2_4(var_2_3, var_1_10008.SEND_MSG, var_2_1)
		else
			PlayRoomChatConst = var_2_4

			if arg_2_1 == var_2_4.CHANNEL_GUILD then
				local var_2_5 = arg_2_0
				local var_2_6 = arg_2_0.sendNotification

				GAME = var_1_10008

				var_2_6(var_2_5, var_1_10008.GUILD_SEND_MSG, var_2_1)
			end
		end
	end

	return
end

return var_0_1
