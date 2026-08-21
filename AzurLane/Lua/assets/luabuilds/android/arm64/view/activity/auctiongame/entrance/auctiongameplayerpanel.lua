local var_0_0 = class("AuctionGamePlayerPanel", import("view.base.BasePanel"))

var_0_0.REFRESH_CURRENCY = "AuctionGamePlayerPanel::REFRESH_CURRENCY"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiDisplayBtn, function()
		arg_2_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameNameCardLayer,
			mediator = AuctionGameNameCardMediator
		}))

		return
	end, SFX_PANEL)

	local var_2_0 = getProxy(PlayerProxy)
	local var_2_1 = getProxy(PlayerProxy):getRawData()

	setText(arg_2_0.uiNameText, var_2_1.name)
	GetImageSpriteFromAtlasAsync("SquareIcon/" .. getProxy(BayProxy):GetShipPhantom(var_2_1:GetShipPhantomMarks()[1]):getPainting(), "", arg_2_0.uiIconTf)
	LoadSpriteAsync(Drop.New({
		type = DROP_TYPE_VITEM,
		id = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):getConfig("config_client").itemID
	}):getIcon(), function(arg_4_0)
		if not IsNil(arg_2_0.uiCurrencyIcon) then
			arg_2_0.uiCurrencyIcon.sprite = arg_4_0
		end

		return
	end)

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:RefreshCurrency()

	arg_5_0.eventIDList = {
		arg_5_0:bind(var_0_0.REFRESH_CURRENCY, handler(arg_5_0, arg_5_0.RefreshCurrency))
	}

	return
end

function var_0_0.RefreshCurrency(arg_6_0)
	setText(arg_6_0.uiCntText, StringHelper.ForamtNumberK(AuctionGameTools.GetCurrencyCnt()))

	return
end

function var_0_0.willExit(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.eventIDList) do
		arg_7_0:disconnect(iter_7_1)
	end

	arg_7_0.eventIDList = nil

	arg_7_0:detach()

	return
end

return var_0_0
