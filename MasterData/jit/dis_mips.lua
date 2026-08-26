-- chunkname: @jit/dis_mips.lua

local type = type
local byte, format = string.byte, string.format
local match, gmatch = string.match, string.gmatch
local concat = table.concat
local bit = require("bit")
local band, bor, tohex = bit.band, bit.bor, bit.tohex
local lshift, rshift, arshift = bit.lshift, bit.rshift, bit.arshift
local map_movci = {
	[0] = "movfDSC",
	"movtDSC",
	shift = 16,
	mask = 1
}
local map_srl = {
	[0] = "srlDTA",
	"rotrDTA",
	shift = 21,
	mask = 1
}
local map_srlv = {
	[0] = "srlvDTS",
	"rotrvDTS",
	shift = 6,
	mask = 1
}
local map_special = {
	[0] = {
		[0] = "nop",
		_ = "sllDTA",
		shift = 0,
		mask = -1
	},
	map_movci,
	map_srl,
	"sraDTA",
	"sllvDTS",
	false,
	map_srlv,
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
	shift = 0,
	mask = 63
}
local map_special2 = {
	[0] = "maddST",
	"madduST",
	"mulDST",
	false,
	"msubST",
	"msubuST",
	[32] = "clzDS",
	[63] = "sdbbpY",
	mask = 63,
	shift = 0,
	[33] = "cloDS"
}
local map_bshfl = {
	nil,
	"wsbhDT",
	[24] = "sehDT",
	[16] = "sebDT",
	shift = 6,
	mask = 31
}
local map_dbshfl = {
	nil,
	"dsbhDT",
	[5] = "dshdDT",
	shift = 6,
	mask = 31
}
local map_special3 = {
	[0] = "extTSAK",
	"dextmTSAP",
	nil,
	"dextTSAK",
	"insTSAL",
	nil,
	"dinsuTSEQ",
	"dinsTSAL",
	[59] = "rdhwrTD",
	shift = 0,
	mask = 63,
	[32] = map_bshfl,
	[36] = map_dbshfl
}
local map_regimm = {
	[0] = "bltzSB",
	"bgezSB",
	"bltzlSB",
	"bgezlSB",
	false,
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
	shift = 16,
	mask = 31
}
local map_cop0 = {
	[0] = {
		[0] = "mfc0TDW",
		nil,
		nil,
		nil,
		"mtc0TDW",
		[14] = "wrpgprDT",
		[10] = "rdpgprDT",
		shift = 21,
		mask = 15,
		[11] = {
			[0] = "diT0",
			"eiT0",
			shift = 5,
			mask = 1
		}
	},
	{
		"tlbr",
		"tlbwi",
		nil,
		nil,
		nil,
		"tlbwr",
		nil,
		"tlbp",
		[24] = "eret",
		[32] = "wait",
		mask = 63,
		[31] = "deret",
		shift = 0
	},
	shift = 25,
	mask = 1
}
local map_cop1s = {
	[0] = "add.sFGH",
	"sub.sFGH",
	"mul.sFGH",
	"div.sFGH",
	"sqrt.sFG",
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
	{
		[0] = "movf.sFGC",
		"movt.sFGC",
		shift = 16,
		mask = 1
	},
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
	shift = 0,
	mask = 63
}
local map_cop1d = {
	[0] = "add.dFGH",
	"sub.dFGH",
	"mul.dFGH",
	"div.dFGH",
	"sqrt.dFG",
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
	{
		[0] = "movf.dFGC",
		"movt.dFGC",
		shift = 16,
		mask = 1
	},
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
	shift = 0,
	mask = 63
}
local map_cop1ps = {
	[0] = "add.psFGH",
	"sub.psFGH",
	"mul.psFGH",
	false,
	false,
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
	{
		[0] = "movf.psFGC",
		"movt.psFGC",
		shift = 16,
		mask = 1
	},
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
	shift = 0,
	mask = 63
}
local map_cop1w = {
	[32] = "cvt.s.wFG",
	[33] = "cvt.d.wFG",
	shift = 0,
	mask = 63
}
local map_cop1l = {
	[32] = "cvt.s.lFG",
	[33] = "cvt.d.lFG",
	shift = 0,
	mask = 63
}
local map_cop1bc = {
	[0] = "bc1fCB",
	"bc1tCB",
	"bc1flCB",
	"bc1tlCB",
	shift = 16,
	mask = 3
}
local map_cop1 = {
	[0] = "mfc1TG",
	"dmfc1TG",
	"cfc1TG",
	"mfhc1TG",
	"mtc1TG",
	"dmtc1TG",
	"ctc1TG",
	"mthc1TG",
	map_cop1bc,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	map_cop1s,
	map_cop1d,
	false,
	false,
	map_cop1w,
	map_cop1l,
	map_cop1ps,
	shift = 21,
	mask = 31
}
local map_cop1x = {
	[0] = "lwxc1FSX",
	"ldxc1FSX",
	false,
	false,
	false,
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
	shift = 0,
	mask = 63
}
local map_pri = {
	[0] = map_special,
	map_regimm,
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
	map_cop0,
	map_cop1,
	false,
	map_cop1x,
	"beql|beqzlST0B",
	"bnel|bnezlST0B",
	"blezlSB",
	"bgtzlSB",
	"daddiTSI",
	"daddiuTSI",
	false,
	false,
	map_special2,
	"jalxJ",
	false,
	map_special3,
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
local map_gpr = {
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

local function putop(ctx, text, operands)
	local pos = ctx.pos
	local extra = ""

	if ctx.rel then
		local sym = ctx.symtab[ctx.rel]

		if sym then
			extra = "\t->" .. sym
		end
	end

	if ctx.hexdump > 0 then
		ctx.out(format("%08x  %s  %-7s %s%s\n", ctx.addr + pos, tohex(ctx.op), text, concat(operands, ", "), extra))
	else
		ctx.out(format("%08x  %-7s %s%s\n", ctx.addr + pos, text, concat(operands, ", "), extra))
	end

	ctx.pos = pos + 4
end

local function unknown(ctx)
	return putop(ctx, ".long", {
		"0x" .. tohex(ctx.op)
	})
end

local function get_be(ctx)
	local pos = ctx.pos
	local b0, b1, b2, b3 = byte(ctx.code, pos + 1, pos + 4)

	return bor(lshift(b0, 24), lshift(b1, 16), lshift(b2, 8), b3)
end

local function get_le(ctx)
	local pos = ctx.pos
	local b0, b1, b2, b3 = byte(ctx.code, pos + 1, pos + 4)

	return bor(lshift(b3, 24), lshift(b2, 16), lshift(b1, 8), b0)
end

local function disass_ins(ctx)
	local op = ctx:get()
	local operands = {}
	local last

	ctx.op = op
	ctx.rel = nil

	local opat = map_pri[rshift(op, 26)]

	while type(opat) ~= "string" do
		if not opat then
			return unknown(ctx)
		end

		opat = opat[band(rshift(op, opat.shift), opat.mask)] or opat._
	end

	local name, pat = match(opat, "^([a-z0-9_.]*)(.*)")
	local altname, pat2 = match(pat, "|([a-z0-9_.|]*)(.*)")

	if altname then
		pat = pat2
	end

	for p in gmatch(pat, ".") do
		local x

		if p == "S" then
			x = map_gpr[band(rshift(op, 21), 31)]
		elseif p == "T" then
			x = map_gpr[band(rshift(op, 16), 31)]
		elseif p == "D" then
			x = map_gpr[band(rshift(op, 11), 31)]
		elseif p == "F" then
			x = "f" .. band(rshift(op, 6), 31)
		elseif p == "G" then
			x = "f" .. band(rshift(op, 11), 31)
		elseif p == "H" then
			x = "f" .. band(rshift(op, 16), 31)
		elseif p == "R" then
			x = "f" .. band(rshift(op, 21), 31)
		elseif p == "A" then
			x = band(rshift(op, 6), 31)
		elseif p == "E" then
			x = band(rshift(op, 6), 31) + 32
		elseif p == "M" then
			x = band(rshift(op, 11), 31)
		elseif p == "N" then
			x = band(rshift(op, 16), 31)
		elseif p == "C" then
			x = band(rshift(op, 18), 7)

			if x == 0 then
				x = nil
			end
		elseif p == "K" then
			x = band(rshift(op, 11), 31) + 1
		elseif p == "P" then
			x = band(rshift(op, 11), 31) + 33
		elseif p == "L" then
			x = band(rshift(op, 11), 31) - last + 1
		elseif p == "Q" then
			x = band(rshift(op, 11), 31) - last + 33
		elseif p == "I" then
			x = arshift(lshift(op, 16), 16)
		elseif p == "U" then
			x = band(op, 65535)
		elseif p == "O" then
			local disp = arshift(lshift(op, 16), 16)

			operands[#operands] = format("%d(%s)", disp, last)
		elseif p == "X" then
			local index = map_gpr[band(rshift(op, 16), 31)]

			operands[#operands] = format("%s(%s)", index, last)
		elseif p == "B" then
			x = ctx.addr + ctx.pos + arshift(lshift(op, 16), 16) * 4 + 4
			ctx.rel = x
			x = format("0x%08x", x)
		elseif p == "J" then
			local a = ctx.addr + ctx.pos

			x = a - band(a, 268435455) + band(op, 67108863) * 4
			ctx.rel = x
			x = format("0x%08x", x)
		elseif p == "V" then
			x = band(rshift(op, 8), 7)

			if x == 0 then
				x = nil
			end
		elseif p == "W" then
			x = band(op, 7)

			if x == 0 then
				x = nil
			end
		elseif p == "Y" then
			x = band(rshift(op, 6), 1048575)

			if x == 0 then
				x = nil
			end
		elseif p == "Z" then
			x = band(rshift(op, 6), 1023)

			if x == 0 then
				x = nil
			end
		elseif p == "0" then
			if last == "r0" or last == 0 then
				local n = #operands

				operands[n] = nil
				last = operands[n - 1]

				if altname then
					local a1, a2 = match(altname, "([^|]*)|(.*)")

					if a1 then
						altname = a2
						name = a1
					else
						name = altname
					end
				end
			end
		elseif p == "1" then
			if last == "ra" then
				operands[#operands] = nil
			end
		else
			assert(false)
		end

		if x then
			operands[#operands + 1] = x
			last = x
		end
	end

	return putop(ctx, name, operands)
end

local function disass_block(ctx, ofs, len)
	ofs = ofs or 0

	if len then
		if not (ofs + len) then
			local stop = #ctx.code

			stop = stop - stop % 4
			ctx.pos = ofs - ofs % 4
			ctx.rel = nil

			while stop > ctx.pos do
				disass_ins(ctx)
			end
		end
	end
end

local function create(code, addr, out)
	local ctx = {}

	ctx.code = code
	ctx.addr = addr or 0
	ctx.out = out or io.write
	ctx.symtab = {}
	ctx.disass = disass_block
	ctx.hexdump = 8
	ctx.get = get_be

	return ctx
end

local function create_el(code, addr, out)
	local ctx = create(code, addr, out)

	ctx.get = get_le

	return ctx
end

local function disass(code, addr, out)
	create(code, addr, out):disass()
end

local function disass_el(code, addr, out)
	create_el(code, addr, out):disass()
end

local function regname(r)
	if r < 32 then
		return map_gpr[r]
	end

	return "f" .. r - 32
end

return {
	create = create,
	create_el = create_el,
	disass = disass,
	disass_el = disass_el,
	regname = regname
}
