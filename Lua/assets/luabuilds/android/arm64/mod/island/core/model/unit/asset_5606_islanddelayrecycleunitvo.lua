local IslandDelayRecycleUnitVO = class("IslandDelayRecycleUnitVO", import(".IslandUnitVO"))

function IslandDelayRecycleUnitVO:Ctor(arg_1_1)
	IslandDelayRecycleUnitVO.super.Ctor(self, arg_1_1)

	self.delayRecycleTime = arg_1_1.delayRecycleTime
	self.recycleAssetType = arg_1_1.recycleAssetType

	return
end

return IslandDelayRecycleUnitVO
