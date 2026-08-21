local var_0_0 = require("jit")

assert(var_0_0.version_num == 20100, "LuaJIT core/library version mismatch")

local var_0_1 = require("jit.util")
local var_0_2 = require("jit.vmdef")
local var_0_3 = var_0_1.funcinfo
local var_0_4 = var_0_1.funcbc
local var_0_5 = var_0_1.traceinfo
local var_0_6 = var_0_1.traceir
local var_0_7 = var_0_1.tracek
local var_0_8 = var_0_1.tracemc
local var_0_9 = var_0_1.tracesnap
local var_0_10 = var_0_1.traceexitstub
local var_0_11 = var_0_1.ircalladdr
local var_0_12 = require("bit")
local var_0_13 = var_0_12.band
local var_0_14 = var_0_12.rshift
local var_0_15 = var_0_12.tohex
local var_0_16 = string.sub
local var_0_17 = string.gsub
local var_0_18 = string.format
local var_0_19 = string.byte
local var_0_20 = string.rep
local var_0_21 = type
local var_0_22 = tostring
local var_0_23 = io.stdout
local var_0_24 = io.stderr
local var_0_25
local var_0_26
local var_0_27
local var_0_28
local var_0_29
local var_0_30 = {
	__index = false
}
local var_0_31 = {}
local var_0_32 = 0

local function var_0_33(arg_1_0, arg_1_1)
	local var_1_0 = {}

	var_0_30.__index = var_1_0

	if var_0_0.arch:sub(1, 4) == "mips" then
		var_1_0[var_0_10(arg_1_0, 0)] = "exit"

		return
	end

	for iter_1_0 = 0, arg_1_1 - 1 do
		local var_1_1 = var_0_10(arg_1_0, iter_1_0)

		if var_1_1 < 0 then
			var_1_1 = var_1_1 + 4294967296
		end

		var_1_0[var_1_1] = var_0_22(iter_1_0)
	end

	local var_1_2 = var_0_10(arg_1_0, arg_1_1)

	if var_1_2 then
		var_1_0[var_1_2] = "stack_check"
	end
end

local function var_0_34(arg_2_0, arg_2_1)
	local var_2_0 = var_0_31

	if var_0_32 == 0 then
		local var_2_1 = var_0_2.ircall

		for iter_2_0 = 0, #var_2_1 do
			local var_2_2 = var_0_11(iter_2_0)

			if var_2_2 ~= 0 then
				if var_2_2 < 0 then
					var_2_2 = var_2_2 + 4294967296
				end

				var_2_0[var_2_2] = var_2_1[iter_2_0]
			end
		end
	end

	if var_0_32 == 1000000 then
		var_0_33(arg_2_0, arg_2_1)
	elseif arg_2_1 > var_0_32 then
		for iter_2_1 = var_0_32, arg_2_1 - 1 do
			local var_2_3 = var_0_10(iter_2_1)

			if var_2_3 == nil then
				var_0_33(arg_2_0, arg_2_1)
				setmetatable(var_0_31, var_0_30)

				arg_2_1 = 1000000

				break
			end

			if var_2_3 < 0 then
				var_2_3 = var_2_3 + 4294967296
			end

			var_2_0[var_2_3] = var_0_22(iter_2_1)
		end

		var_0_32 = arg_2_1
	end

	return var_2_0
end

local function var_0_35(arg_3_0)
	var_0_28:write(arg_3_0)
end

local function var_0_36(arg_4_0)
	local var_4_0 = var_0_5(arg_4_0)

	if not var_4_0 then
		return
	end

	local var_4_1, var_4_2, var_4_3 = var_0_8(arg_4_0)

	if not var_4_1 then
		return
	end

	if not var_0_26 then
		var_0_26 = require("jit.dis_" .. var_0_0.arch)
	end

	if var_4_2 < 0 then
		var_4_2 = var_4_2 + 4294967296
	end

	var_0_28:write("---- TRACE ", arg_4_0, " mcode ", #var_4_1, "\n")

	local var_4_4 = var_0_26.create(var_4_1, var_4_2, var_0_35)

	var_4_4.hexdump = 0
	var_4_4.symtab = var_0_34(arg_4_0, var_4_0.nexit)

	if var_4_3 ~= 0 then
		var_0_31[var_4_2 + var_4_3] = "LOOP"

		var_4_4:disass(0, var_4_3)
		var_0_28:write("->LOOP:\n")
		var_4_4:disass(var_4_3, #var_4_1 - var_4_3)

		var_0_31[var_4_2 + var_4_3] = nil
	else
		var_4_4:disass(0, #var_4_1)
	end
end

local var_0_37 = {
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
local var_0_38 = {
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

local function var_0_39(arg_5_0)
	return arg_5_0
end

local function var_0_40(arg_6_0, arg_6_1)
	return var_0_18(var_0_38[arg_6_1], arg_6_0)
end

local var_0_41 = setmetatable({}, {
	__index = function(arg_7_0, arg_7_1)
		local var_7_0 = var_0_40(var_0_37[arg_7_1], arg_7_1)

		arg_7_0[arg_7_1] = var_7_0

		return var_7_0
	end
})
local var_0_42 = {
	[">"] = "&gt;",
	["<"] = "&lt;",
	["&"] = "&amp;"
}

local function var_0_43(arg_8_0, arg_8_1)
	arg_8_0 = var_0_17(arg_8_0, "[<>&]", var_0_42)

	return var_0_18("<span class=\"irt_%s\">%s</span>", var_0_37[arg_8_1], arg_8_0)
end

local var_0_44 = setmetatable({}, {
	__index = function(arg_9_0, arg_9_1)
		local var_9_0 = var_0_43(var_0_37[arg_9_1], arg_9_1)

		arg_9_0[arg_9_1] = var_9_0

		return var_9_0
	end
})
local var_0_45 = "<style type=\"text/css\">\nbackground { background: #ffffff; color: #000000; }\npre.ljdump {\nfont-size: 10pt;\nbackground: #f0f4ff;\ncolor: #000000;\nborder: 1px solid #bfcfff;\npadding: 0.5em;\nmargin-left: 2em;\nmargin-right: 2em;\n}\nspan.irt_str { color: #00a000; }\nspan.irt_thr, span.irt_fun { color: #404040; font-weight: bold; }\nspan.irt_tab { color: #c00000; }\nspan.irt_udt, span.irt_lud { color: #00c0c0; }\nspan.irt_num { color: #4040c0; }\nspan.irt_int, span.irt_i8, span.irt_u8, span.irt_i16, span.irt_u16 { color: #b040b0; }\n</style>\n"
local var_0_46
local var_0_47
local var_0_48 = {
	["SLOAD "] = setmetatable({}, {
		__index = function(arg_10_0, arg_10_1)
			local var_10_0 = ""

			if var_0_13(arg_10_1, 1) ~= 0 then
				var_10_0 = var_10_0 .. "P"
			end

			if var_0_13(arg_10_1, 2) ~= 0 then
				var_10_0 = var_10_0 .. "F"
			end

			if var_0_13(arg_10_1, 4) ~= 0 then
				var_10_0 = var_10_0 .. "T"
			end

			if var_0_13(arg_10_1, 8) ~= 0 then
				var_10_0 = var_10_0 .. "C"
			end

			if var_0_13(arg_10_1, 16) ~= 0 then
				var_10_0 = var_10_0 .. "R"
			end

			if var_0_13(arg_10_1, 32) ~= 0 then
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
			local var_11_0 = var_0_47[var_0_13(arg_11_1, 31)]
			local var_11_1 = var_0_47[var_0_13(var_0_14(arg_11_1, 5), 31)] .. "." .. var_11_0

			if var_0_13(arg_11_1, 2048) ~= 0 then
				var_11_1 = var_11_1 .. " sext"
			end

			local var_11_2 = var_0_14(arg_11_1, 14)

			if var_11_2 == 2 then
				var_11_1 = var_11_1 .. " index"
			elseif var_11_2 == 3 then
				var_11_1 = var_11_1 .. " check"
			end

			arg_11_0[arg_11_1] = var_11_1

			return var_11_1
		end
	}),
	["FLOAD "] = var_0_2.irfield,
	["FREF  "] = var_0_2.irfield,
	FPMATH = var_0_2.irfpm,
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

local function var_0_49(arg_12_0)
	if arg_12_0 == "\n" then
		return "\\n"
	elseif arg_12_0 == "\r" then
		return "\\r"
	elseif arg_12_0 == "\t" then
		return "\\t"
	else
		return var_0_18("\\%03d", var_0_19(arg_12_0))
	end
end

local function var_0_50(arg_13_0, arg_13_1)
	local var_13_0 = var_0_3(arg_13_0, arg_13_1)

	if var_13_0.loc then
		return var_13_0.loc
	elseif var_13_0.ffid then
		return var_0_2.ffnames[var_13_0.ffid]
	elseif var_13_0.addr then
		return var_0_18("C:%x", var_13_0.addr)
	else
		return "(?)"
	end
end

local function var_0_51(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0, var_14_1, var_14_2 = var_0_7(arg_14_0, arg_14_1)
	local var_14_3 = var_0_21(var_14_0)
	local var_14_4

	if var_14_3 == "number" then
		if var_0_13(arg_14_2 or 0, 196608) ~= 0 then
			var_14_4 = var_0_13(arg_14_2, 131072) ~= 0 and "contpc" or "ftsz"
		elseif var_14_0 == 6755399441055744 then
			var_14_4 = "bias"
		else
			var_14_4 = var_0_18(var_14_0 > 0 and var_14_0 < --[[invalid number]] 1.390671161567e-309 and "%+a" or "%+.14g", var_14_0)
		end
	elseif var_14_3 == "string" then
		var_14_4 = var_0_18(#var_14_0 > 20 and "\"%.20s\"~" or "\"%s\"", var_0_17(var_14_0, "%c", var_0_49))
	elseif var_14_3 == "function" then
		var_14_4 = var_0_50(var_14_0)
	elseif var_14_3 == "table" then
		var_14_4 = var_0_18("{%p}", var_14_0)
	elseif var_14_3 == "userdata" then
		if var_14_1 == 12 then
			var_14_4 = var_0_18("userdata:%p", var_14_0)
		else
			var_14_4 = var_0_18("[%p]", var_14_0)

			if var_14_4 == "[NULL]" then
				var_14_4 = "NULL"
			end
		end
	elseif var_14_1 == 21 then
		var_14_4 = var_0_16(var_0_22(var_14_0), 1, -3)

		if var_0_16(var_14_4, 1, 1) ~= "-" then
			var_14_4 = "+" .. var_14_4
		end
	elseif arg_14_2 == 17137663 then
		return "----"
	else
		var_14_4 = var_0_22(var_14_0)
	end

	local var_14_5 = var_0_46(var_0_18("%-4s", var_14_4), var_14_1)

	if var_14_2 then
		var_14_5 = var_0_18("%s @%d", var_14_5, var_14_2)
	end

	return var_14_5
end

local function var_0_52(arg_15_0, arg_15_1)
	local var_15_0 = 2

	for iter_15_0 = 0, arg_15_1[1] - 1 do
		local var_15_1 = arg_15_1[var_15_0]

		if var_0_14(var_15_1, 24) == iter_15_0 then
			var_15_0 = var_15_0 + 1

			local var_15_2 = var_0_13(var_15_1, 65535) - 32768

			if var_15_2 < 0 then
				var_0_28:write(var_0_51(arg_15_0, var_15_2, var_15_1))
			elseif var_0_13(var_15_1, 524288) ~= 0 then
				var_0_28:write(var_0_46(var_0_18("%04d/%04d", var_15_2, var_15_2 + 1), 14))
			else
				local var_15_3, var_15_4, var_15_5, var_15_6 = var_0_6(arg_15_0, var_15_2)

				var_0_28:write(var_0_46(var_0_18("%04d", var_15_2), var_0_13(var_15_4, 31)))
			end

			var_0_28:write(var_0_13(var_15_1, 65536) == 0 and " " or "|")
		else
			var_0_28:write("---- ")
		end
	end

	var_0_28:write("]\n")
end

local function var_0_53(arg_16_0)
	var_0_28:write("---- TRACE ", arg_16_0, " snapshots\n")

	for iter_16_0 = 0, 1000000000 do
		local var_16_0 = var_0_9(arg_16_0, iter_16_0)

		if not var_16_0 then
			break
		end

		var_0_28:write(var_0_18("#%-3d %04d [ ", iter_16_0, var_16_0[0]))
		var_0_52(arg_16_0, var_16_0)
	end
end

local function var_0_54(arg_17_0, arg_17_1)
	if not var_0_26 then
		var_0_26 = require("jit.dis_" .. var_0_0.arch)
	end

	local var_17_0 = var_0_13(arg_17_0, 255)
	local var_17_1 = var_0_14(arg_17_0, 8)

	if var_17_0 == 253 or var_17_0 == 254 then
		return (var_17_1 == 0 or var_17_1 == 255) and " {sink" or var_0_18(" {%04d", arg_17_1 - var_17_1)
	end

	if arg_17_0 > 255 then
		return var_0_18("[%x]", var_17_1 * 4)
	end

	if var_17_0 < 128 then
		return var_0_26.regname(var_17_0)
	end

	return ""
end

local function var_0_55(arg_18_0, arg_18_1)
	local var_18_0

	if arg_18_1 > 0 then
		local var_18_1, var_18_2, var_18_3, var_18_4 = var_0_6(arg_18_0, arg_18_1)

		if var_0_13(var_18_2, 31) == 0 then
			arg_18_1 = var_18_3
			var_18_0 = var_0_51(arg_18_0, var_18_4)
		end
	end

	if arg_18_1 < 0 then
		var_0_28:write(var_0_18("[0x%x](", tonumber((var_0_7(arg_18_0, arg_18_1)))))
	else
		var_0_28:write(var_0_18("%04d (", arg_18_1))
	end

	return var_18_0
end

local function var_0_56(arg_19_0, arg_19_1)
	if arg_19_1 < 0 then
		var_0_28:write(var_0_51(arg_19_0, arg_19_1))
	else
		local var_19_0, var_19_1, var_19_2, var_19_3 = var_0_6(arg_19_0, arg_19_1)
		local var_19_4 = 6 * var_0_14(var_19_1, 8)

		if var_0_16(var_0_2.irnames, var_19_4 + 1, var_19_4 + 6) == "CARG  " then
			var_0_56(arg_19_0, var_19_2)

			if var_19_3 < 0 then
				var_0_28:write(" ", var_0_51(arg_19_0, var_19_3))
			else
				var_0_28:write(" ", var_0_18("%04d", var_19_3))
			end
		else
			var_0_28:write(var_0_18("%04d", arg_19_1))
		end
	end
end

local function var_0_57(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = var_0_5(arg_20_0)

	if not var_20_0 then
		return
	end

	local var_20_1 = var_20_0.nins

	var_0_28:write("---- TRACE ", arg_20_0, " IR\n")

	local var_20_2 = var_0_2.irnames
	local var_20_3 = 65536
	local var_20_4
	local var_20_5

	if arg_20_1 then
		var_20_4 = var_0_9(arg_20_0, 0)
		var_20_3 = var_20_4[0]
		var_20_5 = 0
	end

	for iter_20_0 = 1, var_20_1 do
		if var_20_3 <= iter_20_0 then
			if arg_20_2 then
				var_0_28:write(var_0_18("....              SNAP   #%-3d [ ", var_20_5))
			else
				var_0_28:write(var_0_18("....        SNAP   #%-3d [ ", var_20_5))
			end

			var_0_52(arg_20_0, var_20_4)

			var_20_5 = var_20_5 + 1
			var_20_4 = var_0_9(arg_20_0, var_20_5)
			var_20_3 = var_20_4 and var_20_4[0] or 65536
		end

		local var_20_6, var_20_7, var_20_8, var_20_9, var_20_10 = var_0_6(arg_20_0, iter_20_0)
		local var_20_11 = 6 * var_0_14(var_20_7, 8)
		local var_20_12 = var_0_13(var_20_7, 31)
		local var_20_13 = var_0_16(var_20_2, var_20_11 + 1, var_20_11 + 6)

		if var_20_13 == "LOOP  " then
			if arg_20_2 then
				var_0_28:write(var_0_18("%04d ------------ LOOP ------------\n", iter_20_0))
			else
				var_0_28:write(var_0_18("%04d ------ LOOP ------------\n", iter_20_0))
			end
		elseif var_20_13 ~= "NOP   " and var_20_13 ~= "CARG  " and (arg_20_2 or var_20_13 ~= "RENAME") then
			local var_20_14 = var_0_13(var_20_10, 255)

			if arg_20_2 then
				var_0_28:write(var_0_18("%04d %-6s", iter_20_0, var_0_54(var_20_10, iter_20_0)))
			else
				var_0_28:write(var_0_18("%04d ", iter_20_0))
			end

			var_0_28:write(var_0_18("%s%s %s %s ", (var_20_14 == 254 or var_20_14 == 253) and "}" or var_0_13(var_20_7, 128) == 0 and " " or ">", var_0_13(var_20_7, 64) == 0 and " " or "+", var_0_47[var_20_12], var_20_13))

			local var_20_15 = var_0_13(var_20_6, 3)
			local var_20_16 = var_0_13(var_20_6, 12)

			if var_0_16(var_20_13, 1, 4) == "CALL" then
				local var_20_17

				if var_20_16 == 4 then
					var_0_28:write(var_0_18("%-10s  (", var_0_2.ircall[var_20_9]))
				else
					var_20_17 = var_0_55(arg_20_0, var_20_9)
				end

				if var_20_8 ~= -1 then
					var_0_56(arg_20_0, var_20_8)
				end

				var_0_28:write(")")

				if var_20_17 then
					var_0_28:write(" ctype ", var_20_17)
				end
			elseif var_20_13 == "CNEW  " and var_20_9 == -1 then
				var_0_28:write(var_0_51(arg_20_0, var_20_8))
			elseif var_20_15 ~= 3 then
				if var_20_8 < 0 then
					var_0_28:write(var_0_51(arg_20_0, var_20_8))
				else
					var_0_28:write(var_0_18(var_20_15 == 0 and "%04d" or "#%-3d", var_20_8))
				end

				if var_20_16 ~= 12 then
					if var_20_16 == 4 then
						local var_20_18 = var_0_48[var_20_13]

						if var_20_18 and var_20_18[var_20_9] then
							var_0_28:write("  ", var_20_18[var_20_9])
						elseif var_20_13 == "UREFO " or var_20_13 == "UREFC " then
							var_0_28:write(var_0_18("  #%-3d", var_0_14(var_20_9, 8)))
						else
							var_0_28:write(var_0_18("  #%-3d", var_20_9))
						end
					elseif var_20_9 < 0 then
						var_0_28:write("  ", var_0_51(arg_20_0, var_20_9))
					else
						var_0_28:write(var_0_18("  %04d", var_20_9))
					end
				end
			end

			var_0_28:write("\n")
		end
	end

	if var_20_4 then
		if arg_20_2 then
			var_0_28:write(var_0_18("....              SNAP   #%-3d [ ", var_20_5))
		else
			var_0_28:write(var_0_18("....        SNAP   #%-3d [ ", var_20_5))
		end

		var_0_52(arg_20_0, var_20_4)
	end
end

local var_0_58 = ""
local var_0_59 = 0

local function var_0_60(arg_21_0, arg_21_1)
	if var_0_21(arg_21_0) == "number" then
		if var_0_21(arg_21_1) == "function" then
			arg_21_1 = var_0_50(arg_21_1)
		end

		arg_21_0 = var_0_18(var_0_2.traceerr[arg_21_0], arg_21_1)
	end

	return arg_21_0
end

local function var_0_61(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	if arg_22_0 == "stop" or arg_22_0 == "abort" and var_0_29.a then
		if var_0_29.i then
			var_0_57(arg_22_1, var_0_29.s, var_0_29.r and arg_22_0 == "stop")
		elseif var_0_29.s then
			var_0_53(arg_22_1)
		end

		if var_0_29.m then
			var_0_36(arg_22_1)
		end
	end

	if arg_22_0 == "start" then
		if var_0_29.H then
			var_0_28:write("<pre class=\"ljdump\">\n")
		end

		var_0_28:write("---- TRACE ", arg_22_1, " ", arg_22_0)

		if arg_22_4 then
			var_0_28:write(" ", arg_22_4, "/", arg_22_5 == -1 and "stitch" or arg_22_5)
		end

		var_0_28:write(" ", var_0_50(arg_22_2, arg_22_3), "\n")
	elseif arg_22_0 == "stop" or arg_22_0 == "abort" then
		var_0_28:write("---- TRACE ", arg_22_1, " ", arg_22_0)

		if arg_22_0 == "abort" then
			var_0_28:write(" ", var_0_50(arg_22_2, arg_22_3), " -- ", var_0_60(arg_22_4, arg_22_5), "\n")
		else
			local var_22_0 = var_0_5(arg_22_1)
			local var_22_1 = var_22_0.link
			local var_22_2 = var_22_0.linktype

			if var_22_1 == arg_22_1 or var_22_1 == 0 then
				var_0_28:write(" -> ", var_22_2, "\n")
			elseif var_22_2 == "root" then
				var_0_28:write(" -> ", var_22_1, "\n")
			else
				var_0_28:write(" -> ", var_22_1, " ", var_22_2, "\n")
			end
		end

		if var_0_29.H then
			var_0_28:write("</pre>\n\n")
		else
			var_0_28:write("\n")
		end
	else
		if arg_22_0 == "flush" then
			var_0_31, var_0_32 = {}, 0
		end

		var_0_28:write("---- TRACE ", arg_22_0, "\n\n")
	end

	var_0_28:flush()
end

local function var_0_62(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_3 ~= var_0_59 then
		var_0_59 = arg_23_3
		var_0_58 = var_0_20(" .", arg_23_3)
	end

	local var_23_0

	if arg_23_2 >= 0 then
		var_23_0 = var_0_25(arg_23_1, arg_23_2, var_0_58)

		if var_0_29.H then
			var_23_0 = var_0_17(var_23_0, "[<>&]", var_0_42)
		end

		if arg_23_2 > 0 then
			var_23_0 = var_0_16(var_23_0, 1, -2) .. "       (" .. var_0_50(arg_23_1, arg_23_2) .. ")\n"
		end
	else
		var_23_0 = "0000 " .. var_0_58 .. " FUNCC      \n"
		arg_23_4 = arg_23_1
	end

	if arg_23_2 <= 0 then
		var_0_28:write(var_0_16(var_23_0, 1, -2), "         ; ", var_0_50(arg_23_1), "\n")
	else
		var_0_28:write(var_23_0)
	end

	if arg_23_2 >= 0 and var_0_13(var_0_4(arg_23_1, arg_23_2), 255) < 16 then
		var_0_28:write(var_0_25(arg_23_1, arg_23_2 + 1, var_0_58))
	end
end

local function var_0_63(arg_24_0, arg_24_1, arg_24_2, arg_24_3, ...)
	var_0_28:write("---- TRACE ", arg_24_0, " exit ", arg_24_1, "\n")

	if var_0_29.X then
		local var_24_0 = {
			...
		}

		if var_0_0.arch == "x64" then
			for iter_24_0 = 1, arg_24_2 do
				var_0_28:write(var_0_18(" %016x", var_24_0[iter_24_0]))

				if iter_24_0 % 4 == 0 then
					var_0_28:write("\n")
				end
			end
		else
			for iter_24_1 = 1, arg_24_2 do
				var_0_28:write(" ", var_0_15(var_24_0[iter_24_1]))

				if iter_24_1 % 8 == 0 then
					var_0_28:write("\n")
				end
			end
		end

		if var_0_0.arch == "mips" or var_0_0.arch == "mipsel" then
			for iter_24_2 = 1, arg_24_3, 2 do
				var_0_28:write(var_0_18(" %+17.14g", var_24_0[arg_24_2 + iter_24_2]))

				if iter_24_2 % 8 == 7 then
					var_0_28:write("\n")
				end
			end
		else
			for iter_24_3 = 1, arg_24_3 do
				var_0_28:write(var_0_18(" %+17.14g", var_24_0[arg_24_2 + iter_24_3]))

				if iter_24_3 % 4 == 0 then
					var_0_28:write("\n")
				end
			end
		end
	end
end

local function var_0_64()
	if var_0_27 then
		var_0_27 = false

		var_0_0.attach(var_0_63)
		var_0_0.attach(var_0_62)
		var_0_0.attach(var_0_61)

		if var_0_28 and var_0_28 ~= var_0_23 and var_0_28 ~= var_0_24 then
			var_0_28:close()
		end

		var_0_28 = nil
	end
end

local function var_0_65(arg_26_0, arg_26_1)
	if var_0_27 then
		var_0_64()
	end

	local var_26_0 = os.getenv("TERM")
	local var_26_1 = (var_26_0 and var_26_0:match("color") or os.getenv("COLORTERM")) and "A" or "T"

	arg_26_0 = arg_26_0 and var_0_17(arg_26_0, "[TAH]", function(arg_27_0)
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
		local var_26_3 = var_0_16(arg_26_0, 1, 1)

		if var_26_3 ~= "+" and var_26_3 ~= "-" then
			var_26_2 = {}
		end

		for iter_26_0 = 1, #arg_26_0 do
			var_26_2[var_0_16(arg_26_0, iter_26_0, iter_26_0)] = var_26_3 ~= "-"
		end
	end

	var_0_29 = var_26_2

	if var_26_2.t or var_26_2.b or var_26_2.i or var_26_2.s or var_26_2.m then
		var_0_0.attach(var_0_61, "trace")
	end

	if var_26_2.b then
		var_0_0.attach(var_0_62, "record")

		if not var_0_25 then
			var_0_25 = require("jit.bc").line
		end
	end

	if var_26_2.x or var_26_2.X then
		var_0_0.attach(var_0_63, "texit")
	end

	arg_26_1 = arg_26_1 or os.getenv("LUAJIT_DUMPFILE")

	if arg_26_1 then
		var_0_28 = arg_26_1 == "-" and var_0_23 or assert(io.open(arg_26_1, "w"))
	else
		var_0_28 = var_0_23
	end

	var_26_2[var_26_1] = true

	if var_26_1 == "A" then
		var_0_46 = var_0_40
		var_0_47 = var_0_41
	elseif var_26_1 == "H" then
		var_0_46 = var_0_43
		var_0_47 = var_0_44

		var_0_28:write(var_0_45)
	else
		var_0_46 = var_0_39
		var_0_47 = var_0_37
	end

	var_0_27 = true
end

return {
	on = var_0_65,
	off = var_0_64,
	start = var_0_65
}
