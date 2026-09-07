local IslandShipOrderSlot = class("IslandShipOrderSlot")

IslandShipOrderSlot.STATE_LOCK = 0
IslandShipOrderSlot.STATE_WAITING = 1
IslandShipOrderSlot.STATE_SUBMITED = 2

function IslandShipOrderSlot:Ctor(arg_1_1)
	self:Init(arg_1_1)

	return
end

function IslandShipOrderSlot:Init(arg_2_1, arg_2_2)
	self.forceUnlock = arg_2_2
	self.id = arg_2_1.id
	self.state = arg_2_1.state or IslandShipOrderSlot.STATE_LOCK
	self.maxFinishCnt = pg.island_set.island_shiporder_limit.key_value_int
	self.finishCnt = arg_2_1.finish_num or 0
	self.nextRefreshFinishCntTime = arg_2_1.auto_time or 0
	self.totalTime = arg_2_1.load_time or 0
	self.endTime = 0

	if self:IsSubmited() then
		self.endTime = arg_2_1.get_time or 0
	end

	self.openTime = 0

	if self:IsWaiting() then
		self.openTime = arg_2_1.get_time or 0
	end

	self.reduceTime = 0
	self.reloadingReduceTime = 0
	self.order = IslandShipOrder.New(arg_2_1)
	self.config = pg.island_order_list[self.id]

	return
end

function IslandShipOrderSlot:Reset()
	self.openTime = 0

	return
end

function IslandShipOrderSlot:FillDelegate(arg_4_1)
	self.openTime = 0

	self.order:FillConsumeList(Clone((arg_4_1:GetRequestList())))
	self.order:FillAwardList(Clone((arg_4_1:GetAwardList())))

	return
end

function IslandShipOrderSlot:CanTransport()
	return self.finishCnt < self.maxFinishCnt or pg.TimeMgr.GetInstance():GetServerTime() >= self.nextRefreshFinishCntTime
end

function IslandShipOrderSlot:GetFinishCnt()
	return self.finishCnt
end

function IslandShipOrderSlot:GetRealFinishCnt()
	if pg.TimeMgr.GetInstance():GetServerTime() >= self.nextRefreshFinishCntTime then
		return math.max(0, self.finishCnt - 1)
	end

	return self.finishCnt
end

function IslandShipOrderSlot:GetMaxFinishCnt()
	return self.maxFinishCnt
end

function IslandShipOrderSlot:GetWorldObjId()
	return pg.island_order_list[self.id].objId or 0
end

function IslandShipOrderSlot:Submit(arg_10_1)
	self.endTime = arg_10_1
	self.state = IslandShipOrderSlot.STATE_SUBMITED

	self:IncreaseFinishCnt()

	return
end

function IslandShipOrderSlot:IncreaseFinishCnt()
	self.finishCnt = math.min(self.finishCnt + 1, self.maxFinishCnt)
	self.nextRefreshFinishCntTime = self:GetNextRefreshFinishCntTime()

	return
end

function IslandShipOrderSlot:GetNextRefreshFinishCntTime()
	local var_12_0 = GetZeroTime() - 0
	local var_12_1 = pg.TimeMgr.GetInstance():GetServerTime()

	return _.detect(_.map(pg.island_set.island_shiporder_refresh.key_value_varchar, function(arg_13_0)
		return arg_13_0 + var_12_0
	end), function(arg_14_0)
		return arg_14_0 > var_12_1
	end) or GetZeroTime() + pg.island_set.island_shiporder_refresh.key_value_varchar[1]
end

function IslandShipOrderSlot:GetOrder()
	return self.order
end

function IslandShipOrderSlot:GetEndTime()
	return self.endTime - self.reduceTime
end

function IslandShipOrderSlot:GetNeedTime()
	return self.totalTime
end

function IslandShipOrderSlot:GetShowTime()
	return self.openTime
end

function IslandShipOrderSlot:IsEmpty()
	if self:IsWaiting() then
		return pg.TimeMgr.GetInstance():GetServerTime() < self:GetShowTime()
	else
		return false
	end

	return
end

function IslandShipOrderSlot:IsLock()
	return self.state == IslandShipOrderSlot.STATE_LOCK
end

function IslandShipOrderSlot:IsWaiting()
	return self.state == IslandShipOrderSlot.STATE_WAITING
end

function IslandShipOrderSlot:IsSubmited()
	return self.state == IslandShipOrderSlot.STATE_SUBMITED
end

function IslandShipOrderSlot:IsFinished()
	return self:IsSubmited() and (function()
		return pg.TimeMgr.GetInstance():GetServerTime() >= self:GetEndTime()
	end)()
end

function IslandShipOrderSlot:CanSubmit()
	return self:IsWaiting()
end

function IslandShipOrderSlot:GetUnlockLevel()
	return self.config.unlock_level
end

function IslandShipOrderSlot:GetUnlockGold()
	local var_27_0 = self.config.unlock_cost[1] or {}
	local var_27_1 = {
		type = DROP_TYPE_ISLAND_ITEM
	}

	var_27_1.id = var_27_0[1] or 1
	var_27_1.count = var_27_0[2] or 0

	return var_27_1
end

function IslandShipOrderSlot:CanUnlock()
	if not self:IsLock() then
		return false
	end

	if self.forceUnlock then
		return true
	end

	if not getProxy(IslandProxy):GetIsland():GetAblityAgency():IsUnlockShipOrder(self.id) then
		return false
	end

	return true
end

function IslandShipOrderSlot:SetReduceTime(arg_29_1)
	self.reduceTime = arg_29_1

	return
end

function IslandShipOrderSlot:AddReduceTime(arg_30_1)
	self.reduceTime = self.reduceTime + arg_30_1

	return
end

function IslandShipOrderSlot:SetReloadingReduceTime(arg_31_1)
	self.reloadingReduceTime = arg_31_1

	return
end

function IslandShipOrderSlot:AddReduceReloadingTime(arg_32_1)
	self.reloadingReduceTime = math.max(self.reloadingReduceTime + arg_32_1, 0)

	return
end

return IslandShipOrderSlot
