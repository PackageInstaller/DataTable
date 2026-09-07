local SelectableSkin = class("SelectableSkin")

function SelectableSkin:Ctor(arg_1_1)
	self.skinId = arg_1_1.id
	self.isTimeLimit = arg_1_1.isTimeLimit
	self.own = getProxy(ShipSkinProxy):hasSkin(self.skinId)

	return
end

function SelectableSkin:IsTimeLimit()
	return self.isTimeLimit
end

function SelectableSkin:OwnSkin()
	return self.own
end

function SelectableSkin:ToShipSkin()
	return ShipSkin.New({
		id = self.skinId
	})
end

function SelectableSkin:GetTimeLimitWeight()
	return self:IsTimeLimit() and 1 or 0
end

function SelectableSkin:GetOwnWeight()
	return self:OwnSkin() and 0 or 1
end

return SelectableSkin
