local var_0_0 = class("IslandSendChatCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.channel
	local var_1_2 = var_1_0.islandId
	local var_1_3 = var_1_0.msg

	if var_1_0.msg == "" then
		pg.TipsMgr.GetInstance():ShowTips(i18n("main_notificationLayer_sendButton"))

		return
	end

	local var_1_4 = getProxy(PlayerProxy):getRawData()
	local var_1_5 = 0

	if var_1_1 == IslandChatConst.CHANNEL_ISLAND then
		local var_1_6 = getProxy(IslandProxy):GetChatMsgList(var_1_2)

		for iter_1_0 = #var_1_6, 1, -1 do
			if var_1_6[iter_1_0].player.id == var_1_4.id then
				var_1_5 = var_1_6[iter_1_0].timestamp

				break
			end
		end
	else
		local var_1_7 = getProxy(ChatProxy):getRawData()

		for iter_1_1 = #var_1_7, 1, -1 do
			if var_1_7[iter_1_1].type == ChatConst.ChannelWorld and var_1_7[iter_1_1].player.id == var_1_4.id then
				var_1_5 = var_1_7[iter_1_1].timestamp

				break
			end
		end
	end

	local var_1_8 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_1_8 < var_1_4.chatMsgBanTime then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("chat_msg_ban", (os.date("%Y/%m/%d %H:%M:%S", var_1_4.chatMsgBanTime)))
		})
	elseif PLATFORM_CODE == PLATFORM_CH and LuaHelper.GetCHPackageType() ~= PACKAGE_TYPE_BILI and var_1_4.level < 70 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("chat_level_not_enough", 70))
	elseif var_1_4.level < 10 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("chat_level_not_enough", 10))
	elseif var_1_8 - var_1_5 < 10 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("dont_send_message_frequently", 10 - (var_1_8 - var_1_5)))
	else
		arg_1_0:Send(var_1_1, var_1_2, var_1_3)
	end

	return
end

function var_0_0.Send(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0, var_2_1 = wordVer(arg_2_3, {
		isReplace = true
	})

	if arg_2_1 == IslandChatConst.CHANNEL_ISLAND then
		pg.ConnectionMgr.GetInstance():Send(21323, {
			island_id = arg_2_2,
			content = var_2_1
		}, 21324, function(arg_3_0)
			if arg_3_0.result == 0 then
				-- block empty
			else
				pg.TipsMgr.GetInstance():ShowTips(arg_3_0.tip)
			end

			return
		end)
	elseif arg_2_1 == IslandChatConst.CHANNEL_WORLD then
		arg_2_0:sendNotification(GAME.SEND_MSG, var_2_1)
	elseif arg_2_1 == IslandChatConst.CHANNEL_GUILD then
		arg_2_0:sendNotification(GAME.GUILD_SEND_MSG, var_2_1)
	end

	return
end

return var_0_0
