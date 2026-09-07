local AuctionGameMainMsgMediator = class("AuctionGameMainMsgMediator", import("view.base.ContextMediator"))

function AuctionGameMainMsgMediator:register()
	return
end

function AuctionGameMainMsgMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.AUCTION_GAME_ROUND_OVER] = function(arg_3_0, arg_3_1)
			arg_3_0.viewComponent:closeView()

			return
		end
	}

	return
end

function AuctionGameMainMsgMediator:remove()
	return
end

return AuctionGameMainMsgMediator
