local ShipModAttr = class("ShipModAttr")

ShipModAttr.ID_TO_ATTR = {
	[2] = AttributeType.Cannon,
	[3] = AttributeType.Torpedo,
	[4] = AttributeType.AntiAircraft,
	[5] = AttributeType.Air,
	[6] = AttributeType.Reload
}
ShipModAttr.ATTR_TO_INDEX = {
	[AttributeType.Cannon] = 1,
	[AttributeType.Torpedo] = 2,
	[AttributeType.AntiAircraft] = 3,
	[AttributeType.Air] = 4,
	[AttributeType.Reload] = 5
}
ShipModAttr.BLUEPRINT_ATTRS = {
	AttributeType.Cannon,
	AttributeType.Torpedo,
	AttributeType.AntiAircraft,
	AttributeType.Air,
	AttributeType.Reload
}

function ShipModAttr:id2Name()
	return AttributeType.Type2Name(ShipModAttr.ID_TO_ATTR[self])
end

return ShipModAttr
