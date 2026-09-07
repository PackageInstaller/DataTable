local IslandCollectSlotNew = class("IslandCollectSlotNew", import("model.vo.BaseVO"))

IslandCollectSlotNew.slotType = {
	Task = 2,
	Normal = 1
}

function IslandCollectSlotNew:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.id = arg_1_2
	self.configId = self.id
	self.placeData = arg_1_1
	self.slotType = arg_1_3

	return
end

function IslandCollectSlotNew:UpdateData(arg_2_1)
	self.id = arg_2_1.id
	self.configId = self.id

	return
end

function IslandCollectSlotNew:GetCanCollectTimeStamps()
	if self.slotType == IslandCollectSlotNew.slotType.Task then
		return 0
	end

	if self.placeData:GetCanCollectTime() >= self.placeData:GetInRecoverTimeBySlotId(self.id) then
		return 0
	end

	return self.placeData:GetNextRecoverTimes()
end

function IslandCollectSlotNew:UpdateCollectData(arg_4_1, arg_4_2)
	local var_4_0 = getProxy(IslandProxy):GetIsland()

	if arg_4_2 == IslandCollectSlotNew.slotType.Task then
		var_4_0:DispatchEvent(IslandBuildingAgency.COLLECT_SLOT_UNIT_REMOVE, {
			slotId = self.configId
		})

		return
	end

	if self.placeData.placeId == IslandProductConst.MinePlaceId then
		var_4_0:DispatchEvent(IslandBuildingAgency.COLLECT_SLOT_UNIT_REMOVE, {
			slotId = self.configId
		})
	end

	self:UpdateData(arg_4_1)

	return
end

function IslandCollectSlotNew:StartColloct()
	pg.m02:sendNotification(GAME.ISLAND_START_COLLECT, {
		build_id = self.placeData.placeId,
		area_id = self.configId,
		type = self.slotType
	})

	return
end

return IslandCollectSlotNew
