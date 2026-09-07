local BaseMiniGameMediator = class("BaseMiniGameMediator", import("..base.ContextMediator"))

BaseMiniGameMediator.MINI_GAME_SUCCESS = "BaseMiniGameMediator:MINI_GAME_SUCCESS"
BaseMiniGameMediator.MINI_GAME_FAILURE = "BaseMiniGameMediator:MINI_GAME_FAILURE"
BaseMiniGameMediator.MINI_GAME_OPERATOR = "BaseMiniGameMediator:MINI_GAME_OPERATOR"
BaseMiniGameMediator.OPEN_SUB_LAYER = "BaseMiniGameMediator:OPEN_SUB_LAYER"
BaseMiniGameMediator.MINI_GAME_COIN = "BaseMiniGameMediator:MINI_GAME_COIN"
BaseMiniGameMediator.COIN_WINDOW_CHANGE = "BaseMiniGameMediator:COIN_WINDOW_CHANGE"
BaseMiniGameMediator.GAME_FINISH_TRACKING = "BaseMiniGameMediator:GAME_FINISH_TRACKING"

function BaseMiniGameMediator:register()
	self.miniGameId = self.contextData.miniGameId
	self.miniGameProxy = getProxy(MiniGameProxy)

	self.viewComponent:SetMGData((self.miniGameProxy:GetMiniGameData(self.miniGameId)))
	self.viewComponent:SetMGHubData((self.miniGameProxy:GetHubByGameId(self.miniGameId)))
	self.miniGameProxy:RequestInitData(self.miniGameId)

	self.gameRoomId = pg.mini_game[self.miniGameId].game_room

	if self.gameRoomId and self.gameRoomId > 0 then
		self.gameRoomData = pg.game_room_template[self.gameRoomId]
		self.gameRoonCoinCount = 0

		self.viewComponent:setGameRoomData(self.gameRoomData)
	end

	self:bind(BaseMiniGameMediator.MINI_GAME_SUCCESS, function(arg_2_0, ...)
		if table.contains(getGameset("live_streaming26_data1")[2], self.miniGameId) then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildFushunAdventure())
		end

		self:OnMiniGameSuccess(...)

		return
	end)
	self:bind(BaseMiniGameMediator.MINI_GAME_FAILURE, function(arg_3_0, ...)
		if table.contains(getGameset("live_streaming26_data1")[2], self.miniGameId) then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildFushunAdventure())
		end

		self:OnMiniGameFailure(...)

		return
	end)
	self:bind(BaseMiniGameMediator.MINI_GAME_OPERATOR, function(arg_4_0, ...)
		self:OnMiniGameOPeration(...)

		return
	end)
	self:bind(BaseMiniGameMediator.OPEN_SUB_LAYER, function(arg_5_0, arg_5_1)
		self:addSubLayers((Context.New(arg_5_1)))

		return
	end)
	self:bind(BaseMiniGameMediator.MINI_GAME_COIN, function(arg_6_0, ...)
		self:loadCoinLayer()

		return
	end)
	self:bind(BaseMiniGameMediator.COIN_WINDOW_CHANGE, function(arg_7_0, arg_7_1)
		self:sendNotification(GameRoomCoinMediator.CHANGE_VISIBLE, arg_7_1)

		return
	end)
	self:bind(BaseMiniGameMediator.GAME_FINISH_TRACKING, function(arg_8_0, arg_8_1)
		self:sendNotification(GAME.SEND_MINI_GAME_OP, {
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

function BaseMiniGameMediator:onUIAvalible()
	if self.gameRoomData and self.gameRoomData.add_base > 0 then
		self:loadCoinLayer()
	end

	return
end

function BaseMiniGameMediator:loadCoinLayer()
	self.viewComponent:setCoinLayer()
	self:addSubLayers(Context.New({
		mediator = GameRoomCoinMediator,
		viewComponent = GameRoomCoinLayer,
		data = self.gameRoomData
	}))

	return
end

function BaseMiniGameMediator:OnMiniGameOPeration(...)
	return
end

function BaseMiniGameMediator:OnMiniGameSuccess(...)
	return
end

function BaseMiniGameMediator:OnMiniGameFailure(...)
	return
end

function BaseMiniGameMediator:listNotificationInterests()
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

function BaseMiniGameMediator:handleNotification(arg_15_1)
	local var_15_0 = arg_15_1:getName()
	local var_15_1 = arg_15_1:getBody()

	if var_15_0 == MiniGameProxy.ON_HUB_DATA_UPDATE then
		self.viewComponent:SetMGHubData(var_15_1)
	elseif var_15_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_16_0)
				if #var_15_1.awards > 0 then
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_15_1.awards, arg_16_0)
				else
					arg_16_0()
				end

				return
			end,
			function(arg_17_0)
				self.viewComponent:OnGetAwardDone(var_15_1)
				arg_17_0()

				return
			end
		})
		self.viewComponent:OnSendMiniGameOPDone(var_15_1)
	elseif var_15_0 == GAME.MODIFY_MINI_GAME_DATA_DONE then
		self.viewComponent:OnModifyMiniGameDataDone(var_15_1)
	elseif var_15_0 == GAME.ON_APPLICATION_PAUSE then
		self.viewComponent:OnApplicationPaused(var_15_1)
	elseif var_15_0 == GAME.GAME_COIN_COUNT_CHANGE then
		self.gameRoonCoinCount = var_15_1
	elseif var_15_0 == GAME.GAME_ROOM_AWARD_DONE then
		if #var_15_1 > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_15_1)
			self.viewComponent:OnGetAwardDone(var_15_1)
		end
	elseif var_15_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		if getProxy(ContextProxy):getContextByMediator(ActivityMediator) then
			return
		end

		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_15_1.awards, var_15_1.callback)
	end

	return
end

return BaseMiniGameMediator
