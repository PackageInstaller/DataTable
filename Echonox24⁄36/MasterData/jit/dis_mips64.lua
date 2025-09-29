local var_0_0 = require((string.match(..., ".*%.") or "") .. "dis_mips")

return {
	create = var_0_0.create,
	disass = var_0_0.disass,
	regname = var_0_0.regname
}
