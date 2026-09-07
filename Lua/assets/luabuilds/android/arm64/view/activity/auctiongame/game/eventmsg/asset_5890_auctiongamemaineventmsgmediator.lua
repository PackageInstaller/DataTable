local AuctionGameMainEventMsgMediator = class("AuctionGameMainEventMsgMediator", import("view.base.ContextMediator"))

function AuctionGameMainEventMsgMediator:register()
	return
end

function AuctionGameMainEventMsgMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.AUCTION_GAME_ROUND_OVER] = function(arg_3_0, arg_3_1)
			arg_3_0.viewComponent:closeView()

			return
		end
	}

	return
end

function AuctionGameMainEventMsgMediator:remove()
	return
end

return AuctionGameMainEventMsgMediator
