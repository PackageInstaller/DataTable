require = var_0_10000
string = var_0_10002

local var_0_0

if not var_0_10002.match(..., ".*%.") then
	var_0_0 = ""
end

local var_0_1 = var_0_10000(var_0_0 .. "dis_x86")

return {
	create = var_0_1.create64,
	disass = var_0_1.disass64,
	regname = var_0_1.regname64
}
