local IslandCollectSlotUnitVO = class("IslandCollectSlotUnitVO", import(".IslandUnitVO"))

function IslandCollectSlotUnitVO:Ctor(arg_1_1)
	IslandCollectSlotUnitVO.super.Ctor(self, arg_1_1)

	self.isSelfIsland = arg_1_1.isSelfIsland
	self.slotId = arg_1_1.slotId

	self:BindSlotData()

	return
end

function IslandCollectSlotUnitVO:BindSlotData()
	self.slotData = self:HandCollectSlotData()

	return
end

function IslandCollectSlotUnitVO:HandCollectSlotData()
	local var_3_1 = (self.isSelfIsland and getProxy(IslandProxy):GetIsland():GetBuildingAgency() or getProxy(IslandProxy):GetSharedIsland():GetBuildingAgency()):GetBuilding(pg.island_production_slot[self.slotId].place)

	if not var_3_1 then
		return nil
	end

	local var_3_2 = var_3_1:GetCollectSlotData(self.slotId)

	if var_3_2 then
		return var_3_2
	end

	return
end

return IslandCollectSlotUnitVO
