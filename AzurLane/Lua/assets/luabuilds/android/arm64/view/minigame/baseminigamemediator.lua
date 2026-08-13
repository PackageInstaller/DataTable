class = var_0_10000

local var_0_0 = "BaseMiniGameMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.MINI_GAME_SUCCESS = "BaseMiniGameMediator:MINI_GAME_SUCCESS"
var_0_1.MINI_GAME_FAILURE = "BaseMiniGameMediator:MINI_GAME_FAILURE"
var_0_1.MINI_GAME_OPERATOR = "BaseMiniGameMediator:MINI_GAME_OPERATOR"
var_0_1.OPEN_SUB_LAYER = "BaseMiniGameMediator:OPEN_SUB_LAYER"
var_0_1.MINI_GAME_COIN = "BaseMiniGameMediator:MINI_GAME_COIN"
var_0_1.COIN_WINDOW_CHANGE = "BaseMiniGameMediator:COIN_WINDOW_CHANGE"
var_0_1.GAME_FINISH_TRACKING = "BaseMiniGameMediator:GAME_FINISH_TRACKING"

function var_0_1.register(arg_1_0)
	arg_1_0.miniGameId = arg_1_0.contextData.miniGameId
	getProxy = var_1
	MiniGameProxy = var_1_10003
	arg_1_0.miniGameProxy = var_1(var_1_10003)

	local var_1_0 = arg_1_0.miniGameProxy
	local var_1_1 = var_1.GetHubByGameId(var_1_0, arg_1_0.miniGameId)
	local var_1_2 = arg_1_0.miniGameProxy
	local var_1_3 = var_2.GetMiniGameData(var_1_2, arg_1_0.miniGameId)
	local var_1_4 = arg_1_0.viewComponent

	var_3.SetMGData(var_1_4, var_1_3)

	local var_1_5 = arg_1_0.viewComponent

	var_3.SetMGHubData(var_1_5, var_1_1)

	local var_1_6 = arg_1_0.miniGameProxy

	var_3.RequestInitData(var_1_6, arg_1_0.miniGameId)

	pg = var_3
	arg_1_0.gameRoomId = var_3.mini_game[arg_1_0.miniGameId].game_room

	if arg_1_0.gameRoomId and arg_1_0.gameRoomId > 0 then
		pg = var_3
		arg_1_0.gameRoomData = var_3.game_room_template[arg_1_0.gameRoomId]
		arg_1_0.gameRoonCoinCount = 0

		local var_1_7 = arg_1_0.viewComponent

		var_3.setGameRoomData(var_1_7, arg_1_0.gameRoomData)
	end

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.bind

	BaseMiniGameMediator = var_6

	var_1_9(var_1_8, var_6.MINI_GAME_SUCCESS, function(arg_2_0, ...)
		table = var_2_10001

		local var_2_0 = var_2_10001.contains

		getGameset = var_2_10003

		if var_2_0(var_2_10003("live_streaming26_data1")[2], arg_1_0.miniGameId) then
			pg = var_1

			local var_2_1 = var_1.GameTrackerMgr.GetInstance()
			local var_2_2 = var_1.Record

			GameTrackerBuilder = var_4

			var_2_2(var_2_1, var_4.BuildFushunAdventure())
		end

		local var_2_3 = arg_1_0

		var_1.OnMiniGameSuccess(var_2_3, ...)

		return
	end)

	local var_1_10 = arg_1_0
	local var_1_11 = arg_1_0.bind

	BaseMiniGameMediator = var_6

	var_1_11(var_1_10, var_6.MINI_GAME_FAILURE, function(arg_3_0, ...)
		table = var_2_10001

		local var_3_0 = var_2_10001.contains

		getGameset = var_2_10003

		if var_3_0(var_2_10003("live_streaming26_data1")[2], arg_1_0.miniGameId) then
			pg = var_1

			local var_3_1 = var_1.GameTrackerMgr.GetInstance()
			local var_3_2 = var_1.Record

			GameTrackerBuilder = var_4

			var_3_2(var_3_1, var_4.BuildFushunAdventure())
		end

		local var_3_3 = arg_1_0

		var_1.OnMiniGameFailure(var_3_3, ...)

		return
	end)

	local var_1_12 = arg_1_0
	local var_1_13 = arg_1_0.bind

	BaseMiniGameMediator = var_6

	var_1_13(var_1_12, var_6.MINI_GAME_OPERATOR, function(arg_4_0, ...)
		local var_4_0 = arg_1_0

		var_1.OnMiniGameOPeration(var_4_0, ...)

		return
	end)

	local var_1_14 = arg_1_0
	local var_1_15 = arg_1_0.bind

	BaseMiniGameMediator = var_6

	var_1_15(var_1_14, var_6.OPEN_SUB_LAYER, function(arg_5_0, arg_5_1)
		Context = var_2_10002

		local var_5_0 = var_2_10002.New(arg_5_1)
		local var_5_1 = arg_1_0

		var_3.addSubLayers(var_5_1, var_5_0)

		return
	end)

	local var_1_16 = arg_1_0
	local var_1_17 = arg_1_0.bind

	BaseMiniGameMediator = var_6

	var_1_17(var_1_16, var_6.MINI_GAME_COIN, function(arg_6_0, ...)
		local var_6_0 = arg_1_0

		var_1.loadCoinLayer(var_6_0)

		return
	end)

	local var_1_18 = arg_1_0
	local var_1_19 = arg_1_0.bind

	BaseMiniGameMediator = var_6

	var_1_19(var_1_18, var_6.COIN_WINDOW_CHANGE, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GameRoomCoinMediator = var_2_10005

		var_7_1(var_7_0, var_2_10005.CHANGE_VISIBLE, arg_7_1)

		return
	end)

	local var_1_20 = arg_1_0
	local var_1_21 = arg_1_0.bind

	BaseMiniGameMediator = var_6

	var_1_21(var_1_20, var_6.GAME_FINISH_TRACKING, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_8_2 = var_2_10005.SEND_MINI_GAME_OP
		local var_8_3 = {
			hubid = arg_8_1.hub_id
		}

		MiniGameOPCommand = var_7
		var_8_3.cmd = var_7.CMD_PLAY
		var_8_3.args1 = {
			arg_8_1.game_id,
			arg_8_1.isComplete
		}

		var_8_1(var_8_0, var_8_2, var_8_3)

		return
	end)

	return
end

function var_0_1.onUIAvalible(arg_9_0)
	if arg_9_0.gameRoomData and arg_9_0.gameRoomData.add_base > 0 then
		arg_9_0:loadCoinLayer()
	end

	return
end

function var_0_1.loadCoinLayer(arg_10_0)
	local var_10_0 = arg_10_0.viewComponent

	var_1.setCoinLayer(var_10_0)

	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.addSubLayers

	Context = var_1_10004

	local var_10_3 = var_1_10004.New
	local var_10_4 = {}

	GameRoomCoinMediator = var_1_10007
	var_10_4.mediator = var_1_10007
	GameRoomCoinLayer = var_1_10007
	var_10_4.viewComponent = var_1_10007
	var_10_4.data = arg_10_0.gameRoomData

	var_10_2(var_10_1, var_10_3(var_10_4))

	return
end

function var_0_1.OnMiniGameOPeration(arg_11_0, ...)
	return
end

function var_0_1.OnMiniGameSuccess(arg_12_0, ...)
	return
end

function var_0_1.OnMiniGameFailure(arg_13_0, ...)
	return
end

function var_0_1.listNotificationInterests(arg_14_0)
	local var_14_0 = {}

	MiniGameProxy = var_1_10002
	var_14_0[1] = var_1_10002.ON_HUB_DATA_UPDATE
	GAME = var_2
	var_14_0[2] = var_2.SEND_MINI_GAME_OP_DONE
	GAME = var_2
	var_14_0[3] = var_2.MODIFY_MINI_GAME_DATA_DONE
	GAME = var_2
	var_14_0[4] = var_2.ON_APPLICATION_PAUSE
	GAME = var_2
	var_14_0[5] = var_2.GAME_COIN_COUNT_CHANGE
	GAME = var_2
	var_14_0[6] = var_2.GAME_ROOM_AWARD_DONE
	ActivityProxy = var_2
	var_14_0[7] = var_2.ACTIVITY_SHOW_AWARDS

	return var_14_0
end

function var_0_1.handleNotification(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1
	local var_15_1 = arg_15_1.getName(var_15_0)
	local var_15_2 = arg_15_1:getBody()

	MiniGameProxy = var_15_0

	if var_15_1 == var_15_0.ON_HUB_DATA_UPDATE then
		var_1_10006 = arg_15_0.viewComponent

		var_4.SetMGHubData(var_1_10006, var_15_2)
	else
		GAME = var_4

		local var_15_3

		if var_15_1 == var_4.SEND_MINI_GAME_OP_DONE then
			var_15_3 = {
				function(arg_16_0)
					if #var_15_2.awards > 0 then
						local var_16_0 = arg_15_0.viewComponent
						local var_16_1 = var_2.emit

						BaseUI = var_2_10005

						var_16_1(var_16_0, var_2_10005.ON_ACHIEVE, var_1, arg_16_0)
					else
						arg_16_0()
					end

					return
				end,
				function(arg_17_0)
					local var_17_0 = arg_15_0.viewComponent

					var_1.OnGetAwardDone(var_17_0, var_15_2)
					arg_17_0()

					return
				end
			}
			seriesAsync = var_5

			var_5(var_15_3)

			var_1_10007 = arg_15_0.viewComponent

			var_5.OnSendMiniGameOPDone(var_1_10007, var_15_2)
		else
			GAME = var_15_3

			if var_15_1 == var_15_3.MODIFY_MINI_GAME_DATA_DONE then
				var_1_10006 = arg_15_0.viewComponent

				var_4.OnModifyMiniGameDataDone(var_1_10006, var_15_2)
			else
				GAME = var_4

				if var_15_1 == var_4.ON_APPLICATION_PAUSE then
					var_1_10006 = arg_15_0.viewComponent

					var_4.OnApplicationPaused(var_1_10006, var_15_2)
				else
					GAME = var_4

					if var_15_1 == var_4.GAME_COIN_COUNT_CHANGE then
						arg_15_0.gameRoonCoinCount = var_15_2
					else
						GAME = var_4

						local var_15_4

						if var_15_1 == var_4.GAME_ROOM_AWARD_DONE then
							if #var_15_2 > 0 then
								var_1_10006 = arg_15_0.viewComponent
								var_15_4 = var_15_4.emit
								BaseUI = var_1_10007

								var_15_4(var_1_10006, var_1_10007.ON_ACHIEVE, var_15_2)

								var_1_10006 = arg_15_0.viewComponent

								var_15_4.OnGetAwardDone(var_1_10006, var_15_2)
							end
						else
							ActivityProxy = var_15_4

							if var_15_1 == var_15_4.ACTIVITY_SHOW_AWARDS then
								getProxy = var_4
								ContextProxy = var_1_10006

								local var_15_5 = var_4(var_1_10006)
								local var_15_6 = var_4.getContextByMediator

								ActivityMediator = var_1_10007

								if var_15_6(var_15_5, var_1_10007) then
									return
								end

								local var_15_7 = arg_15_0.viewComponent
								local var_15_8 = var_5.emit

								BaseUI = var_1_10008

								var_15_8(var_15_7, var_1_10008.ON_ACHIEVE, var_15_2.awards, var_15_2.callback)
							end
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
