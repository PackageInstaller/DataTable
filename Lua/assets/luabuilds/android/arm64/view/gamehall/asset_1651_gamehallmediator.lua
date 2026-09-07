local GameHallMediator = class("GameHallMediator", import("..base.ContextMediator"))

GameHallMediator.OPEN_MINI_GAME = "open mini game"
GameHallMediator.OPEN_GAME_SHOP = "open game shop "
GameHallMediator.GET_WEEKLY_COIN = "get weekly coin"
GameHallMediator.EXCHANGE_COIN = "exchange coin"

function GameHallMediator:register()
	self:bind(GameHallMediator.OPEN_MINI_GAME, function(arg_2_0, arg_2_1, arg_2_2)
		print("open minigame " .. arg_2_1.game_id)
		pg.m02:sendNotification(GAME.GO_MINI_GAME, arg_2_1.game_id)

		return
	end)
	self:bind(GameHallMediator.OPEN_GAME_SHOP, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_MINI_GAME
		})

		return
	end)
	self:bind(GameHallMediator.GET_WEEKLY_COIN, function(arg_4_0, arg_4_1, arg_4_2)
		pg.m02:sendNotification(GAME.GAME_ROOM_WEEK_COIN)

		return
	end)
	self:bind(GameHallMediator.EXCHANGE_COIN, function(arg_5_0, arg_5_1, arg_5_2)
		pg.m02:sendNotification(GAME.GAME_ROOM_EXCHANGE_COIN, arg_5_1)

		return
	end)

	return
end

function GameHallMediator:onUIAvalible()
	if getProxy(GameRoomProxy):getFirstEnter() then
		pg.m02:sendNotification(GAME.GAME_ROOM_FIRST_COIN)
	else
		pg.SystemGuideMgr.GetInstance():Play(self.viewComponent)
	end

	return
end

function GameHallMediator:listNotificationInterests()
	return {
		GAME.GAME_ROOM_AWARD_DONE,
		GAME.ROOM_FIRST_COIN_DONE,
		GAME.END_GUIDE
	}
end

function GameHallMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.GAME_ROOM_AWARD_DONE then
		self.viewComponent:emit(BaseUI.ON_AWARD, {
			items = var_8_1
		})
		self.viewComponent:updateUI()
	elseif var_8_0 == GAME.ROOM_FIRST_COIN_DONE then
		seriesAsync({
			function(arg_9_0)
				self.viewComponent:emit(BaseUI.ON_AWARD, {
					items = var_8_1,
					removeFunc = arg_9_0
				})

				return
			end,
			function(arg_10_0)
				self.viewComponent:updateUI()
				pg.SystemGuideMgr.GetInstance():Play(self.viewComponent)
				arg_10_0()

				return
			end
		})
	elseif var_8_0 == GAME.END_GUIDE then
		pg.SystemGuideMgr.GetInstance():Play(self.viewComponent)
	end

	return
end

return GameHallMediator
