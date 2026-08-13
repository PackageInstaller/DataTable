class = var_0_10000

local var_0_0 = "AuctionGameMainSettlementScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.REVEAL_ITEM = "AuctionGameMainSettlementScene::REVEAL_ITEM"
var_0_1.REVEAL_OVER = "AuctionGameMainSettlementScene::REVEAL_OVER"

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameMainSettlementUI"
end

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.uiRevealBtnText

	i18n = var_1_10003

	var_1_10001(var_2_0, var_1_10003("auction_settlement_quick"))

	setText = var_1_10001

	local var_2_1 = arg_2_0.uiNameTitleText

	i18n = var_3

	var_1_10001(var_2_1, var_3("auction_settlement_name"))

	setText = var_1_10001

	local var_2_2 = arg_2_0.uiBidTitleText

	i18n = var_3

	var_1_10001(var_2_2, var_3("auction_settlement_price"))

	setText = var_1_10001

	local var_2_3 = arg_2_0.uiStoreHouseTitleText

	i18n = var_3

	var_1_10001(var_2_3, var_3("auction_settlement_value"))

	setText = var_1_10001

	local var_2_4 = arg_2_0.uiProceedsTitleText

	i18n = var_3

	var_1_10001(var_2_4, var_3("auction_settlement_revenue"))

	setText = var_1_10001

	local var_2_5 = arg_2_0.uiDividendTitleText

	i18n = var_3

	var_1_10001(var_2_5, var_3("auction_settlement_dividend"))

	setText = var_1_10001

	local var_2_6 = arg_2_0.uiSessionTitleText

	i18n = var_3

	var_1_10001(var_2_6, var_3("auction_settlement_session"))

	onButton = var_1_10001

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.uiCloseBtn

	local function var_2_9()
		local var_3_0 = arg_2_0.storeView

		var_0.RevealAllItem(var_3_0)

		local var_3_1 = arg_2_0

		var_0.closeView(var_3_1)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_2_7, var_2_8, var_2_9, var_1_10005)

	onButton = var_1_10001

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.uiRevealBtn

	local function var_2_12()
		local var_4_0 = arg_2_0.storeView

		var_0.RevealAllItem(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_10, var_2_11, var_2_12, var_1_10005)

	onButton = var_1_10001

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.uiShareBtn

	local function var_2_15()
		pg = var_2_10000

		local var_5_0 = var_2_10000.ShareMgr.GetInstance()
		local var_5_1 = var_0.Share

		pg = var_2_10002

		var_5_1(var_5_0, var_2_10002.ShareMgr.AuctionGame)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_13, var_2_14, var_2_15, var_1_10005)

	AuctionGameMainSettlementStoreView = var_1_10001
	arg_2_0.storeView = var_1_10001.New(arg_2_0.uiStorePanel, arg_2_0)

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
	AuctionGameProxy = var_6_0

	local var_6_1 = var_1(var_6_0)
	local var_6_2 = var_1.GetSettlementData(var_6_1).bidUserID
	local var_6_3

	ipairs = var_5

	for iter_6_0, iter_6_1 in var_5(var_1:GetPlayerList()) do
		if iter_6_1.id == var_6_2 then
			var_6_3 = iter_6_1

			break
		end
	end

	arg_6_0.paintingDefaultAngle = arg_6_0.uiPaintingTf.localEulerAngles
	Ship = var_5

	local var_6_4 = var_5.New({
		configId = var_6_3.icon,
		skin_id = var_6_3.skinId
	})

	setPaintingPrefabAsync = var_6

	var_6(arg_6_0.uiPaintingTf, var_6_4:getPainting(), "chuanwu", nil, {
		skinID = var_6_4:getSkinId(),
		rotateZ = arg_6_0.paintingDefaultAngle.z
	})

	arg_6_0.shipVO = var_6_4
	setScrollText = var_6

	var_6(arg_6_0.uiNameText, var_6_3.name)

	local var_6_5 = var_1
	local var_6_6 = var_1.GetAuctionID(var_6_5)

	setScrollText = var_6_5

	local var_6_7 = arg_6_0.uiSessionText

	pg = var_9

	var_6_5(var_6_7, var_9.auction_session[var_6_6].name)

	setText = var_6_5

	local var_6_8 = arg_6_0.uiBidText

	StringHelper = var_9

	var_6_5(var_6_8, var_9.ForamtNumber(var_2.bidValue))

	setText = var_6_5

	var_6_5(arg_6_0.uiStoreHouseText, 0)

	setText = var_6_5

	local var_6_9 = arg_6_0.uiProceedsText

	string = var_9

	local var_6_10 = var_9.format
	local var_6_11 = "<color=#B13535>%s</color>"

	StringHelper = var_11

	var_6_5(var_6_9, var_6_10(var_6_11, var_11.ForamtNumber(-var_2.bidValue)))

	setText = var_6_5

	var_6_5(arg_6_0.uiDividendText, 0)
	arg_6_0:RefreshCurrency()

	arg_6_0.addValue = 0
	arg_6_0.bidValue = var_2.bidValue
	arg_6_0.settlementVO = var_2

	local var_6_12 = {}
	local var_6_13 = arg_6_0
	local var_6_14 = arg_6_0.bind
	local var_6_15 = var_0_1.REVEAL_ITEM

	handler = var_11
	var_6_12[1] = var_6_14(var_6_13, var_6_15, var_11(arg_6_0, arg_6_0.OnRefreshText))

	local var_6_16 = arg_6_0
	local var_6_17 = arg_6_0.bind
	local var_6_18 = var_0_1.REVEAL_OVER

	handler = var_11
	var_6_12[2] = var_6_17(var_6_16, var_6_18, var_11(arg_6_0, arg_6_0.OnRefreshOver))
	arg_6_0.eventList = var_6_12

	local var_6_19 = arg_6_0.storeView

	var_7.didEnter(var_6_19)

	setActive = var_7

	var_7(arg_6_0.uiCloseBtn, false)

	setActive = var_7

	var_7(arg_6_0.uiShareBtn, false)

	getProxy = var_7
	ActivityProxy = var_8

	local var_6_20 = var_7(var_8)
	local var_6_21 = var_7.getActivityByType

	ActivityConst = var_6_18

	local var_6_22 = var_6_21(var_6_20, var_6_18.ACTIVITY_TYPE_AUCTION_GAME)
	local var_6_23 = var_8.getConfig(var_6_22, "config_client").itemID

	LoadSpriteAsync = var_6_22
	Drop = var_11

	local var_6_24 = var_11.New
	local var_6_25 = {}

	DROP_TYPE_VITEM = var_13
	var_6_25.type = var_13
	var_6_25.id = var_6_23

	local var_6_26 = var_6_24(var_6_25)

	var_6_22(var_11.getIcon(var_6_26), function(arg_7_0)
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

	StringHelper = var_1_10003

	local var_8_1 = var_1_10003.ForamtNumber

	getProxy = var_1_10004
	AuctionGameBaseProxy = var_1_10005

	var_1_10001(var_8_0, var_8_1(var_1_10004(var_1_10005).gold))

	return
end

function var_0_1.OnRefreshText(arg_9_0, arg_9_1, arg_9_2)
	print = var_1_10003

	var_1_10003("揭示物品: id", arg_9_2.id, "uid:", arg_9_2.uid, "价值:", arg_9_2.price, "当前总价值:", arg_9_0.addValue + arg_9_2.price)

	arg_9_0.addValue = arg_9_0.addValue + arg_9_2.price
	setText = var_3

	local var_9_0 = arg_9_0.uiStoreHouseText

	StringHelper = var_5

	var_3(var_9_0, var_5.ForamtNumber(arg_9_0.addValue))

	getProxy = var_3
	AuctionGameProxy = var_9_0

	local var_9_1 = var_3(var_9_0)
	local var_9_2 = var_3.GetSettlementData(var_9_1)
	local var_9_3 = arg_9_0.addValue - arg_9_0.settlementVO.bidValue

	setText = var_6

	local var_9_4 = arg_9_0.uiProceedsText

	string = var_8

	local var_9_5 = var_8.format
	local var_9_6 = "<color=%s>%s</color>"
	local var_9_7 = var_9_3 > 0 and "#03825F" or "#B13535"

	StringHelper = var_11

	var_6(var_9_4, var_9_5(var_9_6, var_9_7, var_11.ForamtNumber(var_9_3)))

	return
end

function var_0_1.OnRefreshOver(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.uiCloseBtn, true)

	setActive = var_1_10001

	var_1_10001(arg_10_0.uiShareBtn, true)

	getProxy = var_1_10001
	AuctionGameProxy = var_2

	local var_10_0 = var_1_10001(var_2)
	local var_10_1 = var_1.GetSettlementData(var_10_0)

	getProxy = var_10_0
	AuctionGameBaseProxy = var_1_10004

	local var_10_2 = var_10_0(var_1_10004)
	local var_10_3 = var_10_1.proceeds

	pg = var_1_10005

	local var_10_4 = var_1_10005.auction_session
	local var_10_5 = var_1
	local var_10_6 = var_10_4[var_1.GetAuctionID(var_10_5)].name
	local var_10_7 = var_10_1.bidUserID

	getProxy = var_10_5
	PlayerProxy = var_1_10008

	local var_10_8 = var_10_5(var_1_10008)
	local var_10_9 = var_10_7 == var_7.getPlayerId(var_10_8) and 1 or 0

	pg = var_7

	local var_10_10 = var_7.GameTrackerMgr.GetInstance()
	local var_10_11 = var_7.Record

	GameTrackerBuilder = var_1_10009

	var_10_11(var_10_10, var_1_10009.BuildAuctionSettlement(var_10_6, var_10_9, var_10_1.bidValue, arg_10_0.addValue, var_10_2.gold, var_10_2.gold + var_10_3))

	pg = var_10_11

	local var_10_12 = var_10_11.NewGuideMgr.GetInstance()

	if not var_7.IsBusy(var_10_12) then
		var_10_2:AddGold(var_10_3)
	end

	local var_10_13 = arg_10_0

	arg_10_0.RefreshCurrency(var_10_13)

	local var_10_14 = var_10_1.bidUserID

	getProxy = var_10_13
	PlayerProxy = var_9

	local var_10_15 = var_10_13(var_9)

	if var_10_14 ~= var_8.getPlayerId(var_10_15) then
		setText = var_10_14

		local var_10_16 = arg_10_0.uiDividendText

		string = var_10_15

		local var_10_17 = var_10_15.format
		local var_10_18 = "<color=%s>%s</color>"
		local var_10_19 = var_10_1.proceeds
		local var_10_20 = 0 < var_10_19 and "#03825F" or "#B13535"

		StringHelper = var_12

		var_10_14(var_10_16, var_10_17(var_10_18, var_10_20, var_12.ForamtNumber(var_10_1.proceeds)))
	end

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
	local var_11_1 = arg_11_0.shipVO

	var_1(var_11_0, var_3.getPainting(var_11_1))

	local var_11_2 = arg_11_0.storeView

	var_1.willExit(var_11_2)

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
