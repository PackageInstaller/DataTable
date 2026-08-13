require = var_0_10000

local var_0_0 = var_0_10000("jit")

assert = var_0_10001

var_0_10001(var_0_0.version_num == 4, "LuaJIT core/library version mismatch")

require = var_0_10001

local var_0_1 = var_0_10001("jit.util")

require = var_2

local var_0_2 = var_2("jit.vmdef")
local var_0_3 = var_0_1.funcinfo
local var_0_4 = var_0_1.funcbc
local var_0_5 = var_0_1.traceinfo
local var_0_6 = var_0_1.traceir
local var_0_7 = var_0_1.tracek
local var_0_8 = var_0_1.tracemc
local var_0_9 = var_0_1.tracesnap
local var_0_10 = var_0_1.traceexitstub
local var_0_11 = var_0_1.ircalladdr

require = var_0_10012

local var_0_12 = var_0_10012("bit").band
local var_0_13 = var_12.rshift
local var_0_14 = var_12.tohex

string = var_0_10016

local var_0_15 = var_0_10016.sub

string = var_0_10017

local var_0_16 = var_0_10017.gsub

string = var_0_10018

local var_0_17 = var_0_10018.format

string = var_0_10019

local var_0_18 = var_0_10019.byte

string = var_0_10020

local var_0_19 = var_0_10020.rep

type = var_0_10021
tostring = var_0_10022
io = var_0_10023

local var_0_20 = var_0_10023.stdout

io = var_0_10024

local var_0_21 = var_0_10024.stderr
local var_0_22
local var_0_23
local var_0_24
local var_0_25
local var_0_26
local var_0_27 = {
	__index = false
}
local var_0_28 = {}
local var_0_29 = 0

local function var_0_30(arg_1_0, arg_1_1)
	local var_1_0 = {}

	var_0_27.__index = var_1_0

	local var_1_1 = var_0_0.arch

	if var_3.sub(var_1_1, 1, 4) == "mips" then
		var_1_0[var_0_10(arg_1_0, 0)] = "exit"

		return
	end

	for iter_1_0 = 0, arg_1_1 - 1 do
		local var_1_2

		if var_0_10(arg_1_0, iter_1_0) < 0 then
			var_1_2 = var_1_2 + 4294967296
		end

		var_1_0[var_1_2] = var_0_10022(iter_1_0)
	end

	if var_0_10(arg_1_0, arg_1_1) then
		var_1_0[var_3] = "stack_check"
	end

	return
end

local function var_0_31(arg_2_0, arg_2_1)
	local var_2_0 = var_0_28

	if var_0_29 == 0 then
		local var_2_1 = var_0_2.ircall

		for iter_2_0 = 0, #var_2_1 do
			if var_0_11(iter_2_0) ~= 0 then
				local var_2_2

				if var_2_2 < 0 then
					var_2_2 = var_2_2 + 4294967296
				end

				var_2_0[var_2_2] = var_2_1[iter_2_0]
			end
		end
	end

	if var_0_29 == 1000000 then
		var_0_30(arg_2_0, arg_2_1)
	elseif arg_2_1 > var_0_29 then
		for iter_2_1 = var_0_29, arg_2_1 - 1 do
			if var_0_10(iter_2_1) == nil then
				var_0_30(arg_2_0, arg_2_1)

				setmetatable = var_8

				var_8(var_0_28, var_0_27)

				arg_2_1 = 1000000

				break
			end

			local var_2_3

			if var_2_3 < 0 then
				var_2_3 = var_2_3 + 4294967296
			end

			var_2_0[var_2_3] = var_0_10022(iter_2_1)
		end

		var_0_29 = arg_2_1
	end

	return var_2_0
end

local function var_0_32(arg_3_0)
	local var_3_0 = var_0_25

	var_1.write(var_3_0, arg_3_0)

	return
end

local function var_0_33(arg_4_0)
	if not var_0_5(arg_4_0) then
		return
	end

	local var_4_0, var_4_1, var_4_2 = var_0_8(arg_4_0)

	if not var_4_0 then
		return
	end

	if not var_0_23 then
		require = var_5
		var_0_23 = var_5("jit.dis_" .. var_0_0.arch)
	end

	if var_4_1 < 0 then
		var_4_1 = var_4_1 + 4294967296
	end

	local var_4_3 = var_0_25

	var_5.write(var_4_3, "---- TRACE ", arg_4_0, " mcode ", #var_4_0, "\n")

	local var_4_4 = var_0_23.create(var_4_0, var_4_1, var_0_32)

	var_4_4.hexdump = 0
	var_4_4.symtab = var_0_31(arg_4_0, var_1.nexit)

	if var_4_2 ~= 0 then
		var_0_28[var_4_1 + var_4_2] = "LOOP"

		var_4_4:disass(0, var_4_2)

		local var_4_5 = var_0_25

		var_6.write(var_4_5, "->LOOP:\n")
		var_4_4:disass(var_4_2, #var_4_0 - var_4_2)

		var_0_28[var_4_1 + var_4_2] = nil
	else
		var_4_4:disass(0, #var_4_0)
	end

	return
end

local var_0_34 = {
	[0] = "nil",
	"fal",
	"tru",
	"lud",
	"str",
	"p32",
	"thr",
	"pro",
	"fun",
	"p64",
	"cdt",
	"tab",
	"udt",
	"flt",
	"num",
	"i8 ",
	"u8 ",
	"i16",
	"u16",
	"int",
	"u32",
	"i64",
	"u64",
	"sfp"
}
local var_0_35 = {
	[0] = "%s",
	"%s",
	"%s",
	"\x1B[36m%s\x1B[m",
	"\x1B[32m%s\x1B[m",
	"%s",
	"\x1B[1m%s\x1B[m",
	"%s",
	"\x1B[1m%s\x1B[m",
	"%s",
	"\x1B[33m%s\x1B[m",
	"\x1B[31m%s\x1B[m",
	"\x1B[36m%s\x1B[m",
	"\x1B[34m%s\x1B[m",
	"\x1B[34m%s\x1B[m",
	"\x1B[35m%s\x1B[m",
	"\x1B[35m%s\x1B[m",
	"\x1B[35m%s\x1B[m",
	"\x1B[35m%s\x1B[m",
	"\x1B[35m%s\x1B[m",
	"\x1B[35m%s\x1B[m",
	"\x1B[35m%s\x1B[m",
	"\x1B[35m%s\x1B[m",
	"\x1B[35m%s\x1B[m"
}

local function var_0_36(arg_5_0)
	return arg_5_0
end

local function var_0_37(arg_6_0, arg_6_1)
	return var_0_17(var_0_35[arg_6_1], arg_6_0)
end

setmetatable = var_0_10041

local var_0_38 = var_0_10041({}, {
	__index = function(arg_7_0, arg_7_1)
		arg_7_0[arg_7_1] = var_0_37(var_0_34[arg_7_1], arg_7_1)

		return var_2
	end
})
local var_0_39 = {
	[">"] = "&gt;",
	["<"] = "&lt;",
	["&"] = "&amp;"
}

local function var_0_40(arg_8_0, arg_8_1)
	arg_8_0 = var_0_16(arg_8_0, "[<>&]", var_0_39)

	return var_0_17("<span class=\"irt_%s\">%s</span>", var_0_34[arg_8_1], arg_8_0)
end

setmetatable = var_44

local var_0_41 = var_44({}, {
	__index = function(arg_9_0, arg_9_1)
		arg_9_0[arg_9_1] = var_0_40(var_0_34[arg_9_1], arg_9_1)

		return var_2
	end
})
local var_0_42 = "<style type=\"text/css\">\nbackground { background: #ffffff; color: #000000; }\npre.ljdump {\nfont-size: 10pt;\nbackground: #f0f4ff;\ncolor: #000000;\nborder: 1px solid #bfcfff;\npadding: 0.5em;\nmargin-left: 2em;\nmargin-right: 2em;\n}\nspan.irt_str { color: #00a000; }\nspan.irt_thr, span.irt_fun { color: #404040; font-weight: bold; }\nspan.irt_tab { color: #c00000; }\nspan.irt_udt, span.irt_lud { color: #00c0c0; }\nspan.irt_num { color: #4040c0; }\nspan.irt_int, span.irt_i8, span.irt_u8, span.irt_i16, span.irt_u16 { color: #b040b0; }\n</style>\n"
local var_0_43
local var_0_44
local var_0_45 = {}

setmetatable = var_0_10049
var_0_45["SLOAD "] = var_0_10049({}, {
	__index = function(arg_10_0, arg_10_1)
		local var_10_0 = ""

		if var_0_12(arg_10_1, 1) ~= 0 then
			var_10_0 = var_10_0 .. "P"
		end

		if var_0_12(arg_10_1, 2) ~= 0 then
			var_10_0 = var_10_0 .. "F"
		end

		if var_0_12(arg_10_1, 4) ~= 0 then
			var_10_0 = var_10_0 .. "T"
		end

		if var_0_12(arg_10_1, 8) ~= 0 then
			var_10_0 = var_10_0 .. "C"
		end

		if var_0_12(arg_10_1, 16) ~= 0 then
			var_10_0 = var_10_0 .. "R"
		end

		if var_0_12(arg_10_1, 32) ~= 0 then
			var_10_0 = var_10_0 .. "I"
		end

		arg_10_0[arg_10_1] = var_10_0

		return var_10_0
	end
})
var_0_45["XLOAD "] = {
	[0] = "",
	"R",
	"V",
	"RV",
	"U",
	"RU",
	"VU",
	"RVU"
}
setmetatable = var_49
var_0_45["CONV  "] = var_49({}, {
	__index = function(arg_11_0, arg_11_1)
		local var_11_0 = var_0_44[var_0_12(arg_11_1, 31)]
		local var_11_1 = var_0_44[var_0_12(var_0_13(arg_11_1, 5), 31)] .. "." .. var_11_0

		if var_0_12(arg_11_1, 2048) ~= 0 then
			var_11_1 = var_11_1 .. " sext"
		end

		if var_0_13(arg_11_1, 14) == 2 then
			var_11_1 = var_11_1 .. " index"
		elseif var_3 == 3 then
			var_11_1 = var_11_1 .. " check"
		end

		arg_11_0[arg_11_1] = var_11_1

		return var_11_1
	end
})
var_0_45["FLOAD "] = var_0_2.irfield
var_0_45["FREF  "] = var_0_2.irfield
var_0_45.FPMATH = var_0_2.irfpm
var_0_45.BUFHDR = {
	[0] = "RESET",
	"APPEND"
}
var_0_45["TOSTR "] = {
	[0] = "INT",
	"NUM",
	"CHAR"
}

local function var_0_46(arg_12_0)
	if arg_12_0 == "\n" then
		return "\\n"
	elseif arg_12_0 == "\r" then
		return "\\r"
	elseif arg_12_0 == "\t" then
		return "\\t"
	else
		return var_0_17("\\%03d", var_0_18(arg_12_0))
	end

	return
end

local function var_0_47(arg_13_0, arg_13_1)
	if var_0_3(arg_13_0, arg_13_1).loc then
		return var_2.loc
	elseif var_2.ffid then
		return var_0_2.ffnames[var_2.ffid]
	elseif var_2.addr then
		return var_0_17("C:%x", var_2.addr)
	else
		return "(?)"
	end

	return
end

local function var_0_48(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0, var_14_1, var_14_2 = var_0_7(arg_14_0, arg_14_1)
	local var_14_3 = var_0_10021(var_14_0)
	local var_14_4

	if var_14_3 == "number" then
		if var_0_12(arg_14_2 or 0, 0) ~= 0 then
			var_14_4 = var_0_12(arg_14_2, 0) ~= 0 and "contpc" or "ftsz"
		elseif var_14_0 == 6755399441055744 then
			var_14_4 = "bias"
		else
			var_14_4 = var_0_17(var_14_0 > 0 and var_14_0 < 0x0.1000000000000p-1022 and "%+a" or "%+.14g", var_14_0)
		end
	elseif var_14_3 == "string" then
		var_14_4 = var_0_17(#var_14_0 > 20 and "\"%.20s\"~" or "\"%s\"", var_0_16(var_14_0, "%c", var_0_46))
	elseif var_14_3 == "function" then
		var_14_4 = var_0_47(var_14_0)
	elseif var_14_3 == "table" then
		var_14_4 = var_0_17("{%p}", var_14_0)
	elseif var_14_3 == "userdata" then
		if var_14_1 == 12 then
			var_14_4 = var_0_17("userdata:%p", var_14_0)
		elseif var_0_17("[%p]", var_14_0) == "[NULL]" then
			var_14_4 = "NULL"
		end
	elseif var_14_1 == 21 then
		var_14_4 = var_0_15(var_0_10022(var_14_0), 1, -3)

		if var_0_15(var_14_4, 1, 1) ~= "-" then
			var_14_4 = "+" .. var_14_4
		end
	elseif arg_14_2 == 17137663 then
		return "----"
	else
		var_14_4 = var_0_10022(var_14_0)
	end

	local var_14_5 = var_0_43(var_0_17("%-4s", var_14_4), var_14_1)

	if var_14_2 then
		var_14_5 = var_0_17("%s @%d", var_14_5, var_14_2)
	end

	return var_14_5
end

local function var_0_49(arg_15_0, arg_15_1)
	local var_15_0 = 2

	for iter_15_0 = 0, arg_15_1[1] - 1 do
		local var_15_1 = arg_15_1[var_15_0]

		if var_0_13(var_15_1, 24) == iter_15_0 then
			var_15_0 = var_15_0 + 1

			if var_0_12(var_15_1, 65535) - 0 < 0 then
				local var_15_2 = var_0_25

				var_9.write(var_15_2, var_0_48(arg_15_0, var_8, var_15_1))
			elseif var_0_12(var_15_1, 0) ~= 0 then
				local var_15_3 = var_0_25

				var_9.write(var_15_3, var_0_43(var_0_17("%04d/%04d", var_8, var_8 + 1), 14))
			else
				local var_15_4, var_15_5, var_15_6, var_15_7 = var_0_6(arg_15_0, var_8)
				local var_15_8 = var_0_25

				var_13.write(var_15_8, var_0_43(var_0_17("%04d", var_8), var_0_12(var_15_5, 31)))
			end

			local var_15_9 = var_0_25

			var_9.write(var_15_9, var_0_12(var_15_1, 0) == 0 and " " or "|")
		else
			local var_15_10 = var_0_25

			var_8.write(var_15_10, "---- ")
		end
	end

	local var_15_11 = var_0_25

	var_3.write(var_15_11, "]\n")

	return
end

local function var_0_50(arg_16_0)
	local var_16_0 = var_0_25

	var_1.write(var_16_0, "---- TRACE ", arg_16_0, " snapshots\n")

	for iter_16_0 = 0, 0 do
		if not var_0_9(arg_16_0, iter_16_0) then
			break
		end

		local var_16_1 = var_0_25

		var_6.write(var_16_1, var_0_17("#%-3d %04d [ ", iter_16_0, var_5[0]))
		var_0_49(arg_16_0, var_5)
	end

	return
end

local function var_0_51(arg_17_0, arg_17_1)
	if not var_0_23 then
		require = var_2
		var_0_23 = var_2("jit.dis_" .. var_0_0.arch)
	end

	local var_17_0 = var_0_12(arg_17_0, 255)
	local var_17_1 = var_0_13(arg_17_0, 8)

	if var_17_0 == 253 or var_17_0 == 254 then
		return (var_17_1 == 0 or var_17_1 == 255) and " {sink" or var_0_17(" {%04d", arg_17_1 - var_17_1)
	end

	if arg_17_0 > 255 then
		return var_0_17("[%x]", var_17_1 * 4)
	end

	if var_17_0 < 128 then
		return var_0_23.regname(var_17_0)
	end

	return ""
end

local function var_0_52(arg_18_0, arg_18_1)
	local var_18_0

	if arg_18_1 > 0 then
		local var_18_1, var_18_2, var_18_3, var_18_4 = var_0_6(arg_18_0, arg_18_1)

		if var_0_12(var_18_2, 31) == 0 then
			arg_18_1 = var_18_3
			var_18_0 = var_0_48(arg_18_0, var_18_4)
		end
	end

	if arg_18_1 < 0 then
		local var_18_5 = var_0_25
		local var_18_6 = var_3.write
		local var_18_7 = var_0_17
		local var_18_8 = "[0x%x]("

		tonumber = var_1_10009

		var_18_6(var_18_5, var_18_7(var_18_8, var_1_10009((var_0_7(arg_18_0, arg_18_1)))))
	else
		local var_18_9 = var_0_25

		var_3.write(var_18_9, var_0_17("%04d (", arg_18_1))
	end

	return var_18_0
end

local function var_0_53(arg_19_0, arg_19_1)
	if arg_19_1 < 0 then
		local var_19_0 = var_0_25

		var_2.write(var_19_0, var_0_48(arg_19_0, arg_19_1))
	else
		local var_19_1, var_19_2, var_19_3, var_19_4 = var_0_6(arg_19_0, arg_19_1)
		local var_19_5 = 6 * var_0_13(var_19_2, 8)

		if var_0_15(var_0_2.irnames, var_19_5 + 1, var_19_5 + 6) == "CARG  " then
			var_0_53(arg_19_0, var_19_3)

			if var_19_4 < 0 then
				local var_19_6 = var_0_25

				var_8.write(var_19_6, " ", var_0_48(arg_19_0, var_19_4))
			else
				local var_19_7 = var_0_25

				var_8.write(var_19_7, " ", var_0_17("%04d", var_19_4))
			end
		else
			local var_19_8 = var_0_25

			var_8.write(var_19_8, var_0_17("%04d", arg_19_1))
		end
	end

	return
end

local function var_0_54(arg_20_0, arg_20_1, arg_20_2)
	if not var_0_5(arg_20_0) then
		return
	end

	local var_20_0 = var_3.nins
	local var_20_1 = var_0_25

	var_5.write(var_20_1, "---- TRACE ", arg_20_0, " IR\n")

	local var_20_2 = var_0_2.irnames
	local var_20_3 = 0
	local var_20_4
	local var_20_5

	if arg_20_1 then
		var_20_3 = var_0_9(arg_20_0, 0)[0]
		var_20_5 = 0
	end

	for iter_20_0 = 1, var_20_0 do
		if var_20_3 <= iter_20_0 then
			if arg_20_2 then
				local var_20_6 = var_0_25

				var_13.write(var_20_6, var_0_17("....              SNAP   #%-3d [ ", var_20_5))
			else
				local var_20_7 = var_0_25

				var_13.write(var_20_7, var_0_17("....        SNAP   #%-3d [ ", var_20_5))
			end

			var_0_49(arg_20_0, var_20_4)

			var_20_5 = var_20_5 + 1
			var_20_3 = var_0_9(arg_20_0, var_20_5) and var_20_4[0] or 0
		end

		local var_20_8, var_20_9, var_20_10, var_20_11, var_20_12 = var_0_6(arg_20_0, iter_20_0)
		local var_20_13 = 6 * var_0_13(var_20_9, 8)
		local var_20_14 = var_0_12(var_20_9, 31)

		if var_0_15(var_20_2, var_20_13 + 1, var_20_13 + 6) == "LOOP  " then
			if arg_20_2 then
				local var_20_15 = var_0_25

				var_21.write(var_20_15, var_0_17("%04d ------------ LOOP ------------\n", iter_20_0))
			else
				local var_20_16 = var_0_25

				var_21.write(var_20_16, var_0_17("%04d ------ LOOP ------------\n", iter_20_0))
			end
		elseif var_20 ~= "NOP   " and var_20 ~= "CARG  " and (arg_20_2 or var_20 ~= "RENAME") then
			local var_20_17 = var_0_12(var_20_12, 255)

			if arg_20_2 then
				local var_20_18 = var_0_25

				var_22.write(var_20_18, var_0_17("%04d %-6s", iter_20_0, var_0_51(var_20_12, iter_20_0)))
			else
				local var_20_19 = var_0_25

				var_22.write(var_20_19, var_0_17("%04d ", iter_20_0))
			end

			local var_20_20 = var_0_25

			var_22.write(var_20_20, var_0_17("%s%s %s %s ", (var_20_17 == 254 or var_20_17 == 253) and "}" or var_0_12(var_20_9, 128) == 0 and " " or ">", var_0_12(var_20_9, 64) == 0 and " " or "+", var_0_44[var_20_14], var_20))

			local var_20_21 = var_0_12(var_20_8, 3)
			local var_20_22 = var_0_12(var_20_8, 12)

			if var_0_15(var_20, 1, 4) == "CALL" then
				local var_20_23

				if var_20_22 == 4 then
					local var_20_24 = var_0_25

					var_25.write(var_20_24, var_0_17("%-10s  (", var_0_2.ircall[var_20_11]))
				else
					var_20_23 = var_0_52(arg_20_0, var_20_11)
				end

				if var_20_10 ~= -1 then
					var_0_53(arg_20_0, var_20_10)
				end

				local var_20_25 = var_0_25

				var_25.write(var_20_25, ")")

				if var_20_23 then
					local var_20_26 = var_0_25

					var_25.write(var_20_26, " ctype ", var_20_23)
				end
			elseif var_20 == "CNEW  " and var_20_11 == -1 then
				local var_20_27 = var_0_25

				var_24.write(var_20_27, var_0_48(arg_20_0, var_20_10))
			elseif var_20_21 ~= 3 then
				if var_20_10 < 0 then
					local var_20_28 = var_0_25

					var_24.write(var_20_28, var_0_48(arg_20_0, var_20_10))
				else
					local var_20_29 = var_0_25

					var_24.write(var_20_29, var_0_17(var_20_21 == 0 and "%04d" or "#%-3d", var_20_10))
				end

				if var_20_22 ~= 12 then
					if var_20_22 == 4 then
						if var_0_45[var_20] and var_24[var_20_11] then
							local var_20_30 = var_0_25

							var_25.write(var_20_30, "  ", var_24[var_20_11])
						elseif var_20 == "UREFO " or var_20 == "UREFC " then
							local var_20_31 = var_0_25

							var_25.write(var_20_31, var_0_17("  #%-3d", var_0_13(var_20_11, 8)))
						else
							local var_20_32 = var_0_25

							var_25.write(var_20_32, var_0_17("  #%-3d", var_20_11))
						end
					elseif var_20_11 < 0 then
						local var_20_33 = var_0_25

						var_24.write(var_20_33, "  ", var_0_48(arg_20_0, var_20_11))
					else
						local var_20_34 = var_0_25

						var_24.write(var_20_34, var_0_17("  %04d", var_20_11))
					end
				end
			end

			local var_20_35 = var_0_25

			var_24.write(var_20_35, "\n")
		end
	end

	if var_20_4 then
		if arg_20_2 then
			local var_20_36 = var_0_25

			var_9.write(var_20_36, var_0_17("....              SNAP   #%-3d [ ", var_20_5))
		else
			local var_20_37 = var_0_25

			var_9.write(var_20_37, var_0_17("....        SNAP   #%-3d [ ", var_20_5))
		end

		var_0_49(arg_20_0, var_20_4)
	end

	return
end

local var_0_55 = ""
local var_0_56 = 0

local function var_0_57(arg_21_0, arg_21_1)
	if var_0_10021(arg_21_0) == "number" then
		if var_0_10021(arg_21_1) == "function" then
			arg_21_1 = var_0_47(arg_21_1)
		end

		arg_21_0 = var_0_17(var_0_2.traceerr[arg_21_0], arg_21_1)
	end

	return arg_21_0
end

local function var_0_58(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	if arg_22_0 == "stop" or arg_22_0 == "abort" and var_0_26.a then
		if var_0_26.i then
			local var_22_0 = var_0_54
			local var_22_1 = arg_22_1
			local var_22_2 = var_0_26.s
			local var_22_3

			if var_0_26.r then
				var_22_3 = arg_22_0 == "stop"
			end

			var_22_0(var_22_1, var_22_2, var_22_3)
		elseif var_0_26.s then
			var_0_50(arg_22_1)
		end

		if var_0_26.m then
			var_0_33(arg_22_1)
		end
	end

	if arg_22_0 == "start" then
		if var_0_26.H then
			local var_22_4 = var_0_25

			var_6.write(var_22_4, "<pre class=\"ljdump\">\n")
		end

		local var_22_5 = var_0_25

		var_6.write(var_22_5, "---- TRACE ", arg_22_1, " ", arg_22_0)

		if arg_22_4 then
			local var_22_6 = var_0_25

			var_6.write(var_22_6, " ", arg_22_4, "/", arg_22_5 == -1 and "stitch" or arg_22_5)
		end

		local var_22_7 = var_0_25

		var_6.write(var_22_7, " ", var_0_47(arg_22_2, arg_22_3), "\n")
	elseif arg_22_0 == "stop" or arg_22_0 == "abort" then
		local var_22_8 = var_0_25

		var_6.write(var_22_8, "---- TRACE ", arg_22_1, " ", arg_22_0)

		if arg_22_0 == "abort" then
			local var_22_9 = var_0_25

			var_6.write(var_22_9, " ", var_0_47(arg_22_2, arg_22_3), " -- ", var_0_57(arg_22_4, arg_22_5), "\n")
		else
			local var_22_10 = var_0_5(arg_22_1).link
			local var_22_11 = var_6.linktype

			if var_22_10 == arg_22_1 or var_22_10 == 0 then
				local var_22_12 = var_0_25

				var_9.write(var_22_12, " -> ", var_22_11, "\n")
			elseif var_22_11 == "root" then
				local var_22_13 = var_0_25

				var_9.write(var_22_13, " -> ", var_22_10, "\n")
			else
				local var_22_14 = var_0_25

				var_9.write(var_22_14, " -> ", var_22_10, " ", var_22_11, "\n")
			end
		end

		if var_0_26.H then
			local var_22_15 = var_0_25

			var_6.write(var_22_15, "</pre>\n\n")
		else
			local var_22_16 = var_0_25

			var_6.write(var_22_16, "\n")
		end
	else
		if arg_22_0 == "flush" then
			var_0_28, var_0_29 = {}, 0
		end

		local var_22_17 = var_0_25

		var_6.write(var_22_17, "---- TRACE ", arg_22_0, "\n\n")
	end

	local var_22_18 = var_0_25

	var_6.flush(var_22_18)

	return
end

local function var_0_59(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_3 ~= var_0_56 then
		var_0_56 = arg_23_3
		var_0_55 = var_0_19(" .", arg_23_3)
	end

	local var_23_0

	if arg_23_2 >= 0 then
		var_23_0 = var_0_22(arg_23_1, arg_23_2, var_0_55)

		if var_0_26.H then
			var_23_0 = var_0_16(var_23_0, "[<>&]", var_0_39)
		end
	else
		var_23_0 = "0000 " .. var_0_55 .. " FUNCC      \n"
		arg_23_4 = arg_23_1
	end

	if arg_23_2 <= 0 then
		local var_23_1 = var_0_25

		var_6.write(var_23_1, var_0_15(var_23_0, 1, -2), "         ; ", var_0_47(arg_23_1), "\n")
	else
		local var_23_2 = var_0_25

		var_6.write(var_23_2, var_23_0)
	end

	if arg_23_2 >= 0 and var_0_12(var_0_4(arg_23_1, arg_23_2), 255) < 16 then
		local var_23_3 = var_0_25

		var_6.write(var_23_3, var_0_22(arg_23_1, arg_23_2 + 1, var_0_55))
	end

	return
end

local function var_0_60(arg_24_0, arg_24_1, arg_24_2, arg_24_3, ...)
	local var_24_0 = var_0_25

	var_4.write(var_24_0, "---- TRACE ", arg_24_0, " exit ", arg_24_1, "\n")

	if var_0_26.X then
		local var_24_1 = {
			...
		}

		if var_0_0.arch == "x64" then
			for iter_24_0 = 1, arg_24_2 do
				local var_24_2 = var_0_25

				var_9.write(var_24_2, var_0_17(" %016x", var_24_1[iter_24_0]))

				if iter_24_0 % 4 == 0 then
					local var_24_3 = var_0_25

					var_9.write(var_24_3, "\n")
				end
			end
		else
			for iter_24_1 = 1, arg_24_2 do
				local var_24_4 = var_0_25

				var_9.write(var_24_4, " ", var_0_14(var_24_1[iter_24_1]))

				if iter_24_1 % 8 == 0 then
					local var_24_5 = var_0_25

					var_9.write(var_24_5, "\n")
				end
			end
		end

		if var_0_0.arch == "mips" or var_0_0.arch == "mipsel" then
			for iter_24_2 = 1, arg_24_3, 2 do
				local var_24_6 = var_0_25

				var_9.write(var_24_6, var_0_17(" %+17.14g", var_24_1[arg_24_2 + iter_24_2]))

				if iter_24_2 % 8 == 7 then
					local var_24_7 = var_0_25

					var_9.write(var_24_7, "\n")
				end
			end
		else
			for iter_24_3 = 1, arg_24_3 do
				local var_24_8 = var_0_25

				var_9.write(var_24_8, var_0_17(" %+17.14g", var_24_1[arg_24_2 + iter_24_3]))

				if iter_24_3 % 4 == 0 then
					local var_24_9 = var_0_25

					var_9.write(var_24_9, "\n")
				end
			end
		end
	end

	return
end

local function var_0_61()
	if var_0_24 then
		var_0_24 = false

		var_0_0.attach(var_0_60)
		var_0_0.attach(var_0_59)
		var_0_0.attach(var_0_58)

		if var_0_25 and var_0_25 ~= var_0_20 and var_0_25 ~= var_0_21 then
			local var_25_0 = var_0_25

			var_0.close(var_25_0)
		end

		var_0_25 = nil
	end

	return
end

local function var_0_62(arg_26_0, arg_26_1)
	if var_0_24 then
		var_0_61()
	end

	os = var_2

	if not var_2.getenv("TERM") or not var_2:match("color") then
		os = var_1_10003

		local var_26_0

		if var_1_10003.getenv("COLORTERM") then
			var_26_0 = "A"
		else
			var_26_0 = "T"
		end

		arg_26_0 = arg_26_0 and var_0_16(arg_26_0, "[TAH]", function(arg_27_0)
			var_26_0 = arg_27_0

			return ""
		end)

		local var_26_1 = {
			b = true,
			i = true,
			m = true,
			t = true
		}

		if arg_26_0 and arg_26_0 ~= "" then
			if var_0_15(arg_26_0, 1, 1) ~= "+" and var_5 ~= "-" then
				var_26_1 = {}
			end

			for iter_26_0 = 1, #arg_26_0 do
				var_26_1[var_0_15(arg_26_0, iter_26_0, iter_26_0)] = var_5 ~= "-"
			end
		end

		var_0_26 = var_26_1

		if var_26_1.t or var_26_1.b or var_26_1.i or var_26_1.s or var_26_1.m then
			var_0_0.attach(var_0_58, "trace")
		end

		if var_26_1.b then
			var_0_0.attach(var_0_59, "record")

			if not var_0_22 then
				require = var_5
				var_0_22 = var_5("jit.bc").line
			end
		end

		if var_26_1.x or var_26_1.X then
			var_0_0.attach(var_0_60, "texit")
		end

		if not arg_26_1 then
			os = var_26_2
			arg_26_1 = var_26_2.getenv("LUAJIT_DUMPFILE")
		end

		if arg_26_1 then
			local var_26_2

			if arg_26_1 ~= "-" or not var_0_20 then
				assert = var_26_2
				io = var_1_10007
				var_26_2 = var_26_2(var_1_10007.open(arg_26_1, "w"))
			end

			var_0_25 = var_26_2
		else
			var_0_25 = var_0_20
		end

		var_26_1[var_26_0] = true

		if var_26_0 == "A" then
			var_0_43 = var_0_37
			var_0_44 = var_0_38
		elseif var_26_0 == "H" then
			var_0_43 = var_0_40
			var_0_44 = var_0_41

			local var_26_3 = var_0_25

			var_5.write(var_26_3, var_0_42)
		else
			var_0_43 = var_0_36
			var_0_44 = var_0_34
		end

		var_0_24 = true

		return
	end
end

return {
	on = var_0_62,
	off = var_0_61,
	start = var_0_62
}
