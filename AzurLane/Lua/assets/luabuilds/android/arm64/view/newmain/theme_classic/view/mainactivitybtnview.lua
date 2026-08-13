class = var_0_10000

local var_0_0 = "MainActivityBtnView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.MainBaseView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.initPos = nil
	arg_1_0.isInit = nil
	arg_1_0.actBtnTpl = arg_1_1:Find("actBtn")
	MainFoldableHelper = var_3

	local var_1_0 = var_3.New
	local var_1_1 = arg_1_0._tf.parent
	local var_1_2 = var_5.Find(var_1_1, "link_top")

	Vector2 = var_6
	arg_1_0.linkBtnTopFoldableHelper = var_1_0(var_1_2, var_6(0, 1))
	NotchAdapt = var_3
	arg_1_0.checkNotchRatio = var_3.CheckNotchRatio

	arg_1_0:InitBtns()
	arg_1_0:Register()

	return
end

function var_0_1.GetActivityBtnList()
	local var_2_0 = {}

	MainActSummaryBtn = var_1_10001
	var_2_0[1] = var_1_10001
	MainCoreActivityBtn = var_1_10001
	var_2_0[2] = var_1_10001
	MainActEscortBtn = var_1_10001
	var_2_0[3] = var_1_10001
	MainActMapBtn = var_1_10001
	var_2_0[4] = var_1_10001
	MainActBossBtn = var_1_10001
	var_2_0[5] = var_1_10001
	MainActBackHillBtn = var_1_10001
	var_2_0[6] = var_1_10001
	MainActAtelierBtn = var_1_10001
	var_2_0[7] = var_1_10001
	MainLanternFestivalBtn = var_1_10001
	var_2_0[8] = var_1_10001
	MainActBossRushBtn = var_1_10001
	var_2_0[9] = var_1_10001
	MainActAprilFoolBtn = var_1_10001
	var_2_0[10] = var_1_10001
	MainActMedalCollectionBtn = var_1_10001
	var_2_0[11] = var_1_10001
	MainActSenranBtn = var_1_10001
	var_2_0[12] = var_1_10001
	MainActBossSingleBtn = var_1_10001
	var_2_0[13] = var_1_10001
	MainActLayerBtn = var_1_10001
	var_2_0[14] = var_1_10001
	MainActDreamlandBtn = var_1_10001
	var_2_0[15] = var_1_10001
	MainActBoatAdBtn = var_1_10001
	var_2_0[16] = var_1_10001
	MainActBlackFridaySalesBtn = var_1_10001
	var_2_0[17] = var_1_10001
	MainActToLoveBtn = var_1_10001
	var_2_0[18] = var_1_10001
	MainActHolidayVillaBtn = var_1_10001
	var_2_0[19] = var_1_10001
	MainCoreActivityBtn2 = var_1_10001
	var_2_0[20] = var_1_10001

	return var_2_0
end

function var_0_1.GetSpecailBtns()
	local var_3_0 = {}

	MainActInsBtn = var_1_10001
	var_3_0[1] = var_1_10001
	MainActTraingCampBtn = var_1_10001
	var_3_0[2] = var_1_10001
	MainActRefluxBtn = var_1_10001
	var_3_0[3] = var_1_10001
	MainActNewServerBtn = var_1_10001
	var_3_0[4] = var_1_10001
	MainActDelegationBtn = var_1_10001
	var_3_0[5] = var_1_10001
	MainIslandActDelegationBtn = var_1_10001
	var_3_0[6] = var_1_10001
	MainVoteEntranceBtn = var_1_10001
	var_3_0[7] = var_1_10001
	MainActCompensatBtn = var_1_10001
	var_3_0[8] = var_1_10001

	return var_3_0
end

function var_0_1.InitBtns(arg_4_0)
	arg_4_0.activityBtns = {}
	ipairs = var_1

	for iter_4_0, iter_4_1 in var_1(var_0_1.GetActivityBtnList()) do
		if iter_4_0 == 1 then
			table = var_1_10006

			var_1_10006.insert(arg_4_0.activityBtns, iter_4_1.New(arg_4_0.actBtnTpl, arg_4_0.event, true))
		elseif iter_4_0 == 2 then
			table = var_1_10006

			var_1_10006.insert(arg_4_0.activityBtns, iter_4_1.New(arg_4_0.actBtnTpl, arg_4_0.event, false))
		else
			table = var_1_10006

			var_1_10006.insert(arg_4_0.activityBtns, iter_4_1.New(arg_4_0.actBtnTpl, arg_4_0.event))
		end
	end

	arg_4_0.specailBtns = {}
	ipairs = var_1

	for iter_4_2, iter_4_3 in var_1(var_0_1.GetSpecailBtns()) do
		table = var_1_10006

		var_1_10006.insert(arg_4_0.specailBtns, iter_4_3.New(arg_4_0._tf, arg_4_0.event))
	end

	pg = var_1

	local var_4_0 = var_1.SdkMgr.GetInstance()

	if var_1.CheckAudit(var_4_0) then
		local var_4_1 = {}

		MainActTraingCampBtn = var_2
		var_4_1[1] = var_2.New(arg_4_0._tf, arg_4_0.event)
		arg_4_0.specailBtns = var_4_1
	end

	return
end

function var_0_1.Register(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.bind

	GAME = var_1_10004

	var_5_1(var_5_0, var_1_10004.REMOVE_LAYERS, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_5_0

		var_2.OnRemoveLayer(var_6_0, arg_6_1.context)

		return
	end)

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.bind

	GAME = var_4

	var_5_3(var_5_2, var_4.REQ_NEW_INSTAGRAM_DATA_DONE, function(arg_7_0)
		local var_7_0 = arg_5_0

		var_1.OnInstagramDataUpdate(var_7_0)

		return
	end)

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.bind

	MiniGameProxy = var_4

	var_5_5(var_5_4, var_4.ON_HUB_DATA_UPDATE, function(arg_8_0)
		local var_8_0 = arg_5_0

		var_1.Refresh(var_8_0)

		return
	end)

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.bind

	GAME = var_4

	var_5_7(var_5_6, var_4.SEND_MINI_GAME_OP_DONE, function(arg_9_0)
		local var_9_0 = arg_5_0

		var_1.Refresh(var_9_0)

		return
	end)

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.bind

	GAME = var_4

	var_5_9(var_5_8, var_4.GET_FEAST_DATA_DONE, function(arg_10_0)
		local var_10_0 = arg_5_0

		var_1.Refresh(var_10_0)

		return
	end)

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.bind

	GAME = var_4

	var_5_11(var_5_10, var_4.FETCH_VOTE_INFO_DONE, function(arg_11_0)
		local var_11_0 = arg_5_0

		var_1.Refresh(var_11_0)

		return
	end)

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.bind

	GAME = var_4

	var_5_13(var_5_12, var_4.ZERO_HOUR_OP_DONE, function(arg_12_0)
		local var_12_0 = arg_5_0

		var_1.Refresh(var_12_0)

		return
	end)

	local var_5_14 = arg_5_0
	local var_5_15 = arg_5_0.bind

	CompensateProxy = var_4

	var_5_15(var_5_14, var_4.UPDATE_ATTACHMENT_COUNT, function(arg_13_0)
		local var_13_0 = arg_5_0

		var_1.Refresh(var_13_0)

		return
	end)

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.bind

	CompensateProxy = var_4

	var_5_17(var_5_16, var_4.All_Compensate_Remove, function(arg_14_0)
		local var_14_0 = arg_5_0

		var_1.Refresh(var_14_0)

		return
	end)

	return
end

function var_0_1.GetBtn(arg_15_0, arg_15_1)
	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_0.activityBtns) do
		isa = var_1_10007

		if var_1_10007(iter_15_1, arg_15_1) then
			return iter_15_1
		end
	end

	ipairs = var_2

	for iter_15_2, iter_15_3 in var_2(arg_15_0.specailBtns) do
		isa = var_1_10007

		if var_1_10007(iter_15_3, arg_15_1) then
			return iter_15_3
		end
	end

	return nil
end

function var_0_1.OnRemoveLayer(arg_16_0, arg_16_1)
	local var_16_0
	local var_16_1 = arg_16_1.mediator

	LotteryMediator = var_1_10004

	if var_16_1 == var_1_10004 then
		local var_16_2 = arg_16_0
		local var_16_3 = arg_16_0.GetBtn

		MainActLotteryBtn = var_1_10006
		var_16_0 = var_16_3(var_16_2, var_1_10006)
	else
		local var_16_4 = arg_16_1.mediator

		InstagramMainMediator = var_1_10004

		if var_16_4 == var_1_10004 then
			local var_16_5 = arg_16_0
			local var_16_6 = arg_16_0.GetBtn

			MainActInsBtn = var_1_10006
			var_16_0 = var_16_6(var_16_5, var_1_10006)
		end
	end

	if var_16_0 and var_16_0:InShowTime() then
		var_16_0:OnInit()
	end

	return
end

function var_0_1.OnInstagramDataUpdate(arg_17_0)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.GetBtn

	MainActInsBtn = var_1_10004

	if var_17_1(var_17_0, var_1_10004) and var_1:InShowTime() then
		var_1:OnInit()
	end

	return
end

function var_0_1.Init(arg_18_0)
	arg_18_0:Flush()

	arg_18_0.isInit = true

	return
end

function var_0_1.FilterActivityBtns(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = {}

	ipairs = var_1_10003

	for iter_19_0, iter_19_1 in var_1_10003(arg_19_0.activityBtns) do
		if iter_19_1:InShowTime() then
			table = var_8

			var_8.insert(var_19_0, iter_19_1)
		else
			table = var_8

			var_8.insert(var_19_1, iter_19_1)
		end
	end

	table = var_3

	local var_19_2 = var_3.sort
	local var_19_3 = var_19_0

	CompareFuncs = iter_19_0

	var_19_2(var_19_3, iter_19_0({
		function(arg_20_0)
			return arg_20_0.config.group_id
		end
	}))

	return var_19_0, var_19_1
end

function var_0_1.FilterSpActivityBtns(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = {}

	ipairs = var_1_10003

	for iter_21_0, iter_21_1 in var_1_10003(arg_21_0.specailBtns) do
		if iter_21_1:InShowTime() then
			table = var_8

			var_8.insert(var_21_0, iter_21_1)
		else
			table = var_8

			var_8.insert(var_21_1, iter_21_1)
		end
	end

	return var_21_0, var_21_1
end

function var_0_1.Flush(arg_22_0)
	local var_22_0 = arg_22_0.checkNotchRatio

	NotchAdapt = var_1_10002

	if var_22_0 ~= var_1_10002.CheckNotchRatio then
		NotchAdapt = var_22_0
		arg_22_0.checkNotchRatio = var_22_0.CheckNotchRatio
		arg_22_0.initPos = nil
	end

	local var_22_1 = arg_22_0
	local var_22_2, var_22_3 = arg_22_0.FilterActivityBtns(var_22_1)

	ipairs = var_22_1

	for iter_22_0, iter_22_1 in var_22_1(var_22_2) do
		iter_22_1:Init(iter_22_0)
	end

	ipairs = var_3

	for iter_22_2, iter_22_3 in var_3(var_22_3) do
		iter_22_3:Clear()
	end

	local var_22_4 = #var_22_2 <= 3 and 1 or 0.85
	local var_22_5 = var_4 and 390 or 420
	local var_22_6 = arg_22_0._tf

	Vector3 = var_1_10008
	var_22_6.localScale = var_1_10008(var_22_4, var_22_4, 1)

	local var_22_7

	if not arg_22_0.initPos then
		var_22_7 = arg_22_0._tf.localPosition
	end

	arg_22_0.initPos = var_22_7
	onNextTick = var_22_7

	var_22_7(function()
		IsNil = var_2_10000

		if not var_2_10000(arg_22_0._tf) then
			local var_23_0 = arg_22_0._tf

			Vector3 = var_2_10001
			var_23_0.localPosition = var_2_10001(arg_22_0.initPos.x, var_22_5, 0)
		end

		return
	end)

	local var_22_8 = arg_22_0
	local var_22_9, var_22_10 = arg_22_0.FilterSpActivityBtns(var_22_8)

	pairs = var_22_8

	for iter_22_4, iter_22_5 in var_22_8(var_22_9) do
		iter_22_5:Init(not var_4, var_3 >= 5)
	end

	pairs = var_9

	for iter_22_6, iter_22_7 in var_9(var_22_10) do
		iter_22_7:Clear()
	end

	return
end

function var_0_1.Refresh(arg_24_0)
	if not arg_24_0.isInit then
		return
	end

	arg_24_0:Flush()

	ipairs = var_1

	for iter_24_0, iter_24_1 in var_1(arg_24_0.specailBtns) do
		if iter_24_1:InShowTime() then
			iter_24_1:Refresh()
		end
	end

	return
end

function var_0_1.Disable(arg_25_0)
	ipairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.specailBtns) do
		if iter_25_1:InShowTime() then
			iter_25_1:Disable()
		end
	end

	return
end

function var_0_1.Dispose(arg_26_0)
	var_0_1.super.Dispose(arg_26_0)

	local var_26_0 = arg_26_0.linkBtnTopFoldableHelper

	var_1.Dispose(var_26_0)

	ipairs = var_1

	for iter_26_0, iter_26_1 in var_1(arg_26_0.activityBtns) do
		iter_26_1:Dispose()
	end

	ipairs = var_1

	for iter_26_2, iter_26_3 in var_1(arg_26_0.specailBtns) do
		iter_26_3:Dispose()
	end

	arg_26_0.specailBtns = nil
	arg_26_0.activityBtns = nil

	return
end

function var_0_1.Fold(arg_27_0, arg_27_1, arg_27_2)
	var_0_1.super.Fold(arg_27_0, arg_27_1, arg_27_2)

	local var_27_0 = arg_27_0.linkBtnTopFoldableHelper

	var_3.Fold(var_27_0, arg_27_1, arg_27_2)

	return
end

function var_0_1.GetDirection(arg_28_0)
	Vector2 = var_1_10001

	return var_1_10001(1, 0)
end

return var_0_1
