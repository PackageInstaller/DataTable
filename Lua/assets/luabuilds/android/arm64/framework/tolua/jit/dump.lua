assert(require("jit").version_num == 4, "LuaJIT core/library version mismatch")

local var_0_0 = require("jit.util")
local var_0_1 = require("jit.vmdef")
local var_0_2 = var_0_0.funcinfo
local var_0_3 = var_0_0.funcbc
local var_0_4 = var_0_0.traceinfo
local var_0_5 = var_0_0.traceir
local var_0_6 = var_0_0.tracek
local var_0_7 = var_0_0.tracemc
local var_0_8 = var_0_0.tracesnap
local var_0_9 = var_0_0.traceexitstub
local var_0_10 = var_0_0.ircalladdr
local var_0_11 = require("bit")
local var_0_12 = var_0_11.band
local var_0_13 = var_0_11.rshift
local var_0_14 = var_0_11.tohex
local var_0_15 = string.sub
local var_0_16 = string.gsub
local var_0_17 = string.format
local var_0_18 = string.byte
local var_0_19 = string.rep
local var_0_20 = type
local var_0_21 = tostring
local var_0_22 = io.stdout
local var_0_23 = io.stderr
local var_0_24
local var_0_25
local var_0_26
local var_0_27
local var_0_28
local var_0_29 = {
	__index = false
}
local var_0_30 = {}
local var_0_31 = 0

local function var_0_32(arg_1_0, arg_1_1)
	var_0_29.__index = {}

	if var_0.arch:sub(1, 4) == "mips" then
		({})[var_0_9(arg_1_0, 0)] = "exit"

		return
	end

	for iter_1_0 = 0, arg_1_1 - 1 do
		local var_1_0 = var_0_9(arg_1_0, iter_1_0)

		if var_1_0 < 0 then
			var_1_0 = var_1_0 + 4294967296
		end

		;({})[var_1_0] = var_0_21(iter_1_0)
	end

	local var_1_1 = var_0_9(arg_1_0, arg_1_1)

	if var_1_1 then
		({})[var_1_1] = "stack_check"
	end

	return
end

local function var_0_33(arg_2_0, arg_2_1)
	if var_0_31 == 0 then
		for iter_2_0 = 0, #var_0_1.ircall do
			local var_2_0 = var_0_10(iter_2_0)

			if var_2_0 ~= 0 then
				if var_2_0 < 0 then
					var_2_0 = var_2_0 + 4294967296
				end

				var_0_30[var_2_0] = var_0_1.ircall[iter_2_0]
			end
		end
	end

	if var_0_31 == 1000000 then
		var_0_32(arg_2_0, arg_2_1)
	elseif arg_2_1 > var_0_31 then
		for iter_2_1 = var_0_31, arg_2_1 - 1 do
			local var_2_1 = var_0_9(iter_2_1)

			if var_2_1 == nil then
				var_0_32(arg_2_0, arg_2_1)
				setmetatable(var_0_30, var_0_29)

				arg_2_1 = 1000000

				break
			end

			if var_2_1 < 0 then
				var_2_1 = var_2_1 + 4294967296
			end

			var_0_30[var_2_1] = var_0_21(iter_2_1)
		end

		var_0_31 = arg_2_1
	end

	return var_0_30
end

local function var_0_34(arg_3_0)
	var_0_27:write(arg_3_0)

	return
end

local function var_0_35(arg_4_0)
	local var_4_0 = var_0_4(arg_4_0)

	if not var_4_0 then
		return
	end

	local var_4_1, var_4_2, var_4_3 = var_0_7(arg_4_0)

	if not var_4_1 then
		return
	end

	var_0_25 = var_0_25 or require("jit.dis_" .. var_0.arch)

	if var_4_2 < 0 then
		var_4_2 = var_4_2 + 4294967296
	end

	var_0_27:write("---- TRACE ", arg_4_0, " mcode ", #var_4_1, "\n")

	local var_4_4 = var_0_25.create(var_4_1, var_4_2, var_0_34)

	var_4_4.hexdump = 0
	var_4_4.symtab = var_0_33(arg_4_0, var_4_0.nexit)

	if var_4_3 ~= 0 then
		var_0_30[var_4_2 + var_4_3] = "LOOP"

		var_4_4:disass(0, var_4_3)
		var_0_27:write("->LOOP:\n")
		var_4_4:disass(var_4_3, #var_4_1 - var_4_3)

		var_0_30[var_4_2 + var_4_3] = nil
	else
		var_4_4:disass(0, #var_4_1)
	end

	return
end

local var_0_36 = {
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
local var_0_37 = {
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

local function var_0_38(arg_5_0)
	return arg_5_0
end

local function var_0_39(arg_6_0, arg_6_1)
	return var_0_17(var_0_37[arg_6_1], arg_6_0)
end

local var_0_40 = setmetatable({}, {
	__index = function(arg_7_0, arg_7_1)
		local var_7_0 = var_0_39(var_0_36[arg_7_1], arg_7_1)

		arg_7_0[arg_7_1] = var_7_0

		return var_7_0
	end
})
local var_0_41 = {
	[">"] = "&gt;",
	["<"] = "&lt;",
	["&"] = "&amp;"
}

local function var_0_42(arg_8_0, arg_8_1)
	arg_8_0 = var_0_16(arg_8_0, "[<>&]", var_0_41)

	return var_0_17("<span class=\"irt_%s\">%s</span>", var_0_36[arg_8_1], arg_8_0)
end

local var_0_43 = setmetatable({}, {
	__index = function(arg_9_0, arg_9_1)
		local var_9_0 = var_0_42(var_0_36[arg_9_1], arg_9_1)

		arg_9_0[arg_9_1] = var_9_0

		return var_9_0
	end
})
local var_0_44 = "<style type=\"text/css\">\nbackground { background: #ffffff; color: #000000; }\npre.ljdump {\nfont-size: 10pt;\nbackground: #f0f4ff;\ncolor: #000000;\nborder: 1px solid #bfcfff;\npadding: 0.5em;\nmargin-left: 2em;\nmargin-right: 2em;\n}\nspan.irt_str { color: #00a000; }\nspan.irt_thr, span.irt_fun { color: #404040; font-weight: bold; }\nspan.irt_tab { color: #c00000; }\nspan.irt_udt, span.irt_lud { color: #00c0c0; }\nspan.irt_num { color: #4040c0; }\nspan.irt_int, span.irt_i8, span.irt_u8, span.irt_i16, span.irt_u16 { color: #b040b0; }\n</style>\n"
local var_0_45
local var_0_46
local var_0_47 = {
	["SLOAD "] = setmetatable({}, {
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
	}),
	["XLOAD "] = {
		[0] = "",
		"R",
		"V",
		"RV",
		"U",
		"RU",
		"VU",
		"RVU"
	},
	["CONV  "] = setmetatable({}, {
		__index = function(arg_11_0, arg_11_1)
			local var_11_0 = var_0_46[var_0_12(var_0_13(arg_11_1, 5), 31)] .. "." .. var_0_46[var_0_12(arg_11_1, 31)]

			if var_0_12(arg_11_1, 2048) ~= 0 then
				var_11_0 = var_11_0 .. " sext"
			end

			local var_11_1 = var_0_13(arg_11_1, 14)

			if var_11_1 == 2 then
				var_11_0 = var_11_0 .. " index"
			elseif var_11_1 == 3 then
				var_11_0 = var_11_0 .. " check"
			end

			arg_11_0[arg_11_1] = var_11_0

			return var_11_0
		end
	}),
	["FLOAD "] = var_0_1.irfield,
	["FREF  "] = var_0_1.irfield,
	FPMATH = var_0_1.irfpm,
	BUFHDR = {
		[0] = "RESET",
		"APPEND"
	},
	["TOSTR "] = {
		[0] = "INT",
		"NUM",
		"CHAR"
	}
}

local function var_0_48(arg_12_0)
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

local function var_0_49(arg_13_0, arg_13_1)
	local var_13_0 = var_0_2(arg_13_0, arg_13_1)

	if var_13_0.loc then
		return var_13_0.loc
	elseif var_13_0.ffid then
		return var_0_1.ffnames[var_13_0.ffid]
	elseif var_13_0.addr then
		return var_0_17("C:%x", var_13_0.addr)
	else
		return "(?)"
	end

	return
end

local function var_0_50(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0, var_14_1, var_14_2 = var_0_6(arg_14_0, arg_14_1)
	local var_14_3 = var_0_20(var_14_0)
	local var_14_4

	if var_14_3 == "number" then
		var_14_4 = var_0_12(arg_14_2 or 0, 0) ~= 0 and (var_0_12(arg_14_2, 0) ~= 0 and "contpc" or "ftsz") or var_14_0 == 6755399441055744 and "bias" or var_0_17(var_14_0 > 0 and var_14_0 < 0x0.1000000000000p-1022 and "%+a" or "%+.14g", var_14_0)
	elseif var_14_3 == "string" then
		var_14_4 = var_0_17(#var_14_0 > 20 and "\"%.20s\"~" or "\"%s\"", var_0_16(var_14_0, "%c", var_0_48))
	elseif var_14_3 == "function" then
		var_14_4 = var_0_49(var_14_0)
	elseif var_14_3 == "table" then
		var_14_4 = var_0_17("{%p}", var_14_0)
	elseif var_14_3 == "userdata" then
		if var_14_1 == 12 then
			var_14_4 = var_0_17("userdata:%p", var_14_0)
		else
			var_14_4 = var_0_17("[%p]", var_14_0)

			if var_14_4 == "[NULL]" then
				var_14_4 = "NULL"
			end
		end
	elseif var_14_1 == 21 then
		var_14_4 = var_0_15(var_0_21(var_14_0), 1, -3)

		if var_0_15(var_14_4, 1, 1) ~= "-" then
			var_14_4 = "+" .. var_14_4
		end
	elseif arg_14_2 == 17137663 then
		return "----"
	else
		var_14_4 = var_0_21(var_14_0)
	end

	local var_14_5 = var_0_45(var_0_17("%-4s", var_14_4), var_14_1)

	if var_14_2 then
		var_14_5 = var_0_17("%s @%d", var_14_5, var_14_2)
	end

	return var_14_5
end

local function var_0_51(arg_15_0, arg_15_1)
	for iter_15_0 = 0, arg_15_1[1] - 1 do
		local var_15_0 = arg_15_1[2]
		local var_15_1

		if var_0_13(arg_15_1[2], 24) == iter_15_0 then
			var_15_1 = 2 + 1

			local var_15_2 = var_0_12(var_15_0, 65535) - 0

			if var_15_2 < 0 then
				var_0_27:write(var_0_50(arg_15_0, var_15_2, var_15_0))
			elseif var_0_12(var_15_0, 0) ~= 0 then
				var_0_27:write(var_0_45(var_0_17("%04d/%04d", var_15_2, var_15_2 + 1), 14))
			else
				local var_15_3, var_15_4, var_15_5, var_15_6 = var_0_5(arg_15_0, var_15_2)

				var_0_27:write(var_0_45(var_0_17("%04d", var_15_2), var_0_12(var_15_4, 31)))
			end

			var_0_27:write(var_0_12(var_15_0, 0) == 0 and " " or "|")
		else
			var_0_27:write("---- ")
		end
	end

	var_0_27:write("]\n")

	return
end

local function var_0_52(arg_16_0)
	var_0_27:write("---- TRACE ", arg_16_0, " snapshots\n")

	for iter_16_0 = 0, 0 do
		local var_16_0 = var_0_8(arg_16_0, iter_16_0)

		if not var_16_0 then
			break
		end

		var_0_27:write(var_0_17("#%-3d %04d [ ", iter_16_0, var_16_0[0]))
		var_0_51(arg_16_0, var_16_0)
	end

	return
end

local function var_0_53(arg_17_0, arg_17_1)
	var_0_25 = var_0_25 or require("jit.dis_" .. var_0.arch)

	local var_17_0 = var_0_12(arg_17_0, 255)
	local var_17_1 = var_0_13(arg_17_0, 8)

	if var_17_0 == 253 or var_17_0 == 254 then
		return (var_17_1 == 0 or var_17_1 == 255) and " {sink" or var_0_17(" {%04d", arg_17_1 - var_17_1)
	end

	if arg_17_0 > 255 then
		return var_0_17("[%x]", var_17_1 * 4)
	end

	if var_17_0 < 128 then
		return var_0_25.regname(var_17_0)
	end

	return ""
end

local function var_0_54(arg_18_0, arg_18_1)
	local var_18_0

	if arg_18_1 > 0 then
		local var_18_1, var_18_2, var_18_3, var_18_4 = var_0_5(arg_18_0, arg_18_1)

		if var_0_12(var_18_2, 31) == 0 then
			arg_18_1 = var_18_3
			var_18_0 = var_0_50(arg_18_0, var_18_4)
		end
	end

	if arg_18_1 < 0 then
		var_0_27:write(var_0_17("[0x%x](", tonumber((var_0_6(arg_18_0, arg_18_1)))))
	else
		var_0_27:write(var_0_17("%04d (", arg_18_1))
	end

	return var_18_0
end

local function var_0_55(arg_19_0, arg_19_1)
	if arg_19_1 < 0 then
		var_0_27:write(var_0_50(arg_19_0, arg_19_1))
	else
		local var_19_0, var_19_1, var_19_2, var_19_3 = var_0_5(arg_19_0, arg_19_1)
		local var_19_4 = 6 * var_0_13(var_19_1, 8)

		if var_0_15(var_0_1.irnames, var_19_4 + 1, var_19_4 + 6) == "CARG  " then
			var_0_55(arg_19_0, var_19_2)

			if var_19_3 < 0 then
				var_0_27:write(" ", var_0_50(arg_19_0, var_19_3))
			else
				var_0_27:write(" ", var_0_17("%04d", var_19_3))
			end
		else
			var_0_27:write(var_0_17("%04d", arg_19_1))
		end
	end

	return
end

local function var_0_56(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = var_0_4(arg_20_0)

	if not var_20_0 then
		return
	end

	local var_20_1 = var_20_0.nins

	var_0_27:write("---- TRACE ", arg_20_0, " IR\n")

	local var_20_2 = 0
	local var_20_3
	local var_20_4

	if arg_20_1 then
		var_20_3 = var_0_8(arg_20_0, 0)
		var_20_2 = var_20_3[0]
		var_20_4 = 0
	end

	for iter_20_0 = 1, var_20_1 do
		if var_20_2 <= iter_20_0 then
			if arg_20_2 then
				var_0_27:write(var_0_17("....              SNAP   #%-3d [ ", var_20_4))
			else
				var_0_27:write(var_0_17("....        SNAP   #%-3d [ ", var_20_4))
			end

			var_0_51(arg_20_0, var_20_3)

			var_20_4 = var_20_4 + 1
			var_20_3 = var_0_8(arg_20_0, var_20_4)
			var_20_2 = var_20_3 and var_20_3[0] or 0
		end

		local var_20_5, var_20_6, var_20_7, var_20_8, var_20_9 = var_0_5(arg_20_0, iter_20_0)
		local var_20_10 = 6 * var_0_13(var_20_6, 8)
		local var_20_11 = var_0_12(var_20_6, 31)
		local var_20_12 = var_0_15(var_0_1.irnames, var_20_10 + 1, var_20_10 + 6)

		if var_20_12 == "LOOP  " then
			if arg_20_2 then
				var_0_27:write(var_0_17("%04d ------------ LOOP ------------\n", iter_20_0))
			else
				var_0_27:write(var_0_17("%04d ------ LOOP ------------\n", iter_20_0))
			end
		elseif var_20_12 ~= "NOP   " and var_20_12 ~= "CARG  " and (arg_20_2 or var_20_12 ~= "RENAME") then
			local var_20_13 = var_0_12(var_20_9, 255)

			if arg_20_2 then
				var_0_27:write(var_0_17("%04d %-6s", iter_20_0, var_0_53(var_20_9, iter_20_0)))
			else
				var_0_27:write(var_0_17("%04d ", iter_20_0))
			end

			var_0_27:write(var_0_17("%s%s %s %s ", (var_20_13 == 254 or var_20_13 == 253) and "}" or var_0_12(var_20_6, 128) == 0 and " " or ">", var_0_12(var_20_6, 64) == 0 and " " or "+", var_0_46[var_20_11], var_20_12))

			local var_20_14 = var_0_12(var_20_5, 3)
			local var_20_15 = var_0_12(var_20_5, 12)

			if var_0_15(var_20_12, 1, 4) == "CALL" then
				local var_20_16

				if var_20_15 == 4 then
					var_0_27:write(var_0_17("%-10s  (", var_0_1.ircall[var_20_8]))
				else
					var_20_16 = var_0_54(arg_20_0, var_20_8)
				end

				if var_20_7 ~= -1 then
					var_0_55(arg_20_0, var_20_7)
				end

				var_0_27:write(")")

				if var_20_16 then
					var_0_27:write(" ctype ", var_20_16)
				end
			elseif var_20_12 == "CNEW  " and var_20_8 == -1 then
				var_0_27:write(var_0_50(arg_20_0, var_20_7))
			elseif var_20_14 ~= 3 then
				if var_20_7 < 0 then
					var_0_27:write(var_0_50(arg_20_0, var_20_7))
				else
					var_0_27:write(var_0_17(var_20_14 == 0 and "%04d" or "#%-3d", var_20_7))
				end

				if var_20_15 ~= 12 then
					if var_20_15 == 4 then
						if var_0_47[var_20_12] and var_0_47[var_20_12][var_20_8] then
							var_0_27:write("  ", var_0_47[var_20_12][var_20_8])
						elseif var_20_12 == "UREFO " or var_20_12 == "UREFC " then
							var_0_27:write(var_0_17("  #%-3d", var_0_13(var_20_8, 8)))
						else
							var_0_27:write(var_0_17("  #%-3d", var_20_8))
						end
					elseif var_20_8 < 0 then
						var_0_27:write("  ", var_0_50(arg_20_0, var_20_8))
					else
						var_0_27:write(var_0_17("  %04d", var_20_8))
					end
				end
			end

			var_0_27:write("\n")
		end
	end

	if var_20_3 then
		if arg_20_2 then
			var_0_27:write(var_0_17("....              SNAP   #%-3d [ ", var_20_4))
		else
			var_0_27:write(var_0_17("....        SNAP   #%-3d [ ", var_20_4))
		end

		var_0_51(arg_20_0, var_20_3)
	end

	return
end

local var_0_57 = ""
local var_0_58 = 0

local function var_0_59(arg_21_0, arg_21_1)
	if var_0_20(arg_21_0) == "number" then
		if var_0_20(arg_21_1) == "function" then
			arg_21_1 = var_0_49(arg_21_1)
		end

		arg_21_0 = var_0_17(var_0_1.traceerr[arg_21_0], arg_21_1)
	end

	return arg_21_0
end

local function var_0_60(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	if arg_22_0 == "stop" or arg_22_0 == "abort" and var_0_28.a then
		if var_0_28.i then
			local var_22_0 = var_0_28.r and arg_22_0 == "stop"

			var_0_56(arg_22_1, var_0_28.s, var_22_0)
		elseif var_0_28.s then
			var_0_52(arg_22_1)
		end

		if var_0_28.m then
			var_0_35(arg_22_1)
		end
	end

	if arg_22_0 == "start" then
		if var_0_28.H then
			var_0_27:write("<pre class=\"ljdump\">\n")
		end

		var_0_27:write("---- TRACE ", arg_22_1, " ", arg_22_0)

		if arg_22_4 then
			var_0_27:write(" ", arg_22_4, "/", arg_22_5 == -1 and "stitch" or arg_22_5)
		end

		var_0_27:write(" ", var_0_49(arg_22_2, arg_22_3), "\n")
	elseif arg_22_0 == "stop" or arg_22_0 == "abort" then
		var_0_27:write("---- TRACE ", arg_22_1, " ", arg_22_0)

		if arg_22_0 == "abort" then
			var_0_27:write(" ", var_0_49(arg_22_2, arg_22_3), " -- ", var_0_59(arg_22_4, arg_22_5), "\n")
		else
			local var_22_1 = var_0_4(arg_22_1)

			if var_22_1.link == arg_22_1 or var_22_1.link == 0 then
				var_0_27:write(" -> ", var_22_1.linktype, "\n")
			elseif var_22_1.linktype == "root" then
				var_0_27:write(" -> ", var_22_1.link, "\n")
			else
				var_0_27:write(" -> ", var_22_1.link, " ", var_22_1.linktype, "\n")
			end
		end

		if var_0_28.H then
			var_0_27:write("</pre>\n\n")
		else
			var_0_27:write("\n")
		end
	else
		if arg_22_0 == "flush" then
			var_0_30, var_0_31 = {}, 0
		end

		var_0_27:write("---- TRACE ", arg_22_0, "\n\n")
	end

	var_0_27:flush()

	return
end

local function var_0_61(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_3 ~= var_0_58 then
		var_0_58 = arg_23_3
		var_0_57 = var_0_19(" .", arg_23_3)
	end

	local var_23_0

	if arg_23_2 >= 0 then
		var_23_0 = var_0_24(arg_23_1, arg_23_2, var_0_57)

		if var_0_28.H then
			var_23_0 = var_0_16(var_23_0, "[<>&]", var_0_41)
		end
	else
		var_23_0 = "0000 " .. var_0_57 .. " FUNCC      \n"
		arg_23_4 = arg_23_1
	end

	if arg_23_2 <= 0 then
		var_0_27:write(var_0_15(var_23_0, 1, -2), "         ; ", var_0_49(arg_23_1), "\n")
	else
		var_0_27:write(var_23_0)
	end

	if arg_23_2 >= 0 and var_0_12(var_0_3(arg_23_1, arg_23_2), 255) < 16 then
		var_0_27:write(var_0_24(arg_23_1, arg_23_2 + 1, var_0_57))
	end

	return
end

local function var_0_62(arg_24_0, arg_24_1, arg_24_2, arg_24_3, ...)
	var_0_27:write("---- TRACE ", arg_24_0, " exit ", arg_24_1, "\n")

	if var_0_28.X then
		local var_24_0 = {
			...
		}

		if var_0.arch == "x64" then
			for iter_24_0 = 1, arg_24_2 do
				var_0_27:write(var_0_17(" %016x", var_24_0[iter_24_0]))

				if iter_24_0 % 4 == 0 then
					var_0_27:write("\n")
				end
			end
		else
			for iter_24_1 = 1, arg_24_2 do
				var_0_27:write(" ", var_0_14(var_24_0[iter_24_1]))

				if iter_24_1 % 8 == 0 then
					var_0_27:write("\n")
				end
			end
		end

		if var_0.arch == "mips" or var_0.arch == "mipsel" then
			for iter_24_2 = 1, arg_24_3, 2 do
				var_0_27:write(var_0_17(" %+17.14g", var_24_0[arg_24_2 + iter_24_2]))

				if iter_24_2 % 8 == 7 then
					var_0_27:write("\n")
				end
			end
		else
			for iter_24_3 = 1, arg_24_3 do
				var_0_27:write(var_0_17(" %+17.14g", var_24_0[arg_24_2 + iter_24_3]))

				if iter_24_3 % 4 == 0 then
					var_0_27:write("\n")
				end
			end
		end
	end

	return
end

return {
	on = function(arg_26_0, arg_26_1)
		if var_0_26 then
			var_0()
		end

		local var_26_0 = os.getenv("TERM")
		local var_26_1 = (var_26_0 and var_26_0:match("color") or os.getenv("COLORTERM")) and "A" or "T"

		arg_26_0 = arg_26_0 and var_0_16(arg_26_0, "[TAH]", function(arg_27_0)
			var_26_1 = arg_27_0

			return ""
		end)

		local var_26_2 = {
			b = true,
			i = true,
			m = true,
			t = true
		}

		if arg_26_0 and arg_26_0 ~= "" then
			local var_26_3 = var_0_15(arg_26_0, 1, 1)

			if var_26_3 ~= "+" and var_26_3 ~= "-" then
				var_26_2 = {}
			end

			for iter_26_0 = 1, #arg_26_0 do
				var_26_2[var_0_15(arg_26_0, iter_26_0, iter_26_0)] = var_26_3 ~= "-"
			end
		end

		var_0_28 = var_26_2

		if var_26_2.t or var_26_2.b or var_26_2.i or var_26_2.s or var_26_2.m then
			var_0.attach(var_0_60, "trace")
		end

		if var_26_2.b then
			var_0.attach(var_0_61, "record")

			var_0_24 = var_0_24 or require("jit.bc").line
		end

		if var_26_2.x or var_26_2.X then
			var_0.attach(var_0_62, "texit")
		end

		arg_26_1 = arg_26_1 or os.getenv("LUAJIT_DUMPFILE")

		if arg_26_1 then
			if arg_26_1 == "-" then
				var_0_27 = var_0_22 or assert(io.open(arg_26_1, "w"))

				if false then
					var_0_27 = var_0_22
				end

				var_26_2[var_26_1] = true

				if var_26_1 == "A" then
					var_0_45 = var_0_39
					var_0_46 = var_0_40
				elseif var_26_1 == "H" then
					var_0_45 = var_0_42
					var_0_46 = var_0_43

					var_0_27:write(var_0_44)
				else
					var_0_45 = var_0_38
					var_0_46 = var_0_36
				end

				var_0_26 = true

				return
			end
		end
	end,
	off = function()
		if var_0_26 then
			var_0_26 = false

			var_0.attach(var_0_62)
			var_0.attach(var_0_61)
			var_0.attach(var_0_60)

			if var_0_27 and var_0_27 ~= var_0_22 and var_0_27 ~= var_0_23 then
				var_0_27:close()
			end

			var_0_27 = nil
		end

		return
	end,
	start = function(arg_26_0, arg_26_1)
		if var_0_26 then
			var_0()
		end

		local var_26_0 = os.getenv("TERM")
		local var_26_1 = (var_26_0 and var_26_0:match("color") or os.getenv("COLORTERM")) and "A" or "T"

		arg_26_0 = arg_26_0 and var_0_16(arg_26_0, "[TAH]", function(arg_27_0)
			var_26_1 = arg_27_0

			return ""
		end)

		local var_26_2 = {
			b = true,
			i = true,
			m = true,
			t = true
		}

		if arg_26_0 and arg_26_0 ~= "" then
			local var_26_3 = var_0_15(arg_26_0, 1, 1)

			if var_26_3 ~= "+" and var_26_3 ~= "-" then
				var_26_2 = {}
			end

			for iter_26_0 = 1, #arg_26_0 do
				var_26_2[var_0_15(arg_26_0, iter_26_0, iter_26_0)] = var_26_3 ~= "-"
			end
		end

		var_0_28 = var_26_2

		if var_26_2.t or var_26_2.b or var_26_2.i or var_26_2.s or var_26_2.m then
			var_0.attach(var_0_60, "trace")
		end

		if var_26_2.b then
			var_0.attach(var_0_61, "record")

			var_0_24 = var_0_24 or require("jit.bc").line
		end

		if var_26_2.x or var_26_2.X then
			var_0.attach(var_0_62, "texit")
		end

		arg_26_1 = arg_26_1 or os.getenv("LUAJIT_DUMPFILE")

		if arg_26_1 then
			if arg_26_1 == "-" then
				var_0_27 = var_0_22 or assert(io.open(arg_26_1, "w"))

				if false then
					var_0_27 = var_0_22
				end

				var_26_2[var_26_1] = true

				if var_26_1 == "A" then
					var_0_45 = var_0_39
					var_0_46 = var_0_40
				elseif var_26_1 == "H" then
					var_0_45 = var_0_42
					var_0_46 = var_0_43

					var_0_27:write(var_0_44)
				else
					var_0_45 = var_0_38
					var_0_46 = var_0_36
				end

				var_0_26 = true

				return
			end
		end
	end
}
