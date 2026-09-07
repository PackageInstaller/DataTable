local AuctionGameMainReadyMediator = class("AuctionGameMainReadyMediator", import("view.base.ContextMediator"))

function AuctionGameMainReadyMediator:register()
	self:sendNotification(GAME.PLAY_ROOM_LOAD_SCENE_COMPLETE)

	return
end

function AuctionGameMainReadyMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.AUCTION_GAME_NEW_ROUND] = function(arg_3_0, arg_3_1)
			arg_3_0.viewComponent:closeView()

			return
		end
	}

	return
end

function AuctionGameMainReadyMediator:remove()
	return
end

return AuctionGameMainReadyMediator
