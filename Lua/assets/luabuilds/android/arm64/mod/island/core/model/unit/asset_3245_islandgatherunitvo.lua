local IslandGatherUnitVO = class("IslandGatherUnitVO", import(".IslandUnitVO"))

function IslandGatherUnitVO:Ctor(arg_1_1)
	IslandGatherUnitVO.super.Ctor(self, arg_1_1)

	self.nowIslandId = self.index
	self.gatherType = self:GetType()

	self:BindGatherData()

	return
end

function IslandGatherUnitVO:BindGatherData()
	local var_2_1 = ((self.nowIslandId == getProxy(IslandProxy):GetIsland().id or nil) and (getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland())):GetWildCollectAgency()

	self.gatherData = self.gatherType == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM and var_2_1:GetGatherDataByUnitId(self.id) or var_2_1:GetCollectDataByUnitId(self.id)

	return
end

function IslandGatherUnitVO:GetGatherData()
	return self.gatherData
end

return IslandGatherUnitVO
