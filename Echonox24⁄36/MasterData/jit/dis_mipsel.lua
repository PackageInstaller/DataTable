local var_0_0 = require((string.match(..., ".*%.") or "") .. "dis_mips")

return {
	create = var_0_0.create_el,
	disass = var_0_0.disass_el,
	regname = var_0_0.regname
}
