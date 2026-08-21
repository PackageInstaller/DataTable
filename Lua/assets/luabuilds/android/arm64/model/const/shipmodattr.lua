local var_0_0 = class("ShipModAttr")

var_0_0.ID_TO_ATTR = {
	[2] = AttributeType.Cannon,
	[3] = AttributeType.Torpedo,
	[4] = AttributeType.AntiAircraft,
	[5] = AttributeType.Air,
	[6] = AttributeType.Reload
}
var_0_0.ATTR_TO_INDEX = {
	[AttributeType.Cannon] = 1,
	[AttributeType.Torpedo] = 2,
	[AttributeType.AntiAircraft] = 3,
	[AttributeType.Air] = 4,
	[AttributeType.Reload] = 5
}
var_0_0.BLUEPRINT_ATTRS = {
	AttributeType.Cannon,
	AttributeType.Torpedo,
	AttributeType.AntiAircraft,
	AttributeType.Air,
	AttributeType.Reload
}

function var_0_0.id2Name(arg_1_0)
	return AttributeType.Type2Name(var_0_0.ID_TO_ATTR[arg_1_0])
end

return var_0_0
