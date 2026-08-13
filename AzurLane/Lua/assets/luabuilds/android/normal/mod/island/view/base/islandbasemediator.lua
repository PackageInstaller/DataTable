class = var_0_10000

local var_0_0 = "IslandBaseMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.SET_UP = "IslandBaseScene:SET_UP"
var_0_1.SWITCH_MAP = "IslandBaseMediator:SWITCH_MAP"
var_0_1.RECORD_PLAYER_POS = "IslandBaseMediator:RECORD_PLAYER_POS"
var_0_1.ANIMATION_OP = "IslandBaseMediator:ANIMATION_OP"
var_0_1.SEND_CHAT = "IslandBaseMediator:SEND_CHAT"
var_0_1.CHANGE_CHAT_ROOM = "IslandBaseMediator:CHANGE_CHAT_ROOM"
var_0_1.OPEN_FRIEND_INFO = "IslandBaseMediator:OPEN_FRIEND_INFO"
var_0_1.GO_FISHING = "IslandBaseMediator:GO_FISHING"
var_0_1.FISHING_RESULT = "IslandBaseMediator:FISHING_RESULT"
var_0_1.EXCHANGE_LURE = "IslandBaseMediator:EXCHANGE_LURE"
var_0_1.TRADE_OP = "IslandBaseMediator:TRADE_OP"
var_0_1.REQ_TRADE_RANK = "IslandBaseMediator:REQ_TRADE_RANK"
var_0_1.TRADE_INVITATION = "IslandBaseMediator:TRADE_INVITATION"
var_0_1.ENTER_ISLAND = "IslandBaseMediator:ENTER_ISLAND"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.EXCHANGE_LURE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.ISLAND_EXCHANGE_LURE, {
			lureId = arg_2_1,
			fishPointId = arg_2_2,
			callback = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.FISHING_RESULT, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
		local var_3_0 = arg_1_0.viewComponent
		local var_3_1 = var_7.GetIsland(var_3_0)
		local var_3_2 = arg_1_0
		local var_3_3 = var_8.sendNotification

		GAME = var_2_10010

		var_3_3(var_3_2, var_2_10010.ISLAND_FISHING_REUSLT, {
			fishId = arg_3_3,
			fishPointId = arg_3_2,
			weight = arg_3_4,
			cupType = arg_3_5,
			islandId = var_3_1.id,
			op = arg_3_1,
			callback = arg_3_6
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_FISHING, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		local var_4_0 = arg_1_0.viewComponent
		local var_4_1 = var_4.GetIsland(var_4_0)
		local var_4_2 = arg_1_0
		local var_4_3 = var_5.sendNotification

		GAME = var_2_10007

		var_4_3(var_4_2, var_2_10007.ISLAND_GO_FISHING, {
			poolId = arg_4_1,
			baitId = arg_4_2,
			islandId = var_4_1.id,
			callback = arg_4_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ENTER_ISLAND, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.ISLAND_ENTER, {
			id = arg_5_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.TRADE_INVITATION, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = arg_1_0
		local var_6_1 = var_4.sendNotification

		GAME = var_2_10006

		var_6_1(var_6_0, var_2_10006.ISLAND_INVITE_TRADE, {
			list = arg_6_1,
			mapId = arg_6_2,
			price = arg_6_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.REQ_TRADE_RANK, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10004

		var_7_1(var_7_0, var_2_10004.ISLAND_GET_FRIEND_TRADE_RANK, {
			callback = arg_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.TRADE_OP, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_1_0.viewComponent
		local var_8_1 = var_4.GetIsland(var_8_0)
		local var_8_2 = var_4.GetTradeAgency(var_8_1)

		if not var_5.CanPurchase(var_8_2) then
			pg = var_5

			local var_8_3 = var_5.TipsMgr.GetInstance()
			local var_8_4 = var_5.ShowTips

			i18n = var_2_10007

			var_8_4(var_8_3, var_2_10007("island_trade_price_unrefresh"))

			return
		end

		local var_8_5 = arg_1_0
		local var_8_6 = var_5.sendNotification

		GAME = var_2_10007

		var_8_6(var_8_5, var_2_10007.ISLAND_TRADE, {
			islandId = var_4.id,
			op = arg_8_1,
			num = arg_8_2,
			price = arg_8_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_FRIEND_INFO, function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		arg_1_0.friendInfoPosition = arg_9_2
		arg_1_0.friendInfoMsg = arg_9_3

		local var_9_0 = arg_1_0
		local var_9_1 = var_4.sendNotification

		GAME = var_2_10006

		local var_9_2 = var_2_10006.FRIEND_SEARCH
		local var_9_3 = {}

		SearchFriendCommand = var_2_10008
		var_9_3.type = var_2_10008.SEARCH_TYPE_RESUME
		var_9_3.keyword = arg_9_1

		var_9_1(var_9_0, var_9_2, var_9_3)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_CHAT_ROOM, function(arg_10_0, arg_10_1)
		if not arg_10_1 then
			return
		end

		if arg_10_1 <= 0 or arg_10_1 == "" then
			return
		end

		local var_10_0 = arg_1_0
		local var_10_1 = var_2.sendNotification

		GAME = var_2_10004

		var_10_1(var_10_0, var_2_10004.CHANGE_CHAT_ROOM, arg_10_1)

		return
	end)
	arg_1_0:bind(var_0_1.SEND_CHAT, function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = arg_1_0.viewComponent
		local var_11_1 = var_3.GetIsland(var_11_0)
		local var_11_2 = arg_1_0
		local var_11_3 = var_4.sendNotification

		GAME = var_2_10006

		var_11_3(var_11_2, var_2_10006.ISLAND_SEND_CHAT, {
			channel = arg_11_1,
			islandId = var_11_1.id,
			msg = arg_11_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ANIMATION_OP, function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_1_0.viewComponent
		local var_12_1 = var_3.GetIsland(var_12_0)
		local var_12_2 = arg_1_0
		local var_12_3 = var_4.sendNotification

		GAME = var_2_10006

		var_12_3(var_12_2, var_2_10006.ISLAND_ANIMATION_OP, {
			islandId = var_12_1.id,
			targetId = arg_12_1,
			actionId = arg_12_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.SET_UP, function(arg_13_0)
		local var_13_0 = arg_1_0

		var_1.SetUp(var_13_0)

		return
	end)
	arg_1_0:bind(var_0_1.SWITCH_MAP, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_1_0.viewComponent
		local var_14_1 = var_3.GetIsland(var_14_0)
		local var_14_2 = var_3.GetAblityAgency(var_14_1)

		if not var_4.IsUnlockMap(var_14_2, arg_14_1) then
			IslandConst = var_4

			if arg_14_1 ~= var_4.CheaterTavernMapId then
				pg = var_4

				local var_14_3 = var_4.TipsMgr.GetInstance()
				local var_14_4 = var_4.ShowTips

				i18n = var_6

				var_14_4(var_14_3, var_6("island_lock_map_tip"))

				return
			end
		end

		local var_14_5 = arg_1_0
		local var_14_6 = var_4.sendNotification

		GAME = var_6

		var_14_6(var_14_5, var_6.ISLAND_ENTER_MAP, {
			islandId = var_3.id,
			mapId = arg_14_1,
			callback = function()
				pg = var_3_10000

				if var_3_10000.island_world_objects[arg_14_2] then
					BuildVector3 = var_1

					local var_15_0 = var_1(var_0.param.position)

					BuildVector3 = var_2

					local var_15_1 = var_2(var_0.param.rotation)
					local var_15_2 = arg_1_0

					var_3.RecordPlayerPosition(var_15_2, arg_14_1, var_15_0, var_15_1)
				end

				local var_15_3 = arg_1_0

				var_1.SwitchScene(var_15_3, arg_14_1, arg_14_2)

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_1.RECORD_PLAYER_POS, function(arg_16_0)
		_IslandCore = var_2_10001

		if not var_2_10001 then
			return
		end

		_IslandCore = var_2_10001

		local var_16_0 = var_2_10001
		local var_16_1 = var_2_10001.GetController(var_16_0).mapId

		_IslandCore = var_16_0

		if not var_16_0:GetView().player or not var_2._tf then
			return
		end

		local var_16_2, var_16_3 = var_2:LastGroundedPosition()
		local var_16_4 = arg_1_0

		var_5.RecordPlayerPosition(var_16_4, var_16_1, var_16_2, var_16_3)

		return
	end)
	arg_1_0:_register()

	return
end

function var_0_1.RecordPlayerPosition(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	_IslandCore = var_1_10004

	if not var_1_10004 then
		return
	end

	_IslandCore = var_1_10004

	local var_17_0 = var_1_10004:GetController()

	if not var_4.IsSelfIsland(var_17_0) then
		return
	end

	local var_17_1 = arg_17_0
	local var_17_2 = arg_17_0.sendNotification

	GAME = var_1_10006

	local var_17_3 = var_1_10006.ISLAND_RECORD_LAST_EXIT_POS
	local var_17_4 = {}
	local var_17_5 = arg_17_0.viewComponent

	var_17_4.islandId = var_8.GetIsland(var_17_5).id
	var_17_4.mapId = arg_17_1
	var_17_4.position = arg_17_2
	var_17_4.rotation = arg_17_3

	var_17_2(var_17_1, var_17_3, var_17_4)

	return
end

function var_0_1.listNotificationInterests(arg_18_0)
	local var_18_0 = {}

	ChatProxy = var_1_10002
	var_18_0[1] = var_1_10002.NEW_MSG
	FriendProxy = var_2
	var_18_0[2] = var_2.FRIEND_NEW_MSG
	GuildProxy = var_2
	var_18_0[3] = var_2.NEW_MSG_ADDED
	IslandProxy = var_2
	var_18_0[4] = var_2.CHAT_MSG_UPDATE
	GAME = var_2
	var_18_0[5] = var_2.CHANGE_CHAT_ROOM_DONE
	GAME = var_2
	var_18_0[6] = var_2.FRIEND_SEARCH_DONE
	GAME = var_2
	var_18_0[7] = var_2.ON_APPLICATION_PAUSE
	GAME = var_2
	var_18_0[8] = var_2.ISLAND_ON_HOME
	GAME = var_2
	var_18_0[9] = var_2.ISLAND_ON_RECONNECT
	GAME = var_2
	var_18_0[10] = var_2.ISLAND_CORE_STATE_CHANGED
	GAME = var_2
	var_18_0[11] = var_2.ISLAND_TRADE_DONE
	IslandTradegency = var_2
	var_18_0[12] = var_2.WEEK_NUM_UPDATE
	IslandTradegency = var_2
	var_18_0[13] = var_2.INVITE_LIST_UPDATE
	GAME = var_2
	var_18_0[14] = var_2.ISLAND_SELECT_GIFT_DONE
	GAME = var_2
	var_18_0[15] = var_2.PLAY_ROOM_LOAD_MINIGAME_SCENE
	GAME = var_2
	var_18_0[16] = var_2.PLAY_ROOM_ALL_LOAD_OVER
	GAME = var_2
	var_18_0[17] = var_2.PLAY_ROOM_ENTER_LOAD
	PlayRoomProxy = var_2
	var_18_0[18] = var_2.CHAT_MSG_UPDATE
	GAME = var_2
	var_18_0[19] = var_2.OPEN_FRIEND_INFO_DONE

	local var_18_1 = arg_18_0
	local var_18_2 = arg_18_0._listNotificationInterests(var_18_1)

	ipairs = var_18_1

	for iter_18_0, iter_18_1 in var_18_1(var_18_2) do
		table = var_1_10008

		if not var_1_10008.contains(var_18_0, iter_18_1) then
			table = var_1_10008

			var_1_10008.insert(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

function var_0_1.handleNotification(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1:getName()
	local var_19_1 = arg_19_1
	local var_19_2 = arg_19_1.getBody(var_19_1)

	ChatProxy = var_19_1

	if var_19_0 ~= var_19_1.NEW_MSG then
		FriendProxy = var_19_3

		if var_19_0 ~= var_19_3.FRIEND_NEW_MSG then
			GuildProxy = var_19_3

			if var_19_0 ~= var_19_3.NEW_MSG_ADDED then
				IslandProxy = var_19_3

				local var_19_3

				if var_19_0 == var_19_3.CHAT_MSG_UPDATE then
					var_1_10005 = arg_19_0.viewComponent
					var_19_3 = var_19_3.emitCore
					ISLAND_EVT = var_1_10006

					var_19_3(var_1_10005, var_1_10006.CHAT_MSG_UPDATE)

					IslandProxy = var_19_3

					if var_19_0 == var_19_3.CHAT_MSG_UPDATE then
						var_19_3 = var_19_2.islandId
						var_1_10006 = arg_19_0.viewComponent

						if var_19_3 == var_1_10005.GetIsland(var_1_10006).id then
							var_1_10005 = arg_19_0.viewComponent
							var_19_3 = var_19_3.emitCore
							ISLAND_EVT = var_1_10006

							var_19_3(var_1_10005, var_1_10006.SHOW_CHAT_MSG, var_19_2.msg)
						end
					end
				else
					GAME = var_19_3

					local var_19_4

					if var_19_0 == var_19_3.CHANGE_CHAT_ROOM_DONE then
						var_1_10005 = arg_19_0.viewComponent
						var_19_4 = var_19_4.emitCore
						ISLAND_EVT = var_1_10006

						var_19_4(var_1_10005, var_1_10006.CHAT_ROOM_UPDATE)
					else
						GAME = var_19_4

						if var_19_0 == var_19_4.OPEN_FRIEND_INFO_DONE then
							arg_19_0.friendInfoPosition = var_19_2
						else
							GAME = var_4

							local var_19_5

							if var_19_0 == var_4.FRIEND_SEARCH_DONE and var_19_2.list[1] then
								var_19_5 = var_19_2.type
								SearchFriendCommand = var_1_10005

								if var_19_5 == var_1_10005.SEARCH_TYPE_RESUME then
									var_1_10005 = arg_19_0
									var_19_5 = arg_19_0.addSubLayers
									Context = var_1_10006
									var_1_10006 = var_1_10006.New
									var_1_10007 = {}
									IslandFriendInfoLayer = var_1_10008
									var_1_10007.viewComponent = var_1_10008
									FriendInfoMediator = var_1_10008
									var_1_10007.mediator = var_1_10008
									var_1_10007.data = {
										friend = var_19_2.list[1],
										msg = arg_19_0.friendInfoMsg,
										pos = arg_19_0.friendInfoPosition
									}

									var_19_5(var_1_10005, var_1_10006(var_1_10007))

									arg_19_0.friendInfoPosition = nil
									arg_19_0.friendInfoMsg = nil

									goto label_19_0
								end
							end

							GAME = var_19_5

							local var_19_6

							if var_19_0 == var_19_5.ON_APPLICATION_PAUSE then
								if not var_19_2 then
									_IslandCore = var_19_6

									if var_19_6 and not arg_19_0.exitProcessing then
										var_1_10005 = arg_19_0
										var_19_6 = arg_19_0.sendNotification
										GAME = var_1_10006
										var_1_10006 = var_1_10006.ISLAND_RECONNECT
										var_1_10007 = {}
										_IslandCore = var_1_10008

										local var_19_7 = var_1_10008:GetController()

										var_1_10007.islandId = var_1_10008.GetIsland(var_19_7).id

										var_19_6(var_1_10005, var_1_10006, var_1_10007)
									end
								end
							else
								GAME = var_19_6

								local var_19_8

								if var_19_0 == var_19_6.ISLAND_ON_HOME then
									var_1_10005 = arg_19_0.viewComponent
									var_19_8 = var_19_8.emit
									BaseUI = var_1_10006

									var_19_8(var_1_10005, var_1_10006.ON_HOME)
								else
									GAME = var_19_8

									local var_19_9

									if var_19_0 == var_19_8.ISLAND_ON_RECONNECT then
										if arg_19_0.exitProcessing then
											return
										end

										function var_19_9()
											arg_19_0.exitProcessing = true

											local var_20_0 = var_19_2

											_IslandCore = var_1

											local var_20_1 = var_1:GetController()

											var_20_0.id = var_1.GetIsland(var_20_1).id

											local var_20_2 = arg_19_0.viewComponent

											var_0.ExitProcess(var_20_2, "", function()
												arg_19_0.exitProcessing = false

												local var_21_0 = arg_19_0
												local var_21_1 = var_0.sendNotification

												GAME = var_3_10002

												var_21_1(var_21_0, var_3_10002.ISLAND_CHANGE_ENTER, var_19_2)

												return
											end)

											return
										end

										_IslandCore = var_1_10005

										if var_1_10005 then
											_IslandCore = var_1_10005

											local var_19_10 = var_1_10005.state

											IslandCore = var_1_10006

											if var_19_10 == var_1_10006.STATE_INIT_FINISH then
												isa = var_19_10
												_IslandCore = var_6
												IslandMinigameCore = var_1_10007

												if var_19_10(var_6, var_1_10007) then
													local var_19_11 = arg_19_0.viewComponent
													local var_19_12 = var_5.GetIsland(var_19_11)

													var_1_10008 = var_5.GetCheaterTavernAgency(var_19_12)

													var_6.SetIsConnecting(var_1_10008, false)
												end

												var_19_9()

												goto label_19_0
											end
										end

										arg_19_0.coreInitCallback = var_19_9
									else
										GAME = var_19_9

										local var_19_14

										if var_19_0 == var_19_9.ISLAND_SELECT_GIFT_DONE then
											local var_19_13 = arg_19_0.viewComponent

											var_19_14 = var_19_14.HandleAwardDisplay

											local var_19_15 = var_19_2.dropData
											local var_19_16 = var_19_2.callback

											IslandAwardDisplayPage = var_1_10008

											var_19_14(var_19_13, var_19_15, var_19_16, var_1_10008.TYPE_SIGN_GIFT)
										else
											GAME = var_19_14

											if var_19_0 == var_19_14.ISLAND_CORE_STATE_CHANGED then
												IslandCore = var_4

												if var_19_2 == var_4.STATE_INIT_FINISH and arg_19_0.coreInitCallback then
													arg_19_0.coreInitCallback()

													arg_19_0.coreInitCallback = nil
												end
											else
												GAME = var_4

												if var_19_0 == var_4.ISLAND_TRADE_DONE then
													local var_19_17 = arg_19_0.viewComponent

													var_4.HandleAwardDisplay(var_19_17, var_19_2.dropData, var_19_2.callback)
												else
													GAME = var_4

													local var_19_18

													if var_19_0 == var_4.PLAY_ROOM_LOAD_MINIGAME_SCENE then
														var_19_18 = var_19_2.mapId

														local var_19_19 = arg_19_0.viewComponent
														local var_19_20 = var_5.GetIsland(var_19_19)
														local var_19_21 = var_5.GetMapId(var_19_20)

														arg_19_0.isReconected = var_19_2.isReconecting

														if var_19_21 ~= var_19_18 then
															arg_19_0:LoadMiniGameScene(var_19_18)

															arg_19_0.needChangeMap = true
														else
															arg_19_0.needChangeMap = false
															Timer = var_7

															local var_19_22 = var_7.New(function()
																pg = var_2_10000

																local var_22_0 = var_2_10000.m02
																local var_22_1 = var_0.sendNotification

																GAME = var_2_10002

																var_22_1(var_22_0, var_2_10002.PLAY_ROOM_LOAD_SCENE_COMPLETE)

																return
															end, 2, 0)

															var_7.Start(var_19_22)
														end
													else
														GAME = var_19_18

														if var_19_0 == var_19_18.PLAY_ROOM_ALL_LOAD_OVER then
															arg_19_0:ChangeMiniGameScene()
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end

				::label_19_0::

				arg_19_0:_handleNotification(arg_19_1)

				local var_19_23 = arg_19_0.viewComponent

				var_4.emit(var_19_23, var_19_0, var_19_2)

				return
			end
		end
	end
end

function var_0_1.LoadMiniGameScene(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.viewComponent
	local var_23_1 = var_2.GetIsland(var_23_0)

	var_2.SetMapId(var_23_1, arg_23_1)

	_IslandCore = var_3

	local var_23_2 = var_3:GetView()
	local var_23_3 = var_3.GetSubView

	IslandOpView = var_1_10006

	local var_23_4

	if not var_23_3(var_23_2, var_1_10006) or not var_4.showBalance then
		var_23_4 = 0
	end

	IslandMinigameCore = var_1_10006

	local var_23_5 = var_1_10006.New
	local var_23_6 = arg_23_0.viewComponent

	arg_23_0.miniGameCore = var_23_5(var_7.GetPoolMgr(var_23_6), var_2, var_23_4)

	local var_23_7 = arg_23_0.miniGameCore

	var_6.SetIslandViewCoponent(var_23_7, arg_23_0.viewComponent)

	local var_23_8 = arg_23_0.miniGameCore

	var_6.SetIsReconected(var_23_8, arg_23_0.isReconected)

	return
end

function var_0_1.ChangeMiniGameScene(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.SceneAnimMgr.GetInstance()

	var_1.CommonSceneChange(var_24_0, "Dorm3DLoading", function(arg_25_0)
		local var_25_1

		if arg_24_0.needChangeMap then
			local var_25_0 = arg_24_0

			var_25_1.UnloadScene(var_25_0)

			var_25_1 = arg_24_0.miniGameCore
			var_25_1 = _IslandCore
		end

		_IslandCore = var_25_1

		var_25_1:OnChangeMiniGameScene(arg_24_0.needChangeMap, arg_24_0.isReConnected)
		arg_25_0()

		return
	end)

	return
end

function var_0_1.SetUp(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.viewComponent
	local var_26_1 = var_2.GetIsland(var_26_0).mapID
	local var_26_2 = var_2.spawnPointId

	IslandCore = var_1_10005

	local var_26_3 = var_1_10005.New
	local var_26_4 = arg_26_0.viewComponent
	local var_26_5 = var_26_3(var_6.GetPoolMgr(var_26_4), var_2, arg_26_1)
	local var_26_6 = _IslandCore
	local var_26_7 = arg_26_0.viewComponent

	var_5.OnSetUpCore(var_26_7, var_26_1, var_26_2)

	return
end

function var_0_1.SwitchScene(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.viewComponent
	local var_27_1 = var_3.GetIsland(var_27_0)

	var_3.SetMapId(var_27_1, arg_27_1)

	if arg_27_2 then
		var_3:SetSpawnPointId(arg_27_2)
	end

	local var_27_2 = arg_27_0:UnloadScene()

	arg_27_0:SetUp(var_27_2)

	return
end

function var_0_1.UnloadScene(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.viewComponent

	var_2.OnUnloadScene(var_28_0)

	_IslandCore = var_2

	if var_2 then
		isa = var_2
		_IslandCore = var_28_0
		IslandMinigameCore = var_1_10004

		local var_28_1

		if var_2(var_28_0, var_1_10004) then
			_IslandCore = var_28_1
			var_28_1 = var_28_1.showBalance
			_IslandCore = var_28_0

			var_28_0:Dispose(arg_28_1)

			local var_28_2
			local var_28_3 = _IslandCore

			return var_28_1
		else
			_IslandCore = var_28_1

			local var_28_4 = var_28_1:GetView()
			local var_28_5 = var_2.GetSubView

			IslandOpView = var_1_10005

			local var_28_6

			if not var_28_5(var_28_4, var_1_10005) or not var_3.showBalance then
				var_28_6 = 1
			end

			_IslandCore = var_1_10005

			var_1_10005:Dispose(arg_28_1)

			local var_28_7
			local var_28_8 = _IslandCore

			return var_28_6
		end
	end

	return 1
end

function var_0_1.remove(arg_29_0)
	arg_29_0:UnloadScene(true)
	arg_29_0:_remove()

	IslandHelper = var_1

	var_1.RunGC(true)

	return
end

function var_0_1._register(arg_30_0)
	return
end

function var_0_1._listNotificationInterests(arg_31_0)
	return {}
end

function var_0_1._handleNotification(arg_32_0, arg_32_1)
	return
end

function var_0_1._remove(arg_33_0)
	return
end

return var_0_1
