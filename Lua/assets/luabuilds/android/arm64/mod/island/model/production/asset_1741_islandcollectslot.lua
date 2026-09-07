local IslandCollectSlot = class("IslandCollectSlot", import("model.vo.BaseVO"))

IslandCollectSlot.slotType = {
	Task = 2,
	Normal = 1
}

function IslandCollectSlot:Ctor(arg_1_1, arg_1_2)
	self.placeId = arg_1_1

	self:UpdateData(arg_1_2)

	return
end

function IslandCollectSlot:bindConfigTable()
	return pg.island_production_slot
end

function IslandCollectSlot:UpdateData(arg_3_1)
	self.configId = arg_3_1.id
	self.pos = arg_3_1.pos
	self.get_num = arg_3_1.get_num
	self.refresh_time = arg_3_1.refresh_time
	self.type = IslandCollectSlot.slotType.Normal

	for iter_3_0, iter_3_1 in ipairs(pg.island_set.mission_gather_point.key_value_varchar) do
		if self.configId == iter_3_1[1] then
			self.type = IslandCollectSlot.slotType.Task
			self.pos = iter_3_1[2]
		end
	end

	if self.type == IslandCollectSlot.slotType.Normal then
		for iter_3_2, iter_3_3 in ipairs(pg.island_set.mining_recovery_time.key_value_varchar) do
			if iter_3_3[1] == self.configId then
				self.cd = iter_3_3[2]
				self.maxTimes = iter_3_3[3]
			end
		end
	end

	return
end

function IslandCollectSlot:UpdateCollectData(arg_4_1, arg_4_2)
	local var_4_0 = getProxy(IslandProxy):GetIsland()

	if arg_4_2 == IslandCollectSlot.slotType.Task then
		var_4_0:DispatchEvent(IslandBuildingAgency.COLLECT_SLOT_UNIT_REMOVE, {
			unitId = self.pos
		})

		return
	end

	local var_4_1

	if arg_4_1.pos ~= self.pos then
		var_4_0:DispatchEvent(IslandBuildingAgency.COLLECT_SLOT_UNIT_REMOVE, {
			unitId = self.pos
		})

		var_4_1 = true
	end

	self:UpdateData(arg_4_1)

	if var_4_1 then
		self:NotifyToLoadCollectSlotModel()
	end

	return
end

function IslandCollectSlot:StartColloct()
	pg.m02:sendNotification(GAME.ISLAND_START_COLLECT, {
		build_id = self.placeId,
		area_id = self.configId
	})

	return
end

function IslandCollectSlot:GetRecoverCD()
	return self.cd
end

function IslandCollectSlot:GetRecoverTime()
	return (math.floor(math.max(pg.TimeMgr.GetInstance():GetServerTime() - self.refresh_time, 0) / self:GetRecoverCD()))
end

function IslandCollectSlot:GetNextRecoverTimes()
	return self.refresh_time + (self:GetRecoverTime() + 1) * self:GetRecoverCD()
end

function IslandCollectSlot:GetCanCollectTime()
	if self.type == IslandCollectSlot.slotType.Task then
		return 1
	end

	return math.min(self.maxTimes, self:GetRecoverTime() - self.get_num + self.maxTimes)
end

function IslandCollectSlot:GetCollectMaxTime()
	if self.type == IslandCollectSlot.slotType.Task then
		return 1
	end

	return self.maxTimes
end

function IslandCollectSlot:NotifyToLoadCollectSlotModel()
	getProxy(IslandProxy):GetIsland():DispatchEvent(IslandBuildingAgency.COLLECT_SlOT_UNIT_INIT, {
		slotId = self.configId
	})

	return
end

return IslandCollectSlot
