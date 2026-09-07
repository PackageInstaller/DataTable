local AuctionGameEntranceLocationItem = class("AuctionGameEntranceLocationItem", import("view.base.BasePanel"))

AuctionGameEntranceLocationItem.SELECTED_LOCATION = "AuctionGameEntranceLocationItem::SELECTED_LOCAITON"

function AuctionGameEntranceLocationItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._go = arg_1_1.gameObject

	AuctionGameEntranceLocationItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2
	self.id = arg_1_3

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameEntranceLocationItem:Init()
	setText(self.uiUnselectedLockText, i18n("auction_not_enough_assets", StringHelper.ForamtNumberK(pg.auction_session[self.id].threshold)))
	onButton(self, self.uiButton, function()
		if AuctionGameTools.GetCurrencyCnt() >= pg.auction_session[self.id].threshold == false then
			return
		end

		getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):SetLocationTip(self.id)
		self:emit(AuctionGameEntranceLocationItem.SELECTED_LOCATION, self.id)

		return
	end, SFX_PANEL)

	return
end

function AuctionGameEntranceLocationItem:didEnter(arg_4_1)
	getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):SetLocationTip(arg_4_1)
	self:RefreshState()
	self:SetSelected(arg_4_1 == self.id)

	return
end

function AuctionGameEntranceLocationItem:SetSelected(arg_5_1)
	setActive(self.uiSelectedGo, arg_5_1)
	setActive(self.uiUnselectedGo, not arg_5_1)

	if AuctionGameTools.GetCurrencyCnt() >= pg.auction_session[self.id].threshold then
		setActive(self.uiUnlockImage, arg_5_1)
		setActive(self.uiLockImage, not arg_5_1)
	else
		setActive(self.uiUnlockImage, false)
		setActive(self.uiLockImage, false)
	end

	return
end

function AuctionGameEntranceLocationItem:RefreshState()
	local var_6_0 = AuctionGameTools.GetCurrencyCnt() >= pg.auction_session[self.id].threshold

	setActive(self.uiUnselectedLockGo, not var_6_0)
	setActive(self.uiSelectedLockGo, not var_6_0)
	setActive(self.uiSelectedUnLockGo, var_6_0)
	self:RefreshTip()

	return
end

function AuctionGameEntranceLocationItem:RefreshTip()
	setActive(self.uiTipGo, getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):GetLocationTip(self.id))

	return
end

function AuctionGameEntranceLocationItem:willExit()
	self:detach()

	return
end

return AuctionGameEntranceLocationItem
