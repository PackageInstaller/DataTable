class = var_0_10000

local var_0_0 = var_0_10000("ShipModAttr")
local var_0_1 = {}

AttributeType = var_2
var_0_1[2] = var_2.Cannon
AttributeType = var_2
var_0_1[3] = var_2.Torpedo
AttributeType = var_2
var_0_1[4] = var_2.AntiAircraft
AttributeType = var_2
var_0_1[5] = var_2.Air
AttributeType = var_2
var_0_1[6] = var_2.Reload
var_0_0.ID_TO_ATTR = var_0_1

local var_0_2 = {}

AttributeType = var_2
var_0_2[var_2.Cannon] = 1
AttributeType = var_2
var_0_2[var_2.Torpedo] = 2
AttributeType = var_2
var_0_2[var_2.AntiAircraft] = 3
AttributeType = var_2
var_0_2[var_2.Air] = 4
AttributeType = var_2
var_0_2[var_2.Reload] = 5
var_0_0.ATTR_TO_INDEX = var_0_2

local var_0_3 = {}

AttributeType = var_2
var_0_3[1] = var_2.Cannon
AttributeType = var_2
var_0_3[2] = var_2.Torpedo
AttributeType = var_2
var_0_3[3] = var_2.AntiAircraft
AttributeType = var_2
var_0_3[4] = var_2.Air
AttributeType = var_2
var_0_3[5] = var_2.Reload
var_0_0.BLUEPRINT_ATTRS = var_0_3

function var_0_0.id2Name(arg_1_0)
	AttributeType = var_1_10001

	return var_1_10001.Type2Name(var_0_0.ID_TO_ATTR[arg_1_0])
end

return var_0_0
