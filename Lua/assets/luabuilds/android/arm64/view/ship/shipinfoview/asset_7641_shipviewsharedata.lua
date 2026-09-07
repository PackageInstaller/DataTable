local ShipViewShareData = class("ShipViewShareData")

function ShipViewShareData:Ctor()
	self.shipVO = nil

	return
end

function ShipViewShareData:SetShipVO(arg_2_1)
	self.shipVO = arg_2_1

	return
end

function ShipViewShareData:SetPlayer(arg_3_1)
	self.player = arg_3_1

	return
end

function ShipViewShareData:HasFashion()
	return getProxy(ShipSkinProxy):HasFashion(self.shipVO)
end

function ShipViewShareData:GetCurGroupSkinList()
	return self:GetGroupSkinList(self.shipVO.groupId)
end

function ShipViewShareData:GetGroupSkinList(arg_6_1)
	return getProxy(ShipSkinProxy):GetAllSkinForShip(self.shipVO)
end

return ShipViewShareData
