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

	if arg_1_0 == "call" then
		if not var_0_2[var_1_0.short_src .. ":" .. var_1_0.linedefined .. ":" .. var_1_0.lastlinedefined] then
			var_0_0.BeginSample(var_0_3, var_1_1 .. ":" .. var_1_0.linedefined .. ":" .. var_1_0.short_src)

			var_0_2[var_1_0.short_src .. ":" .. var_1_0.linedefined .. ":" .. var_1_0.lastlinedefined] = var_0_3
			var_0_3 = var_0_3 + 1
		else
			var_0_0.BeginSample(var_0_2[var_1_0.short_src .. ":" .. var_1_0.linedefined .. ":" .. var_1_0.lastlinedefined])
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
