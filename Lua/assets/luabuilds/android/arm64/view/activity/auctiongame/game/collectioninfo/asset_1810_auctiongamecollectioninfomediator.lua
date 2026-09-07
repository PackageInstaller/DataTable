local AuctionGameCollectionInfoMediator = class("AuctionGameCollectionInfoMediator", import("view.base.ContextMediator"))

function AuctionGameCollectionInfoMediator:register()
	return
end

function AuctionGameCollectionInfoMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.AUCTION_GAME_ROUND_OVER] = function(arg_3_0, arg_3_1)
			arg_3_0.viewComponent:closeView()

			return
		end
	}

	return
end

return AuctionGameCollectionInfoMediator
