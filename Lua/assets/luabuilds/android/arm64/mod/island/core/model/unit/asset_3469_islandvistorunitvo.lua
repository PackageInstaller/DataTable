local IslandVistorUnitVO = class("IslandVistorUnitVO", import(".IslandUnitVO"))

function IslandVistorUnitVO:Ctor(arg_1_1)
	IslandVistorUnitVO.super.Ctor(self, arg_1_1)

	self.islandId = arg_1_1.islandId

	return
end

return IslandVistorUnitVO
