local AuctionGameMainNoticeBoardMediator = class("AuctionGameMainNoticeBoardMediator", import("view.base.ContextMediator"))

function AuctionGameMainNoticeBoardMediator:register()
	return
end

function AuctionGameMainNoticeBoardMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.AUCTION_GAME_ROUND_OVER] = function(arg_3_0, arg_3_1)
			arg_3_0.viewComponent:closeView()

			return
		end
	}

	return
end

function AuctionGameMainNoticeBoardMediator:remove()
	return
end

return AuctionGameMainNoticeBoardMediator
