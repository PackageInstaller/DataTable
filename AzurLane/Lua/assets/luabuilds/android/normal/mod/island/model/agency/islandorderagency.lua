class = var_0_10000

local var_0_0 = "IslandOrderAgency"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

var_0_1.GEN_NEW_ORDER = "IslandOrderAgency:GEN_NEW_ORDER"
var_0_1.UDPATE_ORDER = "IslandOrderAgency:UDPATE_ORDER"
var_0_1.ORDER_FINISH_UPDATE = "IslandOrderAgency:ORDER_FINISH_UPDATE"
var_0_1.COMMON_ORDER_TYPE = 1
var_0_1.URGENCY_ORDER_TYPE = 2
var_0_1.SHIP_ORDER_TYPE = 3

function var_0_1.OnInit(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.InitData
	local var_1_2

	if not arg_1_1.order_system then
		var_1_2 = {}
	end

	var_1_1(var_1_0, var_1_2)

	return
end

function var_0_1.InitData(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_1.favor then
		var_2_0 = 0
	end

	arg_2_0.exp = var_2_0

	local var_2_1

	if not arg_2_1.daily_select then
		IslandOrderSlot = var_2_1
		var_2_1 = var_2_1.TENDENCY_TYPE_COMMON
	end

	arg_2_0.tendency = var_2_1

	local var_2_2

	if not arg_2_1.daily_slot_num then
		var_2_2 = 0
	end

	arg_2_0.finishCnt = var_2_2

	local var_2_3

	if not arg_2_1.time_slot_num then
		var_2_3 = 0
	end

	arg_2_0.urgencyFinishCnt = var_2_3

	local var_2_4

	if not arg_2_1.ship_refresh then
		var_2_4 = 0
	end

	arg_2_0.nextManualReloadDelegateTime = var_2_4
	arg_2_0.awardIndexList = {}
	ipairs = var_2

	local var_2_5

	if not arg_2_1.get_favor then
		var_2_5 = {}
	end

	for iter_2_0, iter_2_1 in var_2(var_2_5) do
		table = var_1_10007

		var_1_10007.insert(arg_2_0.awardIndexList, iter_2_1)
	end

	arg_2_0.actFinishedGroupsMap = {}
	ipairs = var_2

	local var_2_6

	if not arg_2_1.act_group then
		var_2_6 = {}
	end

	for iter_2_2, iter_2_3 in var_2(var_2_6) do
		var_1_10007 = {}
		ipairs = var_1_10008

		for iter_2_4, iter_2_5 in var_1_10008(iter_2_3.groups) do
			table = var_1_10013

			var_1_10013.insert(var_1_10007, iter_2_5)
		end

		var_1_10008 = arg_2_0.actFinishedGroupsMap
		var_1_10008[iter_2_3.act_id] = var_1_10007
	end

	arg_2_0.slotList = {}
	ipairs = var_2

	local var_2_7

	if not arg_2_1.slot_list then
		var_2_7 = {}
	end

	for iter_2_6, iter_2_7 in var_2(var_2_7) do
		IslandOrderSlot = var_1_10007
		var_1_10007 = var_1_10007.New(iter_2_7)
		arg_2_0.slotList[var_1_10007.id] = var_1_10007
	end

	arg_2_0.shipSlotList = {}
	ipairs = var_2
	pg = var_3

	for iter_2_8, iter_2_9 in var_2(var_3.island_order_list.get_id_list_by_type[var_0_1.SHIP_ORDER_TYPE]) do
		IslandShipOrderSlot = var_1_10007
		var_1_10007 = var_1_10007.New({
			id = iter_2_9
		})
		arg_2_0.shipSlotList[var_1_10007.id] = var_1_10007
	end

	ipairs = var_2

	local var_2_8

	if not arg_2_1.ship_slot_list then
		var_2_8 = {}
	end

	for iter_2_10, iter_2_11 in var_2(var_2_8) do
		if arg_2_0.shipSlotList[iter_2_11.id] then
			var_1_10009 = var_1_10007

			var_1_10007.Init(var_1_10009, iter_2_11, true)
		end
	end

	arg_2_0.shipOrderDelegateSlots = {}
	ipairs = var_2

	local var_2_9

	if not arg_2_1.appoint_list then
		var_2_9 = {}
	end

	for iter_2_12, iter_2_13 in var_2(var_2_9) do
		IslandShipOrderDelegateSlot = var_1_10007
		var_1_10007 = var_1_10007.New(iter_2_13)
		arg_2_0.shipOrderDelegateSlots[var_1_10007.id] = var_1_10007
	end

	ipairs = var_2

	local var_2_10

	if not arg_2_1.speed_list then
		var_2_10 = {}
	end

	for iter_2_14, iter_2_15 in var_2(var_2_10) do
		local var_2_11 = iter_2_15.slot_id
		local var_2_12 = iter_2_15.speed_time

		pg = var_1_10009

		if var_1_10009.island_order_list[var_2_11].type == var_0_1.COMMON_ORDER_TYPE then
			local var_2_13 = arg_2_0.slotList[var_2_11]

			var_10.SetReduceTime(var_2_13, var_2_12)
		elseif var_1_10009 == var_0_1.SHIP_ORDER_TYPE then
			if arg_2_0.shipSlotList[var_2_11] and var_10:IsWaiting() then
				var_10:SetReloadingReduceTime(var_2_12)
			elseif var_10 and var_10:IsSubmited() then
				var_10:SetReduceTime(var_2_12)
			end
		end
	end

	return
end

function var_0_1.GetShipSlotList(arg_3_0)
	return arg_3_0.shipSlotList
end

function var_0_1.GetShipOrderSlot(arg_4_0, arg_4_1)
	return arg_4_0.shipSlotList[arg_4_1]
end

function var_0_1.UpdateShipSlot(arg_5_0, arg_5_1)
	arg_5_0.shipSlotList[arg_5_1.id] = arg_5_1

	return
end

function var_0_1.CanRefreshShipOrderDelegate(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.TimeMgr.GetInstance()
	local var_6_1 = var_1.GetServerTime(var_6_0)

	return arg_6_0:GetNextManualReloadDelegateTime() <= var_6_1, var_2
end

function var_0_1.GetDelegateList(arg_7_0)
	return arg_7_0.shipOrderDelegateSlots
end

function var_0_1.RemoveDelegateSlot(arg_8_0, arg_8_1)
	if arg_8_0.shipOrderDelegateSlots[arg_8_1] then
		arg_8_0.shipOrderDelegateSlots[arg_8_1] = nil
	end

	return
end

function var_0_1.GetDelegateSlot(arg_9_0, arg_9_1)
	return arg_9_0.shipOrderDelegateSlots[arg_9_1]
end

function var_0_1.AddDelegateSlot(arg_10_0, arg_10_1)
	arg_10_0.shipOrderDelegateSlots[arg_10_1.id] = arg_10_1

	return
end

function var_0_1.AddDelegateSlotList(arg_11_0, arg_11_1)
	arg_11_0.shipOrderDelegateSlots = arg_11_1

	return
end

function var_0_1.GetNextAutoReloadDelegateTime(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.TimeMgr.GetInstance()
	local var_12_1 = var_1.GetServerTime(var_12_0) + 0

	ipairs = var_12_0

	for iter_12_0, iter_12_1 in var_12_0(arg_12_0.shipOrderDelegateSlots) do
		local var_12_2 = iter_12_1:GetShowTime()

		if not iter_12_1:CanShow() and var_12_2 < var_12_1 then
			var_12_1 = var_12_2
		end
	end

	return var_12_1
end

function var_0_1.GetNextManualReloadDelegateTime(arg_13_0)
	return arg_13_0.nextManualReloadDelegateTime
end

function var_0_1.UpdateNextManualReloadDelegateTime(arg_14_0, arg_14_1)
	arg_14_0.nextManualReloadDelegateTime = arg_14_1

	return
end

function var_0_1.ReduceNextManualReloadDelegateTime(arg_15_0, arg_15_1)
	arg_15_0.nextManualReloadDelegateTime = arg_15_0.nextManualReloadDelegateTime - arg_15_1

	return
end

function var_0_1.AddSlot(arg_16_0, arg_16_1)
	IslandOrderSlot = var_1_10002

	local var_16_0 = var_1_10002.New(arg_16_1)

	arg_16_0.slotList[var_16_0.id] = var_16_0

	arg_16_0:DispatchEvent(var_0_1.GEN_NEW_ORDER, {
		slotId = var_16_0.id
	})

	return
end

function var_0_1.UpdateSlot(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.slotList[arg_17_1.id]

	var_2.Flush(var_17_0, arg_17_1)
	arg_17_0:DispatchEvent(var_0_1.UDPATE_ORDER, {
		slotId = var_2.id
	})

	return
end

function var_0_1.RemoveSlot(arg_18_0, arg_18_1)
	arg_18_0.slotList[arg_18_1] = nil

	return
end

function var_0_1.UpdateOrAddOrder(arg_19_0, arg_19_1)
	if not arg_19_0.slotList[arg_19_1.id] then
		arg_19_0:AddSlot(arg_19_1)
	else
		arg_19_0:UpdateSlot(arg_19_1)
	end

	return
end

function var_0_1.IncFinishCnt(arg_20_0)
	arg_20_0.finishCnt = arg_20_0.finishCnt + 1

	return
end

function var_0_1.GetFinishCnt(arg_21_0)
	return arg_21_0.finishCnt
end

function var_0_1.GetMaxFinishCount(arg_22_0)
	local var_22_0 = arg_22_0:GetHost()
	local var_22_1 = var_1.GetAblityAgency(var_22_0)
	local var_22_2 = var_1.GetOrderDailyCntAddition(var_22_1)

	pg = var_22_1

	return var_22_1.island_set.order_daily_limit_num.key_value_int + var_22_2
end

function var_0_1.IncUrgencyFinishCnt(arg_23_0)
	arg_23_0.urgencyFinishCnt = arg_23_0.urgencyFinishCnt + 1

	return
end

function var_0_1.GetUrgentFinishCnt(arg_24_0)
	return arg_24_0.urgencyFinishCnt
end

function var_0_1.GetMaxUrgentFinishCnt(arg_25_0)
	pg = var_1_10001

	return var_1_10001.island_set.order_special_limit_num.key_value_int
end

function var_0_1.GetLeftUrgentCnt(arg_26_0)
	return arg_26_0:GetMaxUrgentFinishCnt() - arg_26_0:GetUrgentFinishCnt()
end

function var_0_1.GetTendency(arg_27_0)
	return arg_27_0.tendency
end

function var_0_1.SetTendency(arg_28_0, arg_28_1)
	arg_28_0.tendency = arg_28_1

	return
end

function var_0_1.ExpSystemIsOpen(arg_29_0)
	local var_29_0 = arg_29_0:GetHost()
	local var_29_1 = var_1.GetAblityAgency(var_29_0)

	return var_1.IsUnlockOrderExp(var_29_1)
end

function var_0_1.AddExp(arg_30_0, arg_30_1)
	if not arg_30_0:ExpSystemIsOpen() then
		return
	end

	if arg_30_0:IsMaxLevel() then
		return
	end

	arg_30_0.exp = arg_30_0.exp + arg_30_1

	return
end

function var_0_1.GetExp(arg_31_0)
	return arg_31_0.exp
end

function var_0_1.GetTargetExp(arg_32_0)
	local var_32_0 = arg_32_0:GetLevel()

	return arg_32_0:StaticGetTargetExp(var_32_0)
end

function var_0_1.GetNextTargetExp(arg_33_0)
	if arg_33_0:IsMaxLevel() then
		return 0
	end

	local var_33_0 = arg_33_0:GetLevel()

	return arg_33_0:StaticGetTargetExp(var_33_0 + 1)
end

function var_0_1.StaticGetTargetExp(arg_34_0, arg_34_1)
	local var_34_0 = 0

	for iter_34_0 = 1, arg_34_1 do
		pg = var_1_10007

		local var_34_1

		if not var_1_10007.island_order_favor[iter_34_0] or not var_1_10007.exp then
			var_34_1 = 0
		end

		var_34_0 = var_34_0 + var_34_1
	end

	return var_34_0
end

function var_0_1.GetLevel(arg_35_0)
	ipairs = var_1_10001
	pg = var_1_10002

	for iter_35_0, iter_35_1 in var_1_10001(var_1_10002.island_order_favor.all) do
		if arg_35_0:StaticGetTargetExp(iter_35_1 + 1) > arg_35_0.exp then
			return iter_35_1
		end
	end

	if arg_35_0:IsMaxLevel() then
		pg = var_1

		return var_1[#var_1.island_order_favor.all]
	else
		return 0
	end

	return
end

function var_0_1.IsMaxLevel(arg_36_0)
	pg = var_1_10001

	local var_36_0 = var_1[#var_1_10001.island_order_favor.all]

	return arg_36_0:StaticGetTargetExp(var_36_0) <= arg_36_0.exp
end

function var_0_1.GetSlots(arg_37_0)
	return arg_37_0.slotList
end

function var_0_1.GetSlot(arg_38_0, arg_38_1)
	return arg_38_0.slotList[arg_38_1]
end

function var_0_1.IsGotAward(arg_39_0, arg_39_1)
	table = var_1_10002

	return var_1_10002.contains(arg_39_0.awardIndexList, arg_39_1)
end

function var_0_1.UpdateGotAwardList(arg_40_0, arg_40_1)
	if not arg_40_0:IsGotAward(arg_40_1) then
		table = var_2

		var_2.insert(arg_40_0.awardIndexList, arg_40_1)
	end

	return
end

function var_0_1.GetAllCanGetAwardList(arg_41_0)
	local var_41_0 = {}

	ipairs = var_1_10002
	pg = var_1_10003

	for iter_41_0, iter_41_1 in var_1_10002(var_1_10003.island_order_favor.all) do
		if arg_41_0:CanGetAward(iter_41_1) then
			table = var_7

			var_7.insert(var_41_0, iter_41_1)
		end
	end

	return var_41_0
end

function var_0_1.CanGetAward(arg_42_0, arg_42_1)
	if arg_42_0:IsGotAward(arg_42_1) then
		return false
	end

	return arg_42_0:StaticGetTargetExp(arg_42_1) <= arg_42_0.exp
end

local var_0_2 = "island_next_submit_order_time"

function var_0_1.RecordNextCanSubmitTime(arg_43_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_43_0 = var_1_10001(var_1_10002)
	local var_43_1 = var_1.getRawData(var_43_0).id

	pg = var_43_0

	local var_43_2 = var_43_0.TimeMgr.GetInstance()
	local var_43_3 = var_2.GetServerTime(var_43_2)

	pg = var_43_2

	local var_43_4 = var_43_2.island_set.order_complete_refresh_time.key_value_int

	PlayerPrefs = var_1_10004

	var_1_10004.SetInt(var_0_2 .. var_43_1, var_43_3 + var_43_4)

	PlayerPrefs = var_4

	var_4.Save()

	return
end

function var_0_1.CanSubmitOrder(arg_44_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_44_0 = var_1_10001(var_1_10002)
	local var_44_1 = var_1.getRawData(var_44_0).id

	PlayerPrefs = var_44_0

	local var_44_2 = var_44_0.GetInt(var_0_2 .. var_44_1, 0)

	pg = var_3

	local var_44_3 = var_3.TimeMgr.GetInstance()
	local var_44_4 = var_3.GetServerTime(var_44_3)

	return var_44_2 <= 0 or var_44_2 <= var_44_4, var_44_2
end

local var_0_3 = "island_selected_order_id"

function var_0_1.GetCacheSelectedId(arg_45_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_45_0 = var_1_10001(var_1_10002)
	local var_45_1 = var_1.getRawData(var_45_0).id

	PlayerPrefs = var_45_0

	return (var_45_0.GetInt(var_0_3 .. var_45_1, 0))
end

function var_0_1.SetCacheSelectedId(arg_46_0, arg_46_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_46_0 = var_1_10002(var_1_10003)
	local var_46_1 = var_2.getRawData(var_46_0).id

	PlayerPrefs = var_46_0

	var_46_0.SetInt(var_0_3 .. var_46_1, arg_46_1)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.AddFinishedActGroupId(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0

	if not arg_47_0.actFinishedGroupsMap[arg_47_1] then
		var_47_0 = arg_47_0.actFinishedGroupsMap
		var_47_0[arg_47_1] = {}
	end

	table = var_47_0

	if not var_47_0.contains(arg_47_0.actFinishedGroupsMap[arg_47_1], arg_47_2) then
		table = var_3

		var_3.insert(arg_47_0.actFinishedGroupsMap[arg_47_1], arg_47_2)
	end

	return
end

function var_0_1.GetFinishedCntByActId(arg_48_0, arg_48_1)
	pg = var_1_10002

	local var_48_0 = var_1_10002.island_order.get_id_list_by_activity_id[arg_48_1]
	local var_48_1 = {}

	ipairs = var_1_10005

	for iter_48_0, iter_48_1 in var_1_10005(var_48_0) do
		if not var_48_1[var_2[iter_48_1].group_id] then
			var_48_1[var_10] = {}
		end

		table = var_11

		var_11.insert(var_48_1[var_10], iter_48_1)
	end

	local var_48_2 = 0

	ipairs = var_6

	local var_48_3

	if not arg_48_0.actFinishedGroupsMap[arg_48_1] then
		var_48_3 = {}
	end

	for iter_48_2, iter_48_3 in var_6(var_48_3) do
		var_48_2 = var_48_2 + #var_48_1[iter_48_3]
	end

	pairs = var_6

	for iter_48_4, iter_48_5 in var_6(arg_48_0.slotList) do
		local var_48_4 = iter_48_5
		local var_48_5 = iter_48_5.GetOrder(var_48_4)

		isa = var_48_4

		local var_48_6 = var_48_5

		IslandFirmActivityOrder = var_1_10014

		if var_48_4(var_48_6, var_1_10014) and var_48_5:GetActivityId() == arg_48_1 then
			local var_48_7 = var_48_5
			local var_48_8 = var_48_1[var_48_5.GetGroupId(var_48_7)]

			table = var_48_7

			var_48_7.sort(var_48_8)

			table = var_13
			var_48_2 = var_48_2 + var_13.indexof(var_48_8, var_48_5.id) - 1
		end
	end

	return var_48_2
end

function var_0_1.UpdatePerDay(arg_49_0)
	arg_49_0.finishCnt = 0
	pg = var_1

	local var_49_0 = var_1.TimeMgr.GetInstance()

	if var_1.GetServerWeek(var_49_0) == 1 then
		arg_49_0.urgencyFinishCnt = 0
		arg_49_0.exp = 0
	end

	arg_49_0:DispatchEvent(var_0_1.ORDER_FINISH_UPDATE)

	return
end

function var_0_1.OnSeasonReset(arg_50_0, arg_50_1)
	arg_50_0:InitData(arg_50_1)

	return
end

return var_0_1
