local IslandDelegateFishVO = class("IslandDelegateFishVO", import(".IslandUnitVO"))

function IslandDelegateFishVO:Ctor(arg_1_1)
	IslandDelegateFishVO.super.Ctor(self, arg_1_1)

	self.speed = arg_1_1.speed

	return
end

return IslandDelegateFishVO
