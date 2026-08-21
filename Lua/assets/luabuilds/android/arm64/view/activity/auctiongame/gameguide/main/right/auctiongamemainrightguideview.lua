AuctionGameMainRightView = import("view.activity.AuctionGame.game.main.right.AuctionGameMainRightView")

local var_0_0 = class("AuctionGameMainRightGuideView", AuctionGameMainRightView)

function var_0_0.OnPopBidLayer(arg_1_0)
	arg_1_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainBidGuideLayer,
		mediator = AuctionGameMainBidMediator
	}))

	return
end

function var_0_0.OnPopEventLayer(arg_2_0)
	if getProxy(AuctionGameProxy):GetRound() > 1 then
		return
	end

	arg_2_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainEventGuideLayer,
		mediator = AuctionGameMainEventMediator
	}))

	return
end

return var_0_0
