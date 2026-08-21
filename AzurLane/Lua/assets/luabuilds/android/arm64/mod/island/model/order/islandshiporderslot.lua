local var_0_0 = class("IslandShipOrderSlot")

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
	arg_2_0.state = arg_2_1.state or var_0_0.STATE_LOCK
	arg_2_0.maxFinishCnt = pg.island_set.island_shiporder_limit.key_value_int
	arg_2_0.finishCnt = arg_2_1.finish_num or 0
	arg_2_0.nextRefreshFinishCntTime = arg_2_1.auto_time or 0
	arg_2_0.totalTime = arg_2_1.load_time or 0
	arg_2_0.endTime = 0

	if arg_2_0:IsSubmited() then
		arg_2_0.endTime = arg_2_1.get_time or 0
	end

	arg_2_0.openTime = 0

	if arg_2_0:IsWaiting() then
		arg_2_0.openTime = arg_2_1.get_time or 0
	end

	arg_2_0.reduceTime = 0
	arg_2_0.reloadingReduceTime = 0
	arg_2_0.order = IslandShipOrder.New(arg_2_1)
	arg_2_0.config = pg.island_order_list[arg_2_0.id]

	return
end

function var_0_0.Reset(arg_3_0)
	arg_3_0.openTime = 0

	return
end

function var_0_0.FillDelegate(arg_4_0, arg_4_1)
	arg_4_0.openTime = 0

	arg_4_0.order:FillConsumeList(Clone((arg_4_1:GetRequestList())))
	arg_4_0.order:FillAwardList(Clone((arg_4_1:GetAwardList())))

	return
end

function var_0_0.CanTransport(arg_5_0)
	local var_5_0 = pg.TimeMgr.GetInstance():GetServerTime()

	return arg_5_0.finishCnt < arg_5_0.maxFinishCnt or var_5_0 >= arg_5_0.nextRefreshFinishCntTime
end

function var_0_0.GetFinishCnt(arg_6_0)
	return arg_6_0.finishCnt
end

function var_0_0.GetRealFinishCnt(arg_7_0)
	if pg.TimeMgr.GetInstance():GetServerTime() >= arg_7_0.nextRefreshFinishCntTime then
		return math.max(0, arg_7_0.finishCnt - 1)
	end

	return arg_7_0.finishCnt
end

function var_0_0.GetMaxFinishCnt(arg_8_0)
	return arg_8_0.maxFinishCnt
end

function var_0_0.GetWorldObjId(arg_9_0)
	return pg.island_order_list[arg_9_0.id].objId or 0
end

function var_0_0.Submit(arg_10_0, arg_10_1)
	arg_10_0.endTime = arg_10_1
	arg_10_0.state = var_0_0.STATE_SUBMITED

	arg_10_0:IncreaseFinishCnt()

	return
end

function var_0_0.IncreaseFinishCnt(arg_11_0)
	arg_11_0.finishCnt = math.min(arg_11_0.finishCnt + 1, arg_11_0.maxFinishCnt)
	arg_11_0.nextRefreshFinishCntTime = arg_11_0:GetNextRefreshFinishCntTime()

	return
end

function var_0_0.GetNextRefreshFinishCntTime(arg_12_0)
	local var_12_0 = GetZeroTime() - 0
	local var_12_1 = pg.TimeMgr.GetInstance():GetServerTime()

	return _.detect(_.map(pg.island_set.island_shiporder_refresh.key_value_varchar, function(arg_13_0)
		return arg_13_0 + var_12_0
	end), function(arg_14_0)
		return arg_14_0 > var_12_1
	end) or GetZeroTime() + pg.island_set.island_shiporder_refresh.key_value_varchar[1]
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
		local var_19_0 = pg.TimeMgr.GetInstance()

		return var_19_0:GetServerTime() < arg_19_0:GetShowTime()
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
	return arg_23_0:IsSubmited() and (function()
		local var_24_0 = pg.TimeMgr.GetInstance()

		return var_24_0:GetServerTime() >= arg_23_0:GetEndTime()
	end)()
end

function var_0_0.CanSubmit(arg_25_0)
	return arg_25_0:IsWaiting()
end

function var_0_0.GetUnlockLevel(arg_26_0)
	return arg_26_0.config.unlock_level
end

function var_0_0.GetUnlockGold(arg_27_0)
	local var_27_0 = arg_27_0.config.unlock_cost[1] or {}
	local var_27_1 = {
		type = DROP_TYPE_ISLAND_ITEM
	}

	var_27_1.id = var_27_0[1] or 1
	var_27_1.count = var_27_0[2] or 0

	return var_27_1
end

function var_0_0.CanUnlock(arg_28_0)
	if not arg_28_0:IsLock() then
		return false
	end

	if arg_28_0.forceUnlock then
		return true
	end

	local var_28_0 = getProxy(IslandProxy):GetIsland():GetAblityAgency()

	if not var_28_0:IsUnlockShipOrder(arg_28_0.id) then
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
	arg_32_0.reloadingReduceTime = math.max(arg_32_0.reloadingReduceTime + arg_32_1, 0)

	return
end

return var_0_0
