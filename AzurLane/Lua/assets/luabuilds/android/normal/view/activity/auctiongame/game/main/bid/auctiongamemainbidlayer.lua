class = var_0_10000

local var_0_0 = "AuctionGameMainBidLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameMainBidUI"
end

function var_0_1.init(arg_2_0)
	GetComponent = var_1_10001

	local var_2_0 = arg_2_0.uiBidAnimationTf

	typeof = var_1_10003
	DftAniEvent = var_1_10004
	arg_2_0.bidEventCom = var_1_10001(var_2_0, var_1_10003(var_1_10004))

	local var_2_1 = arg_2_0.bidEventCom

	var_1.SetEndEvent(var_2_1, function()
		local var_3_0 = arg_2_0

		var_0.OnClickBidBtn(var_3_0)

		return
	end)

	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.uiCloseBtn

	local function var_2_4()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1(var_2_2, var_2_3, var_2_4, var_1_10005)

	for iter_2_0 = 0, 9 do
		onButton = var_1_10005

		local var_2_5 = arg_2_0

		string = var_1_10007
		var_1_10007 = arg_2_0[var_1_10007.format("uiNumBtn%s", iter_2_0)]

		local function var_2_6()
			local var_5_0 = arg_2_0

			var_0.AddNum(var_5_0, iter_2_0)

			local var_5_1 = arg_2_0

			var_0.RefreshNumText(var_5_1)

			return
		end

		AuctionGameConst = var_9

		var_1_10005(var_2_5, var_1_10007, var_2_6, var_9.SOUND_EFFECT.BID_KEYPAD)
	end

	onButton = var_1

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.uiBtn00

	local function var_2_9()
		local var_6_0 = arg_2_0

		var_0.MultiplierNum(var_6_0, 100)

		local var_6_1 = arg_2_0

		var_0.RefreshNumText(var_6_1)

		return
	end

	AuctionGameConst = var_1_10005

	var_1(var_2_7, var_2_8, var_2_9, var_1_10005.SOUND_EFFECT.BID_KEYPAD)

	onButton = var_1

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.uiBtn000

	local function var_2_12()
		local var_7_0 = arg_2_0

		var_0.MultiplierNum(var_7_0, 1000)

		local var_7_1 = arg_2_0

		var_0.RefreshNumText(var_7_1)

		return
	end

	AuctionGameConst = var_5

	var_1(var_2_10, var_2_11, var_2_12, var_5.SOUND_EFFECT.BID_KEYPAD)

	onButton = var_1

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.uiMultiplierBtn

	local function var_2_15()
		local var_8_0 = arg_2_0

		var_0.MultiplierNum(var_8_0, arg_2_0.multiplierNum)

		local var_8_1 = arg_2_0

		var_0.RefreshNumText(var_8_1)

		return
	end

	AuctionGameConst = var_5

	var_1(var_2_13, var_2_14, var_2_15, var_5.SOUND_EFFECT.BID_KEYPAD)

	onButton = var_1

	local var_2_16 = arg_2_0
	local var_2_17 = arg_2_0.uiDeleteBtn

	local function var_2_18()
		local var_9_0 = arg_2_0

		var_0.DeleteNum(var_9_0)

		local var_9_1 = arg_2_0

		var_0.RefreshNumText(var_9_1)

		return
	end

	AuctionGameConst = var_5

	var_1(var_2_16, var_2_17, var_2_18, var_5.SOUND_EFFECT.BID_KEYPAD)

	onButton = var_1

	local var_2_19 = arg_2_0
	local var_2_20 = arg_2_0.uiClearBtn

	local function var_2_21()
		arg_2_0.inputNum = 0

		local var_10_0 = arg_2_0

		var_0.RefreshNumText(var_10_0)

		return
	end

	AuctionGameConst = var_5

	var_1(var_2_19, var_2_20, var_2_21, var_5.SOUND_EFFECT.BID_KEYPAD)

	onButton = var_1

	local var_2_22 = arg_2_0
	local var_2_23 = arg_2_0.uiBidBtn

	local function var_2_24()
		if arg_2_0.startBid == true then
			return
		end

		local var_11_0 = arg_2_0.inputNum

		if arg_2_0.bided then
			return
		end

		getProxy = var_1
		AuctionGameProxy = var_2_10002

		local var_11_1 = var_1(var_2_10002)
		local var_11_2 = var_1.GetAuctionState(var_11_1)

		pg = var_11_1

		local var_11_3 = var_11_1.TimeMgr.GetInstance()
		local var_11_4 = var_3.GetServerTime(var_11_3)
		local var_11_5 = var_1

		if var_11_4 < var_1.GetTimestamp(var_11_5) then
			AuctionGameConst = var_11_4

			if var_11_2 ~= var_11_4.AUCTION_PHASE.BID then
				pg = var_11_4

				local var_11_6 = var_11_4.TipsMgr.GetInstance()

				var_11_4 = var_11_4.ShowTips
				i18n = var_11_5

				var_11_4(var_11_6, var_11_5("auction_game_wait_bid_phase"))

				return
			end
		end

		pg = var_11_4

		local var_11_7 = var_11_4.auction_session
		local var_11_8 = var_1
		local var_11_9

		if var_11_0 < var_11_7[var_1.GetAuctionID(var_11_8)].bottom_price then
			pg = var_11_9
			var_11_8 = var_11_9.TipsMgr.GetInstance()
			var_11_9 = var_11_9.ShowTips
			i18n = var_2_10006

			var_11_9(var_11_8, var_2_10006("auction_game_min_bid", var_3))

			return
		end

		getProxy = var_11_9
		AuctionGameBaseProxy = var_11_8

		if var_11_9(var_11_8).gold < var_11_0 then
			pg = var_5

			local var_11_10 = var_5.TipsMgr.GetInstance()
			local var_11_11 = var_5.ShowTips

			i18n = var_2_10007

			var_11_11(var_11_10, var_2_10007("auction_game_exceeds_max_value"))

			return
		end

		local var_11_12 = arg_2_0
		local var_11_13 = var_5.emit

		BaseUI = var_2_10007

		local var_11_14 = var_2_10007.ON_ADD_SUBLAYER

		Context = var_2_10008

		local var_11_15 = var_2_10008.New
		local var_11_16 = {}

		AuctionGameMainMsgLayer = var_2_10010
		var_11_16.viewComponent = var_2_10010
		AuctionGameMainMsgMediator = var_2_10010
		var_11_16.mediator = var_2_10010

		local var_11_17 = {}

		i18n = var_2_10011

		local var_11_18 = "auction_game_bid_confirm"

		StringHelper = var_2_10013
		var_11_17.content = var_2_10011(var_11_18, var_2_10013.ForamtNumber(var_11_0))

		function var_11_17.comformCallback()
			local var_12_0 = arg_2_0

			var_12_0.startBid = true
			quickPlayAnimation = var_12_0

			var_12_0(arg_2_0.uiBidAnimationTf, "Anim_AuctionGameEntranceUI_matchBtn_click")

			return
		end

		var_11_16.data = var_11_17

		var_11_13(var_11_12, var_11_14, var_11_15(var_11_16))

		return
	end

	AuctionGameConst = var_5

	var_1(var_2_22, var_2_23, var_2_24, var_5.SOUND_EFFECT.BID)

	setText = var_1

	local var_2_25 = arg_2_0.uiCurrencyTitleText

	i18n = var_2_23

	var_1(var_2_25, var_2_23("auction_main_pt"))

	getProxy = var_1
	ActivityProxy = var_2_25

	local var_2_26 = var_1(var_2_25)
	local var_2_27 = var_1.getActivityByType

	ActivityConst = var_4

	local var_2_28 = var_2_27(var_2_26, var_4.ACTIVITY_TYPE_AUCTION_GAME)
	local var_2_29 = var_2.getConfig(var_2_28, "config_client").itemID

	LoadSpriteAsync = var_2_28
	Drop = var_5

	local var_2_30 = var_5.New
	local var_2_31 = {}

	DROP_TYPE_VITEM = var_1_10007
	var_2_31.type = var_1_10007
	var_2_31.id = var_2_29

	local var_2_32 = var_2_30(var_2_31)

	var_2_28(var_5.getIcon(var_2_32), function(arg_13_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_2_0.uiCurrencyIcon) then
			arg_2_0.uiCurrencyIcon.sprite = arg_13_0
		end

		return
	end)

	setText = var_2_28

	local var_2_33 = arg_2_0.uiCurrencyText

	StringHelper = var_6

	local var_2_34 = var_6.ForamtNumber

	AuctionGameTools = var_1_10007

	var_2_28(var_2_33, var_2_34(var_1_10007.GetCurrencyCnt()))

	setText = var_2_28

	local var_2_35 = arg_2_0.uiClearText

	i18n = var_6

	var_2_28(var_2_35, var_6("auction_bid_keyboard_clear"))

	return
end

function var_0_1.didEnter(arg_14_0)
	arg_14_0:OverlayPanel(arg_14_0._tf, {
		pbList = {
			arg_14_0.uiBg
		}
	})

	pg = var_1

	local var_14_0 = var_1.CriMgr.GetInstance()
	local var_14_1 = var_1.PlaySoundEffect_V3

	AuctionGameConst = var_3

	var_14_1(var_14_0, var_3.SOUND_EFFECT.EXPAND_POPUP)

	getProxy = var_14_1
	AuctionGameProxy = var_14_0

	local var_14_2 = var_14_1(var_14_0)
	local var_14_4, var_14_5

	if var_1.GetRound(var_14_2) <= 1 then
		arg_14_0.inputNum = 0
	else
		getProxy = var_14_4
		PlayerProxy = var_4

		local var_14_3 = var_14_4(var_4)

		var_14_4 = var_14_4.getPlayerId(var_14_3)
		var_14_5 = var_1

		local var_14_6

		if not var_1.GetRoundEventAndBidInfoList(var_14_5)[var_2 - 1][var_14_4].bidValue then
			var_14_6 = 0
		end

		arg_14_0.inputNum = var_14_6
	end

	AuctionGameTools = var_14_4
	arg_14_0.maxValue = var_14_4.GetCurrencyCnt()

	arg_14_0:RefreshUI()

	if 5 <= var_2 then
		setText = var_3

		local var_14_7 = arg_14_0.uiMultiplierDescText

		i18n = var_14_5

		var_3(var_14_7, var_14_5("auction_round_instant_buy", "--"))
	else
		setText = var_3

		local var_14_8 = arg_14_0.uiMultiplierDescText

		i18n = var_14_5

		var_3(var_14_8, var_14_5("auction_round_instant_buy", arg_14_0.multiplierNum))
	end

	return
end

function var_0_1.RefreshUI(arg_15_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)
	local var_15_1 = var_1.GetRound(var_15_0) == 0 and 1 or var_15_1

	tonumber = var_15_0
	pg = var_1_10004
	arg_15_0.multiplierNum = var_15_0(var_1_10004.auction_round[var_15_1].one_hit)
	setText = var_3

	local var_15_2 = arg_15_0.uiMultiplierText

	string = var_1_10005

	var_3(var_15_2, var_1_10005.format("%s", arg_15_0.multiplierNum))
	arg_15_0:RefreshNumText()

	return
end

function var_0_1.AddNum(arg_16_0, arg_16_1)
	if arg_16_1 == 0 and arg_16_0.inputNum == 0 then
		return
	end

	arg_16_0.inputNum = arg_16_0.inputNum * 10 + arg_16_1

	if arg_16_0.inputNum > arg_16_0.maxValue then
		arg_16_0.inputNum = arg_16_0.maxValue
	end

	return
end

function var_0_1.DeleteNum(arg_17_0)
	if arg_17_0.inputNum == 0 then
		return
	end

	math = var_1
	arg_17_0.inputNum = var_1.floor(arg_17_0.inputNum / 10)

	return
end

function var_0_1.MultiplierNum(arg_18_0, arg_18_1)
	if arg_18_0.inputNum == 0 then
		return
	end

	math = var_2
	arg_18_0.inputNum = var_2.ceil(arg_18_0.inputNum * arg_18_1)

	if arg_18_0.inputNum > arg_18_0.maxValue then
		arg_18_0.inputNum = arg_18_0.maxValue
	end

	return
end

function var_0_1.RefreshNumText(arg_19_0)
	setText = var_1_10001

	local var_19_0 = arg_19_0.uiInputText

	StringHelper = var_1_10003

	var_1_10001(var_19_0, var_1_10003.ForamtNumber(arg_19_0.inputNum))

	return
end

function var_0_1.OnClickBidBtn(arg_20_0)
	arg_20_0.startBid = false
	getProxy = var_1
	AuctionGameProxy = var_1_10002

	local var_20_0 = var_1(var_1_10002)

	pg = var_1_10002

	local var_20_1 = var_1_10002.gameset.auction_bid_time.key_value
	local var_20_2 = var_20_0
	local var_20_3 = var_20_0.GetTimestamp(var_20_2)

	pg = var_20_2

	local var_20_4 = var_20_2.TimeMgr.GetInstance()
	local var_20_5 = var_20_1 - (var_20_3 - var_4.GetServerTime(var_20_4))

	pg = var_3

	local var_20_6 = var_3.GameTrackerMgr.GetInstance()
	local var_20_7 = var_3.Record

	GameTrackerBuilder = var_20_4

	var_20_7(var_20_6, var_20_4.BuildAuctionBid(var_20_0:GetAuctionID(), var_20_0:GetRound(), var_20_5, arg_20_0.inputNum, 0))

	local var_20_8 = arg_20_0.inputNum
	local var_20_9 = arg_20_0
	local var_20_10 = arg_20_0.emit

	AuctionGameMainBidMediator = var_6

	var_20_10(var_20_9, var_6.BID, var_20_8)

	return
end

function var_0_1.willExit(arg_21_0)
	arg_21_0:UnOverlayPanel(arg_21_0._tf)

	local var_21_0 = arg_21_0.bidEventCom

	var_1.SetEndEvent(var_21_0, nil)

	pg = var_1

	local var_21_1 = var_1.CriMgr.GetInstance()
	local var_21_2 = var_1.PlaySoundEffect_V3

	AuctionGameConst = var_3

	var_21_2(var_21_1, var_3.SOUND_EFFECT.COLLAPSE_POPUP)

	return
end

return var_0_1
