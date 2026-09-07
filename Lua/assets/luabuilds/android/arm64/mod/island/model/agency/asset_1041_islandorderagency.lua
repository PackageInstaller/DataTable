local IslandOrderAgency = class("IslandOrderAgency", import(".IslandBaseAgency"))

IslandOrderAgency.GEN_NEW_ORDER = "IslandOrderAgency:GEN_NEW_ORDER"
IslandOrderAgency.UDPATE_ORDER = "IslandOrderAgency:UDPATE_ORDER"
IslandOrderAgency.ORDER_FINISH_UPDATE = "IslandOrderAgency:ORDER_FINISH_UPDATE"
IslandOrderAgency.COMMON_ORDER_TYPE = 1
IslandOrderAgency.URGENCY_ORDER_TYPE = 2
IslandOrderAgency.SHIP_ORDER_TYPE = 3

function IslandOrderAgency:OnInit(arg_1_1)
	self:InitData(arg_1_1.order_system or {})

	return
end

function IslandOrderAgency:InitData(arg_2_1)
	self.exp = arg_2_1.favor or 0
	self.tendency = arg_2_1.daily_select or IslandOrderSlot.TENDENCY_TYPE_COMMON
	self.finishCnt = arg_2_1.daily_slot_num or 0
	self.urgencyFinishCnt = arg_2_1.time_slot_num or 0
	self.nextManualReloadDelegateTime = arg_2_1.ship_refresh or 0
	self.awardIndexList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.get_favor or {}) do
		table.insert(self.awardIndexList, iter_2_1)
	end

	self.actFinishedGroupsMap = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.act_group or {}) do
		local var_2_0 = {}

		for iter_2_4, iter_2_5 in ipairs(iter_2_3.groups) do
			table.insert(var_2_0, iter_2_5)
		end

		self.actFinishedGroupsMap[iter_2_3.act_id] = var_2_0
	end

	self.slotList = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.slot_list or {}) do
		local var_2_1 = IslandOrderSlot.New(iter_2_7)

		self.slotList[var_2_1.id] = var_2_1
	end

	self.shipSlotList = {}

	for iter_2_8, iter_2_9 in ipairs(pg.island_order_list.get_id_list_by_type[IslandOrderAgency.SHIP_ORDER_TYPE]) do
		local var_2_2 = IslandShipOrderSlot.New({
			id = iter_2_9
		})

		self.shipSlotList[var_2_2.id] = var_2_2
	end

	for iter_2_10, iter_2_11 in ipairs(arg_2_1.ship_slot_list or {}) do
		if self.shipSlotList[iter_2_11.id] then
			self.shipSlotList[iter_2_11.id]:Init(iter_2_11, true)
		end
	end

	self.shipOrderDelegateSlots = {}

	for iter_2_12, iter_2_13 in ipairs(arg_2_1.appoint_list or {}) do
		local var_2_3 = IslandShipOrderDelegateSlot.New(iter_2_13)

		self.shipOrderDelegateSlots[var_2_3.id] = var_2_3
	end

	for iter_2_14, iter_2_15 in ipairs(arg_2_1.speed_list or {}) do
		if pg.island_order_list[iter_2_15.slot_id].type == IslandOrderAgency.COMMON_ORDER_TYPE then
			self.slotList[iter_2_15.slot_id]:SetReduceTime(iter_2_15.speed_time)
		elseif pg.island_order_list[iter_2_15.slot_id].type == IslandOrderAgency.SHIP_ORDER_TYPE then
			if self.shipSlotList[iter_2_15.slot_id] and self.shipSlotList[iter_2_15.slot_id]:IsWaiting() then
				self.shipSlotList[iter_2_15.slot_id]:SetReloadingReduceTime(iter_2_15.speed_time)
			elseif self.shipSlotList[iter_2_15.slot_id] and self.shipSlotList[iter_2_15.slot_id]:IsSubmited() then
				self.shipSlotList[iter_2_15.slot_id]:SetReduceTime(iter_2_15.speed_time)
			end
		end
	end

	return
end

function IslandOrderAgency:GetShipSlotList()
	return self.shipSlotList
end

function IslandOrderAgency:GetShipOrderSlot(arg_4_1)
	return self.shipSlotList[arg_4_1]
end

function IslandOrderAgency:UpdateShipSlot(arg_5_1)
	self.shipSlotList[arg_5_1.id] = arg_5_1

	return
end

function IslandOrderAgency:CanRefreshShipOrderDelegate()
	local var_6_0 = pg.TimeMgr.GetInstance()
	local var_6_1 = self:GetNextManualReloadDelegateTime()

	return var_6_1 <= var_6_0:GetServerTime(), var_6_1
end

function IslandOrderAgency:GetDelegateList()
	return self.shipOrderDelegateSlots
end

function IslandOrderAgency:RemoveDelegateSlot(arg_8_1)
	if self.shipOrderDelegateSlots[arg_8_1] then
		self.shipOrderDelegateSlots[arg_8_1] = nil
	end

	return
end

function IslandOrderAgency:GetDelegateSlot(arg_9_1)
	return self.shipOrderDelegateSlots[arg_9_1]
end

function IslandOrderAgency:AddDelegateSlot(arg_10_1)
	self.shipOrderDelegateSlots[arg_10_1.id] = arg_10_1

	return
end

function IslandOrderAgency:AddDelegateSlotList(arg_11_1)
	self.shipOrderDelegateSlots = arg_11_1

	return
end

function IslandOrderAgency:GetNextAutoReloadDelegateTime()
	local var_12_0 = pg.TimeMgr.GetInstance():GetServerTime() + 0

	for iter_12_0, iter_12_1 in ipairs(self.shipOrderDelegateSlots) do
		local var_12_1 = iter_12_1:GetShowTime()

		if not iter_12_1:CanShow() and var_12_1 < var_12_0 then
			var_12_0 = var_12_1
		end
	end

	return var_12_0
end

function IslandOrderAgency:GetNextManualReloadDelegateTime()
	return self.nextManualReloadDelegateTime
end

function IslandOrderAgency:UpdateNextManualReloadDelegateTime(arg_14_1)
	self.nextManualReloadDelegateTime = arg_14_1

	return
end

function IslandOrderAgency:ReduceNextManualReloadDelegateTime(arg_15_1)
	self.nextManualReloadDelegateTime = self.nextManualReloadDelegateTime - arg_15_1

	return
end

function IslandOrderAgency:AddSlot(arg_16_1)
	local var_16_0 = IslandOrderSlot.New(arg_16_1)

	self.slotList[var_16_0.id] = var_16_0

	self:DispatchEvent(IslandOrderAgency.GEN_NEW_ORDER, {
		slotId = var_16_0.id
	})

	return
end

function IslandOrderAgency:UpdateSlot(arg_17_1)
	self.slotList[arg_17_1.id]:Flush(arg_17_1)
	self:DispatchEvent(IslandOrderAgency.UDPATE_ORDER, {
		slotId = self.slotList[arg_17_1.id].id
	})

	return
end

function IslandOrderAgency:RemoveSlot(arg_18_1)
	self.slotList[arg_18_1] = nil

	return
end

function IslandOrderAgency:UpdateOrAddOrder(arg_19_1)
	if not self.slotList[arg_19_1.id] then
		self:AddSlot(arg_19_1)
	else
		self:UpdateSlot(arg_19_1)
	end

	return
end

function IslandOrderAgency:IncFinishCnt()
	self.finishCnt = self.finishCnt + 1

	return
end

function IslandOrderAgency:GetFinishCnt()
	return self.finishCnt
end

function IslandOrderAgency:GetMaxFinishCount()
	return pg.island_set.order_daily_limit_num.key_value_int + self:GetHost():GetAblityAgency():GetOrderDailyCntAddition()
end

function IslandOrderAgency:IncUrgencyFinishCnt()
	self.urgencyFinishCnt = self.urgencyFinishCnt + 1

	return
end

function IslandOrderAgency:GetUrgentFinishCnt()
	return self.urgencyFinishCnt
end

function IslandOrderAgency:GetMaxUrgentFinishCnt()
	return pg.island_set.order_special_limit_num.key_value_int
end

function IslandOrderAgency:GetLeftUrgentCnt()
	return self:GetMaxUrgentFinishCnt() - self:GetUrgentFinishCnt()
end

function IslandOrderAgency:GetTendency()
	return self.tendency
end

function IslandOrderAgency:SetTendency(arg_28_1)
	self.tendency = arg_28_1

	return
end

function IslandOrderAgency:ExpSystemIsOpen()
	return self:GetHost():GetAblityAgency():IsUnlockOrderExp()
end

function IslandOrderAgency:AddExp(arg_30_1)
	if not self:ExpSystemIsOpen() then
		return
	end

	if self:IsMaxLevel() then
		return
	end

	self.exp = self.exp + arg_30_1

	return
end

function IslandOrderAgency:GetExp()
	return self.exp
end

function IslandOrderAgency:GetTargetExp()
	return self:StaticGetTargetExp((self:GetLevel()))
end

function IslandOrderAgency:GetNextTargetExp()
	if self:IsMaxLevel() then
		return 0
	end

	return self:StaticGetTargetExp(self:GetLevel() + 1)
end

function IslandOrderAgency:StaticGetTargetExp(arg_34_1)
	local var_34_0 = 0

	for iter_34_0 = 1, arg_34_1 do
		var_34_0 = var_34_0 + ((pg.island_order_favor[iter_34_0] or nil) and (pg.island_order_favor[iter_34_0].exp or 0))
	end

	return var_34_0
end

function IslandOrderAgency:GetLevel()
	for iter_35_0, iter_35_1 in ipairs(pg.island_order_favor.all) do
		if self:StaticGetTargetExp(iter_35_1 + 1) > self.exp then
			return iter_35_1
		end
	end

	if self:IsMaxLevel() then
		return pg.island_order_favor.all[#pg.island_order_favor.all]
	else
		return 0
	end

	return
end

function IslandOrderAgency:IsMaxLevel()
	return self:StaticGetTargetExp(pg.island_order_favor.all[#pg.island_order_favor.all]) <= self.exp
end

function IslandOrderAgency:GetSlots()
	return self.slotList
end

function IslandOrderAgency:GetSlot(arg_38_1)
	return self.slotList[arg_38_1]
end

function IslandOrderAgency:IsGotAward(arg_39_1)
	return table.contains(self.awardIndexList, arg_39_1)
end

function IslandOrderAgency:UpdateGotAwardList(arg_40_1)
	if not self:IsGotAward(arg_40_1) then
		table.insert(self.awardIndexList, arg_40_1)
	end

	return
end

function IslandOrderAgency:GetAllCanGetAwardList()
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(pg.island_order_favor.all) do
		if self:CanGetAward(iter_41_1) then
			table.insert(var_41_0, iter_41_1)
		end
	end

	return var_41_0
end

function IslandOrderAgency:CanGetAward(arg_42_1)
	if self:IsGotAward(arg_42_1) then
		return false
	end

	return self:StaticGetTargetExp(arg_42_1) <= self.exp
end

local var_0_1 = "island_next_submit_order_time"

function IslandOrderAgency:RecordNextCanSubmitTime()
	PlayerPrefs.SetInt(var_0_1 .. getProxy(PlayerProxy):getRawData().id, pg.TimeMgr.GetInstance():GetServerTime() + pg.island_set.order_complete_refresh_time.key_value_int)
	PlayerPrefs.Save()

	return
end

function IslandOrderAgency:CanSubmitOrder()
	local var_44_0 = getProxy(PlayerProxy)
	local var_44_1 = PlayerPrefs.GetInt(var_0_1 .. var_44_0:getRawData().id, 0)

	return var_44_1 <= 0 or var_44_1 <= pg.TimeMgr.GetInstance().GetServerTime(var_44_0), var_44_1
end

local var_0_2 = "island_selected_order_id"

function IslandOrderAgency:GetCacheSelectedId()
	return (PlayerPrefs.GetInt(var_0_2 .. getProxy(PlayerProxy):getRawData().id, 0))
end

function IslandOrderAgency:SetCacheSelectedId(arg_46_1)
	PlayerPrefs.SetInt(var_0_2 .. getProxy(PlayerProxy):getRawData().id, arg_46_1)
	PlayerPrefs.Save()

	return
end

function IslandOrderAgency:AddFinishedActGroupId(arg_47_1, arg_47_2)
	self.actFinishedGroupsMap[arg_47_1] = self.actFinishedGroupsMap[arg_47_1] or {}

	if not table.contains(self.actFinishedGroupsMap[arg_47_1], arg_47_2) then
		table.insert(self.actFinishedGroupsMap[arg_47_1], arg_47_2)
	end

	return
end

function IslandOrderAgency:GetFinishedCntByActId(arg_48_1)
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in ipairs(pg.island_order.get_id_list_by_activity_id[arg_48_1]) do
		var_48_0[pg.island_order[iter_48_1].group_id] = var_48_0[pg.island_order[iter_48_1].group_id] or {}

		table.insert(var_48_0[pg.island_order[iter_48_1].group_id], iter_48_1)
	end

	local var_48_1 = 0

	for iter_48_2, iter_48_3 in ipairs(self.actFinishedGroupsMap[arg_48_1] or {}) do
		var_48_1 = var_48_1 + #var_48_0[iter_48_3]
	end

	for iter_48_4, iter_48_5 in pairs(self.slotList) do
		local var_48_2 = iter_48_5:GetOrder()

		if isa(var_48_2, IslandFirmActivityOrder) and var_48_2:GetActivityId() == arg_48_1 then
			local var_48_3 = var_48_0[var_48_2:GetGroupId()]

			table.sort(var_48_3)

			var_48_1 = var_48_1 + table.indexof(var_48_3, var_48_2.id) - 1
		end
	end

	return var_48_1
end

function IslandOrderAgency:UpdatePerDay()
	self.finishCnt = 0

	if pg.TimeMgr.GetInstance():GetServerWeek() == 1 then
		self.urgencyFinishCnt = 0
		self.exp = 0
	end

	self:DispatchEvent(IslandOrderAgency.ORDER_FINISH_UPDATE)

	return
end

function IslandOrderAgency:OnSeasonReset(arg_50_1)
	self:InitData(arg_50_1)

	return
end

return IslandOrderAgency
