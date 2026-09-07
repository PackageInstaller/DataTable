local AuctionGameMainEventMediator = class("AuctionGameMainEventMediator", import("view.base.ContextMediator"))

AuctionGameMainEventMediator.EVENT_SELECTED_ID = "AuctionGameMainEventMediator::EVENT_SELECTED_ID"

function AuctionGameMainEventMediator:register()
	self:bind(AuctionGameMainEventMediator.EVENT_SELECTED_ID, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.AUCTION_GAME_EVENT_SELECTED_ID, arg_2_1)

		return
	end)

	return
end

function AuctionGameMainEventMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.AUCTION_GAME_EVENT_SELECTED_ID_DONE] = function(arg_4_0, arg_4_1)
			arg_4_0.viewComponent:closeView()

			return
		end,
		[GAME.AUCTION_GAME_ROUND_OVER] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:closeView()

			return
		end,
		[GAME.AUCTION_GAME_BID_PHASE] = function(arg_6_0, arg_6_1)
			arg_6_0.viewComponent:closeView()

			return
		end
	}

	return
end

function AuctionGameMainEventMediator:remove()
	return
end

return AuctionGameMainEventMediator
