class = var_0_10000

local var_0_0 = "NotificationMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_SEND_PUBLIC = "NotificationMediator:ON_SEND_PUBLIC"
var_0_1.CHANGE_ROOM = "NotificationMediator:CHANGE_ROOM"
var_0_1.OPEN_INFO = "NotificationMediator:OPEN_INFO"
var_0_1.OPEN_EMOJI = "NotificationMediator:OPEN_EMOJI"
var_0_1.BATTLE_CHAT_CLOSE = "NotificationMediator:BATTLE_CHAT_CLOSE"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getRawData(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_3.setPlayer(var_1_2, var_1_1)

	getProxy = var_3
	GuildProxy = var_1_2

	local var_1_3 = var_3(var_1_2)
	local var_1_4 = arg_1_0.viewComponent

	var_4.setInGuild(var_1_4, var_1_3:getRawData() ~= nil)

	getProxy = var_4
	NotificationProxy = var_1_4

	local var_1_5 = var_4(var_1_4)
	local var_1_6 = var_4.getAllMessages(var_1_5)
	local var_1_7 = arg_1_0.viewComponent

	var_5.setMessages(var_1_7, var_1_6)
	arg_1_0:bind(var_0_1.ON_SEND_PUBLIC, function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_2 == "$ rndsec refresh" then
			Application = var_2_10003

			if var_2_10003.isEditor then
				MainRandomFlagShipSequence = var_2_10003

				var_2_10003.ForceRandom()

				goto label_2_0
			end
		end

		if arg_2_2 == "$ force gc" then
			gcAll = var_2_10003

			var_2_10003(true)
		else
			if arg_2_2:match("%$ rndskin print %d+") then
				Application = var_3

				if var_3.isEditor then
					string = var_3

					local var_2_0 = var_3.gmatch(arg_2_2, "%d+")

					MainRandomFlagShipSequence = var_2_10004

					local var_2_1 = var_2_10004.CalcRatio

					tonumber = var_6

					var_2_1(var_6(var_2_0()), function(arg_3_0)
						local var_3_0 = {
							richText = true
						}

						getProxy = var_3_10002
						PlayerProxy = var_3_10004

						local var_3_1 = var_3_10002(var_3_10004)

						var_3_0.player = var_2.getData(var_3_1)
						var_3_0.content = arg_3_0
						pg = var_2

						local var_3_2 = var_2.TimeMgr.GetInstance()

						var_3_0.timestamp = var_2.GetServerTime(var_3_2)
						getProxy = var_2
						ChatProxy = var_3_2

						local var_3_3 = var_2(var_3_2)
						local var_3_4 = var_2.addNewMsg

						ChatMsg = var_3_10005

						local var_3_5 = var_3_10005.New

						ChatConst = var_3_10007

						var_3_4(var_3_3, var_3_5(var_3_10007.ChannelWorld, var_3_0))

						return
					end)

					goto label_2_0
				end
			end

			if arg_2_2:match("^%$ battletest") then
				local var_2_2 = arg_1_0
				local var_2_3 = var_3.sendNotification

				NewMainMediator = var_6

				var_2_3(var_2_2, var_6.DEBUG_BATTLE_LOOP, arg_2_2)
			else
				local var_2_4 = arg_2_2
				local var_2_5

				if arg_2_2.match(var_2_4, "^%$ %S+") then
					var_2_5 = {}

					for iter_2_0, iter_2_1 in arg_2_2:gmatch("%s+(%S+)") do
						table = var_2_10009

						var_2_10009.insert(var_2_5, iter_2_0)
					end

					local var_2_6 = arg_1_0
					local var_2_7 = var_4.sendNotification

					GAME = iter_2_0

					var_2_7(var_2_6, iter_2_0.SEND_CMD, {
						cmd = var_2_5[1],
						arg1 = var_2_5[2],
						arg2 = var_2_5[3],
						arg3 = var_2_5[4],
						arg4 = var_2_5[5]
					})
				elseif arg_2_2 == "world battle skip" then
					switch_world_skip_battle = var_2_5

					var_2_5()
				else
					pg = var_2_5

					if arg_2_2 == var_2_5.gameset.code_switch.description then
						getProxy = var_3
						PlayerProxy = var_2_4

						local var_2_8 = var_3(var_2_4)

						if var_3.getRawData(var_2_8).level >= 9 then
							HXSet = var_2_4

							var_2_4.switchCodeMode()
						end
					else
						getProxy = var_3
						PlayerProxy = var_2_4

						local var_2_9 = var_3(var_2_4)
						local var_2_10 = var_3.getData(var_2_9)

						getProxy = var_2_4
						ChatProxy = iter_2_0

						local var_2_11 = var_2_4(iter_2_0)
						local var_2_12 = var_5.getData(var_2_11)
						local var_2_13 = 0

						for iter_2_2 = #var_2_12, 1, -1 do
							var_2_10012 = var_2_12[iter_2_2].type
							ChatConst = var_2_10013

							if var_2_10012 == var_2_10013.ChannelWorld and var_2_12[iter_2_2].player.id == var_2_10.id then
								var_2_13 = var_2_12[iter_2_2].timestamp

								break
							end
						end

						pg = var_8

						local var_2_14 = var_8.TimeMgr.GetInstance()
						local var_2_15

						if var_8.GetServerTime(var_2_14) < var_2_10.chatMsgBanTime then
							os = var_2_15
							var_2_15 = var_2_15.date("%Y/%m/%d %H:%M:%S", var_2_10.chatMsgBanTime)
							pg = var_2_14
							var_2_10012 = var_2_14.MsgboxMgr.GetInstance()
							var_2_14 = var_2_14.ShowMsgBox
							var_2_10013 = {
								hideNo = true
							}
							i18n = var_2_10014
							var_2_10013.content = var_2_10014("chat_msg_ban", var_2_15)

							var_2_14(var_2_10012, var_2_10013)
						else
							PLATFORM_CODE = var_2_15
							PLATFORM_CH = var_2_14

							if var_2_15 == var_2_14 then
								LuaHelper = var_2_15

								local var_2_16 = var_2_15.GetCHPackageType()

								PACKAGE_TYPE_BILI = var_2_14

								if var_2_16 ~= var_2_14 and var_2_10.level < 70 then
									pg = var_9

									local var_2_17 = var_9.TipsMgr.GetInstance()
									local var_2_18 = var_9.ShowTips

									i18n = var_2_10012

									var_2_18(var_2_17, var_2_10012("chat_level_not_enough", 70))

									goto label_2_0
								end
							end

							if var_2_10.level < 10 then
								pg = var_9

								local var_2_19 = var_9.TipsMgr.GetInstance()
								local var_2_20 = var_9.ShowTips

								i18n = var_2_10012

								var_2_20(var_2_19, var_2_10012("chat_level_not_enough", 10))
							else
								local var_2_21

								if var_8 - var_2_13 < 10 then
									var_2_21 = 10 - (var_8 - var_2_13)
									pg = var_10

									local var_2_22 = var_10.TipsMgr.GetInstance()
									local var_2_23 = var_10.ShowTips

									i18n = var_2_10013

									var_2_23(var_2_22, var_2_10013("dont_send_message_frequently", var_2_21))
								else
									wordVer = var_2_21

									local var_2_24, var_2_25 = var_2_21(arg_2_2, {
										isReplace = true
									})

									ChatConst = var_11

									local var_2_27

									if arg_2_1 == var_11.ChannelWorld then
										local var_2_26 = arg_1_0

										var_2_27 = var_2_27.sendNotification
										GAME = var_2_10014

										var_2_27(var_2_26, var_2_10014.SEND_MSG, var_2_25)
									else
										ChatConst = var_2_27

										if arg_2_1 == var_2_27.ChannelGuild then
											local var_2_28 = arg_1_0

											var_2_27 = var_2_27.sendNotification
											GAME = var_2_10014

											var_2_27(var_2_28, var_2_10014.GUILD_SEND_MSG, var_2_25)
										end
									end

									pg = var_2_27

									local var_2_29 = var_2_27.GameTrackerMgr.GetInstance()
									local var_2_30 = var_11.Record

									GameTrackerBuilder = var_2_10014

									var_2_30(var_2_29, var_2_10014.BuildEmoji(var_2_25))
								end
							end
						end
					end
				end
			end
		end

		::label_2_0::

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_ROOM, function(arg_4_0, arg_4_1)
		getProxy = var_2_10002
		PlayerProxy = var_2_10004

		local var_4_0 = var_2_10002(var_2_10004)

		if arg_4_1 == var_2.getRawData(var_4_0).chatRoomId then
			local var_4_1 = arg_1_0

			var_4.onChangeChatRoomDone(var_4_1)
		else
			local var_4_2 = arg_1_0
			local var_4_3 = var_4.sendNotification

			GAME = var_2_10007

			var_4_3(var_4_2, var_2_10007.CHANGE_CHAT_ROOM, arg_4_1)
		end

		return
	end)
	arg_1_0:bind(var_0_1.BATTLE_CHAT_CLOSE, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.sendNotification

		BattleMediator = var_2_10004

		var_5_1(var_5_0, var_2_10004.CLOSE_CHAT)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_INFO, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		if arg_6_1.id == var_1_1.id then
			return
		end

		arg_1_0.contextData.pos = arg_6_2
		arg_1_0.contextData.msg = arg_6_3

		local var_6_0 = arg_1_0
		local var_6_1 = var_4.sendNotification

		GAME = var_2_10007

		local var_6_2 = var_2_10007.FRIEND_SEARCH
		local var_6_3 = {}

		SearchFriendCommand = var_2_10009
		var_6_3.type = var_2_10009.SEARCH_TYPE_RESUME
		var_6_3.keyword = arg_6_1.id

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_EMOJI, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0
		local var_7_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_7_2 = var_2_10006.New
		local var_7_3 = {}

		EmojiLayer = var_2_10009
		var_7_3.viewComponent = var_2_10009
		EmojiMediator = var_2_10009
		var_7_3.mediator = var_2_10009

		local var_7_4 = {
			callback = arg_7_1,
			pos = arg_7_2
		}
		local var_7_5 = arg_1_0.viewComponent

		var_7_4.groupName = var_10.getGroupName(var_7_5)

		function var_7_4.emojiIconCallback(arg_8_0)
			local var_8_0 = arg_1_0.viewComponent

			var_1.insertEmojiToInputText(var_8_0, arg_8_0)

			return
		end

		var_7_3.data = var_7_4

		var_7_1(var_7_0, var_7_2(var_7_3), true)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_9_0)
	local var_9_0 = {}

	GAME = var_1_10002
	var_9_0[1] = var_1_10002.SEND_CMD_DONE
	ChatProxy = var_2
	var_9_0[2] = var_2.NEW_MSG
	GAME = var_2
	var_9_0[3] = var_2.CHANGE_CHAT_ROOM_DONE
	GAME = var_2
	var_9_0[4] = var_2.CHAT_ROOM_MAX_NUMBER
	GAME = var_2
	var_9_0[5] = var_2.FRIEND_SEARCH_DONE
	GAME = var_2
	var_9_0[6] = var_2.FINISH_STAGE
	FriendProxy = var_2
	var_9_0[7] = var_2.FRIEND_NEW_MSG
	GuildProxy = var_2
	var_9_0[8] = var_2.NEW_MSG_ADDED
	GAME = var_2
	var_9_0[9] = var_2.GO_WORLD_BOSS_SCENE

	return var_9_0
end

function var_0_1.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1
	local var_10_1 = arg_10_1.getName(var_10_0)
	local var_10_2 = arg_10_1
	local var_10_3 = arg_10_1.getBody(var_10_2)

	ChatProxy = var_10_0

	if var_10_1 ~= var_10_0.NEW_MSG then
		FriendProxy = var_10_4

		if var_10_1 ~= var_10_4.FRIEND_NEW_MSG then
			GuildProxy = var_10_4

			if var_10_1 == var_10_4.NEW_MSG_ADDED then
				local var_10_4 = arg_10_0.viewComponent.messages

				table = var_10_2

				var_10_2.insert(var_10_4, var_10_3)

				var_1_10007 = arg_10_0.viewComponent

				var_5.setMessages(var_1_10007, var_10_4)

				getProxy = var_5
				PlayerProxy = var_1_10007

				local var_10_5 = var_5(var_1_10007)
				local var_10_6 = var_5.getRawData(var_10_5)

				NotificationLayer = var_1_10007
				var_1_10007 = var_1_10007.ChannelBits.recv
				bit = var_10_5

				local var_10_7 = var_10_5.lshift

				var_1_10010 = 1
				ChatConst = var_1_10011

				if var_1_10007 ~= var_10_7(var_1_10010, var_1_10011.ChannelAll) then
					bit = var_10_8

					local var_10_8 = var_10_8.band

					var_1_10010 = var_1_10007
					bit = var_11

					if var_10_8(var_1_10010, var_11.lshift(1, var_10_3.type)) > 0 then
						table = var_10_8

						var_10_8.insert(arg_10_0.viewComponent.filteredMessages, var_10_3)

						var_1_10010 = arg_10_0.viewComponent

						var_8.append(var_1_10010, var_10_3, -1, true)
					elseif var_10_3.player and var_10_3.player.id == var_10_6.id then
						var_1_10010 = arg_10_0.viewComponent.recvTypes

						var_8.each(var_1_10010, function(arg_11_0, arg_11_1)
							ChatConst = var_2_10002

							if var_2_10002.RecvChannels[arg_11_0 + 1] == var_10_3.type then
								triggerButton = var_2

								var_2(arg_11_1)
							end

							return
						end)
					end

					if false then
						GAME = var_10_4

						if var_10_1 == var_10_4.SEND_CMD_DONE then
							string = var_4

							if var_4.find(var_10_3, "CMD:into") then
								local var_10_9 = arg_10_0.viewComponent

								var_4.closeView(var_10_9)
							end
						else
							GAME = var_4

							if var_10_1 == var_4.CHANGE_CHAT_ROOM_DONE then
								arg_10_0:onChangeChatRoomDone(var_10_3)
							else
								GAME = var_4

								local var_10_11

								if var_10_1 == var_4.CHAT_ROOM_MAX_NUMBER then
									pg = var_10_11

									local var_10_10 = var_10_11.TipsMgr.GetInstance()

									var_10_11 = var_10_11.ShowTips
									i18n = var_1_10007

									var_10_11(var_10_10, var_1_10007("main_notificationMediator_room_max_number"))
								else
									GAME = var_10_11

									local var_10_13

									if var_10_1 == var_10_11.FRIEND_SEARCH_DONE then
										if var_10_3.list[1] then
											local var_10_12 = arg_10_0

											var_10_13 = arg_10_0.addSubLayers
											Context = var_1_10007

											local var_10_14 = var_1_10007.New
											local var_10_15 = {}

											FriendInfoLayer = var_1_10010
											var_10_15.viewComponent = var_1_10010
											FriendInfoMediator = var_1_10010
											var_10_15.mediator = var_1_10010

											local var_10_16 = {
												friend = var_10_3.list[1],
												pos = arg_10_0.contextData.pos,
												msg = arg_10_0.contextData.msg,
												form = arg_10_0.contextData.form
											}
											local var_10_17 = arg_10_0.viewComponent

											var_10_16.groupName = var_11.getGroupName(var_10_17)
											var_10_15.data = var_10_16

											var_10_13(var_10_12, var_10_14(var_10_15))

											var_10_13 = arg_10_0.contextData
											var_10_13.pos = nil
											var_10_13 = arg_10_0.contextData
											var_10_13.msg = nil
										end
									else
										GAME = var_10_13

										if var_10_1 == var_10_13.FINISH_STAGE then
											local var_10_18 = arg_10_0.viewComponent

											var_4.closeView(var_10_18)
										else
											GAME = var_4

											if var_10_1 == var_4.GO_WORLD_BOSS_SCENE then
												local var_10_19 = arg_10_0.viewComponent

												var_4.closeView(var_10_19)
											end
										end
									end
								end
							end
						end
					end

					return
				end
			end
		end
	end
end

function var_0_1.onChangeChatRoomDone(arg_12_0, arg_12_1)
	if arg_12_0.viewComponent.tempRoomSendBits then
		NotificationLayer = var_2
		var_2.ChannelBits.send = arg_12_0.viewComponent.tempRoomSendBits
	end

	if arg_12_0.viewComponent.tempRoomRecvBits then
		NotificationLayer = var_2
		var_2.ChannelBits.recv = arg_12_0.viewComponent.tempRoomRecvBits
	end

	local var_12_0 = arg_12_0.viewComponent

	var_2.closeChangeRoomPanel(var_12_0)

	getProxy = var_2
	NotificationProxy = var_12_0

	local var_12_1 = var_2(var_12_0)
	local var_12_2 = var_2.getAllMessages(var_12_1)
	local var_12_3 = arg_12_0.viewComponent

	var_3.setMessages(var_12_3, var_12_2)

	local var_12_4 = arg_12_0.viewComponent

	var_3.updateChatChannel(var_12_4)

	local var_12_5 = arg_12_0.viewComponent

	var_3.updateFilter(var_12_5)

	local var_12_6 = arg_12_0.viewComponent

	var_3.updateAll(var_12_6)

	if arg_12_1 then
		local var_12_7 = arg_12_0.viewComponent

		var_3.setPlayer(var_12_7, arg_12_1)

		local var_12_8 = arg_12_0.viewComponent

		var_3.updateRoom(var_12_8)
	end

	return
end

return var_0_1
