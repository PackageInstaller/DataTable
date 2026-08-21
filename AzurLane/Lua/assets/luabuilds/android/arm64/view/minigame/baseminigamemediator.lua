local var_0_0 = class("BaseMiniGameMediator", import("..base.ContextMediator"))

var_0_0.MINI_GAME_SUCCESS = "BaseMiniGameMediator:MINI_GAME_SUCCESS"
var_0_0.MINI_GAME_FAILURE = "BaseMiniGameMediator:MINI_GAME_FAILURE"
var_0_0.MINI_GAME_OPERATOR = "BaseMiniGameMediator:MINI_GAME_OPERATOR"
var_0_0.OPEN_SUB_LAYER = "BaseMiniGameMediator:OPEN_SUB_LAYER"
var_0_0.MINI_GAME_COIN = "BaseMiniGameMediator:MINI_GAME_COIN"
var_0_0.COIN_WINDOW_CHANGE = "BaseMiniGameMediator:COIN_WINDOW_CHANGE"
var_0_0.GAME_FINISH_TRACKING = "BaseMiniGameMediator:GAME_FINISH_TRACKING"

function var_0_0.register(arg_1_0)
	arg_1_0.miniGameId = arg_1_0.contextData.miniGameId
	arg_1_0.miniGameProxy = getProxy(MiniGameProxy)

	arg_1_0.viewComponent:SetMGData((arg_1_0.miniGameProxy:GetMiniGameData(arg_1_0.miniGameId)))
	arg_1_0.viewComponent:SetMGHubData((arg_1_0.miniGameProxy:GetHubByGameId(arg_1_0.miniGameId)))
	arg_1_0.miniGameProxy:RequestInitData(arg_1_0.miniGameId)

	arg_1_0.gameRoomId = pg.mini_game[arg_1_0.miniGameId].game_room

	if arg_1_0.gameRoomId and arg_1_0.gameRoomId > 0 then
		arg_1_0.gameRoomData = pg.game_room_template[arg_1_0.gameRoomId]
		arg_1_0.gameRoonCoinCount = 0

		arg_1_0.viewComponent:setGameRoomData(arg_1_0.gameRoomData)
	end

	arg_1_0:bind(BaseMiniGameMediator.MINI_GAME_SUCCESS, function(arg_2_0, ...)
		if table.contains(getGameset("live_streaming26_data1")[2], arg_1_0.miniGameId) then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildFushunAdventure())
		end

		arg_1_0:OnMiniGameSuccess(...)

		return
	end)
	arg_1_0:bind(BaseMiniGameMediator.MINI_GAME_FAILURE, function(arg_3_0, ...)
		if table.contains(getGameset("live_streaming26_data1")[2], arg_1_0.miniGameId) then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildFushunAdventure())
		end

		arg_1_0:OnMiniGameFailure(...)

		return
	end)
	arg_1_0:bind(BaseMiniGameMediator.MINI_GAME_OPERATOR, function(arg_4_0, ...)
		arg_1_0:OnMiniGameOPeration(...)

		return
	end)
	arg_1_0:bind(BaseMiniGameMediator.OPEN_SUB_LAYER, function(arg_5_0, arg_5_1)
		arg_1_0:addSubLayers((Context.New(arg_5_1)))

		return
	end)
	arg_1_0:bind(BaseMiniGameMediator.MINI_GAME_COIN, function(arg_6_0, ...)
		arg_1_0:loadCoinLayer()

		return
	end)
	arg_1_0:bind(BaseMiniGameMediator.COIN_WINDOW_CHANGE, function(arg_7_0, arg_7_1)
		arg_1_0:sendNotification(GameRoomCoinMediator.CHANGE_VISIBLE, arg_7_1)

		return
	end)
	arg_1_0:bind(BaseMiniGameMediator.GAME_FINISH_TRACKING, function(arg_8_0, arg_8_1)
		arg_1_0:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_8_1.hub_id,
			cmd = MiniGameOPCommand.CMD_PLAY,
			args1 = {
				arg_8_1.game_id,
				arg_8_1.isComplete
			}
		})

		return
	end)

	return
end

function var_0_0.onUIAvalible(arg_9_0)
	if arg_9_0.gameRoomData and arg_9_0.gameRoomData.add_base > 0 then
		arg_9_0:loadCoinLayer()
	end

	return
end

function var_0_0.loadCoinLayer(arg_10_0)
	arg_10_0.viewComponent:setCoinLayer()
	arg_10_0:addSubLayers(Context.New({
		mediator = GameRoomCoinMediator,
		viewComponent = GameRoomCoinLayer,
		data = arg_10_0.gameRoomData
	}))

	return
end

function var_0_0.OnMiniGameOPeration(arg_11_0, ...)
	return
end

function var_0_0.OnMiniGameSuccess(arg_12_0, ...)
	return
end

function var_0_0.OnMiniGameFailure(arg_13_0, ...)
	return
end

function var_0_0.listNotificationInterests(arg_14_0)
	return {
		MiniGameProxy.ON_HUB_DATA_UPDATE,
		GAME.SEND_MINI_GAME_OP_DONE,
		GAME.MODIFY_MINI_GAME_DATA_DONE,
		GAME.ON_APPLICATION_PAUSE,
		GAME.GAME_COIN_COUNT_CHANGE,
		GAME.GAME_ROOM_AWARD_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	}
end

function var_0_0.handleNotification(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:getName()
	local var_15_1 = arg_15_1:getBody()

	if var_15_0 == MiniGameProxy.ON_HUB_DATA_UPDATE then
		arg_15_0.viewComponent:SetMGHubData(var_15_1)
	elseif var_15_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_16_0)
				if #var_15_1.awards > 0 then
					arg_15_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_15_1.awards, arg_16_0)
				else
					arg_16_0()
				end

				return
			end,
			function(arg_17_0)
				arg_15_0.viewComponent:OnGetAwardDone(var_15_1)
				arg_17_0()

				return
			end
		})
		arg_15_0.viewComponent:OnSendMiniGameOPDone(var_15_1)
	elseif var_15_0 == GAME.MODIFY_MINI_GAME_DATA_DONE then
		arg_15_0.viewComponent:OnModifyMiniGameDataDone(var_15_1)
	elseif var_15_0 == GAME.ON_APPLICATION_PAUSE then
		arg_15_0.viewComponent:OnApplicationPaused(var_15_1)
	elseif var_15_0 == GAME.GAME_COIN_COUNT_CHANGE then
		arg_15_0.gameRoonCoinCount = var_15_1
	elseif var_15_0 == GAME.GAME_ROOM_AWARD_DONE then
		if #var_15_1 > 0 then
			arg_15_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_15_1)
			arg_15_0.viewComponent:OnGetAwardDone(var_15_1)
		end
	elseif var_15_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		if getProxy(ContextProxy):getContextByMediator(ActivityMediator) then
			return
		end

		arg_15_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_15_1.awards, var_15_1.callback)
	end

	return
end

return var_0_0
