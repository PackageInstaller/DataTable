assert(require("jit").version_num == 4, "LuaJIT core/library version mismatch")

local var_0_0 = require("jit.util")
local var_0_1 = require("jit.vmdef")
local var_0_2 = var_0_0.funcinfo
local var_0_3 = var_0_0.traceinfo
local var_0_4 = type
local var_0_5 = string.format
local var_0_6 = io.stdout
local var_0_7 = io.stderr
local var_0_8
local var_0_9
local var_0_10
local var_0_11

local function var_0_12(arg_1_0, arg_1_1)
	local var_1_0 = var_0_2(arg_1_0, arg_1_1)

	if var_1_0.loc then
		return var_1_0.loc
	elseif var_1_0.ffid then
		return var_0_1.ffnames[var_1_0.ffid]
	elseif var_1_0.addr then
		return var_0_5("C:%x", var_1_0.addr)
	else
		return "(?)"
	end

	return
end

local function var_0_13(arg_2_0, arg_2_1)
	if var_0_4(arg_2_0) == "number" then
		if var_0_4(arg_2_1) == "function" then
			arg_2_1 = var_0_12(arg_2_1)
		end

		arg_2_0 = var_0_5(var_0_1.traceerr[arg_2_0], arg_2_1)
	end

	return arg_2_0
end

local function var_0_14(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if arg_3_0 == "start" then
		var_0_10 = var_0_12(arg_3_2, arg_3_3)

		if arg_3_4 then
			var_0_11 = "(" .. arg_3_4 .. "/" .. (arg_3_5 == -1 and "stitch" or arg_3_5) .. ") " or ""

			if false then
				if arg_3_0 == "abort" then
					local var_3_0 = var_0_12(arg_3_2, arg_3_3)

					if var_3_0 ~= var_0_10 then
						print(var_0_5("[TRACE --- %s%s -- %s at %s]\n", var_0_11, var_0_10, var_0_13(arg_3_4, arg_3_5), var_3_0))
					else
						print(var_0_5("[TRACE --- %s%s -- %s]\n", var_0_11, var_0_10, var_0_13(arg_3_4, arg_3_5)))
					end
				elseif arg_3_0 == "stop" then
					local var_3_1 = var_0_3(arg_3_1)

					if var_3_1.linktype == "interpreter" then
						print(var_0_5("[TRACE %3s %s%s -- fallback to interpreter]\n", arg_3_1, var_0_11, var_0_10))
					elseif var_3_1.linktype == "stitch" then
						print(var_0_5("[TRACE %3s %s%s %s %s]\n", arg_3_1, var_0_11, var_0_10, var_3_1.linktype, var_0_12(arg_3_2, arg_3_3)))
					elseif var_3_1.link == arg_3_1 or var_3_1.link == 0 then
						print(var_0_5("[TRACE %3s %s%s %s]\n", arg_3_1, var_0_11, var_0_10, var_3_1.linktype))
					elseif var_3_1.linktype == "root" then
						print(var_0_5("[TRACE %3s %s%s -> %d]\n", arg_3_1, var_0_11, var_0_10, var_3_1.link))
					else
						print(var_0_5("[TRACE %3s %s%s -> %d %s]\n", arg_3_1, var_0_11, var_0_10, var_3_1.link, var_3_1.linktype))
					end
				else
					print(var_0_5("[TRACE %s]\n", arg_3_0))
				end

				var_0_9:flush()
			end

			return
		end
	end
end

return {
	on = function(arg_5_0)
		if var_0_8 then
			var_0()
		end

		arg_5_0 = arg_5_0 or os.getenv("LUAJIT_VERBOSEFILE")

		if arg_5_0 then
			if arg_5_0 == "-" then
				var_0_9 = var_0_6 or assert(io.open(arg_5_0, "w"))

				if false then
					var_0_9 = var_0_7
				end

				var_0.attach(var_0_14, "trace")

				var_0_8 = true

				return
			end
		end
	end,
	off = function()
		if var_0_8 then
			var_0_8 = false

			var_0.attach(var_0_14)

			if var_0_9 and var_0_9 ~= var_0_6 and var_0_9 ~= var_0_7 then
				var_0_9:close()
			end

			var_0_9 = nil
		end

		return
	end,
	start = function(arg_5_0)
		if var_0_8 then
			var_0()
		end

		arg_5_0 = arg_5_0 or os.getenv("LUAJIT_VERBOSEFILE")

		if arg_5_0 then
			if arg_5_0 == "-" then
				var_0_9 = var_0_6 or assert(io.open(arg_5_0, "w"))

				if false then
					var_0_9 = var_0_7
				end

				var_0.attach(var_0_14, "trace")

				var_0_8 = true

				return
			end
		end
	end
}
