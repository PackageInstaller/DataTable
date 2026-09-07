local NotificationMediator = class("NotificationMediator", import("..base.ContextMediator"))

NotificationMediator.ON_SEND_PUBLIC = "NotificationMediator:ON_SEND_PUBLIC"
NotificationMediator.CHANGE_ROOM = "NotificationMediator:CHANGE_ROOM"
NotificationMediator.OPEN_INFO = "NotificationMediator:OPEN_INFO"
NotificationMediator.OPEN_EMOJI = "NotificationMediator:OPEN_EMOJI"
NotificationMediator.BATTLE_CHAT_CLOSE = "NotificationMediator:BATTLE_CHAT_CLOSE"

function NotificationMediator:register()
	local var_1_0 = getProxy(PlayerProxy):getRawData()

	self.viewComponent:setPlayer(var_1_0)
	self.viewComponent:setInGuild(getProxy(GuildProxy):getRawData() ~= nil)
	self.viewComponent:setMessages((getProxy(NotificationProxy):getAllMessages()))
	self:bind(NotificationMediator.ON_SEND_PUBLIC, function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_2 == "$ rndsec refresh" and Application.isEditor then
			MainRandomFlagShipSequence.ForceRandom()
		elseif arg_2_2 == "$ force gc" then
			gcAll(true)
		elseif arg_2_2:match("%$ rndskin print %d+") and Application.isEditor then
			MainRandomFlagShipSequence.CalcRatio(tonumber(string.gmatch(arg_2_2, "%d+")()), function(arg_3_0)
				local var_3_0 = {
					richText = true
				}

				var_3_0.player = getProxy(PlayerProxy):getData()
				var_3_0.content = arg_3_0
				var_3_0.timestamp = pg.TimeMgr.GetInstance():GetServerTime()

				getProxy(ChatProxy):addNewMsg(ChatMsg.New(ChatConst.ChannelWorld, var_3_0))

				return
			end)
		elseif arg_2_2:match("^%$ battletest") then
			self:sendNotification(NewMainMediator.DEBUG_BATTLE_LOOP, arg_2_2)
		elseif arg_2_2:match("^%$ %S+") then
			local var_2_0 = {}

			for iter_2_0, iter_2_1 in arg_2_2:gmatch("%s+(%S+)") do
				table.insert(var_2_0, iter_2_0)
			end

			self:sendNotification(GAME.SEND_CMD, {
				cmd = var_2_0[1],
				arg1 = var_2_0[2],
				arg2 = var_2_0[3],
				arg3 = var_2_0[4],
				arg4 = var_2_0[5]
			})
		elseif arg_2_2 == "world battle skip" then
			switch_world_skip_battle()
		elseif arg_2_2 == pg.gameset.code_switch.description then
			if getProxy(PlayerProxy):getRawData().level >= 9 then
				HXSet.switchCodeMode()
			end
		else
			local var_2_1 = getProxy(PlayerProxy):getData()
			local var_2_2 = getProxy(ChatProxy):getData()
			local var_2_3 = 0

			for iter_2_2 = #var_2_2, 1, -1 do
				if var_2_2[iter_2_2].type == ChatConst.ChannelWorld and var_2_2[iter_2_2].player.id == var_2_1.id then
					var_2_3 = var_2_2[iter_2_2].timestamp

					break
				end
			end

			local var_2_4 = pg.TimeMgr.GetInstance():GetServerTime()

			if var_2_4 < var_2_1.chatMsgBanTime then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = true,
					content = i18n("chat_msg_ban", (os.date("%Y/%m/%d %H:%M:%S", var_2_1.chatMsgBanTime)))
				})
			elseif PLATFORM_CODE == PLATFORM_CH and LuaHelper.GetCHPackageType() ~= PACKAGE_TYPE_BILI and var_2_1.level < 70 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("chat_level_not_enough", 70))
			elseif var_2_1.level < 10 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("chat_level_not_enough", 10))
			elseif var_2_4 - var_2_3 < 10 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("dont_send_message_frequently", 10 - (var_2_4 - var_2_3)))
			else
				local var_2_5, var_2_6 = wordVer(arg_2_2, {
					isReplace = true
				})

				if arg_2_1 == ChatConst.ChannelWorld then
					self:sendNotification(GAME.SEND_MSG, var_2_6)
				elseif arg_2_1 == ChatConst.ChannelGuild then
					self:sendNotification(GAME.GUILD_SEND_MSG, var_2_6)
				end

				pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildEmoji(var_2_6))
			end
		end

		return
	end)
	self:bind(NotificationMediator.CHANGE_ROOM, function(arg_4_0, arg_4_1)
		if arg_4_1 == getProxy(PlayerProxy):getRawData().chatRoomId then
			self:onChangeChatRoomDone()
		else
			self:sendNotification(GAME.CHANGE_CHAT_ROOM, arg_4_1)
		end

		return
	end)
	self:bind(NotificationMediator.BATTLE_CHAT_CLOSE, function(arg_5_0)
		self:sendNotification(BattleMediator.CLOSE_CHAT)

		return
	end)
	self:bind(NotificationMediator.OPEN_INFO, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		if arg_6_1.id == var_1_0.id then
			return
		end

		self.contextData.pos = arg_6_2
		self.contextData.msg = arg_6_3

		self:sendNotification(GAME.FRIEND_SEARCH, {
			type = SearchFriendCommand.SEARCH_TYPE_RESUME,
			keyword = arg_6_1.id
		})

		return
	end)
	self:bind(NotificationMediator.OPEN_EMOJI, function(arg_7_0, arg_7_1, arg_7_2)
		self:addSubLayers(Context.New({
			viewComponent = EmojiLayer,
			mediator = EmojiMediator,
			data = {
				callback = arg_7_1,
				pos = arg_7_2,
				groupName = self.viewComponent:getGroupName(),
				emojiIconCallback = function(arg_8_0)
					self.viewComponent:insertEmojiToInputText(arg_8_0)

					return
				end
			}
		}), true)

		return
	end)

	return
end

function NotificationMediator:listNotificationInterests()
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

function NotificationMediator:handleNotification(arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()

	if var_10_0 == ChatProxy.NEW_MSG or var_10_0 == FriendProxy.FRIEND_NEW_MSG or var_10_0 == GuildProxy.NEW_MSG_ADDED then
		local var_10_2 = self.viewComponent.messages

		table.insert(self.viewComponent.messages, var_10_1)
		self.viewComponent:setMessages(var_10_2)

		if NotificationLayer.ChannelBits.recv == bit.lshift(1, ChatConst.ChannelAll) or bit.band(NotificationLayer.ChannelBits.recv, bit.lshift(1, var_10_1.type)) > 0 then
			table.insert(self.viewComponent.filteredMessages, var_10_1)
			self.viewComponent:append(var_10_1, -1, true)
		elseif var_10_1.player and var_10_1.player.id == getProxy(PlayerProxy):getRawData().id then
			self.viewComponent.recvTypes:each(function(arg_11_0, arg_11_1)
				if ChatConst.RecvChannels[arg_11_0 + 1] == var_10_1.type then
					triggerButton(arg_11_1)
				end

				return
			end)
		end
	elseif var_10_0 == GAME.SEND_CMD_DONE then
		if string.find(var_10_1, "CMD:into") then
			self.viewComponent:closeView()
		end
	elseif var_10_0 == GAME.CHANGE_CHAT_ROOM_DONE then
		self:onChangeChatRoomDone(var_10_1)
	elseif var_10_0 == GAME.CHAT_ROOM_MAX_NUMBER then
		pg.TipsMgr.GetInstance():ShowTips(i18n("main_notificationMediator_room_max_number"))
	elseif var_10_0 == GAME.FRIEND_SEARCH_DONE then
		if var_10_1.list[1] then
			self:addSubLayers(Context.New({
				viewComponent = FriendInfoLayer,
				mediator = FriendInfoMediator,
				data = {
					friend = var_10_1.list[1],
					pos = self.contextData.pos,
					msg = self.contextData.msg,
					form = self.contextData.form,
					groupName = self.viewComponent:getGroupName()
				}
			}))

			self.contextData.pos = nil
			self.contextData.msg = nil
		end
	elseif var_10_0 == GAME.FINISH_STAGE then
		self.viewComponent:closeView()
	elseif var_10_0 == GAME.GO_WORLD_BOSS_SCENE then
		self.viewComponent:closeView()
	end

	return
end

function NotificationMediator:onChangeChatRoomDone(arg_12_1)
	if self.viewComponent.tempRoomSendBits then
		NotificationLayer.ChannelBits.send = self.viewComponent.tempRoomSendBits
	end

	if self.viewComponent.tempRoomRecvBits then
		NotificationLayer.ChannelBits.recv = self.viewComponent.tempRoomRecvBits
	end

	self.viewComponent:closeChangeRoomPanel()
	self.viewComponent:setMessages((getProxy(NotificationProxy):getAllMessages()))
	self.viewComponent:updateChatChannel()
	self.viewComponent:updateFilter()
	self.viewComponent:updateAll()

	if arg_12_1 then
		self.viewComponent:setPlayer(arg_12_1)
		self.viewComponent:updateRoom()
	end

	return
end

return NotificationMediator
