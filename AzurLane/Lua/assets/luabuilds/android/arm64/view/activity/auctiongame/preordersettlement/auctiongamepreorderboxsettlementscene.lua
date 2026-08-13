class = var_0_10000

local var_0_0 = "AuctionGamePreorderBoxSettlementScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.REVEAL_ITEM = "AuctionGameMainSettlementScene::REVEAL_ITEM"
var_0_1.REVEAL_OVER = "AuctionGameMainSettlementScene::REVEAL_OVER"

function var_0_1.getUIName(arg_1_0)
	return "AuctionGamePreorderBoxSettlementUI"
end

function var_0_1.init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiCloseBtn

	local function var_2_2()
		local var_3_0 = arg_2_0.storeView

		var_0.RevealAllItem(var_3_0)

		local var_3_1 = arg_2_0

		var_0.closeView(var_3_1)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiCancelBtn

	local function var_2_5()
		local var_4_0 = arg_2_0.storeView

		var_0.RevealAllItem(var_4_0)

		local var_4_1 = arg_2_0

		var_0.closeView(var_4_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10006)

	onButton = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.uiRevealBtn

	local function var_2_8()
		local var_5_0 = arg_2_0.storeView

		var_0.RevealAllItem(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_6, var_2_7, var_2_8, var_1_10006)

	AuctionGamePreorderBoxSettlementStoreView = var_1_10001
	arg_2_0.storeView = var_1_10001.New(arg_2_0.uiStorePanel, arg_2_0)
	setText = var_1

	local var_2_9 = arg_2_0.uiRevealBtnText

	i18n = var_4

	var_1(var_2_9, var_4("auction_settlement_quick"))

	setText = var_1

	local var_2_10 = arg_2_0.uiStoreHouseTitleText

	i18n = var_4

	var_1(var_2_10, var_4("auction_settlement_value"))

	setText = var_1

	local var_2_11 = arg_2_0.uiProceedsTitleText

	i18n = var_4

	var_1(var_2_11, var_4("auction_settlement_revenue"))

	return
end

function var_0_1.didEnter(arg_6_0)
	local var_6_0 = arg_6_0

	arg_6_0.OverlayPanel(var_6_0, arg_6_0.uiAdaptTf, {
		pbList = {
			arg_6_0.uiInfoTf
		}
	})

	getProxy = var_1
	PlayerProxy = var_6_0

	local var_6_1 = var_1(var_6_0)

	getProxy = var_1_10002
	PlayerProxy = var_4

	local var_6_2 = var_1_10002(var_4)
	local var_6_3 = var_2.getData(var_6_2)

	setPaintingPrefabAsync = var_6_0

	local var_6_4 = arg_6_0.uiPaintingTf

	pg = var_6

	var_6_0(var_6_4, var_6.ship_skin_template[900284].painting, "chuanwu", nil, {
		skinID = 900284
	})

	setText = var_6_0

	var_6_0(arg_6_0.uiStoreHouseText, 0)

	setText = var_6_0

	local var_6_5 = arg_6_0.uiProceedsText

	string = var_6

	local var_6_6 = var_6.format
	local var_6_7 = "<color=#B13535>%s</color>"

	StringHelper = var_9

	local var_6_8 = var_9.ForamtNumber

	AuctionGameTools = var_1_10011

	var_6_0(var_6_5, var_6_6(var_6_7, var_6_8(-1 * var_1_10011.GetPreorderCurrentyCnt())))
	arg_6_0:RefreshCurrency()

	arg_6_0.addValue = 0

	local var_6_9 = {}
	local var_6_10 = arg_6_0
	local var_6_11 = arg_6_0.bind
	local var_6_12 = var_0_1.REVEAL_ITEM

	handler = var_6_7
	var_6_9[1] = var_6_11(var_6_10, var_6_12, var_6_7(arg_6_0, arg_6_0.OnRefreshText))

	local var_6_13 = arg_6_0
	local var_6_14 = arg_6_0.bind
	local var_6_15 = var_0_1.REVEAL_OVER

	handler = var_8
	var_6_9[2] = var_6_14(var_6_13, var_6_15, var_8(arg_6_0, arg_6_0.OnRefreshOver))
	arg_6_0.eventList = var_6_9

	local var_6_16 = arg_6_0.storeView

	var_3.didEnter(var_6_16)

	setActive = var_3

	var_3(arg_6_0.uiCloseBtn, false)

	getProxy = var_3
	ActivityProxy = var_5

	local var_6_17 = var_3(var_5)
	local var_6_18 = var_3.getActivityByType

	ActivityConst = var_6_15

	local var_6_19 = var_6_18(var_6_17, var_6_15.ACTIVITY_TYPE_AUCTION_GAME)
	local var_6_20 = var_4.getConfig(var_6_19, "config_client").itemID

	LoadSpriteAsync = var_6_17
	Drop = var_8

	local var_6_21 = var_8.New
	local var_6_22 = {}

	DROP_TYPE_VITEM = var_11
	var_6_22.type = var_11
	var_6_22.id = var_6_20

	local var_6_23 = var_6_21(var_6_22)

	var_6_17(var_8.getIcon(var_6_23), function(arg_7_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_6_0.uiCurrencyIcon) then
			arg_6_0.uiCurrencyIcon.sprite = arg_7_0
		end

		return
	end)

	return
end

function var_0_1.RefreshCurrency(arg_8_0)
	setText = var_1_10001

	local var_8_0 = arg_8_0.uiCurrencyText

	StringHelper = var_1_10004

	local var_8_1 = var_1_10004.ForamtNumber

	getProxy = var_1_10006
	AuctionGameBaseProxy = var_1_10008

	var_1_10001(var_8_0, var_8_1(var_1_10006(var_1_10008).gold))

	return
end

function var_0_1.OnRefreshText(arg_9_0, arg_9_1, arg_9_2)
	print = var_1_10003

	var_1_10003("揭示物品: id", arg_9_2.id, "uid:", arg_9_2.uid, "价值:", arg_9_2.price, "当前总价值:", arg_9_0.addValue + arg_9_2.price)

	arg_9_0.addValue = arg_9_0.addValue + arg_9_2.price
	setText = var_3

	local var_9_0 = arg_9_0.uiStoreHouseText

	StringHelper = var_6

	var_3(var_9_0, var_6.ForamtNumber(arg_9_0.addValue))

	local var_9_1 = arg_9_0.addValue

	AuctionGameTools = var_4

	local var_9_2 = var_9_1 - var_4.GetPreorderCurrentyCnt()

	setText = var_4

	local var_9_3 = arg_9_0.uiProceedsText

	string = var_7

	local var_9_4 = var_7.format
	local var_9_5 = "<color=%s>%s</color>"
	local var_9_6 = var_9_2 > 0 and "#03825F" or "#B13535"

	StringHelper = var_11

	var_4(var_9_3, var_9_4(var_9_5, var_9_6, var_11.ForamtNumber(var_9_2)))

	return
end

function var_0_1.OnRefreshOver(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.uiCloseBtn, true)

	local var_10_0 = arg_10_0.addValue

	getProxy = var_1_10002
	AuctionGameBaseProxy = var_4

	local var_10_1 = var_1_10002(var_4)

	var_2.AddGold(var_10_1, var_10_0)

	pg = var_3

	local var_10_2 = var_3.GameTrackerMgr.GetInstance()
	local var_10_3 = var_3.Record

	GameTrackerBuilder = var_6

	var_10_3(var_10_2, var_6.BuildPreorder(1, var_10_0))
	arg_10_0:RefreshCurrency()

	return
end

function var_0_1.willExit(arg_11_0)
	arg_11_0:UnOverlayPanel(arg_11_0.uiAdaptTf, arg_11_0._tf)

	ipairs = var_1

	for iter_11_0, iter_11_1 in var_1(arg_11_0.eventList) do
		arg_11_0:disconnect(iter_11_1)
	end

	retPaintingPrefab = var_1

	local var_11_0 = arg_11_0.uiPaintingTf

	pg = iter_11_0

	var_1(var_11_0, iter_11_0.ship_skin_template[900284].painting)

	local var_11_1 = arg_11_0.storeView

	var_1.willExit(var_11_1)

	arg_11_0.storeView = nil

	return
end

function var_0_1.onBackPressed(arg_12_0)
	isActive = var_1_10001

	if var_1_10001(arg_12_0.uiCloseBtn) then
		var_0_1.super.onBackPressed(arg_12_0)
	end

	return
end

return var_0_1
