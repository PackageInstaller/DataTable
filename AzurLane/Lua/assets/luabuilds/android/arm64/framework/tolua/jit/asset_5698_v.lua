require = var_0_10000

local var_0_0 = var_0_10000("jit")

assert = var_0_10001

var_0_10001(var_0_0.version_num == 4, "LuaJIT core/library version mismatch")

require = var_0_10001

local var_0_1 = var_0_10001("jit.util")

require = var_2

local var_0_2 = var_2("jit.vmdef")
local var_0_3 = var_0_1.funcinfo
local var_0_4 = var_0_1.traceinfo

type = var_0_10005
string = var_0_10006

local var_0_5 = var_0_10006.format

io = var_0_10007

local var_0_6 = var_0_10007.stdout

io = var_0_10008

local var_0_7 = var_0_10008.stderr
local var_0_8
local var_0_9
local var_0_10
local var_0_11

local function var_0_12(arg_1_0, arg_1_1)
	if var_0_3(arg_1_0, arg_1_1).loc then
		return var_2.loc
	elseif var_2.ffid then
		return var_0_2.ffnames[var_2.ffid]
	elseif var_2.addr then
		return var_0_5("C:%x", var_2.addr)
	else
		return "(?)"
	end

	return
end

local function var_0_13(arg_2_0, arg_2_1)
	if var_0_10005(arg_2_0) == "number" then
		if var_0_10005(arg_2_1) == "function" then
			arg_2_1 = var_0_12(arg_2_1)
		end

		arg_2_0 = var_0_5(var_0_2.traceerr[arg_2_0], arg_2_1)
	end

	return arg_2_0
end

local function var_0_14(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if arg_3_0 == "start" then
		var_0_10 = var_0_12(arg_3_2, arg_3_3)

		if arg_3_4 then
			var_1_10006 = "("

			local var_3_0 = arg_3_4
			local var_3_1 = "/"

			var_1_10009 = arg_3_5 == -1 and "stitch" or arg_3_5

			if not (var_1_10006 .. var_3_0 .. var_3_1 .. var_1_10009 .. ") ") then
				var_1_10006 = ""
			end

			var_0_11 = var_1_10006

			if false then
				if arg_3_0 == "abort" then
					if var_0_12(arg_3_2, arg_3_3) ~= var_0_10 then
						print = var_7

						var_7(var_0_5("[TRACE --- %s%s -- %s at %s]\n", var_0_11, var_0_10, var_0_13(arg_3_4, arg_3_5), var_1_10006))
					else
						print = var_7

						var_7(var_0_5("[TRACE --- %s%s -- %s]\n", var_0_11, var_0_10, var_0_13(arg_3_4, arg_3_5)))
					end
				elseif arg_3_0 == "stop" then
					local var_3_2 = var_0_4(arg_3_1).link

					if var_1_10006.linktype == "interpreter" then
						print = var_1_10009

						var_1_10009(var_0_5("[TRACE %3s %s%s -- fallback to interpreter]\n", arg_3_1, var_0_11, var_0_10))
					elseif var_8 == "stitch" then
						print = var_1_10009

						var_1_10009(var_0_5("[TRACE %3s %s%s %s %s]\n", arg_3_1, var_0_11, var_0_10, var_8, var_0_12(arg_3_2, arg_3_3)))
					elseif var_3_2 == arg_3_1 or var_3_2 == 0 then
						print = var_1_10009

						var_1_10009(var_0_5("[TRACE %3s %s%s %s]\n", arg_3_1, var_0_11, var_0_10, var_8))
					elseif var_8 == "root" then
						print = var_1_10009

						var_1_10009(var_0_5("[TRACE %3s %s%s -> %d]\n", arg_3_1, var_0_11, var_0_10, var_3_2))
					else
						print = var_1_10009

						var_1_10009(var_0_5("[TRACE %3s %s%s -> %d %s]\n", arg_3_1, var_0_11, var_0_10, var_3_2, var_8))
					end
				else
					print = var_1_10006

					var_1_10006(var_0_5("[TRACE %s]\n", arg_3_0))
				end

				local var_3_3 = var_0_9

				var_6.flush(var_3_3)
			end

			return
		end
	end
end

local function var_0_15()
	if var_0_8 then
		var_0_8 = false

		var_0_0.attach(var_0_14)

		if var_0_9 and var_0_9 ~= var_0_6 and var_0_9 ~= var_0_7 then
			local var_4_0 = var_0_9

			var_0.close(var_4_0)
		end

		var_0_9 = nil
	end

	return
end

local function var_0_16(arg_5_0)
	if var_0_8 then
		var_0_15()
	end

	if not arg_5_0 then
		os = var_5_0
		arg_5_0 = var_5_0.getenv("LUAJIT_VERBOSEFILE")
	end

	if arg_5_0 then
		local var_5_0

		if arg_5_0 ~= "-" or not var_0_6 then
			assert = var_5_0
			io = var_1_10003
			var_5_0 = var_5_0(var_1_10003.open(arg_5_0, "w"))
		end

		var_0_9 = var_5_0
	else
		var_0_9 = var_0_7
	end

	var_0_0.attach(var_0_14, "trace")

	var_0_8 = true

	return
end

return {
	on = var_0_16,
	off = var_0_15,
	start = var_0_16
}
