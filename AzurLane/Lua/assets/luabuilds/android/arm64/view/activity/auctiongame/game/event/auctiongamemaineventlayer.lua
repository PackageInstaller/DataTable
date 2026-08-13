class = var_0_10000

local var_0_0 = "AuctionGameMainEventLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameMainEventUI"
end

function var_0_1.init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiBgBtn

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiOkBtn

	local function var_2_5()
		getProxy = var_2_10000
		AuctionGameProxy = var_2_10002

		local var_4_0 = var_2_10000(var_2_10002)

		if var_0.GetPersonalEventSelectedID(var_4_0) ~= 0 then
			return
		end

		if arg_2_0.selectedID == 0 then
			return
		end

		pg = var_1

		local var_4_1 = var_1.gameset.auction_event_choose_time.key_value
		local var_4_2 = var_0:GetTimestamp()

		pg = var_4_0

		local var_4_3 = var_4_0.TimeMgr.GetInstance()
		local var_4_4 = var_4_1 - (var_4_2 - var_3.GetServerTime(var_4_3))

		pg = var_2

		local var_4_5 = var_2.GameTrackerMgr.GetInstance()
		local var_4_6 = var_2.Record

		GameTrackerBuilder = var_4_3

		var_4_6(var_4_5, var_4_3.BuildAuctionChooseEvent(var_0:GetAuctionID(), var_0:GetRound(), var_4_4, arg_2_0.selectedID))

		local var_4_7 = arg_2_0
		local var_4_8 = var_2.emit

		AuctionGameMainEventMediator = var_5

		var_4_8(var_4_7, var_5.EVENT_SELECTED_ID, arg_2_0.selectedID)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10006)

	arg_2_0.eventItemList = {}

	return
end

function var_0_1.didEnter(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.CriMgr.GetInstance()
	local var_5_1 = var_1.PlaySoundEffect_V3

	AuctionGameConst = var_1_10004

	var_5_1(var_5_0, var_1_10004.SOUND_EFFECT.EXPAND_POPUP)

	local var_5_2 = arg_5_0

	arg_5_0.OverlayPanel(var_5_2, arg_5_0._tf, {
		pbList = {
			arg_5_0.uiBg
		}
	})

	getProxy = var_1
	AuctionGameProxy = var_5_2

	local var_5_3 = var_1(var_5_2)
	local var_5_4 = var_1.GetPersonalEventList(var_5_3)

	ipairs = var_5_2

	for iter_5_0, iter_5_1 in var_5_2(var_5_4) do
		var_1_10008 = arg_5_0.eventItemList
		AuctionGameMainEventItem = var_1_10009
		var_1_10009 = var_1_10009.New
		string = var_1_10011
		var_1_10008[iter_5_0] = var_1_10009(arg_5_0[var_1_10011.format("uiEventItemTf%s", iter_5_0)], arg_5_0)

		local var_5_5 = arg_5_0.eventItemList[iter_5_0]

		var_1_10008.didEnter(var_5_5, iter_5_1)
	end

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.OnSelectedID

	_ = iter_5_0

	var_5_7(var_5_6, iter_5_0, var_1:GetPersonalEventSelectedID())

	local var_5_8 = {}
	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.bind

	AuctionGameMainEventItem = var_7

	local var_5_11 = var_7.AUCTION_GAME_SELECTED_EVENT

	handler = var_1_10008
	var_5_8[1] = var_5_10(var_5_9, var_5_11, var_1_10008(arg_5_0, arg_5_0.OnSelectedID))
	arg_5_0.eventList = var_5_8

	return
end

function var_0_1.OnSelectedID(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.selectedID = arg_6_2
	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_0.eventItemList) do
		iter_6_1:SetSelected(arg_6_2)
	end

	arg_6_0:RefreshOkBtn()

	return
end

function var_0_1.RefreshOkBtn(arg_7_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10003

	local var_7_0 = var_1_10001(var_1_10003)

	if var_1.GetPersonalEventSelectedID(var_7_0) ~= 0 then
		return
	end

	return
end

function var_0_1.willExit(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.CriMgr.GetInstance()
	local var_8_1 = var_1.PlaySoundEffect_V3

	AuctionGameConst = var_1_10004

	var_8_1(var_8_0, var_1_10004.SOUND_EFFECT.COLLAPSE_POPUP)
	arg_8_0:UnOverlayPanel(arg_8_0._tf)

	ipairs = var_1

	for iter_8_0, iter_8_1 in var_1(arg_8_0.eventList) do
		arg_8_0:disconnect(iter_8_1)
	end

	arg_8_0.eventList = nil
	ipairs = var_1

	for iter_8_2, iter_8_3 in var_1(arg_8_0.eventItemList) do
		iter_8_3:willExit()
	end

	arg_8_0.eventItemList = nil

	return
end

return var_0_1
