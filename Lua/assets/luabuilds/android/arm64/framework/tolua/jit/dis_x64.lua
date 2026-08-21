local var_0_0 = string.match(..., ".*%.") or ""
local var_0_1 = require(var_0_0 .. "dis_x86")

return {
	create = var_0_1.create64,
	disass = var_0_1.disass64,
	regname = var_0_1.regname64
}
