local var_0_0 = {
	LEVEL_SIGN = {
		MID_HIGH = 2,
		HIGH = 3,
		LOW = 0,
		MID_LOW = 1,
		UNKNOWN = -1
	}
}

var_0_0.CPU_LEVELS = {
	[var_0_0.LEVEL_SIGN.MID_LOW] = 2000,
	[var_0_0.LEVEL_SIGN.MID_HIGH] = 2400,
	[var_0_0.LEVEL_SIGN.HIGH] = 2840
}
var_0_0.MEMORY_LEVELS = {
	[var_0_0.LEVEL_SIGN.MID_LOW] = 4096,
	[var_0_0.LEVEL_SIGN.MID_HIGH] = 6144,
	[var_0_0.LEVEL_SIGN.HIGH] = 8192
}
var_0_0.DEVICE_LEVEL_SIGN = {
	HIGH = 2,
	MID = 1,
	LOW = 0,
	UNKNOWN = -1
}
var_0_0.IOS_DEVICE_LEVELS = {
	iphone = {
		[var_0_0.DEVICE_LEVEL_SIGN.MID] = 1108,
		[var_0_0.DEVICE_LEVEL_SIGN.HIGH] = 1302
	},
	ipad = {
		[var_0_0.DEVICE_LEVEL_SIGN.MID] = 700,
		[var_0_0.DEVICE_LEVEL_SIGN.HIGH] = 800
	},
	ipod = {
		[var_0_0.DEVICE_LEVEL_SIGN.MID] = 700,
		[var_0_0.DEVICE_LEVEL_SIGN.HIGH] = 900
	}
}

return var_0_0
