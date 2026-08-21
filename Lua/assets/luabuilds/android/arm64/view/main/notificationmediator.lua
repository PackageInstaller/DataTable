local var_0_0 = class("NotificationMediator", import("..base.ContextMediator"))

var_0_0.ON_SEND_PUBLIC = "NotificationMediator:ON_SEND_PUBLIC"
var_0_0.CHANGE_ROOM = "NotificationMediator:CHANGE_ROOM"
var_0_0.OPEN_INFO = "NotificationMediator:OPEN_INFO"
var_0_0.OPEN_EMOJI = "NotificationMediator:OPEN_EMOJI"
var_0_0.BATTLE_CHAT_CLOSE = "NotificationMediator:BATTLE_CHAT_CLOSE"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getRawData()))

	local var_1_0 = getProxy(GuildProxy)

	arg_1_0.viewComponent:setInGuild(var_1_0:getRawData() ~= nil)
	arg_1_0.viewComponent:setMessages((getProxy(NotificationProxy):getAllMessages()))
	arg_1_0:bind(var_0_0.ON_SEND_PUBLIC, function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_2 == "$ rndsec refresh" and Application.isEditor then
			MainRandomFlagShipSequence.ForceRandom()
		elseif arg_2_2 == "$ force gc" then
			gcAll(true)
		elseif arg_2_2:match("%$ rndskin print %d+") and Application.isEditor then
			MainRandomFlagShipSequence.CalcRatio(tonumber(string.gmatch(arg_2_2, "%d+")()), function(arg_3_0)
				({
					richText = true
				}).player = getProxy(PlayerProxy):getData()
				;({
					richText = true
				}).content = arg_3_0
				;({
					richText = true
				}).timestamp = pg.TimeMgr.GetInstance():GetServerTime()

				getProxy(ChatProxy):addNewMsg(ChatMsg.New(ChatConst.ChannelWorld, {
					richText = true
				}))

				return
			end)
		elseif arg_2_2:match("^%$ battletest") then
			arg_1_0:sendNotification(NewMainMediator.DEBUG_BATTLE_LOOP, arg_2_2)
		elseif arg_2_2:match("^%$ %S+") then
			for iter_2_0, iter_2_1 in arg_2_2:gmatch("%s+(%S+)") do
				table.insert({}, iter_2_0)
			end

			arg_1_0:sendNotification(GAME.SEND_CMD, {
				cmd = ({})[1],
				arg1 = ({})[2],
				arg2 = ({})[3],
				arg3 = ({})[4],
				arg4 = ({})[5]
			})
		elseif arg_2_2 == "world battle skip" then
			switch_world_skip_battle()
		elseif arg_2_2 == pg.gameset.code_switch.description then
			if getProxy(PlayerProxy):getRawData().level >= 9 then
				HXSet.switchCodeMode()
			end
		else
			local var_2_0 = getProxy(PlayerProxy):getData()
			local var_2_1 = getProxy(ChatProxy):getData()
			local var_2_2 = 0

			for iter_2_2 = #var_2_1, 1, -1 do
				if var_2_1[iter_2_2].type == ChatConst.ChannelWorld and var_2_1[iter_2_2].player.id == var_2_0.id then
					var_2_2 = var_2_1[iter_2_2].timestamp

					break
				end
			end

			local var_2_3 = pg.TimeMgr.GetInstance():GetServerTime()

			if var_2_3 < var_2_0.chatMsgBanTime then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = true,
					content = i18n("chat_msg_ban", (os.date("%Y/%m/%d %H:%M:%S", var_2_0.chatMsgBanTime)))
				})
			elseif PLATFORM_CODE == PLATFORM_CH and LuaHelper.GetCHPackageType() ~= PACKAGE_TYPE_BILI and var_2_0.level < 70 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("chat_level_not_enough", 70))
			elseif var_2_0.level < 10 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("chat_level_not_enough", 10))
			elseif var_2_3 - var_2_2 < 10 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("dont_send_message_frequently", 10 - (var_2_3 - var_2_2)))
			else
				local var_2_4, var_2_5 = wordVer(arg_2_2, {
					isReplace = true
				})

				if arg_2_1 == ChatConst.ChannelWorld then
					arg_1_0:sendNotification(GAME.SEND_MSG, var_2_5)
				elseif arg_2_1 == ChatConst.ChannelGuild then
					arg_1_0:sendNotification(GAME.GUILD_SEND_MSG, var_2_5)
				end

				pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildEmoji(var_2_5))
			end
		end

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_ROOM, function(arg_4_0, arg_4_1)
		if arg_4_1 == getProxy(PlayerProxy):getRawData().chatRoomId then
			arg_1_0:onChangeChatRoomDone()
		else
			arg_1_0:sendNotification(GAME.CHANGE_CHAT_ROOM, arg_4_1)
		end

		return
	end)
	arg_1_0:bind(var_0_0.BATTLE_CHAT_CLOSE, function(arg_5_0)
		arg_1_0:sendNotification(BattleMediator.CLOSE_CHAT)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_INFO, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		if arg_6_1.id == var_0.id then
			return
		end

		arg_1_0.contextData.pos = arg_6_2
		arg_1_0.contextData.msg = arg_6_3

		arg_1_0:sendNotification(GAME.FRIEND_SEARCH, {
			type = SearchFriendCommand.SEARCH_TYPE_RESUME,
			keyword = arg_6_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_EMOJI, function(arg_7_0, arg_7_1, arg_7_2)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = EmojiLayer,
			mediator = EmojiMediator,
			data = {
				callback = arg_7_1,
				pos = arg_7_2,
				groupName = arg_1_0.viewComponent:getGroupName(),
				emojiIconCallback = function(arg_8_0)
					arg_1_0.viewComponent:insertEmojiToInputText(arg_8_0)

					return
				end
			}
		}), true)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_9_0)
	return {
		GAME.SEND_CMD_DONE,
		ChatProxy.NEW_MSG,
		GAME.CHANGE_CHAT_ROOM_DONE,
		GAME.CHAT_ROOM_MAX_NUMBER,
		GAME.FRIEND_SEARCH_DONE,
		GAME.FINISH_STAGE,
		FriendProxy.FRIEND_NEW_MSG,
		GuildProxy.NEW_MSG_ADDED,
		GAME.GO_WORLD_BOSS_SCENE
	}
end

function var_0_0.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()

	if var_10_0 == ChatProxy.NEW_MSG or var_10_0 == FriendProxy.FRIEND_NEW_MSG or var_10_0 == GuildProxy.NEW_MSG_ADDED then
		local var_10_2 = arg_10_0.viewComponent.messages

		table.insert(arg_10_0.viewComponent.messages, var_10_1)
		arg_10_0.viewComponent:setMessages(var_10_2)

		if NotificationLayer.ChannelBits.recv == bit.lshift(1, ChatConst.ChannelAll) or bit.band(NotificationLayer.ChannelBits.recv, bit.lshift(1, var_10_1.type)) > 0 then
			table.insert(arg_10_0.viewComponent.filteredMessages, var_10_1)
			arg_10_0.viewComponent:append(var_10_1, -1, true)
		elseif var_10_1.player and var_10_1.player.id == getProxy(PlayerProxy):getRawData().id then
			arg_10_0.viewComponent.recvTypes:each(function(arg_11_0, arg_11_1)
				if ChatConst.RecvChannels[arg_11_0 + 1] == var_10_1.type then
					triggerButton(arg_11_1)
				end

				return
			end)
		end
	elseif var_10_0 == GAME.SEND_CMD_DONE then
		if string.find(var_10_1, "CMD:into") then
			arg_10_0.viewComponent:closeView()
		end
	elseif var_10_0 == GAME.CHANGE_CHAT_ROOM_DONE then
		arg_10_0:onChangeChatRoomDone(var_10_1)
	elseif var_10_0 == GAME.CHAT_ROOM_MAX_NUMBER then
		pg.TipsMgr.GetInstance():ShowTips(i18n("main_notificationMediator_room_max_number"))
	elseif var_10_0 == GAME.FRIEND_SEARCH_DONE then
		if var_10_1.list[1] then
			arg_10_0:addSubLayers(Context.New({
				viewComponent = FriendInfoLayer,
				mediator = FriendInfoMediator,
				data = {
					friend = var_10_1.list[1],
					pos = arg_10_0.contextData.pos,
					msg = arg_10_0.contextData.msg,
					form = arg_10_0.contextData.form,
					groupName = arg_10_0.viewComponent:getGroupName()
				}
			}))

			arg_10_0.contextData.pos = nil
			arg_10_0.contextData.msg = nil
		end
	elseif var_10_0 == GAME.FINISH_STAGE then
		arg_10_0.viewComponent:closeView()
	elseif var_10_0 == GAME.GO_WORLD_BOSS_SCENE then
		arg_10_0.viewComponent:closeView()
	end

	return
end

function var_0_0.onChangeChatRoomDone(arg_12_0, arg_12_1)
	if arg_12_0.viewComponent.tempRoomSendBits then
		NotificationLayer.ChannelBits.send = arg_12_0.viewComponent.tempRoomSendBits
	end

	if arg_12_0.viewComponent.tempRoomRecvBits then
		NotificationLayer.ChannelBits.recv = arg_12_0.viewComponent.tempRoomRecvBits
	end

	arg_12_0.viewComponent:closeChangeRoomPanel()
	arg_12_0.viewComponent:setMessages((getProxy(NotificationProxy):getAllMessages()))
	arg_12_0.viewComponent:updateChatChannel()
	arg_12_0.viewComponent:updateFilter()
	arg_12_0.viewComponent:updateAll()

	if arg_12_1 then
		arg_12_0.viewComponent:setPlayer(arg_12_1)
		arg_12_0.viewComponent:updateRoom()
	end

	return
end

return var_0_0
