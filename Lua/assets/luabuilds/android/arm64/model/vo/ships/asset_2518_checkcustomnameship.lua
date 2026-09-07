local CheckCustomNameShip = class("CheckCustomNameShip", import("model.vo.Ship"))

function CheckCustomNameShip:getName()
	if getProxy(PlayerProxy):getRawData():ShouldCheckCustomName() then
		return self:GetDefaultName()
	else
		return CheckCustomNameShip.super.getName(self)
	end

	return
end

return CheckCustomNameShip
