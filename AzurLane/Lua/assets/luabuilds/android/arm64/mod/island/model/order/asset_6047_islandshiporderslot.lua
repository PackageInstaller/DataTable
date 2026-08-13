class = var_0_10000

local var_0_0 = var_0_10000("IslandShipOrderSlot")

var_0_0.STATE_LOCK = 0
var_0_0.STATE_WAITING = 1
var_0_0.STATE_SUBMITED = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0:Init(arg_1_1)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.forceUnlock = arg_2_2
	arg_2_0.id = arg_2_1.id

	local var_2_0

	if not arg_2_1.state then
		var_2_0 = var_0_0.STATE_LOCK
	end

	arg_2_0.state = var_2_0
	pg = var_2_0
	arg_2_0.maxFinishCnt = var_2_0.island_set.island_shiporder_limit.key_value_int

	local var_2_1

	if not arg_2_1.finish_num then
		var_2_1 = 0
	end

	arg_2_0.finishCnt = var_2_1

	local var_2_2

	if not arg_2_1.auto_time then
		var_2_2 = 0
	end

	arg_2_0.nextRefreshFinishCntTime = var_2_2

	local var_2_3

	if not arg_2_1.load_time then
		var_2_3 = 0
	end

	arg_2_0.totalTime = var_2_3
	arg_2_0.endTime = 0

	if arg_2_0:IsSubmited() then
		local var_2_4

		if not arg_2_1.get_time then
			var_2_4 = 0
		end

		arg_2_0.endTime = var_2_4
	end

	arg_2_0.openTime = 0

	if arg_2_0:IsWaiting() then
		local var_2_5

		if not arg_2_1.get_time then
			var_2_5 = 0
		end

		arg_2_0.openTime = var_2_5
	end

	arg_2_0.reduceTime = 0
	arg_2_0.reloadingReduceTime = 0
	IslandShipOrder = var_3
	arg_2_0.order = var_3.New(arg_2_1)
	pg = var_3
	arg_2_0.config = var_3.island_order_list[arg_2_0.id]

	return
end

function var_0_0.Reset(arg_3_0)
	arg_3_0.openTime = 0

	return
end

function var_0_0.FillDelegate(arg_4_0, arg_4_1)
	arg_4_0.openTime = 0

	local var_4_0 = arg_4_1:GetRequestList()
	local var_4_1 = arg_4_1:GetAwardList()
	local var_4_2 = arg_4_0.order
	local var_4_3 = var_4.FillConsumeList

	Clone = var_1_10007

	var_4_3(var_4_2, var_1_10007(var_4_0))

	local var_4_4 = arg_4_0.order
	local var_4_5 = var_4.FillAwardList

	Clone = var_7

	var_4_5(var_4_4, var_7(var_4_1))

	return
end

function var_0_0.CanTransport(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.TimeMgr.GetInstance()
	local var_5_1 = var_1.GetServerTime(var_5_0)

	return arg_5_0.finishCnt < arg_5_0.maxFinishCnt or var_5_1 >= arg_5_0.nextRefreshFinishCntTime
end

function var_0_0.GetFinishCnt(arg_6_0)
	return arg_6_0.finishCnt
end

function var_0_0.GetRealFinishCnt(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.TimeMgr.GetInstance()
	local var_7_1 = var_1.GetServerTime(var_7_0)

	if arg_7_0.nextRefreshFinishCntTime <= var_7_1 then
		math = var_2

		return var_2.max(0, arg_7_0.finishCnt - 1)
	end

	return arg_7_0.finishCnt
end

function var_0_0.GetMaxFinishCnt(arg_8_0)
	return arg_8_0.maxFinishCnt
end

function var_0_0.GetWorldObjId(arg_9_0)
	pg = var_1_10001

	local var_9_0

	if not var_1_10001.island_order_list[arg_9_0.id].objId then
		var_9_0 = 0
	end

	return var_9_0
end

function var_0_0.Submit(arg_10_0, arg_10_1)
	arg_10_0.endTime = arg_10_1
	arg_10_0.state = var_0_0.STATE_SUBMITED

	arg_10_0:IncreaseFinishCnt()

	return
end

function var_0_0.IncreaseFinishCnt(arg_11_0)
	math = var_1_10001
	arg_11_0.finishCnt = var_1_10001.min(arg_11_0.finishCnt + 1, arg_11_0.maxFinishCnt)
	arg_11_0.nextRefreshFinishCntTime = arg_11_0:GetNextRefreshFinishCntTime()

	return
end

function var_0_0.GetNextRefreshFinishCntTime(arg_12_0)
	GetZeroTime = var_1_10001

	local var_12_0 = var_1_10001() - 0

	pg = var_1_10002

	local var_12_1 = var_1_10002.island_set.island_shiporder_refresh.key_value_varchar

	_ = var_1_10003

	local var_12_2 = var_1_10003.map(var_12_1, function(arg_13_0)
		return arg_13_0 + var_12_0
	end)

	pg = var_1_10004

	local var_12_3 = var_1_10004.TimeMgr.GetInstance()
	local var_12_4 = var_4.GetServerTime(var_12_3)

	_ = var_5

	if not var_5.detect(var_12_2, function(arg_14_0)
		return arg_14_0 > var_12_4
	end) then
		::label_12_0::

		GetZeroTime = var_12_3
		var_12_3 = var_12_3() + var_12_1[1]
	end

	return var_12_3
end

function var_0_0.GetOrder(arg_15_0)
	return arg_15_0.order
end

function var_0_0.GetEndTime(arg_16_0)
	return arg_16_0.endTime - arg_16_0.reduceTime
end

function var_0_0.GetNeedTime(arg_17_0)
	return arg_17_0.totalTime
end

function var_0_0.GetShowTime(arg_18_0)
	return arg_18_0.openTime
end

function var_0_0.IsEmpty(arg_19_0)
	if arg_19_0:IsWaiting() then
		pg = var_1

		local var_19_0 = var_1.TimeMgr.GetInstance()

		return var_1.GetServerTime(var_19_0) < arg_19_0:GetShowTime()
	else
		return false
	end

	return
end

function var_0_0.IsLock(arg_20_0)
	return arg_20_0.state == var_0_0.STATE_LOCK
end

function var_0_0.IsWaiting(arg_21_0)
	return arg_21_0.state == var_0_0.STATE_WAITING
end

function var_0_0.IsSubmited(arg_22_0)
	return arg_22_0.state == var_0_0.STATE_SUBMITED
end

function var_0_0.IsFinished(arg_23_0)
	local function var_23_0()
		pg = var_2_10000

		local var_24_0 = var_2_10000.TimeMgr.GetInstance()
		local var_24_1 = var_0.GetServerTime(var_24_0)
		local var_24_2 = arg_23_0

		return var_24_1 >= var_1.GetEndTime(var_24_2)
	end

	local var_23_1

	if arg_23_0:IsSubmited() then
		var_23_1 = var_23_0()
	end

	return var_23_1
end

function var_0_0.CanSubmit(arg_25_0)
	return arg_25_0:IsWaiting()
end

function var_0_0.GetUnlockLevel(arg_26_0)
	return arg_26_0.config.unlock_level
end

function var_0_0.GetUnlockGold(arg_27_0)
	local var_27_0

	if not arg_27_0.config.unlock_cost[1] then
		var_27_0 = {}
	end

	local var_27_1 = {}

	DROP_TYPE_ISLAND_ITEM = var_1_10003
	var_27_1.type = var_1_10003

	local var_27_2

	if not var_27_0[1] then
		var_27_2 = 1
	end

	var_27_1.id = var_27_2

	local var_27_3

	if not var_27_0[2] then
		var_27_3 = 0
	end

	var_27_1.count = var_27_3

	return var_27_1
end

function var_0_0.CanUnlock(arg_28_0)
	local var_28_0 = arg_28_0

	if not arg_28_0.IsLock(var_28_0) then
		return false
	end

	if arg_28_0.forceUnlock then
		return true
	end

	getProxy = var_1
	IslandProxy = var_28_0

	local var_28_1 = var_1(var_28_0)
	local var_28_2 = var_1.GetIsland(var_28_1)
	local var_28_3 = var_1.GetAblityAgency(var_28_2)

	if not var_1.IsUnlockShipOrder(var_28_3, arg_28_0.id) then
		return false
	end

	return true
end

function var_0_0.SetReduceTime(arg_29_0, arg_29_1)
	arg_29_0.reduceTime = arg_29_1

	return
end

function var_0_0.AddReduceTime(arg_30_0, arg_30_1)
	arg_30_0.reduceTime = arg_30_0.reduceTime + arg_30_1

	return
end

function var_0_0.SetReloadingReduceTime(arg_31_0, arg_31_1)
	arg_31_0.reloadingReduceTime = arg_31_1

	return
end

function var_0_0.AddReduceReloadingTime(arg_32_0, arg_32_1)
	math = var_1_10002
	arg_32_0.reloadingReduceTime = var_1_10002.max(arg_32_0.reloadingReduceTime + arg_32_1, 0)

	return
end

return var_0_0
