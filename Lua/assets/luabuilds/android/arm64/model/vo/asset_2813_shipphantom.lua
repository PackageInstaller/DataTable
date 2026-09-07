local ShipPhantom = class("ShipPhantom", import(".Ship"))

function ShipPhantom:Change(arg_1_1)
	assert(self.__cname == "Ship")
	setmetatable(self, ShipPhantom)

	self.class = ShipPhantom
	self.phantomId = arg_1_1

	return self
end

function ShipPhantom:Revert()
	assert(self.__cname == "ShipPhantom")
	setmetatable(self, Ship)

	self.class = Ship
	self.phantomId = nil

	return self
end

function ShipPhantom:Create(arg_3_1)
	assert(self.__cname == "Ship")

	local var_3_0 = cloneRawTableFormClass(self)

	var_3_0.phantomId = arg_3_1

	setmetatable(var_3_0, ShipPhantom)

	var_3_0.class = ShipPhantom

	return var_3_0
end

function ShipPhantom:getSkinId(arg_4_1)
	return ShipPhantom.super.getSkinId(self, arg_4_1 or self.phantomId)
end

function ShipPhantom:GetShipPhantomMark(arg_5_1)
	return ShipPhantom.super.GetShipPhantomMark(self, arg_5_1 or self.phantomId)
end

function ShipPhantom:getRandomFlag()
	return ShipPhantom.super.getRandomFlag(self, self.phantomId)
end

function ShipPhantom:GetSelectMark()
	return self:GetShipPhantomMark()
end

function ShipPhantom:PackMark(arg_8_1)
	return self .. "_" .. (arg_8_1 or 0)
end

function ShipPhantom:UnpackMark()
	return unpack(underscore.map(string.split(self, "_"), function(arg_10_0)
		return tonumber(arg_10_0)
	end))
end

return ShipPhantom
