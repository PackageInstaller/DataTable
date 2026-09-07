local BidGameMainRoundOverMediator = class("BidGameMainRoundOverMediator", import("view.base.ContextMediator"))

function BidGameMainRoundOverMediator:register()
	return
end

function BidGameMainRoundOverMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.AUCTION_GAME_NEW_ROUND] = function(arg_3_0, arg_3_1)
			arg_3_0.viewComponent:closeView()

			return
		end
	}

	return
end

function BidGameMainRoundOverMediator:remove()
	return
end

return BidGameMainRoundOverMediator
