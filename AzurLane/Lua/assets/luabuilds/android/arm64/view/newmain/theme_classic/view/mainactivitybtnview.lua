local var_0_0 = class("MainActivityBtnView", import("...base.MainBaseView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.initPos = nil
	arg_1_0.isInit = nil
	arg_1_0.actBtnTpl = arg_1_1:Find("actBtn")
	arg_1_0.linkBtnTopFoldableHelper = MainFoldableHelper.New(arg_1_0._tf.parent:Find("link_top"), Vector2(0, 1))
	arg_1_0.checkNotchRatio = NotchAdapt.CheckNotchRatio

	arg_1_0:InitBtns()
	arg_1_0:Register()

	return
end

function var_0_0.GetActivityBtnList()
	return {
		MainActSummaryBtn,
		MainCoreActivityBtn,
		MainActEscortBtn,
		MainActMapBtn,
		MainActBossBtn,
		MainActBackHillBtn,
		MainActAtelierBtn,
		MainLanternFestivalBtn,
		MainActBossRushBtn,
		MainActAprilFoolBtn,
		MainActMedalCollectionBtn,
		MainActSenranBtn,
		MainActBossSingleBtn,
		MainActLayerBtn,
		MainActDreamlandBtn,
		MainActBoatAdBtn,
		MainActBlackFridaySalesBtn,
		MainActToLoveBtn,
		MainActHolidayVillaBtn,
		MainCoreActivityBtn2
	}
end

function var_0_0.GetSpecailBtns()
	return {
		MainActInsBtn,
		MainActTraingCampBtn,
		MainActRefluxBtn,
		MainActNewServerBtn,
		MainActDelegationBtn,
		MainIslandActDelegationBtn,
		MainVoteEntranceBtn,
		MainActCompensatBtn
	}
end

function var_0_0.InitBtns(arg_4_0)
	arg_4_0.activityBtns = {}

	for iter_4_0, iter_4_1 in ipairs(var_0_0.GetActivityBtnList()) do
		if iter_4_0 == 1 then
			table.insert(arg_4_0.activityBtns, iter_4_1.New(arg_4_0.actBtnTpl, arg_4_0.event, true))
		elseif iter_4_0 == 2 then
			table.insert(arg_4_0.activityBtns, iter_4_1.New(arg_4_0.actBtnTpl, arg_4_0.event, false))
		else
			table.insert(arg_4_0.activityBtns, iter_4_1.New(arg_4_0.actBtnTpl, arg_4_0.event))
		end
	end

	arg_4_0.specailBtns = {}

	for iter_4_2, iter_4_3 in ipairs(var_0_0.GetSpecailBtns()) do
		table.insert(arg_4_0.specailBtns, iter_4_3.New(arg_4_0._tf, arg_4_0.event))
	end

	if pg.SdkMgr.GetInstance():CheckAudit() then
		arg_4_0.specailBtns = {
			MainActTraingCampBtn.New(arg_4_0._tf, arg_4_0.event)
		}
	end

	return
end

function var_0_0.Register(arg_5_0)
	arg_5_0:bind(GAME.REMOVE_LAYERS, function(arg_6_0, arg_6_1)
		arg_5_0:OnRemoveLayer(arg_6_1.context)

		return
	end)
	arg_5_0:bind(GAME.REQ_NEW_INSTAGRAM_DATA_DONE, function(arg_7_0)
		arg_5_0:OnInstagramDataUpdate()

		return
	end)
	arg_5_0:bind(MiniGameProxy.ON_HUB_DATA_UPDATE, function(arg_8_0)
		arg_5_0:Refresh()

		return
	end)
	arg_5_0:bind(GAME.SEND_MINI_GAME_OP_DONE, function(arg_9_0)
		arg_5_0:Refresh()

		return
	end)
	arg_5_0:bind(GAME.GET_FEAST_DATA_DONE, function(arg_10_0)
		arg_5_0:Refresh()

		return
	end)
	arg_5_0:bind(GAME.FETCH_VOTE_INFO_DONE, function(arg_11_0)
		arg_5_0:Refresh()

		return
	end)
	arg_5_0:bind(GAME.ZERO_HOUR_OP_DONE, function(arg_12_0)
		arg_5_0:Refresh()

		return
	end)
	arg_5_0:bind(CompensateProxy.UPDATE_ATTACHMENT_COUNT, function(arg_13_0)
		arg_5_0:Refresh()

		return
	end)
	arg_5_0:bind(CompensateProxy.All_Compensate_Remove, function(arg_14_0)
		arg_5_0:Refresh()

		return
	end)

	return
end

function var_0_0.GetBtn(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.activityBtns) do
		if isa(iter_15_1, arg_15_1) then
			return iter_15_1
		end
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_0.specailBtns) do
		if isa(iter_15_3, arg_15_1) then
			return iter_15_3
		end
	end

	return nil
end

function var_0_0.OnRemoveLayer(arg_16_0, arg_16_1)
	local var_16_0

	if arg_16_1.mediator == LotteryMediator then
		var_16_0 = arg_16_0:GetBtn(MainActLotteryBtn)
	elseif arg_16_1.mediator == InstagramMainMediator then
		var_16_0 = arg_16_0:GetBtn(MainActInsBtn)
	end

	if var_16_0 and var_16_0:InShowTime() then
		var_16_0:OnInit()
	end

	return
end

function var_0_0.OnInstagramDataUpdate(arg_17_0)
	local var_17_0 = arg_17_0:GetBtn(MainActInsBtn)

	if var_17_0 and var_17_0:InShowTime() then
		var_17_0:OnInit()
	end

	return
end

function var_0_0.Init(arg_18_0)
	arg_18_0:Flush()

	arg_18_0.isInit = true

	return
end

function var_0_0.FilterActivityBtns(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.activityBtns) do
		if iter_19_1:InShowTime() then
			table.insert({}, iter_19_1)
		else
			table.insert({}, iter_19_1)
		end
	end

	table.sort({}, CompareFuncs({
		function(arg_20_0)
			return arg_20_0.config.group_id
		end
	}))

	return {}, {}
end

function var_0_0.FilterSpActivityBtns(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.specailBtns) do
		if iter_21_1:InShowTime() then
			table.insert({}, iter_21_1)
		else
			table.insert({}, iter_21_1)
		end
	end

	return {}, {}
end

function var_0_0.Flush(arg_22_0)
	if arg_22_0.checkNotchRatio ~= NotchAdapt.CheckNotchRatio then
		arg_22_0.checkNotchRatio = NotchAdapt.CheckNotchRatio
		arg_22_0.initPos = nil
	end

	local var_22_0, var_22_1 = arg_22_0:FilterActivityBtns()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		iter_22_1:Init(iter_22_0)
	end

	for iter_22_2, iter_22_3 in ipairs(var_22_1) do
		iter_22_3:Clear()
	end

	local var_22_2 = #var_22_0
	local var_22_3 = #var_22_0 <= 3
	local var_22_4 = #var_22_0 <= 3 and 390 or 420

	arg_22_0._tf.localScale = Vector3(#var_22_0 <= 3 and 1 or 0.85, #var_22_0 <= 3 and 1 or 0.85, 1)
	arg_22_0.initPos = arg_22_0.initPos or arg_22_0._tf.localPosition

	onNextTick(function()
		if not IsNil(arg_22_0._tf) then
			arg_22_0._tf.localPosition = Vector3(arg_22_0.initPos.x, var_22_4, 0)
		end

		return
	end)

	local var_22_5, var_22_6 = arg_22_0:FilterSpActivityBtns()

	for iter_22_4, iter_22_5 in pairs(var_22_5) do
		iter_22_5:Init(not var_22_3, var_22_2 >= 5)
	end

	for iter_22_6, iter_22_7 in pairs(var_22_6) do
		iter_22_7:Clear()
	end

	return
end

function var_0_0.Refresh(arg_24_0)
	if not arg_24_0.isInit then
		return
	end

	arg_24_0:Flush()

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.specailBtns) do
		if iter_24_1:InShowTime() then
			iter_24_1:Refresh()
		end
	end

	return
end

function var_0_0.Disable(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.specailBtns) do
		if iter_25_1:InShowTime() then
			iter_25_1:Disable()
		end
	end

	return
end

function var_0_0.Dispose(arg_26_0)
	var_0_0.super.Dispose(arg_26_0)
	arg_26_0.linkBtnTopFoldableHelper:Dispose()

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.activityBtns) do
		iter_26_1:Dispose()
	end

	for iter_26_2, iter_26_3 in ipairs(arg_26_0.specailBtns) do
		iter_26_3:Dispose()
	end

	arg_26_0.specailBtns = nil
	arg_26_0.activityBtns = nil

	return
end

function var_0_0.Fold(arg_27_0, arg_27_1, arg_27_2)
	var_0_0.super.Fold(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.linkBtnTopFoldableHelper:Fold(arg_27_1, arg_27_2)

	return
end

function var_0_0.GetDirection(arg_28_0)
	return Vector2(1, 0)
end

return var_0_0
