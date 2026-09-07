local AuctionGameCollectionListMediator = class("AuctionGameCollectionListMediator", import("view.base.ContextMediator"))

function AuctionGameCollectionListMediator:register()
	return
end

function AuctionGameCollectionListMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.AUCTION_GAME_ROUND_OVER] = function(arg_3_0, arg_3_1)
			arg_3_0.viewComponent:closeView()

			return
		end
	}

	return
end

function AuctionGameCollectionListMediator:remove()
	return
end

return AuctionGameCollectionListMediator
