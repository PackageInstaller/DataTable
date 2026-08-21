local var_0_0 = class("AuctionGameMainLeftView", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.storeView = AuctionGameStoreView.New(arg_2_0.uiStorePanel, arg_2_0._parentClass)

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.storeView:didEnter()

	if getProxy(AuctionGameProxy):GetAuctionID() == 1 then
		setActive(arg_3_0.uiEstimateGo, true)
	else
		setActive(arg_3_0.uiEstimateGo, false)
	end

	arg_3_0.eventList = {
		arg_3_0:bind(AuctionGameMainRightView.EVENT_SELECTED, handler(arg_3_0, arg_3_0.RefreshEstimate))
	}

	return
end

function var_0_0.RefreshRound(arg_4_0)
	arg_4_0:RefreshEstimate()

	return
end

function var_0_0.RefreshEstimate(arg_5_0)
	local var_5_0 = 0
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in pairs(getProxy(AuctionGameProxy):GetStoreItemDataList()) do
		local var_5_2, var_5_3 = iter_5_1:GetEstimateValue()

		var_5_0 = var_5_0 + var_5_2
		var_5_1 = var_5_1 + var_5_3
	end

	setText(arg_5_0.uiEstimateText, i18n("auction_store_estimate", StringHelper.ForamtNumber(var_5_0), StringHelper.ForamtNumber(var_5_1)))

	return
end

function var_0_0.willExit(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.eventList) do
		arg_6_0:disconnect(iter_6_1)
	end

	arg_6_0.eventList = nil

	arg_6_0.storeView:willExit()

	arg_6_0.storeView = nil

	arg_6_0:detach()

	return
end

return var_0_0
