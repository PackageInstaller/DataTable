class = var_0_10000

local var_0_0 = "AuctionGamePlayerPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

var_0_1.REFRESH_CURRENCY = "AuctionGamePlayerPanel::REFRESH_CURRENCY"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiDisplayBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		BaseUI = var_2_10002

		local var_3_2 = var_2_10002.ON_ADD_SUBLAYER

		Context = var_2_10003

		local var_3_3 = var_2_10003.New
		local var_3_4 = {}

		AuctionGameNameCardLayer = var_2_10005
		var_3_4.viewComponent = var_2_10005
		AuctionGameNameCardMediator = var_2_10005
		var_3_4.mediator = var_2_10005

		var_3_1(var_3_0, var_3_2, var_3_3(var_3_4))

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	getProxy = var_1_10001
	PlayerProxy = var_2_0

	local var_2_3 = var_1_10001(var_2_0)

	getProxy = var_2_0
	PlayerProxy = var_2_1

	local var_2_4 = var_2_0(var_2_1)
	local var_2_5 = var_2.getRawData(var_2_4)

	setText = var_2_4

	var_2_4(arg_2_0.uiNameText, var_2_5.name)

	local var_2_6 = var_2_5
	local var_2_7 = var_2_5.GetShipPhantomMarks(var_2_6)[1]

	getProxy = var_2_6
	BayProxy = var_5

	local var_2_8 = var_2_6(var_5)
	local var_2_9 = var_4.GetShipPhantom(var_2_8, var_2_7)

	GetImageSpriteFromAtlasAsync = var_2_8

	var_2_8("SquareIcon/" .. var_2_9:getPainting(), "", arg_2_0.uiIconTf)

	getProxy = var_2_8
	ActivityProxy = var_6

	local var_2_10 = var_2_8(var_6)
	local var_2_11 = var_5.getActivityByType

	ActivityConst = var_8

	local var_2_12 = var_2_11(var_2_10, var_8.ACTIVITY_TYPE_AUCTION_GAME)
	local var_2_13 = var_6.getConfig(var_2_12, "config_client").itemID

	LoadSpriteAsync = var_2_12
	Drop = var_9

	local var_2_14 = var_9.New
	local var_2_15 = {}

	DROP_TYPE_VITEM = var_1_10011
	var_2_15.type = var_1_10011
	var_2_15.id = var_2_13

	local var_2_16 = var_2_14(var_2_15)

	var_2_12(var_9.getIcon(var_2_16), function(arg_4_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_2_0.uiCurrencyIcon) then
			arg_2_0.uiCurrencyIcon.sprite = arg_4_0
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:RefreshCurrency()

	local var_5_0 = {}
	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.bind
	local var_5_3 = var_0_1.REFRESH_CURRENCY

	handler = var_1_10005
	var_5_0[1] = var_5_2(var_5_1, var_5_3, var_1_10005(arg_5_0, arg_5_0.RefreshCurrency))
	arg_5_0.eventIDList = var_5_0

	return
end

function var_0_1.RefreshCurrency(arg_6_0)
	setText = var_1_10001

	local var_6_0 = arg_6_0.uiCntText

	StringHelper = var_1_10003

	local var_6_1 = var_1_10003.ForamtNumberK

	AuctionGameTools = var_1_10004

	var_1_10001(var_6_0, var_6_1(var_1_10004.GetCurrencyCnt()))

	return
end

function var_0_1.willExit(arg_7_0)
	ipairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.eventIDList) do
		arg_7_0:disconnect(iter_7_1)
	end

	arg_7_0.eventIDList = nil

	arg_7_0:detach()

	return
end

return var_0_1
