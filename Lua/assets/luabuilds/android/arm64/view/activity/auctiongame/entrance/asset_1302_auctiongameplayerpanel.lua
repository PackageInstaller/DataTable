local AuctionGamePlayerPanel = class("AuctionGamePlayerPanel", import("view.base.BasePanel"))

AuctionGamePlayerPanel.REFRESH_CURRENCY = "AuctionGamePlayerPanel::REFRESH_CURRENCY"

function AuctionGamePlayerPanel:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGamePlayerPanel.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGamePlayerPanel:Init()
	onButton(self, self.uiDisplayBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameNameCardLayer,
			mediator = AuctionGameNameCardMediator
		}))

		return
	end, SFX_PANEL)

	local var_2_0 = getProxy(PlayerProxy)
	local var_2_1 = getProxy(PlayerProxy):getRawData()

	setText(self.uiNameText, var_2_1.name)
	GetImageSpriteFromAtlasAsync("SquareIcon/" .. getProxy(BayProxy):GetShipPhantom(var_2_1:GetShipPhantomMarks()[1]):getPainting(), "", self.uiIconTf)
	LoadSpriteAsync(Drop.New({
		type = DROP_TYPE_VITEM,
		id = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):getConfig("config_client").itemID
	}):getIcon(), function(arg_4_0)
		if not IsNil(self.uiCurrencyIcon) then
			self.uiCurrencyIcon.sprite = arg_4_0
		end

		return
	end)

	return
end

function AuctionGamePlayerPanel:didEnter()
	self:RefreshCurrency()

	self.eventIDList = {
		self:bind(AuctionGamePlayerPanel.REFRESH_CURRENCY, handler(self, self.RefreshCurrency))
	}

	return
end

function AuctionGamePlayerPanel:RefreshCurrency()
	setText(self.uiCntText, StringHelper.ForamtNumberK(AuctionGameTools.GetCurrencyCnt()))

	return
end

function AuctionGamePlayerPanel:willExit()
	for iter_7_0, iter_7_1 in ipairs(self.eventIDList) do
		self:disconnect(iter_7_1)
	end

	self.eventIDList = nil

	self:detach()

	return
end

return AuctionGamePlayerPanel
