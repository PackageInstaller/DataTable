local var_0_0 = {}
local var_0_1 = {
	[0] = 410 - 100
}

var_0_1[1] = 410
var_0_1[2] = 410 + 100
var_0_0.heightY = var_0_1
var_0_0.lineNextType = {
	HORIZONTAL = 1,
	NONE = 0,
	TWO_ONE_UP = 3,
	TWO_ONE_DOWN = 2
}
var_0_0.lineNextWidth = {
	[var_0_0.lineNextType.NONE] = 0,
	[var_0_0.lineNextType.HORIZONTAL] = 76,
	[var_0_0.lineNextType.TWO_ONE_DOWN] = 186,
	[var_0_0.lineNextType.TWO_ONE_UP] = 186
}
var_0_0.linePreType = {
	HORIZONTAL = 1,
	NONE = 0,
	ONE_TWO_DOWN = 3,
	ONE_TWO_UP = 2
}
var_0_0.linePreWidth = {
	[var_0_0.linePreType.NONE] = 0,
	[var_0_0.linePreType.HORIZONTAL] = 76,
	[var_0_0.linePreType.ONE_TWO_UP] = 186,
	[var_0_0.linePreType.ONE_TWO_DOWN] = 186
}
var_0_0.maxWidthLine = 186

return var_0_0
