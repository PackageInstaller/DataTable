local var_0_0 = {}
local var_0_1 = {
	[0] = 410 - 113
}

var_0_1[1] = 410
var_0_1[2] = 410 + 113
var_0_0.heightY = var_0_1
var_0_0.lineNextType = {
	TWO_ONE_UP = 3,
	TWO_ONE_DOWN = 2,
	HORIZONTAL = 1,
	NONE = 0
}
var_0_0.lineNextWidth = {
	[var_0_0.lineNextType.NONE] = 0,
	[var_0_0.lineNextType.HORIZONTAL] = 88,
	[var_0_0.lineNextType.TWO_ONE_DOWN] = 144,
	[var_0_0.lineNextType.TWO_ONE_UP] = 144
}
var_0_0.linePreType = {
	ONE_TWO_UP = 2,
	ONE_TWO_DOWN = 3,
	HORIZONTAL = 1,
	NONE = 0
}
var_0_0.linePreWidth = {
	[var_0_0.linePreType.NONE] = 0,
	[var_0_0.linePreType.HORIZONTAL] = 88,
	[var_0_0.linePreType.ONE_TWO_UP] = 144,
	[var_0_0.linePreType.ONE_TWO_DOWN] = 144
}
var_0_0.maxWidthLine = 144

return var_0_0
