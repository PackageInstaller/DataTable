local var_0_0 = {}
local var_0_1 = {
	[7] = 410 - 121 - 59,
	[6] = 410 - 122,
	[5] = 410 - 121 + 60
}

var_0_1[4] = 410
var_0_1[3] = 410 + 121 - 59
var_0_1[2] = 410 + 121
var_0_1[1] = 410 + 121 + 60
var_0_0.heightY = var_0_1
var_0_0.lineNextType = {
	ONE_TWO_BIG = 3,
	TWO_ONE_UP_SMALL = 8,
	HORIZONTAL_SMALL = 2,
	TWO_ONE_DOWN_BIG = 5,
	HORIZONTAL_BIG = 1,
	TWO_ONE_DOWN_SMALL = 6,
	TWO_ONE_UP_BIG = 7,
	ONE_TWO_SMALL = 4,
	NONE = 0
}
var_0_0.lineNextWidth = {
	[var_0_0.lineNextType.NONE] = 0,
	[var_0_0.lineNextType.HORIZONTAL_BIG] = 104,
	[var_0_0.lineNextType.TWO_ONE_DOWN_BIG] = 68,
	[var_0_0.lineNextType.TWO_ONE_UP_BIG] = 68,
	[var_0_0.lineNextType.ONE_TWO_BIG] = 68,
	[var_0_0.lineNextType.HORIZONTAL_SMALL] = 74,
	[var_0_0.lineNextType.TWO_ONE_DOWN_SMALL] = 88,
	[var_0_0.lineNextType.TWO_ONE_UP_SMALL] = 88,
	[var_0_0.lineNextType.ONE_TWO_SMALL] = 88
}
var_0_0.linePreType = {
	ONE_TWO_UP_BIG = 3,
	ONE_TWO_UP_SMALL = 4,
	ONE_TWO_DOWN_BIG = 5,
	HORIZONTAL_SMALL = 2,
	HORIZONTAL_BIG = 1,
	ONE_TWO_DOWN_SMALL = 6,
	NONE = 0
}
var_0_0.linePreWidth = {
	[var_0_0.linePreType.NONE] = 0,
	[var_0_0.linePreType.HORIZONTAL_BIG] = 104,
	[var_0_0.linePreType.HORIZONTAL_SMALL] = 74,
	[var_0_0.linePreType.ONE_TWO_UP_BIG] = 68,
	[var_0_0.linePreType.ONE_TWO_DOWN_BIG] = 68,
	[var_0_0.linePreType.ONE_TWO_UP_SMALL] = 88,
	[var_0_0.linePreType.ONE_TWO_DOWN_SMALL] = 88
}
var_0_0.maxWidthLine = 104

return var_0_0
