local AuctionGameMainMediator = class("AuctionGameMainMediator", import("view.base.ContextMediator"))

AuctionGameMainMediator.FORFEIT = "AuctionGameMainMediator::FORFEIT"
AuctionGameMainMediator.EXIT = "AuctionGameMainMediator::EXIT"

function AuctionGameMainMediator:register()
	self:bind(AuctionGameMainMediator.FORFEIT, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.AUCTION_GAME_FORFEIT)

		return
	end)
	self:bind(AuctionGameMainMediator.EXIT, function(arg_3_0, arg_3_1)
		self.viewComponent:closeView()

		return
	end)

	return
end

function AuctionGameMainMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.AUCTION_GAME_NEW_ROUND] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:RefreshRound()
			arg_5_0.viewComponent:emit(AuctionGameMainRightView.POP_EVENT_LAYER)

			return
		end,
		[GAME.AUCTION_GAME_EVENT_SELECTED_ID_DONE] = function(arg_6_0, arg_6_1)
			arg_6_0.viewComponent:emit(AuctionGameMainRightView.EVENT_SELECTED)

			return
		end,
		[GAME.AUCTION_GAME_BID_PHASE] = function(arg_7_0, arg_7_1)
			arg_7_0.viewComponent:OnStartBid()

			return
		end,
		[GAME.AUCTION_GAME_BID_DONE] = function(arg_8_0, arg_8_1)
			arg_8_0.viewComponent:OnBidDone(arg_8_1:getBody())

			return
		end,
		[GAME.AUCTION_GAME_FORFEIT_DONE] = function(arg_9_0, arg_9_1)
			arg_9_0.viewComponent:emit(AuctionGameMainRightView.FORFEIT_DONE, arg_9_1)

			return
		end,
		[GAME.AUCTION_GAME_EVENT_EFFECT_UPDATE] = function(arg_10_0, arg_10_1)
			arg_10_0.viewComponent:emit(AuctionGameStoreView.UPDATE_ITEM_LIST)
			arg_10_0.viewComponent:emit(AuctionGameMainRightInfoView.EVENT_INFO_UPDATE)

			return
		end,
		[GAME.AUCTION_GAME_PLAYER_OPT_STATE_UPDATE] = function(arg_11_0, arg_11_1)
			arg_11_0.viewComponent:emit(AuctionGameMainRightView.PLAYER_OPT_STATE_UPDATE)

			return
		end,
		[GAME.AUCTION_GAME_ROUND_OVER] = function(arg_12_0, arg_12_1)
			arg_12_0.viewComponent:OnStartRoundOver()

			return
		end,
		[GAME.AUCTION_GAME_SETTLEMENT] = function(arg_13_0, arg_13_1)
			local var_13_0 = getProxy(AuctionGameProxy)

			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionFinish(var_13_0:GetAuctionID(), var_13_0:GetRound(), 0))
			arg_13_0:sendNotification(GAME.GO_SCENE, SCENE.AUCTION_GAME_MAIN_SETTLEMENT)

			return
		end,
		[GAME.AUCTION_GAME_KICK] = function(arg_14_0, arg_14_1)
			arg_14_0.viewComponent:OnKick()

			return
		end,
		[GAME.AUCTION_GAME_SHOW_EMOJI] = function(arg_15_0, arg_15_1)
			arg_15_0.viewComponent:emit(AuctionGameMainRightView.SHOW_EMOJI, arg_15_1:getBody())

			return
		end,
		[GAME.AUCTION_GAME_SWITCH_EMOJI_DONE] = function(arg_16_0, arg_16_1)
			arg_16_0.viewComponent:emit(AuctionGameMainRightView.SWITCH_EMOJI)

			return
		end,
		[GAME.ON_RECONNECTION] = function(arg_17_0, arg_17_1)
			arg_17_0.viewComponent:OnReconnection()

			return
		end
	}

	return
end

function AuctionGameMainMediator:remove()
	return
end

return AuctionGameMainMediator
