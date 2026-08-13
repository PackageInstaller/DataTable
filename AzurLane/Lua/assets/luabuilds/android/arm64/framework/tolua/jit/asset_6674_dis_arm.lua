type = var_0_10000
string = var_0_10001

local var_0_0 = var_0_10001.sub

string = var_0_10002

local var_0_1 = var_0_10002.byte

string = var_0_10003

local var_0_2 = var_0_10003.format

string = var_0_10004

local var_0_3 = var_0_10004.match

string = var_0_10005

local var_0_4 = var_0_10005.gmatch

table = var_0_10006

local var_0_5 = var_0_10006.concat

require = var_0_10007

local var_0_6 = var_0_10007("bit").band
local var_0_7 = var_7.bor
local var_0_8 = var_7.ror
local var_0_9 = var_7.tohex
local var_0_10 = var_7.lshift
local var_0_11 = var_7.rshift
local var_0_12 = var_7.arshift
local var_0_13 = {
	shift = 8,
	mask = 15,
	[10] = {
		[0] = {
			[0] = "mask",
			3,
			vmovFmDN = "vstmFNdr",
			shift = 23,
			_ = {
				[0] = 1,
				{
					[13] = "vpushFdr",
					_ = "vstmdbFNdr",
					shift = 16,
					mask = 15
				},
				vstrFdl = "shift",
				[21] = "mask"
			}
		},
		{
			[0] = 3,
			{
				[13] = "vpopFdr",
				_ = "vldmFNdr",
				shift = 16,
				mask = 15
			},
			vmovFDNm = "shift",
			[23] = "mask",
			_ = {
				[0] = "mask",
				1,
				vldrFdl = "vldmdbFNdr",
				shift = 21
			}
		},
		shift = 20,
		mask = 1
	},
	[11] = {
		[0] = {
			[0] = "mask",
			3,
			vmovGmDN = "vstmGNdr",
			shift = 23,
			_ = {
				[0] = 1,
				{
					[13] = "vpushGdr",
					_ = "vstmdbGNdr",
					shift = 16,
					mask = 15
				},
				vstrGdl = "shift",
				[21] = "mask"
			}
		},
		{
			[0] = 3,
			{
				[13] = "vpopGdr",
				_ = "vldmGNdr",
				shift = 16,
				mask = 15
			},
			vmovGDNm = "shift",
			[23] = "mask",
			_ = {
				[0] = "mask",
				1,
				vldrGdl = "vldmdbGNdr",
				shift = 21
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
local var_0_14 = {
	[0] = 147457,
	"vfnmaF.dnm",
	["vmlaF.dnm"] = "vmlsF.dnm",
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
	[1] = {
		[0] = 3585,
		"vcvtG.dF.m",
		["vmovF.dm"] = "vabsF.dm",
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
		shift = 7
	}
}
local var_0_15 = {
	[0] = 147457,
	"vfnmaG.dnm",
	["vmlaG.dnm"] = "vmlsG.dnm",
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
	[1] = {
		[0] = 3585,
		"vcvtF.dG.m",
		["vmovG.dm"] = "vabsG.dm",
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
		shift = 7
	}
}
local var_0_16 = {
	[0] = "mask",
	1,
	[nil] = "svcT",
	shift = 24,
	[0] = {
		[0] = {
			shift = 8,
			mask = 15,
			[10] = var_0_14,
			[11] = var_0_15
		},
		{
			shift = 8,
			mask = 15,
			[10] = {
				[0] = "mask",
				15,
				vmovFnD = "vmovFDn",
				[14] = "vmsrD",
				shift = 20,
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
local var_0_17 = {
	shift = 0,
	mask = 0
}
local var_0_18 = {
	shift = 0,
	mask = 0
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
	[0] = false,
	{
		[0] = "sadd8DNM",
		false,
		false,
		"ssub8DNM",
		"shift",
		5,
		"mask",
		7,
		sadd16DNM = "sasxDNM",
		ssaxDNM = "ssub16DNM"
	},
	{
		[0] = "qadd8DNM",
		false,
		false,
		"qsub8DNM",
		"shift",
		5,
		"mask",
		7,
		qadd16DNM = "qasxDNM",
		qsaxDNM = "qsub16DNM"
	},
	{
		[0] = "shadd8DNM",
		false,
		false,
		"shsub8DNM",
		"shift",
		5,
		"mask",
		7,
		shadd16DNM = "shasxDNM",
		shsaxDNM = "shsub16DNM"
	},
	nil,
	false,
	[5] = {
		[0] = "uadd8DNM",
		false,
		false,
		"usub8DNM",
		"shift",
		5,
		"mask",
		7,
		uadd16DNM = "uasxDNM",
		usaxDNM = "usub16DNM"
	},
	{
		[0] = "uqadd8DNM",
		false,
		false,
		"uqsub8DNM",
		"shift",
		5,
		"mask",
		7,
		uqadd16DNM = "uqasxDNM",
		uqsaxDNM = "uqsub16DNM"
	},
	{
		[0] = "uhadd8DNM",
		false,
		false,
		"uhsub8DNM",
		"shift",
		5,
		"mask",
		7,
		uhadd16DNM = "uhasxDNM",
		uhsaxDNM = "uhsub16DNM"
	},
	{
		[0] = "pkhbtDNMU",
		"selDNM",
		"pkhtbDNMU",
		"shift",
		5,
		"mask",
		7,
		pkhbtDNMU = false,
		pkhtbDNMU = nil,
		[3] = {
			_ = "sxtab16DNMU",
			[15] = "sxtb16DMU",
			shift = 16,
			mask = 15
		}
	},
	false,
	{
		[0] = "ssatDxMu",
		false,
		"ssatDxMu",
		"shift",
		5,
		"mask",
		7,
		ssatDxMu = "ssat16DxM",
		ssatDxMu = nil,
		[3] = {
			_ = "sxtabDNMU",
			[15] = "sxtbDMU",
			shift = 16,
			mask = 15
		}
	},
	{
		[0] = "ssatDxMu",
		"rev16DM",
		"ssatDxMu",
		"shift",
		5,
		"mask",
		7,
		ssatDxMu = "revDM",
		ssatDxMu = nil,
		[3] = {
			_ = "sxtahDNMU",
			[15] = "sxthDMU",
			shift = 16,
			mask = 15
		}
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
	false,
	false,
	[14] = {
		[0] = "usatDwMu",
		false,
		"usatDwMu",
		"shift",
		5,
		"mask",
		7,
		usatDwMu = "usat16DwM",
		usatDwMu = nil,
		[3] = {
			_ = "uxtabDNMU",
			[15] = "uxtbDMU",
			shift = 16,
			mask = 15
		}
	},
	[15] = {
		[0] = "usatDwMu",
		"revshDM",
		"usatDwMu",
		"shift",
		5,
		"mask",
		7,
		usatDwMu = "rbitDM",
		usatDwMu = nil,
		[3] = {
			_ = "uxtahDNMU",
			[15] = "uxthDMU",
			shift = 16,
			mask = 15
		}
	},
	{
		shift = 12,
		mask = 15,
		[15] = {
			[0] = "smusdxNMS",
			"shift",
			5,
			"mask",
			7,
			[nil] = "smuadNMS",
			smuadxNMS = "smusdNMS"
		},
		_ = {
			[0] = "shift",
			5,
			"mask",
			7,
			smladNMSD = "smladxNMSD",
			smlsdNMSD = "smlsdxNMSD"
		}
	},
	nil,
	false,
	false,
	{
		[0] = "shift",
		5,
		"mask",
		7,
		smlaldDNMS = "smlaldxDNMS",
		smlsldDNMS = "smlsldxDNMS"
	},
	false,
	"shift",
	20,
	"mask",
	31,
	[21] = {
		[0] = false,
		false,
		"smmlsNMSD",
		"smmlsrNMSD",
		"shift",
		5,
		"mask",
		7,
		[nil] = nil,
		[false] = false,
		[0] = {
			_ = "smmlaNMSD",
			[15] = "smmulNMS",
			shift = 12,
			mask = 15
		},
		[1] = {
			_ = "smmlarNMSD",
			[15] = "smmulrNMS",
			shift = 12,
			mask = 15
		}
	},
	[24] = {
		shift = 5,
		mask = 7,
		[0] = {
			_ = "usada8NMSD",
			[15] = "usad8NMS",
			shift = 12,
			mask = 15
		}
	},
	{
		[0] = 5,
		"mask",
		3,
		[nil] = nil,
		sbfxDMvw = "shift"
	},
	{
		[0] = 5,
		"mask",
		3,
		[nil] = nil,
		sbfxDMvw = "shift"
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
		[0] = 5,
		"mask",
		3,
		[nil] = nil,
		ubfxDMvw = "shift"
	},
	{
		[0] = 5,
		"mask",
		3,
		[nil] = nil,
		ubfxDMvw = "shift"
	},
	[false] = nil,
	[nil] = nil
}
local var_0_23 = {
	{
		[0] = "strbtDL",
		"ldrbtDL",
		"shift",
		20,
		"mask",
		5,
		strtDL = "ldrtDL",
		[nil] = nil
	},
	shift = 21,
	mask = 9,
	_ = {
		[0] = "strbDL",
		"ldrbDL",
		"shift",
		20,
		"mask",
		5,
		strDL = "ldrDL",
		[nil] = nil
	}
}
local var_0_24 = {
	[0] = var_0_23,
	var_0_22,
	shift = 4,
	mask = 1
}
local var_0_25 = {
	[0] = {
		[0] = "shift",
		23,
		"mask",
		3,
		stmdaNR = "stmNR",
		[nil] = "stmibNR",
		[2] = {
			[45] = "pushR",
			_ = "stmdbNR",
			shift = 16,
			mask = 63
		}
	},
	{
		[0] = "shift",
		23,
		"mask",
		3,
		ldmdaNR = nil,
		ldmdbNR = "ldmibNR",
		[1] = {
			_ = "ldmNR",
			[61] = "popR",
			shift = 16,
			mask = 63
		}
	},
	shift = 20,
	mask = 1
}
local var_0_26 = {
	[0] = "addDNPs",
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
	"shift",
	21,
	"mask",
	15,
	andDNPs = "eorDNPs",
	subDNPs = "rsbDNPs"
}
local var_0_27 = {
	[0] = "umullDNMSs",
	"umlalDNMSs",
	"smullDNMSs",
	"smlalDNMSs",
	"shift",
	21,
	"mask",
	7,
	mulNMSs = "mlaNMSDs",
	umaalDNMS = "mlsDNMS"
}
local var_0_28 = {
	[0] = "swpbDMN",
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
	"shift",
	20,
	"mask",
	15,
	swpDMN = false,
	[false] = false
}
local var_0_29 = {
	[0] = {
		[0] = "shift",
		5,
		"mask",
		3,
		smlabbNMSD = "smlatbNMSD",
		smlabtNMSD = "smlattNMSD"
	},
	{
		[0] = "shift",
		5,
		"mask",
		3,
		smlawbNMSD = "smulwbNMS",
		smlawtNMSD = "smulwtNMS"
	},
	{
		[0] = "shift",
		5,
		"mask",
		3,
		smlalbbDNMS = "smlaltbDNMS",
		smlalbtDNMS = "smlalttDNMS"
	},
	{
		[0] = "shift",
		5,
		"mask",
		3,
		smulbbNMS = "smultbNMS",
		smulbtNMS = "smulttNMS"
	},
	shift = 21,
	mask = 3
}
local var_0_30 = {
	[0] = false,
	[0] = {
		[0] = "mask",
		1,
		mrsD = "msrM",
		shift = 21
	},
	{
		[0] = "shift",
		21,
		"mask",
		3,
		[nil] = "bxM",
		[false] = "clzDM"
	},
	false,
	"shift",
	4,
	"mask",
	7,
	[2] = {
		[0] = "mask",
		3,
		[nil] = "bxjM",
		shift = 21
	},
	[3] = {
		[0] = "mask",
		3,
		[nil] = "blxM",
		shift = 21
	},
	[5] = {
		[0] = "shift",
		21,
		"mask",
		3,
		qaddDMN = "qsubDMN",
		qdaddDMN = "qdsubDMN"
	},
	{
		[0] = "mask",
		3,
		[nil] = "bkptK",
		shift = 21
	},
	[nil] = nil,
	[nil] = nil
}
local var_0_31 = {
	shift = 4,
	mask = 9,
	[9] = {
		[0] = {
			[0] = var_0_27,
			var_0_28,
			shift = 24,
			mask = 1
		},
		{
			[0] = "mask",
			1,
			strhDL = "ldrhDL",
			shift = 20
		},
		{
			[0] = "mask",
			1,
			ldrdDL = "ldrsbDL",
			shift = 20
		},
		{
			[0] = "mask",
			1,
			strdDL = "ldrshDL",
			shift = 20
		},
		shift = 5,
		mask = 3
	},
	_ = {
		shift = 20,
		mask = 25,
		[16] = {
			[0] = var_0_30,
			var_0_29,
			shift = 7,
			mask = 1
		},
		_ = {
			shift = 0,
			mask = 4294967295,
			[var_0_7(3785359360)] = "nop",
			_ = var_0_26
		}
	}
}
local var_0_32 = {
	[16] = "movwDW",
	mask = 31,
	[20] = "movtDW",
	shift = 20,
	[22] = "msrNW",
	[18] = {
		[0] = 983295,
		nopv6 = "_",
		msrNW = "shift",
		[0] = "mask"
	},
	_ = var_0_26
}
local var_0_33 = {
	[0] = "mask",
	1,
	bB = "blB",
	shift = 24
}
local var_0_34 = {
	[0] = var_0_31,
	var_0_32,
	var_0_23,
	var_0_24,
	var_0_25,
	var_0_33,
	var_0_13,
	var_0_16
}
local var_0_35 = {
	[0] = false,
	var_0_19,
	var_0_20,
	var_0_21,
	false,
	"blxB",
	var_0_17,
	var_0_18
}
local var_0_36 = {
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
local var_0_37 = {
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
local var_0_38 = {
	[0] = "lsl",
	"lsr",
	"asr",
	"ror"
}

local function var_0_39(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0.pos
	local var_1_1 = ""

	if arg_1_0.rel then
		if arg_1_0.symtab[arg_1_0.rel] then
			var_1_1 = "\t->" .. var_5
		elseif var_0_6(arg_1_0.op, 0) ~= 0 then
			var_1_1 = "\t; 0x" .. var_0_9(arg_1_0.rel)
		end
	end

	if arg_1_0.hexdump > 0 then
		arg_1_0.out(var_0_2("%08x  %s  %-5s %s%s\n", arg_1_0.addr + var_1_0, var_0_9(arg_1_0.op), arg_1_1, var_0_5(arg_1_2, ", "), var_1_1))
	else
		arg_1_0.out(var_0_2("%08x  %-5s %s%s\n", arg_1_0.addr + var_1_0, arg_1_1, var_0_5(arg_1_2, ", "), var_1_1))
	end

	arg_1_0.pos = var_1_0 + 4

	return
end

local function var_0_40(arg_2_0)
	return var_0_39(arg_2_0, ".long", {
		"0x" .. var_0_9(arg_2_0.op)
	})
end

local function var_0_41(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_36[var_0_6(var_0_11(arg_3_1, 16), 15)]
	local var_3_1
	local var_3_2

	if not (var_0_6(arg_3_1, 0) == 0) and var_0_6(arg_3_1, 0) == 0 then
		var_3_2 = var_0_6(arg_3_1, 4095)

		if var_0_6(arg_3_1, 0) == 0 then
			var_3_2 = -var_3_2
		end

		if var_3_0 == "pc" then
			arg_3_0.rel = arg_3_0.addr + arg_3_2 + 8 + var_3_2
		end

		var_3_2 = "#" .. var_3_2
	elseif var_6 and var_0_6(arg_3_1, 0) ~= 0 then
		var_3_2 = var_0_6(arg_3_1, 15) + var_0_6(var_0_11(arg_3_1, 4), 240)

		if var_0_6(arg_3_1, 0) == 0 then
			var_3_2 = -var_3_2
		end

		if var_3_0 == "pc" then
			arg_3_0.rel = arg_3_0.addr + arg_3_2 + 8 + var_3_2
		end

		var_3_2 = "#" .. var_3_2
	else
		var_3_2 = var_0_36[var_0_6(arg_3_1, 15)]

		if var_6 or var_0_6(arg_3_1, 4064) == 0 then
			-- block empty
		elseif var_0_6(arg_3_1, 4064) == 96 then
			var_3_2 = var_0_2("%s, rrx", var_3_2)
		else
			local var_3_3

			if var_0_6(var_0_11(arg_3_1, 7), 31) == 0 then
				var_3_3 = 32
			end

			var_3_2 = var_0_2("%s, %s #%d", var_3_2, var_0_38[var_0_6(var_0_11(arg_3_1, 5), 3)], var_3_3)
		end

		if var_0_6(arg_3_1, 0) == 0 then
			var_3_2 = "-" .. var_3_2
		end
	end

	if var_3_2 == "#0" then
		var_3_1 = var_0_2("[%s]", var_3_0)
	elseif var_0_6(arg_3_1, 0) == 0 then
		var_3_1 = var_0_2("[%s], %s", var_3_0, var_3_2)
	else
		var_3_1 = var_0_2("[%s, %s]", var_3_0, var_3_2)
	end

	if var_0_6(arg_3_1, 0) == 0 then
		var_3_1 = var_3_1 .. "!"
	end

	return var_3_1
end

local function var_0_42(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_36[var_0_6(var_0_11(arg_4_1, 16), 15)]
	local var_4_1 = var_0_6(arg_4_1, 255) * 4

	if var_0_6(arg_4_1, 0) == 0 then
		var_4_1 = -var_4_1
	end

	if var_4_0 == "pc" then
		arg_4_0.rel = arg_4_0.addr + arg_4_2 + 8 + var_4_1
	end

	if var_4_1 == 0 then
		return var_0_2("[%s]", var_4_0)
	else
		return var_0_2("[%s, #%d]", var_4_0, var_4_1)
	end

	return
end

local function var_0_43(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 == "s" then
		return var_0_2("s%d", 2 * var_0_6(var_0_11(arg_5_0, arg_5_2), 15) + var_0_6(var_0_11(arg_5_0, arg_5_3), 1))
	else
		return var_0_2("d%d", var_0_6(var_0_11(arg_5_0, arg_5_2), 15) + var_0_6(var_0_11(arg_5_0, arg_5_3 - 4), 16))
	end

	return
end

local function var_0_44(arg_6_0)
	local var_6_0 = arg_6_0.pos
	local var_6_1, var_6_2, var_6_3, var_6_4 = var_0_1(arg_6_0.code, var_6_0 + 1, var_6_0 + 4)
	local var_6_5 = var_0_7(var_0_10(var_6_4, 24), var_0_10(var_6_3, 16), var_0_10(var_6_2, 8), var_6_1)
	local var_6_6 = {}
	local var_6_7 = ""
	local var_6_8
	local var_6_9
	local var_6_10
	local var_6_11

	arg_6_0.op = var_6_5
	arg_6_0.rel = nil

	local var_6_12 = var_0_11(var_6_5, 28)
	local var_6_13

	if var_6_12 == 15 then
		var_6_13 = var_0_35[var_0_6(var_0_11(var_6_5, 25), 7)]
	else
		if var_6_12 ~= 14 then
			var_6_7 = var_0_37[var_6_12]
		end

		var_6_13 = var_0_34[var_0_6(var_0_11(var_6_5, 25), 7)]
	end

	while var_0_10000(var_6_13) ~= "string" do
		if not var_6_13 then
			return var_0_40(arg_6_0)
		end

		var_6_13 = var_6_13[var_0_6(var_0_11(var_6_5, var_6_13.shift), var_6_13.mask)] or var_6_13._
	end

	local var_6_14, var_6_15 = var_0_3(var_6_13, "^([a-z0-9]*)(.*)")

	if var_0_0(var_6_15, 1, 1) == "." then
		local var_6_16, var_6_17 = var_0_3(var_6_15, "^([a-z0-9.]*)(.*)")

		var_6_7 = var_6_7 .. var_6_16
		var_6_15 = var_6_17
	end

	for iter_6_0 in var_0_4(var_6_15, ".") do
		local var_6_18

		if iter_6_0 == "D" then
			var_6_18 = var_0_36[var_0_6(var_0_11(var_6_5, 12), 15)]
		elseif iter_6_0 == "N" then
			var_6_18 = var_0_36[var_0_6(var_0_11(var_6_5, 16), 15)]
		elseif iter_6_0 == "S" then
			var_6_18 = var_0_36[var_0_6(var_0_11(var_6_5, 8), 15)]
		elseif iter_6_0 == "M" then
			var_6_18 = var_0_36[var_0_6(var_6_5, 15)]
		elseif iter_6_0 == "d" then
			var_6_18 = var_0_43(var_6_5, var_6_11, 12, 22)
		elseif iter_6_0 == "n" then
			var_6_18 = var_0_43(var_6_5, var_6_11, 16, 7)
		elseif iter_6_0 == "m" then
			var_6_18 = var_0_43(var_6_5, var_6_11, 0, 5)
		elseif iter_6_0 == "P" then
			if var_0_6(var_6_5, 0) ~= 0 then
				var_6_18 = var_0_8(var_0_6(var_6_5, 255), 2 * var_0_6(var_0_11(var_6_5, 8), 15))
			else
				var_6_18 = var_0_36[var_0_6(var_6_5, 15)]

				if var_0_6(var_6_5, 4080) ~= 0 then
					var_6_6[#var_6_6 + 1] = var_6_18
					var_1_10020 = var_0_38[var_0_6(var_0_11(var_6_5, 5), 3)]

					local var_6_19

					if var_0_6(var_6_5, 3984) == 0 then
						if var_1_10020 == "ror" then
							var_1_10020 = "rrx"
						else
							var_6_19 = "#32"
						end
					elseif var_0_6(var_6_5, 16) == 0 then
						var_6_19 = "#" .. var_0_6(var_0_11(var_6_5, 7), 31)
					else
						var_6_19 = var_0_36[var_0_6(var_0_11(var_6_5, 8), 15)]
					end

					if var_6_14 == "mov" then
						var_6_14 = var_1_10020
						var_6_18 = var_6_19
					elseif var_6_19 then
						var_6_18 = var_0_2("%s %s", var_1_10020, var_6_19)
					else
						var_6_18 = var_1_10020
					end
				end
			end
		elseif iter_6_0 == "L" then
			var_6_18 = var_0_41(arg_6_0, var_6_5, var_6_0)
		elseif iter_6_0 == "l" then
			var_6_18 = var_0_42(arg_6_0, var_6_5, var_6_0)
		elseif iter_6_0 == "B" then
			var_1_10020 = arg_6_0.addr + var_6_0 + 8 + var_0_12(var_0_10(var_6_5, 8), 6)

			if var_6_12 == 15 then
				var_1_10020 = var_1_10020 + var_0_6(var_0_11(var_6_5, 23), 2)
			end

			arg_6_0.rel = var_1_10020
			var_6_18 = "0x" .. var_0_9(var_1_10020)
		elseif iter_6_0 == "F" then
			var_6_11 = "s"
		elseif iter_6_0 == "G" then
			var_6_11 = "d"
		elseif iter_6_0 == "." then
			var_6_7 = var_6_7 .. (var_6_11 == "s" and ".f32" or ".f64")
		elseif iter_6_0 == "R" then
			if var_0_6(var_6_5, 0) ~= 0 and #var_6_6 == 1 then
				var_6_6[1] = var_6_6[1] .. "!"
			end

			var_1_10020 = {}

			for iter_6_1 = 0, 15 do
				if var_0_6(var_0_11(var_6_5, iter_6_1), 1) == 1 then
					var_1_10020[#var_1_10020 + 1] = var_0_36[iter_6_1]
				end
			end

			var_6_18 = "{" .. var_0_5(var_1_10020, ", ") .. "}"
		elseif iter_6_0 == "r" then
			if var_0_6(var_6_5, 0) ~= 0 and #var_6_6 == 2 then
				var_6_6[1] = var_6_6[1] .. "!"
			end

			tonumber = var_1_10020
			var_1_10020 = var_1_10020(var_0_0(var_6_8, 2))

			local var_6_20 = var_0_6(var_6_5, 255)

			if var_6_11 == "d" then
				var_6_20 = var_0_11(var_6_20, 1)
			end

			var_6_6[#var_6_6] = var_0_2("{%s-%s%d}", var_6_8, var_6_11, var_1_10020 + var_6_20 - 1)
		elseif iter_6_0 == "W" then
			var_6_18 = var_0_6(var_6_5, 4095) + var_0_6(var_0_11(var_6_5, 4), 0)
		elseif iter_6_0 == "T" then
			var_6_18 = "#0x" .. var_0_9(var_0_6(var_6_5, 16777215), 6)
		elseif iter_6_0 == "U" then
			if var_0_6(var_0_11(var_6_5, 7), 31) == 0 then
				var_6_18 = nil
			end
		elseif iter_6_0 == "u" then
			var_6_18 = var_0_6(var_0_11(var_6_5, 7), 31)

			if var_0_6(var_6_5, 64) == 0 then
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
			var_6_18 = var_0_6(var_0_11(var_6_5, 7), 31)
		elseif iter_6_0 == "w" then
			var_6_18 = var_0_6(var_0_11(var_6_5, 16), 31)
		elseif iter_6_0 == "x" then
			var_6_18 = var_0_6(var_0_11(var_6_5, 16), 31) + 1
		elseif iter_6_0 == "X" then
			var_6_18 = var_0_6(var_0_11(var_6_5, 16), 31) - var_6_8 + 1
		elseif iter_6_0 == "Y" then
			var_6_18 = var_0_6(var_0_11(var_6_5, 12), 240) + var_0_6(var_6_5, 15)
		elseif iter_6_0 == "K" then
			var_6_18 = "#0x" .. var_0_9(var_0_6(var_0_11(var_6_5, 4), 65520) + var_0_6(var_6_5, 15), 4)
		elseif iter_6_0 == "s" then
			if var_0_6(var_6_5, 0) ~= 0 then
				var_6_7 = "s" .. var_6_7
			end
		else
			assert = var_1_10020

			var_1_10020(false)
		end

		if var_6_18 then
			var_6_8 = var_6_18

			if var_0_10000(var_6_18) == "number" then
				var_6_18 = "#" .. var_6_18
			end

			var_6_6[#var_6_6 + 1] = var_6_18
		end
	end

	return var_0_39(arg_6_0, var_6_14 .. var_6_7, var_6_6)
end

local function var_0_45(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1 = arg_7_1 or 0

	local var_7_0

	if not arg_7_2 or not (arg_7_1 + arg_7_2) then
		var_7_0 = #arg_7_0.code
	end

	arg_7_0.pos = arg_7_1
	arg_7_0.rel = nil

	while var_7_0 > arg_7_0.pos do
		var_0_44(arg_7_0)
	end

	return
end

local function var_0_46(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		code = arg_8_0,
		addr = arg_8_1 or 0
	}
	local var_8_1

	if not arg_8_2 then
		::label_8_0::

		io = var_8_1
		var_8_1 = var_8_1.write
	end

	var_8_0.out = var_8_1
	var_8_0.symtab = {}
	var_8_0.disass = var_0_45
	var_8_0.hexdump = 8

	return var_8_0
end

local function var_0_47(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = var_0_46(arg_9_0, arg_9_1, arg_9_2)

	var_3.disass(var_9_0)

	return
end

local function var_0_48(arg_10_0)
	if arg_10_0 < 16 then
		return var_0_36[arg_10_0]
	end

	return "d" .. arg_10_0 - 16
end

return {
	create = var_0_46,
	disass = var_0_47,
	regname = var_0_48
}
