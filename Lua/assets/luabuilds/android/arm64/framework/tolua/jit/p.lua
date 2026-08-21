assert(require("jit").version_num == 4, "LuaJIT core/library version mismatch")

local var_0_0 = require("jit.profile")
local var_0_1 = require("jit.vmdef")
local var_0_2 = pairs
local var_0_3 = ipairs
local var_0_4 = tonumber
local var_0_5 = math.floor
local var_0_6 = table.sort
local var_0_7 = string.format
local var_0_8 = io.stdout
local var_0_9
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
local var_0_22 = {
	G = "Garbage Collector",
	C = "C code",
	N = "Compiled",
	J = "JIT Compiler",
	I = "Interpreted"
}

local function var_0_23(arg_1_0, arg_1_1, arg_1_2)
	var_0_21 = var_0_21 + arg_1_1

	local var_1_0
	local var_1_1
	local var_1_2

	if var_0_12 then
		var_1_2 = var_0_12 == "v" and (var_0_22[arg_1_2] or arg_1_2) or var_0_9:get() or "(none)"
	end

	if var_0_16 then
		var_1_0 = var_0_0.dumpstack(arg_1_0, var_0_16, var_0_17)
		var_1_0 = var_1_0:gsub("%[builtin#(%d+)%]", function(arg_2_0)
			return var_0_1.ffnames[var_0_4(arg_2_0)]
		end)

		if var_0_13 == 2 then
			local var_1_3, var_1_4 = var_1_0:match("(.-) [<>] (.*)")

			if var_1_4 then
				var_1_1 = var_1_4
				var_1_0 = var_1_3
			end
		elseif var_0_13 == 3 then
			var_1_1 = var_0_0.dumpstack(arg_1_0, "l", 1)
		end
	end

	local var_1_5
	local var_1_6

	if var_0_13 == 1 then
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
		local var_1_7 = var_0_19[var_1_5] or 0

		var_0_19[var_1_5] = var_1_7 + arg_1_1

		if var_1_6 then
			local var_1_8 = var_0_20[var_1_5]

			if not var_0_20[var_1_5] then
				var_1_8 = {}
				var_0_20[var_1_5] = {}
			end

			local var_1_9 = var_1_8[var_1_6] or 0

			var_1_8[var_1_6] = var_1_9 + arg_1_1
		end
	end

	return
end

local function var_0_24(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = 0

	for iter_3_0 in var_0_2(arg_3_0) do
		var_3_0 = var_3_0 + 1
		;({})[var_3_0] = iter_3_0
	end

	var_0_6({}, function(arg_4_0, arg_4_1)
		return arg_3_0[arg_4_0] > arg_3_0[arg_4_1]
	end)

	for iter_3_1 = 1, var_3_0 do
		local var_3_1 = ({})[iter_3_1]
		local var_3_2 = arg_3_0[({})[iter_3_1]]
		local var_3_3 = var_0_5(arg_3_0[({})[iter_3_1]] * 100 / arg_3_2 + 0.5)

		if var_3_3 < var_0_14 then
			break
		end

		if not var_0_15 then
			var_0_10:write(var_0_7("%s%2d%%  %s\n", arg_3_3, var_3_3, var_3_1))
		elseif var_0_15 == "r" then
			var_0_10:write(var_0_7("%s%5d  %s\n", arg_3_3, var_3_2, var_3_1))
		else
			var_0_10:write(var_0_7("%s %d\n", var_3_1, var_3_2))
		end

		if arg_3_1 then
			local var_3_4 = arg_3_1[var_3_1]

			if arg_3_1[var_3_1] then
				var_0_24(var_3_4, nil, var_3_2, (var_0_13 == 3 or var_0_13 == 1) and "  -- " or var_0_17 < 0 and "  -> " or "  <- ")
			end
		end
	end

	return
end

local function var_0_25(arg_5_0, arg_5_1)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in var_0_2(arg_5_0) do
		local var_5_1 = var_0_5(iter_5_1 * 100 / arg_5_1 + 0.5)

		var_5_0 = var_0.max(var_5_0, iter_5_1)

		if var_5_1 >= var_0_14 then
			local var_5_2, var_5_3 = iter_5_0:match("^(.*):(%d+)$")

			if not var_5_2 then
				var_5_2 = iter_5_0
				var_5_3 = 0
			end

			local var_5_4 = ({})[var_5_2]

			if not ({})[var_5_2] then
				var_5_4 = {}
				;({})[var_5_2] = {}
				;({})[#{} + 1] = var_5_2
			end

			var_5_4[var_0_4(var_5_3)] = var_0_15 and iter_5_1 or var_5_1
		end
	end

	var_0_6({})

	local var_5_5 = " %3d%% | %s\n"
	local var_5_6 = "      | %s\n"

	if var_0_15 then
		local var_5_7 = var_0.max(5, var_0.ceil(var_0.log10(var_5_0)))

		var_5_5 = "%" .. var_5_7 .. "d | %s\n"
		var_5_6 = (" "):rep(var_5_7) .. " | %s\n"
	end

	local var_5_8 = var_0_18

	for iter_5_2, iter_5_3 in var_0_3({}) do
		local var_5_9 = iter_5_3:byte()

		if var_5_9 == 40 or var_5_9 == 91 then
			var_0_10:write(var_0_7("\n====== %s ======\n[Cannot annotate non-file]\n", iter_5_3))

			break
		end

		local var_5_10, var_5_11 = io.open(iter_5_3)

		if not var_5_10 then
			var_0_10:write(var_0_7("====== ERROR: %s: %s\n", iter_5_3, var_5_11))

			break
		end

		var_0_10:write(var_0_7("\n====== %s ======\n", iter_5_3))

		local var_5_12 = 1
		local var_5_13 = false

		if var_5_8 ~= 0 then
			for iter_5_4 = 1, var_5_8 do
				if ({})[iter_5_3][iter_5_4] then
					var_5_13 = true

					var_0_10:write("@@ 1 @@\n")

					break
				end
			end
		end

		for iter_5_5 in var_5_10:lines() do
			if iter_5_5:byte() == 27 then
				var_0_10:write("[Cannot annotate bytecode file]\n")

				break
			end

			local var_5_14 = ({})[iter_5_3][var_5_12]

			if var_5_8 ~= 0 then
				if var_5_13 then
					if ({})[iter_5_3][var_5_12 + var_5_8] then
						var_5_13 = var_5_12 + var_5_8
					elseif var_5_14 then
						var_5_13 = var_5_12
					elseif var_5_12 > var_5_13 + var_5_8 then
						var_5_13 = false
					end
				elseif ({})[iter_5_3][var_5_12 + var_5_8] then
					var_5_13 = var_5_12 + var_5_8

					var_0_10:write(var_0_7("@@ %d @@\n", var_5_12))
				end

				if not var_5_13 then
					goto label_5_0
				end
			end

			if var_5_14 then
				var_0_10:write(var_0_7(var_5_5, var_5_14, iter_5_5))
			else
				var_0_10:write(var_0_7(var_5_6, iter_5_5))
			end

			::label_5_0::

			var_5_12 = var_5_12 + 1
		end

		var_5_10:close()
	end

	return
end

local function var_0_26(arg_7_0)
	local var_7_0 = ""

	arg_7_0 = arg_7_0:gsub("i%d*", function(arg_8_0)
		var_7_0 = arg_8_0

		return ""
	end)
	var_0_14 = 3
	arg_7_0 = arg_7_0:gsub("m(%d+)", function(arg_9_0)
		var_0_14 = var_0_4(arg_9_0)

		return ""
	end)
	var_0_17 = 1
	arg_7_0 = arg_7_0:gsub("%-?%d+", function(arg_10_0)
		var_0_17 = var_0_4(arg_10_0)

		return ""
	end)

	local var_7_1 = {}

	for iter_7_0 in arg_7_0:gmatch(".") do
		var_7_1[iter_7_0] = iter_7_0
	end

	var_0_12 = var_7_1.z or var_7_1.v

	if var_0_12 == "z" then
		var_0_9 = require("jit.zone")
	end

	local var_7_2 = var_7_1.l or var_7_1.f or var_7_1.F or var_0_12 and "" or "f"
	local var_7_3 = var_7_1.p or ""

	var_0_15 = var_7_1.r

	if var_7_1.s then
		var_0_13 = 2

		if var_0_17 == -1 or var_7_1["-"] then
			var_0_17 = -2
		elseif var_0_17 == 1 then
			var_0_17 = 2
		end
	elseif arg_7_0:find("[fF].*l") then
		var_7_2 = "l"
		var_0_13 = 3
	else
		var_0_13 = (var_7_2 == "" or arg_7_0:find("[zv].*[lfF]")) and 1 or 0
	end

	var_0_18 = var_7_1.A and 0 or var_7_1.a and 3

	if var_0_18 then
		var_7_2 = "l"
		var_0_16 = "pl"
		var_0_13 = 0
		var_0_17 = 1

		goto label_7_0
	end

	if var_7_1.G and var_7_2 ~= "" then
		var_0_16 = var_7_3 .. var_7_2 .. "Z;"
		var_0_17 = 28
		var_0_15 = true
		var_0_14 = 0

		goto label_7_0
	end

	if var_7_2 == "" then
		var_0_16 = false

		goto label_7_0
	end

	::label_7_0::

	if var_0_13 == 3 then
		do
			local var_7_5 = var_7_1.f or var_7_1.F or var_7_2

			var_0_16 = var_7_3 .. var_7_5 .. (var_0_17 >= 0 and "Z < " or "Z > ")
		end

		var_0_19 = {}
		var_0_20 = {}
		var_0_21 = 0

		var_0_0.start(var_7_2:lower() .. "", var_0_23)

		var_0_11 = newproxy(true)
		getmetatable(var_0_11).__gc = var_0

		return
	end
end

return {
	start = function(arg_11_0, arg_11_1)
		arg_11_1 = arg_11_1 or os.getenv("LUAJIT_PROFILEFILE")

		if arg_11_1 then
			if arg_11_1 == "-" then
				var_0_10 = var_0_8 or assert(io.open(arg_11_1, "w"))

				if false then
					var_0_10 = var_0_8
				end

				var_0_26(arg_11_0 or "f")

				return
			end
		end
	end,
	stop = function()
		if var_0_11 then
			var_0_0.stop()

			if var_0_21 == 0 then
				if var_0_15 ~= true then
					var_0_10:write("[No samples collected]\n")
				end

				return
			end

			if var_0_18 then
				var_0_25(var_0_19, var_0_21)
			else
				var_0_24(var_0_19, var_0_20, var_0_21, "")
			end

			var_0_19 = nil
			var_0_20 = nil
			var_0_11 = nil
		end

		return
	end
}
