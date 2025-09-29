local var_0_0 = type
local var_0_1 = string.sub
local var_0_2 = string.byte
local var_0_3 = string.format
local var_0_4 = string.match
local var_0_5 = string.gmatch
local var_0_6 = table.concat
local var_0_7 = require("bit")
local var_0_8 = var_0_7.band
local var_0_9 = var_0_7.bor
local var_0_10 = var_0_7.ror
local var_0_11 = var_0_7.tohex
local var_0_12 = var_0_7.lshift
local var_0_13 = var_0_7.rshift
local var_0_14 = var_0_7.arshift
local var_0_15 = {
	shift = 8,
	mask = 15,
	[10] = {
		[0] = {
			[0] = "vmovFmDN",
			"vstmFNdr",
			shift = 23,
			mask = 3,
			_ = {
				[0] = "vstrFdl",
				{
					[13] = "vpushFdr",
					_ = "vstmdbFNdr",
					shift = 16,
					mask = 15
				},
				shift = 21,
				mask = 1
			}
		},
		{
			[0] = "vmovFDNm",
			{
				[13] = "vpopFdr",
				_ = "vldmFNdr",
				shift = 16,
				mask = 15
			},
			shift = 23,
			mask = 3,
			_ = {
				[0] = "vldrFdl",
				"vldmdbFNdr",
				shift = 21,
				mask = 1
			}
		},
		shift = 20,
		mask = 1
	},
	[11] = {
		[0] = {
			[0] = "vmovGmDN",
			"vstmGNdr",
			shift = 23,
			mask = 3,
			_ = {
				[0] = "vstrGdl",
				{
					[13] = "vpushGdr",
					_ = "vstmdbGNdr",
					shift = 16,
					mask = 15
				},
				shift = 21,
				mask = 1
			}
		},
		{
			[0] = "vmovGDNm",
			{
				[13] = "vpopGdr",
				_ = "vldmGNdr",
				shift = 16,
				mask = 15
			},
			shift = 23,
			mask = 3,
			_ = {
				[0] = "vldrGdl",
				"vldmdbGNdr",
				shift = 21,
				mask = 1
			}
		},
		shift = 20,
		mask = 1
	},
	_ = {
		shift = 0,
		mask = 0
	}
}
local var_0_16 = {
	[0] = "vmlaF.dnm",
	"vmlsF.dnm",
	[147456] = "vfnmsF.dnm",
	[163840] = "vfmaF.dnm",
	[131072] = "vdivF.dnm",
	mask = 180225,
	[32769] = "vnmulF.dnm",
	[16384] = "vnmlsF.dnm",
	[32768] = "vmulF.dnm",
	[16385] = "vnmlaF.dnm",
	[163841] = "vfmsF.dnm",
	[180224] = "vmovF.dY",
	[49153] = "vsubF.dnm",
	[49152] = "vaddF.dnm",
	shift = 6,
	[147457] = "vfnmaF.dnm",
	[180225] = {
		[0] = "vmovF.dm",
		"vabsF.dm",
		[512] = "vnegF.dm",
		[2048] = "vcmpF.dm",
		[4096] = "vcvt.f32.u32Fdm",
		mask = 7681,
		[513] = "vsqrtF.dm",
		[2560] = "vcmpzF.d",
		[2049] = "vcmpeF.dm",
		[4097] = "vcvt.f32.s32Fdm",
		[6144] = "vcvtr.u32F.dm",
		[2561] = "vcmpzeF.d",
		[6656] = "vcvtr.s32F.dm",
		[6145] = "vcvt.u32F.dm",
		[6657] = "vcvt.s32F.dm",
		shift = 7,
		[3585] = "vcvtG.dF.m"
	}
}
local var_0_17 = {
	[0] = "vmlaG.dnm",
	"vmlsG.dnm",
	[147456] = "vfnmsG.dnm",
	[163840] = "vfmaG.dnm",
	[131072] = "vdivG.dnm",
	mask = 180225,
	[32769] = "vnmulG.dnm",
	[16384] = "vnmlsG.dnm",
	[32768] = "vmulG.dnm",
	[16385] = "vnmlaG.dnm",
	[163841] = "vfmsG.dnm",
	[180224] = "vmovG.dY",
	[49153] = "vsubG.dnm",
	[49152] = "vaddG.dnm",
	shift = 6,
	[147457] = "vfnmaG.dnm",
	[180225] = {
		[0] = "vmovG.dm",
		"vabsG.dm",
		[512] = "vnegG.dm",
		[2048] = "vcmpG.dm",
		[4096] = "vcvt.f64.u32GdFm",
		mask = 7681,
		[513] = "vsqrtG.dm",
		[2560] = "vcmpzG.d",
		[2049] = "vcmpeG.dm",
		[4097] = "vcvt.f64.s32GdFm",
		[6144] = "vcvtr.u32FdG.m",
		[2561] = "vcmpzeG.d",
		[6656] = "vcvtr.s32FdG.m",
		[6145] = "vcvt.u32FdG.m",
		[6657] = "vcvt.s32FdG.m",
		shift = 7,
		[3585] = "vcvtF.dG.m"
	}
}
local var_0_18 = {
	"svcT",
	shift = 24,
	mask = 1,
	[0] = {
		[0] = {
			shift = 8,
			mask = 15,
			[10] = var_0_16,
			[11] = var_0_17
		},
		{
			shift = 8,
			mask = 15,
			[10] = {
				[0] = "vmovFnD",
				"vmovFDn",
				[14] = "vmsrD",
				shift = 20,
				mask = 15,
				[15] = {
					_ = "vmrsD",
					[15] = "vmrs",
					shift = 12,
					mask = 15
				}
			}
		},
		shift = 4,
		mask = 1
	}
}
local var_0_19 = {
	shift = 0,
	mask = 0
}
local var_0_20 = {
	shift = 0,
	mask = 0
}
local var_0_21 = {
	shift = 0,
	mask = 0
}
local var_0_22 = {
	shift = 0,
	mask = 0
}
local var_0_23 = {
	shift = 0,
	mask = 0
}
local var_0_24 = {
	[0] = false,
	{
		[0] = "sadd16DNM",
		"sasxDNM",
		"ssaxDNM",
		"ssub16DNM",
		"sadd8DNM",
		false,
		false,
		"ssub8DNM",
		shift = 5,
		mask = 7
	},
	{
		[0] = "qadd16DNM",
		"qasxDNM",
		"qsaxDNM",
		"qsub16DNM",
		"qadd8DNM",
		false,
		false,
		"qsub8DNM",
		shift = 5,
		mask = 7
	},
	{
		[0] = "shadd16DNM",
		"shasxDNM",
		"shsaxDNM",
		"shsub16DNM",
		"shadd8DNM",
		false,
		false,
		"shsub8DNM",
		shift = 5,
		mask = 7
	},
	false,
	{
		[0] = "uadd16DNM",
		"uasxDNM",
		"usaxDNM",
		"usub16DNM",
		"uadd8DNM",
		false,
		false,
		"usub8DNM",
		shift = 5,
		mask = 7
	},
	{
		[0] = "uqadd16DNM",
		"uqasxDNM",
		"uqsaxDNM",
		"uqsub16DNM",
		"uqadd8DNM",
		false,
		false,
		"uqsub8DNM",
		shift = 5,
		mask = 7
	},
	{
		[0] = "uhadd16DNM",
		"uhasxDNM",
		"uhsaxDNM",
		"uhsub16DNM",
		"uhadd8DNM",
		false,
		false,
		"uhsub8DNM",
		shift = 5,
		mask = 7
	},
	{
		[0] = "pkhbtDNMU",
		false,
		"pkhtbDNMU",
		{
			_ = "sxtab16DNMU",
			[15] = "sxtb16DMU",
			shift = 16,
			mask = 15
		},
		"pkhbtDNMU",
		"selDNM",
		"pkhtbDNMU",
		shift = 5,
		mask = 7
	},
	false,
	{
		[0] = "ssatDxMu",
		"ssat16DxM",
		"ssatDxMu",
		{
			_ = "sxtabDNMU",
			[15] = "sxtbDMU",
			shift = 16,
			mask = 15
		},
		"ssatDxMu",
		false,
		"ssatDxMu",
		shift = 5,
		mask = 7
	},
	{
		[0] = "ssatDxMu",
		"revDM",
		"ssatDxMu",
		{
			_ = "sxtahDNMU",
			[15] = "sxthDMU",
			shift = 16,
			mask = 15
		},
		"ssatDxMu",
		"rev16DM",
		"ssatDxMu",
		shift = 5,
		mask = 7
	},
	{
		shift = 5,
		mask = 7,
		[3] = {
			_ = "uxtab16DNMU",
			[15] = "uxtb16DMU",
			shift = 16,
			mask = 15
		}
	},
	false,
	{
		[0] = "usatDwMu",
		"usat16DwM",
		"usatDwMu",
		{
			_ = "uxtabDNMU",
			[15] = "uxtbDMU",
			shift = 16,
			mask = 15
		},
		"usatDwMu",
		false,
		"usatDwMu",
		shift = 5,
		mask = 7
	},
	{
		[0] = "usatDwMu",
		"rbitDM",
		"usatDwMu",
		{
			_ = "uxtahDNMU",
			[15] = "uxthDMU",
			shift = 16,
			mask = 15
		},
		"usatDwMu",
		"revshDM",
		"usatDwMu",
		shift = 5,
		mask = 7
	},
	{
		shift = 12,
		mask = 15,
		[15] = {
			"smuadNMS",
			"smuadxNMS",
			"smusdNMS",
			"smusdxNMS",
			shift = 5,
			mask = 7
		},
		_ = {
			[0] = "smladNMSD",
			"smladxNMSD",
			"smlsdNMSD",
			"smlsdxNMSD",
			shift = 5,
			mask = 7
		}
	},
	false,
	false,
	false,
	{
		[0] = "smlaldDNMS",
		"smlaldxDNMS",
		"smlsldDNMS",
		"smlsldxDNMS",
		shift = 5,
		mask = 7
	},
	{
		[0] = {
			_ = "smmlaNMSD",
			[15] = "smmulNMS",
			shift = 12,
			mask = 15
		},
		{
			_ = "smmlarNMSD",
			[15] = "smmulrNMS",
			shift = 12,
			mask = 15
		},
		false,
		false,
		false,
		false,
		"smmlsNMSD",
		"smmlsrNMSD",
		shift = 5,
		mask = 7
	},
	false,
	false,
	{
		shift = 5,
		mask = 7,
		[0] = {
			_ = "usada8NMSD",
			[15] = "usad8NMS",
			shift = 12,
			mask = 15
		}
	},
	false,
	{
		nil,
		"sbfxDMvw",
		shift = 5,
		mask = 3
	},
	{
		nil,
		"sbfxDMvw",
		shift = 5,
		mask = 3
	},
	{
		shift = 5,
		mask = 3,
		[0] = {
			_ = "bfiDMvX",
			[15] = "bfcDvX",
			shift = 0,
			mask = 15
		}
	},
	{
		shift = 5,
		mask = 3,
		[0] = {
			_ = "bfiDMvX",
			[15] = "bfcDvX",
			shift = 0,
			mask = 15
		}
	},
	{
		nil,
		"ubfxDMvw",
		shift = 5,
		mask = 3
	},
	{
		nil,
		"ubfxDMvw",
		shift = 5,
		mask = 3
	},
	shift = 20,
	mask = 31
}
local var_0_25 = {
	{
		[0] = "strtDL",
		"ldrtDL",
		nil,
		nil,
		"strbtDL",
		"ldrbtDL",
		shift = 20,
		mask = 5
	},
	shift = 21,
	mask = 9,
	_ = {
		[0] = "strDL",
		"ldrDL",
		nil,
		nil,
		"strbDL",
		"ldrbDL",
		shift = 20,
		mask = 5
	}
}
local var_0_26 = {
	[0] = var_0_25,
	var_0_24,
	shift = 4,
	mask = 1
}
local var_0_27 = {
	[0] = {
		[0] = "stmdaNR",
		"stmNR",
		{
			[45] = "pushR",
			_ = "stmdbNR",
			shift = 16,
			mask = 63
		},
		"stmibNR",
		shift = 23,
		mask = 3
	},
	{
		[0] = "ldmdaNR",
		{
			_ = "ldmNR",
			[61] = "popR",
			shift = 16,
			mask = 63
		},
		"ldmdbNR",
		"ldmibNR",
		shift = 23,
		mask = 3
	},
	shift = 20,
	mask = 1
}
local var_0_28 = {
	[0] = "andDNPs",
	"eorDNPs",
	"subDNPs",
	"rsbDNPs",
	"addDNPs",
	"adcDNPs",
	"sbcDNPs",
	"rscDNPs",
	"tstNP",
	"teqNP",
	"cmpNP",
	"cmnNP",
	"orrDNPs",
	"movDPs",
	"bicDNPs",
	"mvnDPs",
	shift = 21,
	mask = 15
}
local var_0_29 = {
	[0] = "mulNMSs",
	"mlaNMSDs",
	"umaalDNMS",
	"mlsDNMS",
	"umullDNMSs",
	"umlalDNMSs",
	"smullDNMSs",
	"smlalDNMSs",
	shift = 21,
	mask = 7
}
local var_0_30 = {
	[0] = "swpDMN",
	false,
	false,
	false,
	"swpbDMN",
	false,
	false,
	false,
	"strexDMN",
	"ldrexDN",
	"strexdDN",
	"ldrexdDN",
	"strexbDMN",
	"ldrexbDN",
	"strexhDN",
	"ldrexhDN",
	shift = 20,
	mask = 15
}
local var_0_31 = {
	[0] = {
		[0] = "smlabbNMSD",
		"smlatbNMSD",
		"smlabtNMSD",
		"smlattNMSD",
		shift = 5,
		mask = 3
	},
	{
		[0] = "smlawbNMSD",
		"smulwbNMS",
		"smlawtNMSD",
		"smulwtNMS",
		shift = 5,
		mask = 3
	},
	{
		[0] = "smlalbbDNMS",
		"smlaltbDNMS",
		"smlalbtDNMS",
		"smlalttDNMS",
		shift = 5,
		mask = 3
	},
	{
		[0] = "smulbbNMS",
		"smultbNMS",
		"smulbtNMS",
		"smulttNMS",
		shift = 5,
		mask = 3
	},
	shift = 21,
	mask = 3
}
local var_0_32 = {
	[0] = {
		[0] = "mrsD",
		"msrM",
		shift = 21,
		mask = 1
	},
	{
		"bxM",
		false,
		"clzDM",
		shift = 21,
		mask = 3
	},
	{
		"bxjM",
		shift = 21,
		mask = 3
	},
	{
		"blxM",
		shift = 21,
		mask = 3
	},
	false,
	{
		[0] = "qaddDMN",
		"qsubDMN",
		"qdaddDMN",
		"qdsubDMN",
		shift = 21,
		mask = 3
	},
	false,
	{
		"bkptK",
		shift = 21,
		mask = 3
	},
	shift = 4,
	mask = 7
}
local var_0_33 = {
	shift = 4,
	mask = 9,
	[9] = {
		[0] = {
			[0] = var_0_29,
			var_0_30,
			shift = 24,
			mask = 1
		},
		{
			[0] = "strhDL",
			"ldrhDL",
			shift = 20,
			mask = 1
		},
		{
			[0] = "ldrdDL",
			"ldrsbDL",
			shift = 20,
			mask = 1
		},
		{
			[0] = "strdDL",
			"ldrshDL",
			shift = 20,
			mask = 1
		},
		shift = 5,
		mask = 3
	},
	_ = {
		shift = 20,
		mask = 25,
		[16] = {
			[0] = var_0_32,
			var_0_31,
			shift = 7,
			mask = 1
		},
		_ = {
			shift = 0,
			mask = 4294967295,
			[var_0_9(3785359360)] = "nop",
			_ = var_0_28
		}
	}
}
local var_0_34 = {
	[16] = "movwDW",
	mask = 31,
	[20] = "movtDW",
	shift = 20,
	[22] = "msrNW",
	[18] = {
		[0] = "nopv6",
		_ = "msrNW",
		shift = 0,
		mask = 983295
	},
	_ = var_0_28
}
local var_0_35 = {
	[0] = "bB",
	"blB",
	shift = 24,
	mask = 1
}
local var_0_36 = {
	[0] = var_0_33,
	var_0_34,
	var_0_25,
	var_0_26,
	var_0_27,
	var_0_35,
	var_0_15,
	var_0_18
}
local var_0_37 = {
	[0] = false,
	var_0_21,
	var_0_22,
	var_0_23,
	false,
	"blxB",
	var_0_19,
	var_0_20
}
local var_0_38 = {
	[0] = "r0",
	"r1",
	"r2",
	"r3",
	"r4",
	"r5",
	"r6",
	"r7",
	"r8",
	"r9",
	"r10",
	"r11",
	"r12",
	"sp",
	"lr",
	"pc"
}
local var_0_39 = {
	[0] = "eq",
	"ne",
	"hs",
	"lo",
	"mi",
	"pl",
	"vs",
	"vc",
	"hi",
	"ls",
	"ge",
	"lt",
	"gt",
	"le",
	"al"
}
local var_0_40 = {
	[0] = "lsl",
	"lsr",
	"asr",
	"ror"
}

local function var_0_41(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0.pos
	local var_1_1 = ""

	if arg_1_0.rel then
		local var_1_2 = arg_1_0.symtab[arg_1_0.rel]

		if var_1_2 then
			var_1_1 = "\t->" .. var_1_2
		elseif var_0_8(arg_1_0.op, 234881024) ~= 167772160 then
			var_1_1 = "\t; 0x" .. var_0_11(arg_1_0.rel)
		end
	end

	if arg_1_0.hexdump > 0 then
		arg_1_0.out(var_0_3("%08x  %s  %-5s %s%s\n", arg_1_0.addr + var_1_0, var_0_11(arg_1_0.op), arg_1_1, var_0_6(arg_1_2, ", "), var_1_1))
	else
		arg_1_0.out(var_0_3("%08x  %-5s %s%s\n", arg_1_0.addr + var_1_0, arg_1_1, var_0_6(arg_1_2, ", "), var_1_1))
	end

	arg_1_0.pos = var_1_0 + 4
end

local function var_0_42(arg_2_0)
	return var_0_41(arg_2_0, ".long", {
		"0x" .. var_0_11(arg_2_0.op)
	})
end

local function var_0_43(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_38[var_0_8(var_0_13(arg_3_1, 16), 15)]
	local var_3_1
	local var_3_2
	local var_3_3 = var_0_8(arg_3_1, 67108864) == 0

	if not var_3_3 and var_0_8(arg_3_1, 33554432) == 0 then
		var_3_2 = var_0_8(arg_3_1, 4095)

		if var_0_8(arg_3_1, 8388608) == 0 then
			var_3_2 = -var_3_2
		end

		if var_3_0 == "pc" then
			arg_3_0.rel = arg_3_0.addr + arg_3_2 + 8 + var_3_2
		end

		var_3_2 = "#" .. var_3_2
	elseif var_3_3 and var_0_8(arg_3_1, 4194304) ~= 0 then
		var_3_2 = var_0_8(arg_3_1, 15) + var_0_8(var_0_13(arg_3_1, 4), 240)

		if var_0_8(arg_3_1, 8388608) == 0 then
			var_3_2 = -var_3_2
		end

		if var_3_0 == "pc" then
			arg_3_0.rel = arg_3_0.addr + arg_3_2 + 8 + var_3_2
		end

		var_3_2 = "#" .. var_3_2
	else
		var_3_2 = var_0_38[var_0_8(arg_3_1, 15)]

		if var_3_3 or var_0_8(arg_3_1, 4064) == 0 then
			-- block empty
		elseif var_0_8(arg_3_1, 4064) == 96 then
			var_3_2 = var_0_3("%s, rrx", var_3_2)
		else
			local var_3_4 = var_0_8(var_0_13(arg_3_1, 7), 31)

			if var_3_4 == 0 then
				var_3_4 = 32
			end

			var_3_2 = var_0_3("%s, %s #%d", var_3_2, var_0_40[var_0_8(var_0_13(arg_3_1, 5), 3)], var_3_4)
		end

		if var_0_8(arg_3_1, 8388608) == 0 then
			var_3_2 = "-" .. var_3_2
		end
	end

	if var_3_2 == "#0" then
		var_3_1 = var_0_3("[%s]", var_3_0)
	elseif var_0_8(arg_3_1, 16777216) == 0 then
		var_3_1 = var_0_3("[%s], %s", var_3_0, var_3_2)
	else
		var_3_1 = var_0_3("[%s, %s]", var_3_0, var_3_2)
	end

	if var_0_8(arg_3_1, 18874368) == 18874368 then
		var_3_1 = var_3_1 .. "!"
	end

	return var_3_1
end

local function var_0_44(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_38[var_0_8(var_0_13(arg_4_1, 16), 15)]
	local var_4_1 = var_0_8(arg_4_1, 255) * 4

	if var_0_8(arg_4_1, 8388608) == 0 then
		var_4_1 = -var_4_1
	end

	if var_4_0 == "pc" then
		arg_4_0.rel = arg_4_0.addr + arg_4_2 + 8 + var_4_1
	end

	if var_4_1 == 0 then
		return var_0_3("[%s]", var_4_0)
	else
		return var_0_3("[%s, #%d]", var_4_0, var_4_1)
	end
end

local function var_0_45(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 == "s" then
		return var_0_3("s%d", 2 * var_0_8(var_0_13(arg_5_0, arg_5_2), 15) + var_0_8(var_0_13(arg_5_0, arg_5_3), 1))
	else
		return var_0_3("d%d", var_0_8(var_0_13(arg_5_0, arg_5_2), 15) + var_0_8(var_0_13(arg_5_0, arg_5_3 - 4), 16))
	end
end

local function var_0_46(arg_6_0)
	local var_6_0 = arg_6_0.pos
	local var_6_1, var_6_2, var_6_3, var_6_4 = var_0_2(arg_6_0.code, var_6_0 + 1, var_6_0 + 4)
	local var_6_5 = var_0_9(var_0_12(var_6_4, 24), var_0_12(var_6_3, 16), var_0_12(var_6_2, 8), var_6_1)
	local var_6_6 = {}
	local var_6_7 = ""
	local var_6_8
	local var_6_9
	local var_6_10
	local var_6_11

	arg_6_0.op = var_6_5
	arg_6_0.rel = nil

	local var_6_12 = var_0_13(var_6_5, 28)
	local var_6_13

	if var_6_12 == 15 then
		var_6_13 = var_0_37[var_0_8(var_0_13(var_6_5, 25), 7)]
	else
		if var_6_12 ~= 14 then
			var_6_7 = var_0_39[var_6_12]
		end

		var_6_13 = var_0_36[var_0_8(var_0_13(var_6_5, 25), 7)]
	end

	while var_0_0(var_6_13) ~= "string" do
		if not var_6_13 then
			return var_0_42(arg_6_0)
		end

		var_6_13 = var_6_13[var_0_8(var_0_13(var_6_5, var_6_13.shift), var_6_13.mask)] or var_6_13._
	end

	local var_6_14, var_6_15 = var_0_4(var_6_13, "^([a-z0-9]*)(.*)")

	if var_0_1(var_6_15, 1, 1) == "." then
		local var_6_16, var_6_17 = var_0_4(var_6_15, "^([a-z0-9.]*)(.*)")

		var_6_7 = var_6_7 .. var_6_16
		var_6_15 = var_6_17
	end

	for iter_6_0 in var_0_5(var_6_15, ".") do
		local var_6_18

		if iter_6_0 == "D" then
			var_6_18 = var_0_38[var_0_8(var_0_13(var_6_5, 12), 15)]
		elseif iter_6_0 == "N" then
			var_6_18 = var_0_38[var_0_8(var_0_13(var_6_5, 16), 15)]
		elseif iter_6_0 == "S" then
			var_6_18 = var_0_38[var_0_8(var_0_13(var_6_5, 8), 15)]
		elseif iter_6_0 == "M" then
			var_6_18 = var_0_38[var_0_8(var_6_5, 15)]
		elseif iter_6_0 == "d" then
			var_6_18 = var_0_45(var_6_5, var_6_11, 12, 22)
		elseif iter_6_0 == "n" then
			var_6_18 = var_0_45(var_6_5, var_6_11, 16, 7)
		elseif iter_6_0 == "m" then
			var_6_18 = var_0_45(var_6_5, var_6_11, 0, 5)
		elseif iter_6_0 == "P" then
			if var_0_8(var_6_5, 33554432) ~= 0 then
				var_6_18 = var_0_10(var_0_8(var_6_5, 255), 2 * var_0_8(var_0_13(var_6_5, 8), 15))
			else
				var_6_18 = var_0_38[var_0_8(var_6_5, 15)]

				if var_0_8(var_6_5, 4080) ~= 0 then
					var_6_6[#var_6_6 + 1] = var_6_18

					local var_6_19 = var_0_40[var_0_8(var_0_13(var_6_5, 5), 3)]
					local var_6_20

					if var_0_8(var_6_5, 3984) == 0 then
						if var_6_19 == "ror" then
							var_6_19 = "rrx"
						else
							var_6_20 = "#32"
						end
					elseif var_0_8(var_6_5, 16) == 0 then
						var_6_20 = "#" .. var_0_8(var_0_13(var_6_5, 7), 31)
					else
						var_6_20 = var_0_38[var_0_8(var_0_13(var_6_5, 8), 15)]
					end

					if var_6_14 == "mov" then
						var_6_14 = var_6_19
						var_6_18 = var_6_20
					elseif var_6_20 then
						var_6_18 = var_0_3("%s %s", var_6_19, var_6_20)
					else
						var_6_18 = var_6_19
					end
				end
			end
		elseif iter_6_0 == "L" then
			var_6_18 = var_0_43(arg_6_0, var_6_5, var_6_0)
		elseif iter_6_0 == "l" then
			var_6_18 = var_0_44(arg_6_0, var_6_5, var_6_0)
		elseif iter_6_0 == "B" then
			local var_6_21 = arg_6_0.addr + var_6_0 + 8 + var_0_14(var_0_12(var_6_5, 8), 6)

			if var_6_12 == 15 then
				var_6_21 = var_6_21 + var_0_8(var_0_13(var_6_5, 23), 2)
			end

			arg_6_0.rel = var_6_21
			var_6_18 = "0x" .. var_0_11(var_6_21)
		elseif iter_6_0 == "F" then
			var_6_11 = "s"
		elseif iter_6_0 == "G" then
			var_6_11 = "d"
		elseif iter_6_0 == "." then
			var_6_7 = var_6_7 .. (var_6_11 == "s" and ".f32" or ".f64")
		elseif iter_6_0 == "R" then
			if var_0_8(var_6_5, 2097152) ~= 0 and #var_6_6 == 1 then
				var_6_6[1] = var_6_6[1] .. "!"
			end

			local var_6_22 = {}

			for iter_6_1 = 0, 15 do
				if var_0_8(var_0_13(var_6_5, iter_6_1), 1) == 1 then
					var_6_22[#var_6_22 + 1] = var_0_38[iter_6_1]
				end
			end

			var_6_18 = "{" .. var_0_6(var_6_22, ", ") .. "}"
		elseif iter_6_0 == "r" then
			if var_0_8(var_6_5, 2097152) ~= 0 and #var_6_6 == 2 then
				var_6_6[1] = var_6_6[1] .. "!"
			end

			local var_6_23 = tonumber(var_0_1(var_6_8, 2))
			local var_6_24 = var_0_8(var_6_5, 255)

			if var_6_11 == "d" then
				var_6_24 = var_0_13(var_6_24, 1)
			end

			var_6_6[#var_6_6] = var_0_3("{%s-%s%d}", var_6_8, var_6_11, var_6_23 + var_6_24 - 1)
		elseif iter_6_0 == "W" then
			var_6_18 = var_0_8(var_6_5, 4095) + var_0_8(var_0_13(var_6_5, 4), 61440)
		elseif iter_6_0 == "T" then
			var_6_18 = "#0x" .. var_0_11(var_0_8(var_6_5, 16777215), 6)
		elseif iter_6_0 == "U" then
			var_6_18 = var_0_8(var_0_13(var_6_5, 7), 31)

			if var_6_18 == 0 then
				var_6_18 = nil
			end
		elseif iter_6_0 == "u" then
			var_6_18 = var_0_8(var_0_13(var_6_5, 7), 31)

			if var_0_8(var_6_5, 64) == 0 then
				if var_6_18 == 0 then
					var_6_18 = nil
				else
					var_6_18 = "lsl #" .. var_6_18
				end
			elseif var_6_18 == 0 then
				var_6_18 = "asr #32"
			else
				var_6_18 = "asr #" .. var_6_18
			end
		elseif iter_6_0 == "v" then
			var_6_18 = var_0_8(var_0_13(var_6_5, 7), 31)
		elseif iter_6_0 == "w" then
			var_6_18 = var_0_8(var_0_13(var_6_5, 16), 31)
		elseif iter_6_0 == "x" then
			var_6_18 = var_0_8(var_0_13(var_6_5, 16), 31) + 1
		elseif iter_6_0 == "X" then
			var_6_18 = var_0_8(var_0_13(var_6_5, 16), 31) - var_6_8 + 1
		elseif iter_6_0 == "Y" then
			var_6_18 = var_0_8(var_0_13(var_6_5, 12), 240) + var_0_8(var_6_5, 15)
		elseif iter_6_0 == "K" then
			var_6_18 = "#0x" .. var_0_11(var_0_8(var_0_13(var_6_5, 4), 65520) + var_0_8(var_6_5, 15), 4)
		elseif iter_6_0 == "s" then
			if var_0_8(var_6_5, 1048576) ~= 0 then
				var_6_7 = "s" .. var_6_7
			end
		else
			assert(false)
		end

		if var_6_18 then
			var_6_8 = var_6_18

			if var_0_0(var_6_18) == "number" then
				var_6_18 = "#" .. var_6_18
			end

			var_6_6[#var_6_6 + 1] = var_6_18
		end
	end

	return var_0_41(arg_6_0, var_6_14 .. var_6_7, var_6_6)
end

local function var_0_47(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1 = arg_7_1 or 0

	local var_7_0 = arg_7_2 and arg_7_1 + arg_7_2 or #arg_7_0.code

	arg_7_0.pos = arg_7_1
	arg_7_0.rel = nil

	while var_7_0 > arg_7_0.pos do
		var_0_46(arg_7_0)
	end
end

local function var_0_48(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		code = arg_8_0,
		addr = arg_8_1 or 0,
		out = arg_8_2 or io.write,
		symtab = {},
		disass = var_0_47
	}

	var_8_0.hexdump = 8

	return var_8_0
end

local function var_0_49(arg_9_0, arg_9_1, arg_9_2)
	var_0_48(arg_9_0, arg_9_1, arg_9_2):disass()
end

local function var_0_50(arg_10_0)
	if arg_10_0 < 16 then
		return var_0_38[arg_10_0]
	end

	return "d" .. arg_10_0 - 16
end

return {
	create = var_0_48,
	disass = var_0_49,
	regname = var_0_50
}
