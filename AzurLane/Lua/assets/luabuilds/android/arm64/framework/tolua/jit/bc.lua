require = var_0_10000

local var_0_0 = var_0_10000("jit")

assert = var_0_10001

var_0_10001(var_0_0.version_num == 4, "LuaJIT core/library version mismatch")

require = var_0_10001

local var_0_1 = var_0_10001("jit.util")

require = var_2

local var_0_2 = var_2("jit.vmdef")

require = var_3

local var_0_3 = var_3("bit")

string = var_4

local var_0_4 = var_4.sub

string = var_5

local var_0_5 = var_5.gsub

string = var_0_10006

local var_0_6 = var_0_10006.format

string = var_0_10007

local var_0_7 = var_0_10007.byte
local var_0_8 = var_0_3.band
local var_0_9 = var_0_3.rshift
local var_0_10 = var_0_1.funcinfo
local var_0_11 = var_0_1.funcbc
local var_0_12 = var_0_1.funck
local var_0_13 = var_0_1.funcuvname
local var_0_14 = var_0_2.bcnames

io = var_0_10015

local var_0_15 = var_0_10015.stdout

io = var_0_10016

local var_0_16 = var_0_10016.stderr

local function var_0_17(arg_1_0)
	if arg_1_0 == "\n" then
		return "\\n"
	elseif arg_1_0 == "\r" then
		return "\\r"
	elseif arg_1_0 == "\t" then
		return "\\t"
	else
		return var_0_6("\\%03d", var_0_7(arg_1_0))
	end

	return
end

local function var_0_18(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0, var_2_1 = var_0_11(arg_2_0, arg_2_1)

	if not var_2_0 then
		return
	end

	local var_2_2 = var_0_8(var_2_1, 7)
	local var_2_3 = var_0_8(var_2_1, 120)
	local var_2_4 = var_0_8(var_2_1, 1920)
	local var_2_5 = var_0_8(var_0_9(var_2_0, 8), 255)
	local var_2_6 = 6 * var_0_8(var_2_0, 255)
	local var_2_7 = var_0_4(var_0_14, var_2_6 + 1, var_2_6 + 6)
	local var_2_8 = var_0_6("%04d %s %-6s %3s ", arg_2_1, arg_2_2 or "  ", var_2_7, var_2_2 == 0 and "" or var_2_5)
	local var_2_9 = var_0_9(var_2_0, 16)

	if var_2_4 == 0 then
		return var_0_6("%s=> %04d\n", var_2_8, arg_2_1 + var_2_9 - 32767)
	end

	if var_2_3 ~= 0 then
		var_2_9 = var_0_8(var_2_9, 255)
	elseif var_2_4 == 0 then
		return var_2_8 .. "\n"
	end

	local var_2_10

	if var_2_4 == 0 then
		var_2_10 = var_0_12(arg_2_0, -var_2_9 - 1)
		var_2_10 = var_0_6(#var_2_10 > 40 and "\"%.40s\"~" or "\"%s\"", var_0_5(var_2_10, "%c", var_0_17))
	elseif var_2_4 == 0 then
		var_2_10 = var_0_12(arg_2_0, var_2_9)

		if var_2_7 == "TSETM " then
			var_2_10 = var_2_10 - 4503599627370496
		end
	elseif var_2_4 == 0 then
		if var_0_10(var_0_12(arg_2_0, -var_2_9 - 1)).ffid then
			var_2_10 = var_0_2.ffnames[var_14.ffid]
		else
			var_2_10 = var_14.loc
		end
	elseif var_2_4 == 0 then
		var_2_10 = var_0_13(arg_2_0, var_2_9)
	end

	if var_2_2 == 5 then
		local var_2_11 = var_0_13(arg_2_0, var_2_5)

		if var_2_10 then
			var_2_10 = var_2_11 .. " ; " .. var_2_10
		else
			var_2_10 = var_2_11
		end
	end

	if var_2_3 ~= 0 then
		local var_2_12 = var_0_9(var_2_0, 24)

		if var_2_10 then
			return var_0_6("%s%3d %3d  ; %s\n", var_2_8, var_2_12, var_2_9, var_2_10)
		end

		return var_0_6("%s%3d %3d\n", var_2_8, var_2_12, var_2_9)
	end

	if var_2_10 then
		return var_0_6("%s%3d      ; %s\n", var_2_8, var_2_9, var_2_10)
	end

	if var_2_4 == 0 and var_2_9 > 32767 then
		var_2_9 = var_2_9 - 0
	end

	return var_0_6("%s%3d\n", var_2_8, var_2_9)
end

local function var_0_19(arg_3_0)
	local var_3_0 = {}

	for iter_3_0 = 1, 0 do
		local var_3_1, var_3_2 = var_0_11(arg_3_0, iter_3_0)

		if not var_3_1 then
			break
		end

		if var_0_8(var_3_2, 1920) == 0 then
			var_3_0[iter_3_0 + var_0_9(var_3_1, 16) - 32767] = true
		end
	end

	return var_3_0
end

local function var_0_20(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1 = arg_4_1 or var_0_15

	local var_4_0 = var_0_10(arg_4_0)

	if arg_4_2 and var_4_0.children then
		for iter_4_0 = -1, 0, -1 do
			if not var_0_12(arg_4_0, iter_4_0) then
				break
			end

			type = var_1_10009

			if var_1_10009(var_8) == "proto" then
				var_0_20(var_8, arg_4_1, true)
			end
		end
	end

	arg_4_1:write(var_0_6("-- BYTECODE -- %s-%d\n", var_4_0.loc, var_4_0.lastlinedefined))

	local var_4_1 = var_0_19(arg_4_0)

	for iter_4_1 = 1, 0 do
		local var_4_2 = var_0_18
		local var_4_3 = arg_4_0
		local var_4_4 = iter_4_1
		local var_4_5

		if var_4_1[iter_4_1] then
			var_4_5 = "=>"
		end

		if not var_4_2(var_4_3, var_4_4, var_4_5) then
			break
		end

		arg_4_1:write(var_9)
	end

	arg_4_1:write("\n")
	arg_4_1:flush()

	return
end

local var_0_21
local var_0_22

local function var_0_23(arg_5_0)
	return var_0_20(arg_5_0, var_0_22)
end

local function var_0_24()
	if var_0_21 then
		var_0_21 = false

		var_0_0.attach(var_0_23)

		if var_0_22 and var_0_22 ~= var_0_15 and var_0_22 ~= var_0_16 then
			local var_6_0 = var_0_22

			var_0.close(var_6_0)
		end

		var_0_22 = nil
	end

	return
end

local function var_0_25(arg_7_0)
	if var_0_21 then
		var_0_24()
	end

	if not arg_7_0 then
		os = var_7_0
		arg_7_0 = var_7_0.getenv("LUAJIT_LISTFILE")
	end

	if arg_7_0 then
		local var_7_0

		if arg_7_0 ~= "-" or not var_0_15 then
			assert = var_7_0
			io = var_1_10003
			var_7_0 = var_7_0(var_1_10003.open(arg_7_0, "w"))
		end

		var_0_22 = var_7_0
	else
		var_0_22 = var_0_16
	end

	var_0_0.attach(var_0_23, "bc")

	var_0_21 = true

	return
end

return {
	line = var_0_18,
	dump = var_0_20,
	targets = var_0_19,
	on = var_0_25,
	off = var_0_24,
	start = var_0_25
}
