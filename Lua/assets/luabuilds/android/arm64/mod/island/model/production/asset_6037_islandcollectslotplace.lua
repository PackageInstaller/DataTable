local IslandCollectSlotPlace = class("IslandCollectSlotPlace", import("model.vo.BaseVO"))

IslandCollectSlotPlace.slotType = {
	Task = 2,
	Normal = 1
}

function IslandCollectSlotPlace:Ctor(arg_1_1, arg_1_2)
	self.placeId = arg_1_1
	self.get_num = arg_1_2.get_num
	self.refresh_time = arg_1_2.refresh_time

	if pg.TimeMgr.GetInstance():GetServerTime() > self.refresh_time then
		self.get_num = 0
	end

	if self.get_num > 0 then
		self.needRefresh = true
	end

	self.recoverQueue = {}
	self.collectionSlotData = {}
	self.taskPointDic = {}

	for iter_1_0, iter_1_1 in ipairs(pg.island_set.mission_gather_point.key_value_varchar) do
		self.taskPointDic[iter_1_1[1]] = true
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_2.collect_list or {}) do
		local var_1_0

		if self.taskPointDic[iter_1_3] then
			var_1_0 = IslandCollectSlotPlace.slotType.Task or IslandCollectSlotPlace.slotType.Normal

			if var_1_0 == IslandCollectSlotPlace.slotType.Normal then
				table.insert(self.recoverQueue, iter_1_3)
			end
		end

		self.collectionSlotData[iter_1_3] = IslandCollectSlotNew.New(self, iter_1_3, var_1_0)
	end

	return
end

function IslandCollectSlotPlace:GetCollectSlotDatasDic()
	return self.collectionSlotData
end

function IslandCollectSlotPlace:GetRecoverQueue()
	return self.recoverQueue
end

function IslandCollectSlotPlace:GetCanCollectTime()
	return math.min(#self.recoverQueue, #self.recoverQueue - self.get_num)
end

function IslandCollectSlotPlace:GetInRecoverTimeBySlotId(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self.recoverQueue) do
		if iter_5_1 == arg_5_1 then
			return iter_5_0
		end
	end

	return
end

function IslandCollectSlotPlace:GetNextRecoverTimes()
	return self.refresh_time
end

function IslandCollectSlotPlace:UpdateCollectRefreshtTime(arg_7_1)
	if arg_7_1 ~= self.refresh_time then
		self.refresh_time = arg_7_1
		self.needRefresh = true
	end

	return
end

function IslandCollectSlotPlace:UpdateGetCollectNum(arg_8_1)
	if arg_8_1 == IslandCollectSlotPlace.slotType.Normal then
		self.get_num = self.get_num + 1
	end

	return
end

function IslandCollectSlotPlace:SetAllTakeColelct()
	self.get_num = #self.recoverQueue

	return
end

function IslandCollectSlotPlace:UpdateCollectDataBySlotId(arg_10_1, arg_10_2)
	if not self.collectionSlotData[arg_10_1.id] then
		return
	end

	if arg_10_2 == IslandCollectSlotPlace.slotType.Task then
		self.collectionSlotData[arg_10_1.id]:UpdateCollectData(arg_10_1, arg_10_2)

		self.collectionSlotData[arg_10_1.id] = nil
	else
		self:RefreshRecoverQueue(arg_10_1.id)
		self.collectionSlotData[arg_10_1.id]:UpdateCollectData(arg_10_1, arg_10_2)
	end

	return
end

function IslandCollectSlotPlace:RefreshRecoverQueue(arg_11_1)
	local var_11_0 = -1

	for iter_11_0, iter_11_1 in ipairs(self.recoverQueue) do
		if iter_11_1 == arg_11_1 then
			var_11_0 = iter_11_0
		end
	end

	if var_11_0 ~= -1 then
		table.remove(self.recoverQueue, var_11_0)
	end

	table.insert(self.recoverQueue, arg_11_1)

	return
end

function IslandCollectSlotPlace:GetCollectSlotData(arg_12_1)
	return self.collectionSlotData[arg_12_1]
end

function IslandCollectSlotPlace:InitHandSlotData(arg_13_1)
	if self.collectionSlotData[arg_13_1.id] then
		warning("已经存在当前槽位的信息了")

		return
	end

	local var_13_0

	if self.taskPointDic[arg_13_1.id] then
		var_13_0 = IslandCollectSlotPlace.slotType.Task or IslandCollectSlotPlace.slotType.Normal

		if var_13_0 == IslandCollectSlotPlace.slotType.Normal then
			table.insert(self.recoverQueue, 1, arg_13_1.id)
		end
	end

	self.collectionSlotData[arg_13_1.id] = IslandCollectSlotNew.New(self.configId, arg_13_1, var_13_0)

	getProxy(IslandProxy):GetIsland():DispatchEvent(IslandBuildingAgency.COLLECT_SlOT_UNIT_INIT, {
		slotId = arg_13_1.id
	})

	return
end

function IslandCollectSlotPlace:UpdatePerSecond()
	if self.needRefresh and pg.TimeMgr.GetInstance():GetServerTime() >= self.refresh_time then
		self.needRefresh = false
		self.get_num = 0

		local var_14_0 = getProxy(IslandProxy):GetIsland()

		for iter_14_0 = #self.recoverQueue, math.max(1, #self.recoverQueue - self.get_num + 1), -1 do
			if self.placeId == IslandProductConst.MinePlaceId then
				var_14_0:DispatchEvent(IslandBuildingAgency.COLLECT_SlOT_UNIT_INIT, {
					slotId = self.recoverQueue[iter_14_0]
				})
			else
				var_14_0:DispatchEvent(IslandBuildingAgency.COLLECT_SlOT_UNIT_UPDATE, {
					slotId = self.recoverQueue[iter_14_0]
				})
			end
		end
	end

	return
end

return IslandCollectSlotPlace
