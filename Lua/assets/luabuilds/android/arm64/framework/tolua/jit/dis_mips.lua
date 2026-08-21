local var_0_0 = type
local var_0_1 = string.byte
local var_0_2 = string.format
local var_0_3 = string.match
local var_0_4 = string.gmatch
local var_0_5 = table.concat
local var_0_6 = require("bit")
local var_0_7 = var_0_6.band
local var_0_8 = var_0_6.bor
local var_0_9 = var_0_6.tohex
local var_0_10 = var_0_6.lshift
local var_0_11 = var_0_6.rshift
local var_0_12 = var_0_6.arshift
local var_0_13 = {
	[0] = {
		[0] = "sllvDTS",
		false,
		[0] = {
			[0] = -1,
			nop = "_",
			sllDTA = "shift",
			[0] = "mask"
		},
		[1] = {
			[0] = "mask",
			1,
			movfDSC = "movtDSC",
			shift = 16
		},
		{
			[0] = "mask",
			1,
			srlDTA = "rotrDTA",
			shift = 21
		},
		"sravDTS",
		"jrS",
		"jalrD1S",
		"movzDST",
		"movnDST",
		"syscallY",
		"breakY",
		false,
		"sync",
		"mfhiD",
		"mthiS",
		"mfloD",
		"mtloS",
		"dsllvDST",
		false,
		"dsrlvDST",
		"dsravDST",
		"multST",
		"multuST",
		"divST",
		"divuST",
		"dmultST",
		"dmultuST",
		"ddivST",
		"ddivuST",
		"addDST",
		"addu|moveDST0",
		"subDST",
		"subu|neguDS0T",
		"andDST",
		"or|moveDST0",
		"xorDST",
		"nor|notDST0",
		false,
		false,
		"sltDST",
		"sltuDST",
		"daddDST",
		"dadduDST",
		"dsubDST",
		"dsubuDST",
		"tgeSTZ",
		"tgeuSTZ",
		"tltSTZ",
		"tltuSTZ",
		"teqSTZ",
		false,
		"tneSTZ",
		false,
		"dsllDTA",
		false,
		"dsrlDTA",
		"dsraDTA",
		"dsll32DTA",
		false,
		"dsrl32DTA",
		"dsra32DTA",
		"shift",
		0,
		"mask",
		63,
		[nil] = nil,
		[nil] = "sraDTA",
		[6] = {
			[0] = "mask",
			1,
			srlvDTS = "rotrvDTS",
			shift = 6
		}
	},
	{
		[0] = false,
		false,
		false,
		false,
		"tgeiSI",
		"tgeiuSI",
		"tltiSI",
		"tltiuSI",
		"teqiSI",
		false,
		"tneiSI",
		false,
		"bltzalSB",
		"bgezalSB",
		"bltzallSB",
		"bgezallSB",
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		"synciSO",
		"shift",
		16,
		"mask",
		31,
		bltzSB = "bgezSB",
		bltzlSB = "bgezlSB"
	},
	"jJ",
	"jalJ",
	"beq|beqz|bST00B",
	"bne|bnezST0B",
	"blezSB",
	"bgtzSB",
	"addiTSI",
	"addiu|liTS0I",
	"sltiTSI",
	"sltiuTSI",
	"andiTSU",
	"ori|liTS0U",
	"xoriTSU",
	"luiTU",
	{
		[0] = {
			[0] = "rdpgprDT",
			"shift",
			21,
			"mask",
			15,
			mfc0TDW = nil,
			[nil] = nil,
			mtc0TDW = 14,
			wrpgprDT = 10,
			[11] = {
				[0] = "mask",
				1,
				diT0 = "eiT0",
				shift = 5
			}
		},
		{
			[0] = "eret",
			32,
			"wait",
			"mask",
			63,
			31,
			"deret",
			"shift",
			0,
			[nil] = "tlbr",
			tlbwi = nil,
			[nil] = nil,
			tlbwr = nil,
			tlbp = 24
		},
		shift = 25,
		mask = 1
	},
	{
		[0] = "mtc1TG",
		"dmtc1TG",
		"ctc1TG",
		"mthc1TG",
		nil,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		nil,
		nil,
		false,
		false,
		"shift",
		21,
		"mask",
		31,
		[8] = {
			[0] = "shift",
			16,
			"mask",
			3,
			bc1fCB = "bc1tCB",
			bc1flCB = "bc1tlCB"
		},
		[16] = {
			[0] = "sqrt.sFG",
			"abs.sFG",
			"mov.sFG",
			"neg.sFG",
			"round.l.sFG",
			"trunc.l.sFG",
			"ceil.l.sFG",
			"floor.l.sFG",
			"round.w.sFG",
			"trunc.w.sFG",
			"ceil.w.sFG",
			"floor.w.sFG",
			false,
			nil,
			"movz.sFGT",
			"movn.sFGT",
			false,
			"recip.sFG",
			"rsqrt.sFG",
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			"cvt.d.sFG",
			false,
			false,
			"cvt.w.sFG",
			"cvt.l.sFG",
			"cvt.ps.sFGH",
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			"c.f.sVGH",
			"c.un.sVGH",
			"c.eq.sVGH",
			"c.ueq.sVGH",
			"c.olt.sVGH",
			"c.ult.sVGH",
			"c.ole.sVGH",
			"c.ule.sVGH",
			"c.sf.sVGH",
			"c.ngle.sVGH",
			"c.seq.sVGH",
			"c.ngl.sVGH",
			"c.lt.sVGH",
			"c.nge.sVGH",
			"c.le.sVGH",
			"c.ngt.sVGH",
			"shift",
			0,
			"mask",
			63,
			["add.sFGH"] = "sub.sFGH",
			["mul.sFGH"] = "div.sFGH",
			[17] = {
				[0] = "mask",
				1,
				["movf.sFGC"] = "movt.sFGC",
				shift = 16
			}
		},
		[17] = {
			[0] = "sqrt.dFG",
			"abs.dFG",
			"mov.dFG",
			"neg.dFG",
			"round.l.dFG",
			"trunc.l.dFG",
			"ceil.l.dFG",
			"floor.l.dFG",
			"round.w.dFG",
			"trunc.w.dFG",
			"ceil.w.dFG",
			"floor.w.dFG",
			false,
			nil,
			"movz.dFGT",
			"movn.dFGT",
			false,
			"recip.dFG",
			"rsqrt.dFG",
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			"cvt.s.dFG",
			false,
			false,
			false,
			"cvt.w.dFG",
			"cvt.l.dFG",
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			"c.f.dVGH",
			"c.un.dVGH",
			"c.eq.dVGH",
			"c.ueq.dVGH",
			"c.olt.dVGH",
			"c.ult.dVGH",
			"c.ole.dVGH",
			"c.ule.dVGH",
			"c.df.dVGH",
			"c.ngle.dVGH",
			"c.deq.dVGH",
			"c.ngl.dVGH",
			"c.lt.dVGH",
			"c.nge.dVGH",
			"c.le.dVGH",
			"c.ngt.dVGH",
			"shift",
			0,
			"mask",
			63,
			["add.dFGH"] = "sub.dFGH",
			["mul.dFGH"] = "div.dFGH",
			[17] = {
				[0] = "mask",
				1,
				["movf.dFGC"] = "movt.dFGC",
				shift = 16
			}
		},
		{
			[32] = "cvt.s.wFG",
			[33] = "cvt.d.wFG",
			shift = 0,
			mask = 63
		},
		{
			[32] = "cvt.s.lFG",
			[33] = "cvt.d.lFG",
			shift = 0,
			mask = 63
		},
		{
			[0] = false,
			"abs.psFG",
			"mov.psFG",
			"neg.psFG",
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			nil,
			"movz.psFGT",
			"movn.psFGT",
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			"cvt.s.puFG",
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			"cvt.s.plFG",
			false,
			false,
			false,
			"pll.psFGH",
			"plu.psFGH",
			"pul.psFGH",
			"puu.psFGH",
			"c.f.psVGH",
			"c.un.psVGH",
			"c.eq.psVGH",
			"c.ueq.psVGH",
			"c.olt.psVGH",
			"c.ult.psVGH",
			"c.ole.psVGH",
			"c.ule.psVGH",
			"c.psf.psVGH",
			"c.ngle.psVGH",
			"c.pseq.psVGH",
			"c.ngl.psVGH",
			"c.lt.psVGH",
			"c.nge.psVGH",
			"c.le.psVGH",
			"c.ngt.psVGH",
			"shift",
			0,
			"mask",
			63,
			["add.psFGH"] = "sub.psFGH",
			["mul.psFGH"] = false,
			[17] = {
				[0] = "mask",
				1,
				["movf.psFGC"] = "movt.psFGC",
				shift = 16
			}
		},
		mfc1TG = "dmfc1TG",
		cfc1TG = "mfhc1TG"
	},
	false,
	{
		[0] = false,
		"luxc1FSX",
		false,
		false,
		"swxc1FSX",
		"sdxc1FSX",
		false,
		false,
		false,
		"suxc1FSX",
		false,
		"prefxMSX",
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		"alnv.psFGHS",
		false,
		"madd.sFRGH",
		"madd.dFRGH",
		false,
		false,
		false,
		false,
		"madd.psFRGH",
		false,
		"msub.sFRGH",
		"msub.dFRGH",
		false,
		false,
		false,
		false,
		"msub.psFRGH",
		false,
		"nmadd.sFRGH",
		"nmadd.dFRGH",
		false,
		false,
		false,
		false,
		"nmadd.psFRGH",
		false,
		"nmsub.sFRGH",
		"nmsub.dFRGH",
		false,
		false,
		false,
		false,
		"nmsub.psFRGH",
		false,
		"shift",
		0,
		"mask",
		63,
		lwxc1FSX = "ldxc1FSX",
		[false] = false
	},
	"beql|beqzlST0B",
	"bnel|bnezlST0B",
	"blezlSB",
	"bgtzlSB",
	"daddiTSI",
	"daddiuTSI",
	false,
	false,
	{
		[0] = "mask",
		63,
		"shift",
		0,
		33,
		"cloDS",
		maddST = "madduST",
		mulDST = false,
		msubST = "msubuST",
		[32] = "clzDS",
		[63] = "sdbbpY"
	},
	"jalxJ",
	false,
	{
		[0] = "dinsuTSEQ",
		"dinsTSAL",
		59,
		"rdhwrTD",
		"shift",
		0,
		"mask",
		63,
		extTSAK = "dextmTSAP",
		[nil] = "dextTSAK",
		insTSAL = nil,
		[32] = {
			[0] = 6,
			"mask",
			31,
			[nil] = nil,
			wsbhDT = 24,
			sehDT = 16,
			sebDT = "shift"
		},
		[36] = {
			[0] = 6,
			"mask",
			31,
			[nil] = nil,
			dsbhDT = 5,
			dshdDT = "shift"
		}
	},
	"lbTSO",
	"lhTSO",
	"lwlTSO",
	"lwTSO",
	"lbuTSO",
	"lhuTSO",
	"lwrTSO",
	false,
	"sbTSO",
	"shTSO",
	"swlTSO",
	"swTSO",
	false,
	false,
	"swrTSO",
	"cacheNSO",
	"llTSO",
	"lwc1HSO",
	"lwc2TSO",
	"prefNSO",
	false,
	"ldc1HSO",
	"ldc2TSO",
	"ldTSO",
	"scTSO",
	"swc1HSO",
	"swc2TSO",
	false,
	false,
	"sdc1HSO",
	"sdc2TSO",
	"sdTSO"
}
local var_0_14 = {
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
	"r13",
	"r14",
	"r15",
	"r16",
	"r17",
	"r18",
	"r19",
	"r20",
	"r21",
	"r22",
	"r23",
	"r24",
	"r25",
	"r26",
	"r27",
	"r28",
	"sp",
	"r30",
	"ra"
}

local function var_0_15(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = ""

	if arg_1_0.rel then
		if arg_1_0.symtab[arg_1_0.rel] then
			var_1_0 = "\t->" .. arg_1_0.symtab[arg_1_0.rel]
		end
	end

	if arg_1_0.hexdump > 0 then
		arg_1_0.out(var_0_2("%08x  %s  %-7s %s%s\n", arg_1_0.addr + arg_1_0.pos, var_0_9(arg_1_0.op), arg_1_1, var_0_5(arg_1_2, ", "), var_1_0))
	else
		arg_1_0.out(var_0_2("%08x  %-7s %s%s\n", arg_1_0.addr + arg_1_0.pos, arg_1_1, var_0_5(arg_1_2, ", "), var_1_0))
	end

	arg_1_0.pos = arg_1_0.pos + 4

	return
end

local function var_0_16(arg_2_0)
	return var_0_15(arg_2_0, ".long", {
		"0x" .. var_0_9(arg_2_0.op)
	})
end

local function var_0_17(arg_3_0)
	local var_3_0, var_3_1, var_3_2, var_3_3 = var_0_1(arg_3_0.code, arg_3_0.pos + 1, arg_3_0.pos + 4)

	return var_0_8(var_0_10(var_3_0, 24), var_0_10(var_3_1, 16), var_0_10(var_3_2, 8), var_3_3)
end

local function var_0_18(arg_4_0)
	local var_4_0, var_4_1, var_4_2, var_4_3 = var_0_1(arg_4_0.code, arg_4_0.pos + 1, arg_4_0.pos + 4)

	return var_0_8(var_0_10(var_4_3, 24), var_0_10(var_4_2, 16), var_0_10(var_4_1, 8), var_4_0)
end

local function var_0_19(arg_5_0)
	local var_5_0 = arg_5_0:get()
	local var_5_1 = {}
	local var_5_2

	arg_5_0.op = var_5_0
	arg_5_0.rel = nil

	local var_5_3 = var_0_13[var_0_11(var_5_0, 26)]

	while var_0_0(var_5_3) ~= "string" do
		if not var_5_3 then
			return var_0_16(arg_5_0)
		end

		var_5_3 = var_5_3[var_0_7(var_0_11(var_5_0, var_5_3.shift), var_5_3.mask)] or var_5_3._
	end

	local var_5_4, var_5_5 = var_0_3(var_5_3, "^([a-z0-9_.]*)(.*)")
	local var_5_6, var_5_7 = var_0_3(var_5_5, "|([a-z0-9_.|]*)(.*)")

	if var_5_6 then
		var_5_5 = var_5_7
	end

	for iter_5_0 in var_0_4(var_5_5, ".") do
		local var_5_8

		if iter_5_0 == "S" then
			var_5_8 = var_0_14[var_0_7(var_0_11(var_5_0, 21), 31)]
		elseif iter_5_0 == "T" then
			var_5_8 = var_0_14[var_0_7(var_0_11(var_5_0, 16), 31)]
		elseif iter_5_0 == "D" then
			var_5_8 = var_0_14[var_0_7(var_0_11(var_5_0, 11), 31)]
		elseif iter_5_0 == "F" then
			var_5_8 = "f" .. var_0_7(var_0_11(var_5_0, 6), 31)
		elseif iter_5_0 == "G" then
			var_5_8 = "f" .. var_0_7(var_0_11(var_5_0, 11), 31)
		elseif iter_5_0 == "H" then
			var_5_8 = "f" .. var_0_7(var_0_11(var_5_0, 16), 31)
		elseif iter_5_0 == "R" then
			var_5_8 = "f" .. var_0_7(var_0_11(var_5_0, 21), 31)
		elseif iter_5_0 == "A" then
			var_5_8 = var_0_7(var_0_11(var_5_0, 6), 31)
		elseif iter_5_0 == "E" then
			var_5_8 = var_0_7(var_0_11(var_5_0, 6), 31) + 32
		elseif iter_5_0 == "M" then
			var_5_8 = var_0_7(var_0_11(var_5_0, 11), 31)
		elseif iter_5_0 == "N" then
			var_5_8 = var_0_7(var_0_11(var_5_0, 16), 31)
		elseif iter_5_0 == "C" then
			var_5_8 = var_0_7(var_0_11(var_5_0, 18), 7)

			if var_5_8 == 0 then
				var_5_8 = nil
			end
		elseif iter_5_0 == "K" then
			var_5_8 = var_0_7(var_0_11(var_5_0, 11), 31) + 1
		elseif iter_5_0 == "P" then
			var_5_8 = var_0_7(var_0_11(var_5_0, 11), 31) + 33
		elseif iter_5_0 == "L" then
			var_5_8 = var_0_7(var_0_11(var_5_0, 11), 31) - var_5_2 + 1
		elseif iter_5_0 == "Q" then
			var_5_8 = var_0_7(var_0_11(var_5_0, 11), 31) - var_5_2 + 33
		elseif iter_5_0 == "I" then
			var_5_8 = var_0_12(var_0_10(var_5_0, 16), 16)
		elseif iter_5_0 == "U" then
			var_5_8 = var_0_7(var_5_0, 65535)
		elseif iter_5_0 == "O" then
			var_5_1[#var_5_1] = var_0_2("%d(%s)", var_0_12(var_0_10(var_5_0, 16), 16), var_5_2)
		elseif iter_5_0 == "X" then
			var_5_1[#var_5_1] = var_0_2("%s(%s)", var_0_14[var_0_7(var_0_11(var_5_0, 16), 31)], var_5_2)
		elseif iter_5_0 == "B" then
			var_5_8 = arg_5_0.addr + arg_5_0.pos + var_0_12(var_0_10(var_5_0, 16), 16) * 4 + 4
			arg_5_0.rel = var_5_8
			var_5_8 = var_0_2("0x%08x", var_5_8)
		elseif iter_5_0 == "J" then
			var_5_8 = arg_5_0.addr + arg_5_0.pos - var_0_7(arg_5_0.addr + arg_5_0.pos, 268435455) + var_0_7(var_5_0, 67108863) * 4
			arg_5_0.rel = var_5_8
			var_5_8 = var_0_2("0x%08x", var_5_8)
		elseif iter_5_0 == "V" then
			var_5_8 = var_0_7(var_0_11(var_5_0, 8), 7)

			if var_5_8 == 0 then
				var_5_8 = nil
			end
		elseif iter_5_0 == "W" then
			var_5_8 = var_0_7(var_5_0, 7)

			if var_5_8 == 0 then
				var_5_8 = nil
			end
		elseif iter_5_0 == "Y" then
			var_5_8 = var_0_7(var_0_11(var_5_0, 6), 1048575)

			if var_5_8 == 0 then
				var_5_8 = nil
			end
		elseif iter_5_0 == "Z" then
			var_5_8 = var_0_7(var_0_11(var_5_0, 6), 1023)

			if var_5_8 == 0 then
				var_5_8 = nil
			end
		elseif iter_5_0 == "0" then
			if var_5_2 == "r0" or var_5_2 == 0 then
				local var_5_9 = #var_5_1

				var_5_1[#var_5_1] = nil
				var_5_2 = var_5_1[var_5_9 - 1]

				if var_5_6 then
					local var_5_10, var_5_11 = var_0_3(var_5_6, "([^|]*)|(.*)")

					if var_5_10 then
						var_5_6 = var_5_11
						var_5_4 = var_5_10
					else
						var_5_4 = var_5_6
					end
				end
			end
		elseif iter_5_0 == "1" then
			if var_5_2 == "ra" then
				var_5_1[#var_5_1] = nil
			end
		else
			assert(false)
		end

		if var_5_8 then
			var_5_1[#var_5_1 + 1] = var_5_8
			var_5_2 = var_5_8
		end
	end

	return var_0_15(arg_5_0, var_5_4, var_5_1)
end

local function var_0_20(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1 = arg_6_1 or 0

	if arg_6_2 then
		local var_6_0 = arg_6_1 + arg_6_2 or #arg_6_0.code
		local var_6_1 = var_6_0 - var_6_0 % 4

		arg_6_0.pos = arg_6_1 - arg_6_1 % 4
		arg_6_0.rel = nil

		while var_6_1 > arg_6_0.pos do
			var_0_19(arg_6_0)
		end

		return
	end
end

return {
	create = function(arg_7_0, arg_7_1, arg_7_2)
		({
			code = arg_7_0,
			addr = arg_7_1 or 0,
			out = arg_7_2 or io.write,
			symtab = {},
			disass = var_0_20
		}).hexdump = 8
		;({
			code = arg_7_0,
			addr = arg_7_1 or 0,
			out = arg_7_2 or io.write,
			symtab = {},
			disass = var_0_20
		}).get = var_0_17

		return {
			code = arg_7_0,
			addr = arg_7_1 or 0,
			out = arg_7_2 or io.write,
			symtab = {},
			disass = var_0_20
		}
	end,
	create_el = function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = var_0(arg_8_0, arg_8_1, arg_8_2)

		var_8_0.get = var_0_18

		return var_8_0
	end,
	disass = function(arg_9_0, arg_9_1, arg_9_2)
		var_0(arg_9_0, arg_9_1, arg_9_2):disass()

		return
	end,
	disass_el = function(arg_10_0, arg_10_1, arg_10_2)
		var_0(arg_10_0, arg_10_1, arg_10_2):disass()

		return
	end,
	regname = function(arg_11_0)
		if arg_11_0 < 32 then
			return var_0_14[arg_11_0]
		end

		return "f" .. arg_11_0 - 32
	end
}
