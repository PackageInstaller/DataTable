class = var_0_10000

local var_0_0 = "AuctionGameMainLeftView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	AuctionGameStoreView = var_1_10001
	arg_2_0.storeView = var_1_10001.New(arg_2_0.uiStorePanel, arg_2_0._parentClass)

	return
end

function var_0_1.didEnter(arg_3_0)
	local var_3_0 = arg_3_0.storeView

	var_1.didEnter(var_3_0)

	getProxy = var_1
	AuctionGameProxy = var_3_0

	local var_3_1 = var_1(var_3_0)

	if var_1.GetAuctionID(var_3_1) == 1 then
		setActive = var_2

		var_2(arg_3_0.uiEstimateGo, true)
	else
		setActive = var_2

		var_2(arg_3_0.uiEstimateGo, false)
	end

	local var_3_2 = {}
	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.bind

	AuctionGameMainRightView = var_1_10005

	local var_3_5 = var_1_10005.EVENT_SELECTED

	handler = var_1_10006
	var_3_2[1] = var_3_4(var_3_3, var_3_5, var_1_10006(arg_3_0, arg_3_0.RefreshEstimate))
	arg_3_0.eventList = var_3_2

	return
end

function var_0_1.RefreshRound(arg_4_0)
	arg_4_0:RefreshEstimate()

	return
end

function var_0_1.RefreshEstimate(arg_5_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10002

	local var_5_0 = var_1_10001(var_1_10002)
	local var_5_1 = 0
	local var_5_2 = 0

	pairs = var_1_10004

	for iter_5_0, iter_5_1 in var_1_10004(var_5_0:GetStoreItemDataList()) do
		local var_5_3, var_5_4 = iter_5_1:GetEstimateValue()

		var_5_1 = var_5_1 + var_5_3
		var_5_2 = var_5_2 + var_5_4
	end

	setText = var_4

	local var_5_5 = arg_5_0.uiEstimateText

	i18n = var_6

	local var_5_6 = "auction_store_estimate"

	StringHelper = iter_5_1

	local var_5_7 = iter_5_1.ForamtNumber(var_5_1)

	StringHelper = var_9

	var_4(var_5_5, var_6(var_5_6, var_5_7, var_9.ForamtNumber(var_5_2)))

	return
end

function var_0_1.willExit(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.eventList) do
		arg_6_0:disconnect(iter_6_1)
	end

	arg_6_0.eventList = nil

	local var_6_0 = arg_6_0.storeView

	var_1.willExit(var_6_0)

	arg_6_0.storeView = nil

	arg_6_0:detach()

	return
end

return var_0_1
