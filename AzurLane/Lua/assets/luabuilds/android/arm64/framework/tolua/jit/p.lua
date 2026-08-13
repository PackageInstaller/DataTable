require = var_0_10000

local var_0_0 = var_0_10000("jit")

assert = var_0_10001

var_0_10001(var_0_0.version_num == 4, "LuaJIT core/library version mismatch")

require = var_0_10001

local var_0_1 = var_0_10001("jit.profile")

require = var_2

local var_0_2 = var_2("jit.vmdef")

math = var_3
pairs = var_4
ipairs = var_0_10005
tonumber = var_0_10006

local var_0_3 = var_3.floor

table = var_0_10008

local var_0_4 = var_0_10008.sort

string = var_0_10009

local var_0_5 = var_0_10009.format

io = var_0_10010

local var_0_6 = var_0_10010.stdout
local var_0_7
local var_0_8
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
local var_0_20 = {
	G = "Garbage Collector",
	C = "C code",
	N = "Compiled",
	J = "JIT Compiler",
	I = "Interpreted"
}

local function var_0_21(arg_1_0, arg_1_1, arg_1_2)
	var_0_19 = var_0_19 + arg_1_1

	local var_1_0
	local var_1_1
	local var_1_2

	if var_0_10 then
		if var_0_10 == "v" then
			var_1_2 = var_0_20[arg_1_2] or arg_1_2
		else
			local var_1_3 = var_0_7

			var_1_2 = var_6.get(var_1_3) or "(none)"
		end
	end

	if var_0_14 then
		local var_1_4 = var_0_1.dumpstack(arg_1_0, var_0_14, var_0_15)

		var_1_0 = var_1_0.gsub(var_1_4, "%[builtin#(%d+)%]", function(arg_2_0)
			return var_0_2.ffnames[var_0_10006(arg_2_0)]
		end)

		if var_0_11 == 2 then
			local var_1_5, var_1_6 = var_1_0:match("(.-) [<>] (.*)")

			if var_1_6 then
				var_1_0, var_1_1 = var_1_5, var_1_6
			end
		elseif var_0_11 == 3 then
			var_1_1 = var_0_1.dumpstack(arg_1_0, "l", 1)
		end
	end

	local var_1_7
	local var_1_8

	if var_0_11 == 1 then
		if var_1_2 then
			var_1_7 = var_1_2

			if var_1_0 then
				var_1_8 = var_1_0
			end
		end
	elseif var_1_0 then
		var_1_7 = var_1_0

		if var_1_1 then
			var_1_8 = var_1_1
		elseif var_1_2 then
			var_1_8 = var_1_2
		end
	end

	if var_1_7 then
		local var_1_9

		if not var_0_17[var_1_7] then
			var_1_9 = 0
		end

		var_8[var_1_7] = var_1_9 + arg_1_1

		if var_1_8 then
			if not var_0_18[var_1_7] then
				var_9[var_1_7] = {}
			end

			local var_1_10

			if not var_10[var_1_8] then
				var_1_10 = 0
			end

			var_10[var_1_8] = var_1_10 + arg_1_1
		end
	end

	return
end

local function var_0_22(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {}
	local var_3_1 = 0

	for iter_3_0 in var_0(arg_3_0) do
		var_3_0[var_3_1 + 1] = iter_3_0
	end

	var_0_4(var_3_0, function(arg_4_0, arg_4_1)
		return arg_3_0[arg_4_0] > arg_3_0[arg_4_1]
	end)

	for iter_3_1 = 1, var_3_1 do
		local var_3_2 = arg_3_0[var_3_0[iter_3_1]]

		if var_0_3(var_3_2 * 100 / arg_3_2 + 0.5) < var_0_12 then
			break
		end

		if not var_0_13 then
			local var_3_3 = var_0_8

			var_13.write(var_3_3, var_0_5("%s%2d%%  %s\n", arg_3_3, var_12, var_10))
		elseif var_0_13 == "r" then
			local var_3_4 = var_0_8

			var_13.write(var_3_4, var_0_5("%s%5d  %s\n", arg_3_3, var_3_2, var_10))
		else
			local var_3_5 = var_0_8

			var_13.write(var_3_5, var_0_5("%s %d\n", var_10, var_3_2))
		end

		if arg_3_1 and arg_3_1[var_10] then
			var_0_22(var_13, nil, var_3_2, (var_0_11 == 3 or var_0_11 == 1) and "  -- " or var_0_15 < 0 and "  -> " or "  <- ")
		end
	end

	return
end

local function var_0_23(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in var_0(arg_5_0) do
		local var_5_2 = var_0_3(iter_5_1 * 100 / arg_5_1 + 0.5)

		var_5_1 = var_0.max(var_5_1, iter_5_1)

		if var_5_2 >= var_0_12 then
			local var_5_3, var_5_4 = iter_5_0:match("^(.*):(%d+)$")

			if not var_5_3 then
				var_5_3 = iter_5_0
				var_5_4 = 0
			end

			if not var_5_0[var_5_3] then
				var_5_0[var_5_3] = {}
				var_5_0[#var_5_0 + 1] = var_5_3
			end

			local var_5_5 = var_0_10006(var_5_4)

			var_1_10013 = var_0_13 and iter_5_1 or var_5_2
			var_12[var_5_5] = var_1_10013
		end
	end

	var_0_4(var_5_0)

	local var_5_6 = " %3d%% | %s\n"
	local var_5_7 = "      | %s\n"

	if var_0_13 then
		local var_5_8 = var_0.max(5, var_0.ceil(var_0.log10(var_5_1)))

		var_5_6 = "%" .. var_5_8 .. "d | %s\n"

		local var_5_9 = " "

		var_5_7 = var_7.rep(var_5_9, var_5_8) .. " | %s\n"
	end

	local var_5_10 = var_0_16

	for iter_5_2, iter_5_3 in var_0_10005(var_5_0) do
		if iter_5_3:byte() == 40 or var_12 == 91 then
			local var_5_11 = var_0_8

			var_1_10013.write(var_5_11, var_0_5("\n====== %s ======\n[Cannot annotate non-file]\n", iter_5_3))

			break
		end

		io = var_1_10013

		local var_5_12

		var_1_10013, var_5_12 = var_1_10013.open(iter_5_3)

		if not var_1_10013 then
			local var_5_13 = var_0_8

			var_15.write(var_5_13, var_0_5("====== ERROR: %s: %s\n", iter_5_3, var_5_12))

			break
		end

		local var_5_14 = var_0_8

		var_15.write(var_5_14, var_0_5("\n====== %s ======\n", iter_5_3))

		local var_5_15 = var_5_0[iter_5_3]
		local var_5_16 = 1
		local var_5_17 = false

		if var_5_10 ~= 0 then
			for iter_5_4 = 1, var_5_10 do
				if var_5_15[iter_5_4] then
					var_5_17 = true

					local var_5_18 = var_0_8

					var_22.write(var_5_18, "@@ 1 @@\n")

					break
				end
			end
		end

		for iter_5_5 in var_1_10013:lines() do
			if iter_5_5:byte() == 27 then
				local var_5_19 = var_0_8

				var_22.write(var_5_19, "[Cannot annotate bytecode file]\n")

				break
			end

			local var_5_20 = var_5_15[var_5_16]

			if var_5_10 ~= 0 then
				local var_5_21 = var_5_15[var_5_16 + var_5_10]

				if var_5_17 then
					if var_5_21 then
						var_5_17 = var_5_16 + var_5_10
					elseif var_5_20 then
						var_5_17 = var_5_16
					elseif var_5_16 > var_5_17 + var_5_10 then
						var_5_17 = false
					end
				elseif var_5_21 then
					var_5_17 = var_5_16 + var_5_10

					local var_5_22 = var_0_8

					var_24.write(var_5_22, var_0_5("@@ %d @@\n", var_5_16))
				end

				if not var_5_17 then
					goto label_5_0
				end
			end

			if var_5_20 then
				local var_5_23 = var_0_8

				var_23.write(var_5_23, var_0_5(var_5_6, var_5_20, iter_5_5))
			else
				local var_5_24 = var_0_8

				var_23.write(var_5_24, var_0_5(var_5_7, iter_5_5))
			end

			::label_5_0::

			var_5_16 = var_5_16 + 1
		end

		var_1_10013:close()
	end

	return
end

local function var_0_24()
	if var_0_9 then
		var_0_1.stop()

		if var_0_19 == 0 then
			if var_0_13 ~= true then
				local var_6_0 = var_0_8

				var_1.write(var_6_0, "[No samples collected]\n")
			end

			return
		end

		if var_0_16 then
			var_0_23(var_0_17, var_0)
		else
			var_0_22(var_0_17, var_0_18, var_0, "")
		end

		var_0_17 = nil
		var_0_18 = nil
		var_0_9 = nil
	end

	return
end

local function var_0_25(arg_7_0)
	local var_7_0 = ""

	arg_7_0 = arg_7_0:gsub("i%d*", function(arg_8_0)
		var_7_0 = arg_8_0

		return ""
	end)
	var_0_12 = 3
	arg_7_0 = arg_7_0:gsub("m(%d+)", function(arg_9_0)
		var_0_12 = var_0_10006(arg_9_0)

		return ""
	end)
	var_0_15 = 1
	arg_7_0 = arg_7_0:gsub("%-?%d+", function(arg_10_0)
		var_0_15 = var_0_10006(arg_10_0)

		return ""
	end)

	local var_7_1 = {}

	for iter_7_0 in arg_7_0:gmatch(".") do
		var_7_1[iter_7_0] = iter_7_0
	end

	local var_7_2

	if not var_7_1.z then
		var_7_2 = var_7_1.v
	end

	var_0_10 = var_7_2

	if var_0_10 == "z" then
		require = var_3
		var_0_7 = var_3("jit.zone")
	end

	local var_7_3

	if not var_7_1.l and not var_7_1.f and not var_7_1.F then
		var_7_3 = var_0_10 and "" or "f"
	end

	local var_7_4

	if not var_7_1.p then
		var_7_4 = ""
	end

	var_0_13 = var_7_1.r

	if var_7_1.s then
		var_0_11 = 2

		if var_0_15 == -1 or var_7_1["-"] then
			var_0_15 = -2
		elseif var_0_15 == 1 then
			var_0_15 = 2
		end
	elseif arg_7_0:find("[fF].*l") then
		var_7_3 = "l"
		var_0_11 = 3
	else
		var_0_11 = (var_7_3 == "" or arg_7_0:find("[zv].*[lfF]")) and 1 or 0
	end

	local var_7_5

	if var_7_1.A then
		var_7_5 = 0
	elseif var_7_1.a then
		var_7_5 = 3
	end

	var_0_16 = var_7_5

	if var_0_16 then
		var_7_3 = "l"
		var_0_14 = "pl"
		var_0_11 = 0
		var_0_15 = 1
	elseif var_7_1.G and var_7_3 ~= "" then
		var_0_14 = var_7_4 .. var_7_3 .. "Z;"
		var_0_15 = 28
		var_0_13 = true
		var_0_12 = 0
	elseif var_7_3 == "" then
		var_0_14 = false
	else
		local var_7_6

		if (var_0_11 ~= 3 or not var_7_1.f) and not var_7_1.F then
			var_7_6 = var_7_3
		end

		var_0_14 = var_7_4 .. var_7_6 .. (var_0_15 >= 0 and "Z < " or "Z > ")
	end

	var_0_17 = {}
	var_0_18 = {}
	var_0_19 = 0

	var_0_1.start(var_7_3:lower() .. var_7_0, var_0_21)

	newproxy = var_5
	var_0_9 = var_5(true)
	getmetatable = var_5
	var_5(var_0_9).__gc = var_0_24

	return
end

local function var_0_26(arg_11_0, arg_11_1)
	if not arg_11_1 then
		os = var_1_10002
		arg_11_1 = var_1_10002.getenv("LUAJIT_PROFILEFILE")
	end

	if arg_11_1 then
		if arg_11_1 ~= "-" or not var_0_6 then
			assert = var_1_10002
			io = var_1_10004
			var_1_10002 = var_1_10002(var_1_10004.open(arg_11_1, "w"))
		end

		var_0_8 = var_1_10002
	else
		var_0_8 = var_0_6
	end

	var_0_25(arg_11_0 or "f")

	return
end

return {
	start = var_0_26,
	stop = var_0_24
}
