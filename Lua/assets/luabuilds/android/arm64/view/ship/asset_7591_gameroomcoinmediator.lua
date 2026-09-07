local GameRoomCoinMediator = class("GameRoomCoinMediator", import("..base.ContextMediator"))

GameRoomCoinMediator.CHANGE_VISIBLE = "GameRoomCoinMediator:CHANGE_VISIBLE"
GameRoomCoinMediator.CHANGE_COIN_NUM = "GameRoomCoinMediator:CHANGE COIN COUNT"

function GameRoomCoinMediator:register()
	self:bind(GameRoomCoinMediator.CHANGE_COIN_NUM, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.GAME_COIN_COUNT_CHANGE, arg_2_1)

		return
	end)

	return
end

function GameRoomCoinMediator:listNotificationInterests()
	return {
		GameRoomCoinMediator.CHANGE_VISIBLE
	}
end

function GameRoomCoinMediator:handleNotification(arg_4_1)
	if arg_4_1:getName() == GameRoomCoinMediator.CHANGE_VISIBLE then
		self.viewComponent:changeVisible((arg_4_1:getBody()))
	end

	return
end

return GameRoomCoinMediator
