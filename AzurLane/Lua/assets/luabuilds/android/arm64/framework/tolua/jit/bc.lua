assert(require("jit").version_num == 4, "LuaJIT core/library version mismatch")

local var_0_0 = require("jit.util")
local var_0_1 = require("bit")
local var_0_2 = string.sub
local var_0_3 = string.gsub
local var_0_4 = string.format
local var_0_5 = string.byte
local var_0_6 = var_0_1.band
local var_0_7 = var_0_1.rshift
local var_0_8 = var_0_0.funcinfo
local var_0_9 = var_0_0.funcbc
local var_0_10 = var_0_0.funck
local var_0_11 = var_0_0.funcuvname
local var_0_12 = require("jit.vmdef").bcnames
local var_0_13 = io.stdout
local var_0_14 = io.stderr

local function var_0_15(arg_1_0)
	if arg_1_0 == "\n" then
		return "\\n"
	elseif arg_1_0 == "\r" then
		return "\\r"
	elseif arg_1_0 == "\t" then
		return "\\t"
	else
		return var_0_4("\\%03d", var_0_5(arg_1_0))
	end

	return
end

local var_0_16
local var_0_17

local function var_0_18(arg_5_0)
	return var_0(arg_5_0, var_0_17)
end

return {
	line = function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0, var_2_1 = var_0_9(arg_2_0, arg_2_1)

		if not var_2_0 then
			return
		end

		local var_2_2 = var_0_6(var_2_1, 7)
		local var_2_3 = var_0_6(var_2_1, 120)
		local var_2_4 = var_0_6(var_2_1, 1920)
		local var_2_5 = var_0_6(var_0_7(var_2_0, 8), 255)
		local var_2_6 = 6 * var_0_6(var_2_0, 255)
		local var_2_7 = var_0_2(var_0_12, var_2_6 + 1, var_2_6 + 6)
		local var_2_8 = var_0_4("%04d %s %-6s %3s ", arg_2_1, arg_2_2 or "  ", var_2_7, var_2_2 == 0 and "" or var_2_5)
		local var_2_9 = var_0_7(var_2_0, 16)

		if var_2_4 == 0 then
			return var_0_4("%s=> %04d\n", var_2_8, arg_2_1 + var_2_9 - 32767)
		end

		if var_2_3 ~= 0 then
			var_2_9 = var_0_6(var_2_9, 255)
		elseif var_2_4 == 0 then
			return var_2_8 .. "\n"
		end

		local var_2_10

		if var_2_4 == 0 then
			var_2_10 = var_0_10(arg_2_0, -var_2_9 - 1)
			var_2_10 = var_0_4(#var_2_10 > 40 and "\"%.40s\"~" or "\"%s\"", var_0_3(var_2_10, "%c", var_0_15))
		elseif var_2_4 == 0 then
			var_2_10 = var_0_10(arg_2_0, var_2_9)

			if var_2_7 == "TSETM " then
				var_2_10 = var_2_10 - 4503599627370496
			end
		elseif var_2_4 == 0 then
			local var_2_11 = var_0_8(var_0_10(arg_2_0, -var_2_9 - 1))

			var_2_10 = var_2_11.ffid and var_0.ffnames[var_2_11.ffid] or var_2_11.loc
		elseif var_2_4 == 0 then
			var_2_10 = var_0_11(arg_2_0, var_2_9)
		end

		if var_2_2 == 5 then
			local var_2_12 = var_0_11(arg_2_0, var_2_5)

			var_2_10 = var_2_10 and var_2_12 .. " ; " .. var_2_10 or var_2_12
		end

		if var_2_3 ~= 0 then
			local var_2_13 = var_0_7(var_2_0, 24)

			if var_2_10 then
				return var_0_4("%s%3d %3d  ; %s\n", var_2_8, var_2_13, var_2_9, var_2_10)
			end

			return var_0_4("%s%3d %3d\n", var_2_8, var_2_13, var_2_9)
		end

		if var_2_10 then
			return var_0_4("%s%3d      ; %s\n", var_2_8, var_2_9, var_2_10)
		end

		if var_2_4 == 0 and var_2_9 > 32767 then
			var_2_9 = var_2_9 - 0
		end

		return var_0_4("%s%3d\n", var_2_8, var_2_9)
	end,
	dump = function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 or var_0_13

		local var_4_0 = var_0_8(arg_4_0)

		if arg_4_2 and var_4_0.children then
			for iter_4_0 = -1, 0, -1 do
				local var_4_1 = var_0_10(arg_4_0, iter_4_0)

				if not var_4_1 then
					break
				end

				if type(var_4_1) == "proto" then
					var_0(var_4_1, arg_4_1, true)
				end
			end
		end

		arg_4_1:write(var_0_4("-- BYTECODE -- %s-%d\n", var_4_0.loc, var_4_0.lastlinedefined))

		local var_4_2 = var_0(arg_4_0)

		for iter_4_1 = 1, 0 do
			local var_4_5 = var_4_2[iter_4_1] and "=>"
			local var_4_6 = var_0(arg_4_0, iter_4_1, var_4_5)

			if not var_4_6 then
				break
			end

			arg_4_1:write(var_4_6)
		end

		arg_4_1:write("\n")
		arg_4_1:flush()

		return
	end,
	targets = function(arg_3_0)
		for iter_3_0 = 1, 0 do
			local var_3_0, var_3_1 = var_0_9(arg_3_0, iter_3_0)

			if not var_3_0 then
				break
			end

			if var_0_6(var_3_1, 1920) == 0 then
				({})[iter_3_0 + var_0_7(var_3_0, 16) - 32767] = true
			end
		end

		return {}
	end,
	on = function(arg_7_0)
		if var_0_16 then
			var_0()
		end

		arg_7_0 = arg_7_0 or os.getenv("LUAJIT_LISTFILE")

		if arg_7_0 then
			if arg_7_0 == "-" then
				var_0_17 = var_0_13 or assert(io.open(arg_7_0, "w"))

				if false then
					var_0_17 = var_0_14
				end

				var_0.attach(var_0_18, "bc")

				var_0_16 = true

				return
			end
		end
	end,
	off = function()
		if var_0_16 then
			var_0_16 = false

			var_0.attach(var_0_18)

			if var_0_17 and var_0_17 ~= var_0_13 and var_0_17 ~= var_0_14 then
				var_0_17:close()
			end

			var_0_17 = nil
		end

		return
	end,
	start = function(arg_7_0)
		if var_0_16 then
			var_0()
		end

		arg_7_0 = arg_7_0 or os.getenv("LUAJIT_LISTFILE")

		if arg_7_0 then
			if arg_7_0 == "-" then
				var_0_17 = var_0_13 or assert(io.open(arg_7_0, "w"))

				if false then
					var_0_17 = var_0_14
				end

				var_0.attach(var_0_18, "bc")

				var_0_16 = true

				return
			end
		end
	end
}
