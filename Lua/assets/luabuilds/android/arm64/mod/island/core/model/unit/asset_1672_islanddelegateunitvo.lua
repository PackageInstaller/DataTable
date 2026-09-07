local IslandDelegateUnitVO = class("IslandDelegateUnitVO", import(".IslandUnitVO"))

function IslandDelegateUnitVO:Ctor(arg_1_1)
	IslandDelegateUnitVO.super.Ctor(self, arg_1_1)

	self.isChicken = arg_1_1.isChicken

	return
end

return IslandDelegateUnitVO
