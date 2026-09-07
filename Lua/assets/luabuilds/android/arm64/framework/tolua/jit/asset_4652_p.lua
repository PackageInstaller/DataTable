assert(require("jit").version_num == 4, "LuaJIT core/library version mismatch")

local profile = require("jit.profile")
local vmdef = require("jit.vmdef")
local var_0_2 = math
local var_0_3 = pairs
local var_0_4 = ipairs
local var_0_5 = tonumber
local var_0_6 = math.floor
local var_0_7 = table.sort
local var_0_8 = string.format
local var_0_9 = io.stdout
local var_0_10
local var_0_11
local var_0_12
local var_0_13
local var_0_14
local var_0_15
local var_0_16
local var_0_17
local var_0_18
local var_0_19
local var_0_20
local var_0_21
local var_0_22
local var_0_23 = {
	G = "Garbage Collector",
	C = "C code",
	N = "Compiled",
	J = "JIT Compiler",
	I = "Interpreted"
}

local function var_0_24(arg_1_0, arg_1_1, arg_1_2)
	var_0_22 = var_0_22 + arg_1_1

	local var_1_0
	local var_1_1
	local var_1_2

	if var_0_13 then
		var_1_2 = var_0_13 == "v" and (var_0_23[arg_1_2] or arg_1_2) or var_0_10:get() or "(none)"
	end

	if var_0_17 then
		var_1_0 = profile.dumpstack(arg_1_0, var_0_17, var_0_18)
		var_1_0 = var_1_0:gsub("%[builtin#(%d+)%]", function(arg_2_0)
			return vmdef.ffnames[var_0_5(arg_2_0)]
		end)

		if var_0_14 == 2 then
			local var_1_3, var_1_4 = var_1_0:match("(.-) [<>] (.*)")

			if var_1_4 then
				var_1_1 = var_1_4
				var_1_0 = var_1_3
			end
		elseif var_0_14 == 3 then
			var_1_1 = profile.dumpstack(arg_1_0, "l", 1)
		end
	end

	local var_1_5
	local var_1_6

	if var_0_14 == 1 then
		if var_1_2 then
			var_1_5 = var_1_2

			if var_1_0 then
				var_1_6 = var_1_0
			end
		end
	elseif var_1_0 then
		var_1_5 = var_1_0

		if var_1_1 then
			var_1_6 = var_1_1
		elseif var_1_2 then
			var_1_6 = var_1_2
		end
	end

	if var_1_5 then
		var_0_20[var_1_5] = (var_0_20[var_1_5] or 0) + arg_1_1

		if var_1_6 then
			local var_1_8 = var_0_21[var_1_5]

			if not var_0_21[var_1_5] then
				var_1_8 = {}
				var_0_21[var_1_5] = var_1_8
			end

			var_1_8[var_1_6] = (var_1_8[var_1_6] or 0) + arg_1_1
		end
	end

	return
end

local function var_0_25(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {}
	local var_3_1 = 0

	for iter_3_0 in var_0_3(arg_3_0) do
		var_3_1 = var_3_1 + 1
		var_3_0[var_3_1] = iter_3_0
	end

	var_0_7(var_3_0, function(arg_4_0, arg_4_1)
		return arg_3_0[arg_4_0] > arg_3_0[arg_4_1]
	end)

	for iter_3_1 = 1, var_3_1 do
		local var_3_2 = var_3_0[iter_3_1]
		local var_3_3 = arg_3_0[var_3_0[iter_3_1]]
		local var_3_4 = var_0_6(arg_3_0[var_3_0[iter_3_1]] * 100 / arg_3_2 + 0.5)

		if var_3_4 < var_0_15 then
			break
		end

		if not var_0_16 then
			var_0_11:write(var_0_8("%s%2d%%  %s\n", arg_3_3, var_3_4, var_3_2))
		elseif var_0_16 == "r" then
			var_0_11:write(var_0_8("%s%5d  %s\n", arg_3_3, var_3_3, var_3_2))
		else
			var_0_11:write(var_0_8("%s %d\n", var_3_2, var_3_3))
		end

		if arg_3_1 then
			if arg_3_1[var_3_2] then
				var_0_25(arg_3_1[var_3_2], nil, var_3_3, (var_0_14 == 3 or var_0_14 == 1) and "  -- " or var_0_18 < 0 and "  -> " or "  <- ")
			end
		end
	end

	return
end

local function var_0_26(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in var_0_3(arg_5_0) do
		local var_5_2 = var_0_6(iter_5_1 * 100 / arg_5_1 + 0.5)

		var_5_1 = var_0_2.max(var_5_1, iter_5_1)

		if var_5_2 >= var_0_15 then
			local var_5_3, var_5_4 = iter_5_0:match("^(.*):(%d+)$")

			if not var_5_3 then
				var_5_3 = iter_5_0
				var_5_4 = 0
			end

			local var_5_5 = var_5_0[var_5_3]

			if not var_5_0[var_5_3] then
				var_5_5 = {}
				var_5_0[var_5_3] = var_5_5
				var_5_0[#var_5_0 + 1] = var_5_3
			end

			var_5_5[var_0_5(var_5_4)] = var_0_16 and iter_5_1 or var_5_2
		end
	end

	var_0_7(var_5_0)

	local var_5_6 = " %3d%% | %s\n"
	local var_5_7 = "      | %s\n"

	if var_0_16 then
		local var_5_8 = var_0_2.max(5, var_0_2.ceil(var_0_2.log10(var_5_1)))

		var_5_6 = "%" .. var_5_8 .. "d | %s\n"
		var_5_7 = (" "):rep(var_5_8) .. " | %s\n"
	end

	local var_5_9 = var_0_19

	for iter_5_2, iter_5_3 in var_0_4(var_5_0) do
		local var_5_10 = iter_5_3:byte()

		if var_5_10 == 40 or var_5_10 == 91 then
			var_0_11:write(var_0_8("\n====== %s ======\n[Cannot annotate non-file]\n", iter_5_3))

			break
		end

		local var_5_11, var_5_12 = io.open(iter_5_3)

		if not var_5_11 then
			var_0_11:write(var_0_8("====== ERROR: %s: %s\n", iter_5_3, var_5_12))

			break
		end

		var_0_11:write(var_0_8("\n====== %s ======\n", iter_5_3))

		local var_5_13 = 1
		local var_5_14 = false

		if var_5_9 ~= 0 then
			for iter_5_4 = 1, var_5_9 do
				if var_5_0[iter_5_3][iter_5_4] then
					var_5_14 = true

					var_0_11:write("@@ 1 @@\n")

					break
				end
			end
		end

		for iter_5_5 in var_5_11:lines() do
			if iter_5_5:byte() == 27 then
				var_0_11:write("[Cannot annotate bytecode file]\n")

				break
			end

			local var_5_15 = var_5_0[iter_5_3][var_5_13]

			if var_5_9 ~= 0 then
				if var_5_14 then
					if var_5_0[iter_5_3][var_5_13 + var_5_9] then
						var_5_14 = var_5_13 + var_5_9
					elseif var_5_15 then
						var_5_14 = var_5_13
					elseif var_5_13 > var_5_14 + var_5_9 then
						var_5_14 = false
					end
				elseif var_5_0[iter_5_3][var_5_13 + var_5_9] then
					var_5_14 = var_5_13 + var_5_9

					var_0_11:write(var_0_8("@@ %d @@\n", var_5_13))
				end

				if not var_5_14 then
					goto label_5_0
				end
			end

			if var_5_15 then
				var_0_11:write(var_0_8(var_5_6, var_5_15, iter_5_5))
			else
				var_0_11:write(var_0_8(var_5_7, iter_5_5))
			end

			::label_5_0::

			var_5_13 = var_5_13 + 1
		end

		var_5_11:close()
	end

	return
end

local function var_0_27()
	if var_0_12 then
		profile.stop()

		if var_0_22 == 0 then
			if var_0_16 ~= true then
				var_0_11:write("[No samples collected]\n")
			end

			return
		end

		if var_0_19 then
			var_0_26(var_0_20, var_0_22)
		else
			var_0_25(var_0_20, var_0_21, var_0_22, "")
		end

		var_0_20 = nil
		var_0_21 = nil
		var_0_12 = nil
	end

	return
end

local function var_0_28(arg_7_0)
	local var_7_0 = ""

	arg_7_0 = arg_7_0:gsub("i%d*", function(arg_8_0)
		var_7_0 = arg_8_0

		return ""
	end)
	var_0_15 = 3
	arg_7_0 = arg_7_0:gsub("m(%d+)", function(arg_9_0)
		var_0_15 = var_0_5(arg_9_0)

		return ""
	end)
	var_0_18 = 1
	arg_7_0 = arg_7_0:gsub("%-?%d+", function(arg_10_0)
		var_0_18 = var_0_5(arg_10_0)

		return ""
	end)

	local var_7_1 = {}

	for iter_7_0 in arg_7_0:gmatch(".") do
		var_7_1[iter_7_0] = iter_7_0
	end

	var_0_13 = var_7_1.z or var_7_1.v

	if var_0_13 == "z" then
		var_0_10 = require("jit.zone")
	end

	local var_7_2 = var_7_1.l or var_7_1.f or var_7_1.F or var_0_13 and "" or "f"
	local var_7_3 = var_7_1.p or ""

	var_0_16 = var_7_1.r

	if var_7_1.s then
		var_0_14 = 2

		if var_0_18 == -1 or var_7_1["-"] then
			var_0_18 = -2
		elseif var_0_18 == 1 then
			var_0_18 = 2
		end
	elseif arg_7_0:find("[fF].*l") then
		var_7_2 = "l"
		var_0_14 = 3
	else
		var_0_14 = (var_7_2 == "" or arg_7_0:find("[zv].*[lfF]")) and 1 or 0
	end

	var_0_19 = var_7_1.A and 0 or var_7_1.a and 3

	if var_0_19 then
		var_7_2 = "l"
		var_0_17 = "pl"
		var_0_14 = 0
		var_0_18 = 1
	elseif var_7_1.G and var_7_2 ~= "" then
		var_0_17 = var_7_3 .. var_7_2 .. "Z;"
		var_0_18 = 28
		var_0_16 = true
		var_0_15 = 0
	elseif var_7_2 == "" then
		var_0_17 = false
	else
		var_0_17 = var_7_3 .. ((var_0_14 == 3 or nil) and (var_7_1.f or var_7_1.F or var_7_2)) .. (var_0_18 >= 0 and "Z < " or "Z > ")
	end

	var_0_20 = {}
	var_0_21 = {}
	var_0_22 = 0

	profile.start(var_7_2:lower() .. "", var_0_24)

	var_0_12 = newproxy(true)
	getmetatable(var_0_12).__gc = var_0_27

	return
end

return {
	start = function(arg_11_0, arg_11_1)
		arg_11_1 = arg_11_1 or os.getenv("LUAJIT_PROFILEFILE")

		if arg_11_1 then
			if arg_11_1 == "-" then
				var_0_11 = var_0_9 or assert(io.open(arg_11_1, "w"))
			end
		else
			var_0_11 = var_0_9
		end

		var_0_28(arg_11_0 or "f")

		return
	end,
	stop = var_0_27
}
