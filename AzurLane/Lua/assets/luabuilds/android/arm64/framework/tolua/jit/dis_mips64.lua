local var_0_0 = string.match(..., ".*%.") or ""
local var_0_1 = require(var_0_0 .. "dis_mips")

return {
	create = var_0_1.create,
	disass = var_0_1.disass,
	regname = var_0_1.regname
}
