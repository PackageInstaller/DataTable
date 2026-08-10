local var_0_0 = LuaProfiler
local var_0_1 = debug
local var_0_2 = {}
local var_0_3 = 0

local function var_0_4(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1.getinfo(2, "Sn")

	if var_1_0.what ~= "Lua" then
		return
	end

	local var_1_1 = var_1_0.name or "[unknown]"

	if var_1_1 == "lua_profiler_attach" or var_1_1 == "lua_profiler_detach" then
		return
	end

	local var_1_2 = var_1_0.linedefined
	local var_1_3 = var_1_0.lastlinedefined
	local var_1_4 = var_1_0.short_src
	local var_1_5 = var_1_4 .. ":" .. var_1_2 .. ":" .. var_1_3
	local var_1_6 = var_0_2[var_1_5]

	if arg_1_0 == "call" then
		if not var_1_6 then
			local var_1_7 = var_1_1 .. ":" .. var_1_2 .. ":" .. var_1_4

			var_0_0.BeginSample(var_0_3, var_1_7)

			var_0_2[var_1_5] = var_0_3
			var_0_3 = var_0_3 + 1
		else
			var_0_0.BeginSample(var_1_6)
		end
	elseif arg_1_0 == "return" or arg_1_0 == "tail return" then
		var_0_0.EndSample()
	end
end

function lua_profiler_attach()
	var_0_1.sethook(var_0_4, "cr", 0)
end

function lua_profiler_detach()
	var_0_1.sethook()

	var_0_2 = {}

	var_0_0.Clear()
end
