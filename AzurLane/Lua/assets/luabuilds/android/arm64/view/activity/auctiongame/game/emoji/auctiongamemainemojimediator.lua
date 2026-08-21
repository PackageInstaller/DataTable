local var_0_0 = class("AuctionGameMainEmojiMediator", import("view.base.ContextMediator"))

var_0_0.ON_CLICK_EMOJI = "AuctionGameMainEmojiMediator::ON_CLICK_EMOJI"
var_0_0.ON_CLICK_EMOJI_SWITCH = "AuctionGameMainEmojiMediator::ON_CLICK_EMOJI_SWITCH"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_CLICK_EMOJI, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.AUCTION_GAME_EMOJI, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_CLICK_EMOJI_SWITCH, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.AUCTION_GAME_SWITCH_EMOJI, arg_3_1)

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_4_0)
	arg_4_0.handleDic = {
		[GAME.AUCTION_GAME_EMOJI_DONE] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:closeView()

			return
		end,
		[GAME.AUCTION_GAME_SWITCH_EMOJI_DONE] = function(arg_6_0, arg_6_1)
			arg_6_0.viewComponent:OnRefreshSwitchEmojiBtn()

			return
		end
	}

	return
end

function var_0_0.remove(arg_7_0)
	return
end

return var_0_0
