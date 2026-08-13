class = var_0_10000

local var_0_0 = "AuctionGameNameCardLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AuctioNGameNameCardUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10003
	YSTool = var_1_10004
	arg_2_0.ysScreenShoter = var_2_1(var_2_0, var_1_10003(var_1_10004.YSScreenShoter))
	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.uiBgBtn

	local function var_2_4()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1(var_2_2, var_2_3, var_2_4, var_1_10005)

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.uiCopyBtn

	local function var_2_7()
		UniPasteBoard = var_2_10000

		local var_4_0 = var_2_10000.SetClipBoardString

		getProxy = var_2_10001
		PlayerProxy = var_2_10002

		local var_4_1 = var_2_10001(var_2_10002)

		var_4_0(var_1.getPlayerId(var_4_1))

		pg = var_4_0

		local var_4_2 = var_4_0.TipsMgr.GetInstance()
		local var_4_3 = var_0.ShowTips

		i18n = var_4_1

		var_4_3(var_4_2, var_4_1("friend_id_copy_ok"))

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_5, var_2_6, var_2_7, var_1_10005)

	onButton = var_1

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.uiShareBtn

	local function var_2_10()
		getProxy = var_2_10000
		PlayerProxy = var_2_10001

		local var_5_0 = var_2_10000(var_2_10001)

		getProxy = var_2_10001
		PlayerProxy = var_2_10002

		local var_5_1 = var_2_10001(var_2_10002)
		local var_5_2 = var_1.getData(var_5_1)

		pg = var_5_1

		local var_5_3 = var_5_1.GameTrackerMgr.GetInstance()
		local var_5_4 = var_2.Record

		GameTrackerBuilder = var_2_10004

		var_5_4(var_5_3, var_2_10004.BuildNameCard(1, var_5_2.id))

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_8, var_2_9, var_2_10, var_1_10005)

	onButton = var_1

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.uiSaveBtn

	local function var_2_13()
		setActive = var_2_10000
		pg = var_2_10001

		var_2_10000(var_2_10001.UIMgr.GetInstance().OverlayEffect, false)

		setActive = var_2_10000

		var_2_10000(arg_2_0.uiBtnsGo, false)

		local function var_6_0(arg_7_0)
			setActive = var_3_10001
			pg = var_3_10002

			var_3_10001(var_3_10002.UIMgr.GetInstance().OverlayEffect, true)

			setActive = var_3_10001

			var_3_10001(arg_2_0.uiBtnsGo, true)

			YSNormalTool = var_3_10001

			var_3_10001.MediaTool.SaveImageWithBytes(arg_7_0, function(arg_8_0, arg_8_1)
				if arg_8_0 then
					pg = var_4_10002

					local var_8_0 = var_4_10002.TipsMgr.GetInstance()
					local var_8_1 = var_2.ShowTips

					i18n = var_4_10004

					var_8_1(var_8_0, var_4_10004("word_save_ok"))
				end

				return
			end)

			return
		end

		local var_6_1 = arg_2_0.ysScreenShoter
		local var_6_2 = var_1.TakeScreenShotData

		tackCallBack = var_2_10003

		var_6_2(var_6_1, var_2_10003, var_6_0)

		getProxy = var_6_2
		PlayerProxy = var_6_1

		local var_6_3 = var_6_2(var_6_1)

		getProxy = var_6_1
		PlayerProxy = var_2_10003

		local var_6_4 = var_6_1(var_2_10003)
		local var_6_5 = var_2.getData(var_6_4)

		pg = var_6_4

		local var_6_6 = var_6_4.GameTrackerMgr.GetInstance()
		local var_6_7 = var_3.Record

		GameTrackerBuilder = var_2_10005

		var_6_7(var_6_6, var_2_10005.BuildNameCard(2, var_6_5.id))

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_11, var_2_12, var_2_13, var_1_10005)

	arg_2_0.paintingDefaultAngle = arg_2_0.uiPaintingTf.localEulerAngles
	setText = var_1

	local var_2_14 = arg_2_0.uiMatchesTitleText

	i18n = var_2_12

	var_1(var_2_14, var_2_12("auction_matches_title"))

	setText = var_1

	local var_2_15 = arg_2_0.uiSuccessCntTitleText

	i18n = var_3

	var_1(var_2_15, var_3("auction_success_cnt_title"))

	setText = var_1

	local var_2_16 = arg_2_0.uiSuccessRateTitleText

	i18n = var_3

	var_1(var_2_16, var_3("auction_success_rate_title"))

	setText = var_1

	local var_2_17 = arg_2_0.uiCurrencyTitleText

	i18n = var_3

	var_1(var_2_17, var_3("auction_currency_title"))

	setText = var_1

	local var_2_18 = arg_2_0.uiTotalProfitTitleText

	i18n = var_3

	var_1(var_2_18, var_3("auction_total_profit_title"))

	setText = var_1

	local var_2_19 = arg_2_0.uiHighestProfitTitleText

	i18n = var_3

	var_1(var_2_19, var_3("auction_highest_profit_title"))

	setText = var_1

	local var_2_20 = arg_2_0.uiCollectionTitleText

	i18n = var_3

	var_1(var_2_20, var_3("auction_collection_type_title"))

	setText = var_1

	local var_2_21 = arg_2_0.uiCollectionPriceTitleText

	i18n = var_3

	var_1(var_2_21, var_3("auction_collection_price_title"))

	setActive = var_1

	var_1(arg_2_0.uiShareBtn, false)

	return
end

function var_0_1.didEnter(arg_9_0)
	local var_9_0 = arg_9_0

	arg_9_0.OverlayPanel(var_9_0, arg_9_0._tf, {
		pbList = {
			arg_9_0.uiBg
		}
	})

	getProxy = var_1
	PlayerProxy = var_9_0

	local var_9_1 = var_1(var_9_0)

	getProxy = var_9_0
	PlayerProxy = var_3

	local var_9_2 = var_9_0(var_3)
	local var_9_3 = var_2.getRawData(var_9_2)

	setText = var_9_2

	var_9_2(arg_9_0.uiNameText, var_9_3.name)

	setText = var_9_2

	var_9_2(arg_9_0.uiUidText, var_9_3.id)

	getProxy = var_9_2
	UserProxy = var_4

	local var_9_4 = var_9_2(var_4)
	local var_9_5 = var_3.getRawData(var_9_4)

	getProxy = var_9_4
	ServerProxy = var_5

	local var_9_6 = var_9_4(var_5)
	local var_9_7 = var_4.getRawData(var_9_6)
	local var_9_8

	if not var_9_5 or not var_9_5.server then
		var_9_8 = 0
	end

	local var_9_9 = var_9_7[var_9_8]

	setScrollText = var_9_8

	local var_9_10 = arg_9_0.uiServerNameText
	local var_9_11

	if not var_9_9 or not var_9_9.name then
		var_9_11 = ""
	end

	var_9_8(var_9_10, var_9_11)

	getProxy = var_9_8
	AuctionGameBaseProxy = var_9_10

	local var_9_12 = var_9_8(var_9_10).matchNum

	setText = var_9_11

	var_9_11(arg_9_0.uiMatchesCntText, var_9_12)

	setText = var_9_11

	var_9_11(arg_9_0.uiSuccessCntText, var_5.bidSuccessCnt)

	setText = var_9_11

	local var_9_13 = arg_9_0.uiSuccessRateText

	string = var_9

	var_9_11(var_9_13, var_9.format("%.2f", var_5.totalBidPrice == 0 and 0 or var_5.totalCollectionPrice / var_5.totalBidPrice))

	setText = var_9_11

	local var_9_14 = arg_9_0.uiCurrencyText

	StringHelper = var_9

	var_9_11(var_9_14, var_9.ForamtNumberK(var_5.gold))

	setText = var_9_11

	local var_9_15 = arg_9_0.uiTotalProfitText

	StringHelper = var_9

	var_9_11(var_9_15, var_9.ForamtNumberK(var_5.totalProfit))

	setText = var_9_11

	local var_9_16 = arg_9_0.uiHighestProfitText

	StringHelper = var_9

	var_9_11(var_9_16, var_9.ForamtNumberK(var_5.highestProfit))

	setText = var_9_11

	local var_9_17 = arg_9_0.uiCollectionText

	string = var_9

	local var_9_18 = var_9.format
	local var_9_19 = "<color=#393a3c>%s/</color>%s"
	local var_9_20 = var_5.unlockCollectionCnt

	pg = var_1_10012

	var_9_11(var_9_17, var_9_18(var_9_19, var_9_20, #var_1_10012.auction_collection.all))

	setText = var_9_11

	local var_9_21 = arg_9_0.uiCollectionPriceText

	StringHelper = var_9

	var_9_11(var_9_21, var_9.ForamtNumberK(var_5.totalCollectionPrice))

	local var_9_22 = var_9_3
	local var_9_23 = var_9_3.GetShipPhantomMarks(var_9_22)[1]

	getProxy = var_9_22
	BayProxy = var_9

	local var_9_24 = var_9_22(var_9)

	arg_9_0.shipVO = var_8.GetShipPhantom(var_9_24, var_9_23)
	setPaintingPrefabAsync = var_8

	local var_9_25 = arg_9_0.uiPaintingTf
	local var_9_26 = arg_9_0.shipVO
	local var_9_27 = var_10.getPainting(var_9_26)
	local var_9_28 = "biandui"
	local var_9_29
	local var_9_30 = {}
	local var_9_31 = arg_9_0.shipVO

	var_9_30.skinID = var_14.getSkinId(var_9_31)
	var_9_30.rotateZ = arg_9_0.paintingDefaultAngle.z

	var_8(var_9_25, var_9_27, var_9_28, var_9_29, var_9_30)

	GetImageSpriteFromAtlasAsync = var_8

	local var_9_32 = "SquareIcon/"
	local var_9_33 = arg_9_0.shipVO

	var_8(var_9_32 .. var_10.getPainting(var_9_33), "", arg_9_0.uiIcon)

	pg = var_8

	local var_9_34 = var_8.GameTrackerMgr.GetInstance()
	local var_9_35 = var_8.Record

	GameTrackerBuilder = var_10

	var_9_35(var_9_34, var_10.BuildNameCard(0, var_9_3.id))

	return
end

function var_0_1.willExit(arg_10_0)
	retPaintingPrefab = var_1_10001

	local var_10_0 = arg_10_0.uiPaintingTf
	local var_10_1 = arg_10_0.shipVO

	var_1_10001(var_10_0, var_3.getPainting(var_10_1))
	arg_10_0:UnOverlayPanel(arg_10_0._tf)

	return
end

return var_0_1
