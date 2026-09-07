AuctionGameMainRightView = import("view.activity.AuctionGame.game.main.right.AuctionGameMainRightView")

local AuctionGameMainRightGuideView = class("AuctionGameMainRightGuideView", AuctionGameMainRightView)

function AuctionGameMainRightGuideView:OnPopBidLayer()
	self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainBidGuideLayer,
		mediator = AuctionGameMainBidMediator
	}))

	return
end

function AuctionGameMainRightGuideView:OnPopEventLayer()
	if getProxy(AuctionGameProxy):GetRound() > 1 then
		return
	end

	self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainEventGuideLayer,
		mediator = AuctionGameMainEventMediator
	}))

	return
end

return AuctionGameMainRightGuideView
