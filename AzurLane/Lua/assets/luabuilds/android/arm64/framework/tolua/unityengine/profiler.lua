local var_0_0 = LuaProfiler
local var_0_1

if jit then
	var_0_1 = require("jit.vmdef")
end

local var_0_2 = {
	event = {
		[142] = "event.__call",
		[20] = "_xpcall.__call"
	},
	slot = {
		[11] = "slot.__call"
	},
	MainScene = {
		[250] = "MainScene.Update"
	}
}
local var_0_3 = {
	["_xpcall.__call"] = 1,
	ipairs_aux = 1,
	unknow = 1
}
local var_0_4 = {
	mark = 1,
	cache = 1
}
local var_0_5 = {}

;({
	mark = 1,
	cache = 1
}).scan = function(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_0.mark[arg_1_1] then
		return
	end

	arg_1_0.mark[arg_1_1] = true

	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		if type(iter_1_0) == "string" then
			if type(iter_1_1) == "function" then
				local var_1_0 = iter_1_0

				if arg_1_2 then
					var_1_0 = arg_1_2 .. "." .. var_1_0
				end

				if not var_0_3[var_1_0] and iter_1_0 ~= "__index" and iter_1_0 ~= "__newindex" then
					arg_1_0.cache[iter_1_1] = {
						id = -1,
						name = var_1_0
					}
				end
			elseif type(iter_1_1) == "table" and not arg_1_0.mark[iter_1_1] then
				arg_1_0:scan(iter_1_1, iter_1_0)
			end
		elseif arg_1_2 and iter_1_0 == tolua.gettag or iter_1_0 == tolua.settag then
			arg_1_0:scan(iter_1_1, arg_1_2)
		end
	end

	return
end
;({
	mark = 1,
	cache = 1
}).scanlibs = function(arg_2_0)
	arg_2_0.mark[package.loaded] = true

	for iter_2_0, iter_2_1 in pairs(package.loaded) do
		if type(iter_2_0) == "string" and type(iter_2_1) == "table" then
			arg_2_0:scan(iter_2_1, iter_2_0)

			local var_2_0 = getmetatable(iter_2_1)

			if var_2_0 then
				arg_2_0:scan(var_2_0, iter_2_0)
			end
		end
	end

	return
end

local function var_0_6(arg_3_0)
	local var_3_0 = #var_0_5 + 1

	for iter_3_0, iter_3_1 in ipairs(var_0_5) do
		if iter_3_1 == arg_3_0 then
			var_3_0 = iter_3_0
		end
	end

	return var_3_0
end

local function var_0_7(arg_4_0)
	if #var_0_5 > 0 then
		local var_4_0 = debug.getinfo(5, "f")

		if var_4_0 then
			local var_4_1 = var_0_6(var_4_0.func)

			if #var_0_5 < var_4_1 then
				local var_4_2 = debug.getinfo(6, "f")

				var_4_1 = var_4_2 and var_0_6(var_4_2.func) or var_4_1
			end

			for iter_4_0 = var_4_1 + 1, #var_0_5 do
				table.remove(var_0_5)
				var_0_0.EndSample()
			end
		end
	end

	return
end

local function var_0_8(arg_5_0, arg_5_1, arg_5_2)
	var_0_7()
	table.insert(var_0_5, arg_5_1)

	if arg_5_2.id == -1 then
		arg_5_2.name = arg_5_0
		arg_5_2.id = var_0_0.GetID(arg_5_0)
	end

	var_0_0.BeginSample(arg_5_2.id)

	return
end

local function var_0_9(arg_6_0, arg_6_1, arg_6_2)
	var_0_7()
	table.insert(var_0_5, arg_6_1)

	if arg_6_2.nick == nil then
		arg_6_2.nick = {}
	end

	local var_6_1 = arg_6_2.nick[arg_6_0]

	if not arg_6_2.nick[arg_6_0] then
		var_6_1 = var_0_0.GetID(arg_6_0)
		arg_6_2.nick[arg_6_0] = var_6_1
	end

	var_0_0.BeginSample(var_6_1)

	return
end

function profiler_hook(arg_7_0, arg_7_1)
	if arg_7_0 == "call" then
		local var_7_0
		local var_7_1 = debug.getinfo(2, "f").func
		local var_7_2 = var_0_4.cache[var_7_1]

		if var_0_4.cache[var_7_1] then
			var_7_0 = var_7_2.name
		end

		if var_0_3[var_7_0] then
			return
		end

		if var_7_0 == "event.__call" then
			local var_7_3 = debug.getinfo(2, "n").name or var_7_0

			var_0_9(var_7_3, var_7_1, var_7_2)
		elseif var_7_0 then
			var_0_8(var_7_0, var_7_1, var_7_2)
		else
			local var_7_4 = debug.getinfo(2, "Sn")
			local var_7_5 = var_7_4.name

			if not var_7_2 then
				var_7_2 = {
					id = -1,
					name = "unknow"
				}
				var_0_4.cache[var_7_1] = {
					id = -1,
					name = "unknow"
				}
			end

			if var_7_4.short_src == "[C]" then
				if var_7_5 == "__index" or var_7_5 == "__newindex" then
					return
				end

				local var_7_6 = tostring(var_7_1):match("function: builtin#(%d+)")

				if not var_7_6 then
					if var_7_5 then
						var_0_8(var_7_5, var_7_1, var_7_2)
					elseif var_7_4.linedefined ~= -1 then
						var_0_8(var_7_4.short_src .. var_7_4.linedefined, var_7_1, var_7_2)
					end
				else
					local var_7_8 = var_0_1.ffnames[tonumber(var_7_6)]

					if not var_0_3[var_7_8] then
						var_0_8(var_7_8, var_7_1, var_7_2)
					end
				end
			elseif var_7_4.linedefined ~= -1 or var_7_5 then
				local var_7_9 = var_7_4.short_src

				var_7_5 = var_7_5 or var_7_4.linedefined

				local var_7_10 = var_7_9:match("([^/\\]+)%.%w+$") or var_7_9:match("([^/\\]+)$")
				local var_7_12 = var_0_2[nil]

				var_7_10 = var_0_2[nil] and var_7_12[var_7_4.linedefined] or var_7_10 .. "." .. var_7_5
				var_7_10 = var_7_10 or var_7_9 .. "." .. var_7_5

				var_0_8(var_7_10, var_7_1, var_7_2)
			else
				var_0_8(var_7_0, var_7_1, var_7_2)
			end
		end
	elseif arg_7_0 == "return" then
		if #var_0_5 == 0 then
			return
		end

		local var_7_13 = debug.getinfo(2, "f")

		if var_7_13.func == var_0_5[#var_0_5] then
			table.remove(var_0_5)
			var_0_0.EndSample()
		else
			local var_7_14 = var_0_6(var_7_13.func)

			if #var_0_5 < var_7_14 then
				return
			end

			for iter_7_0 = var_7_14, #var_0_5 do
				table.remove(var_0_5)
				var_0_0.EndSample()
			end
		end
	end

	return
end

;({
	mark = 1,
	cache = 1
}).start = function(arg_8_0)
	arg_8_0.mark = {}
	arg_8_0.cache = {
		__mode = "k"
	}

	arg_8_0:scan(_G, nil)
	arg_8_0:scanlibs()

	arg_8_0.mark = nil

	debug.sethook(profiler_hook, "cr", 0)

	return
end
;({
	mark = 1,
	cache = 1
}).print = function(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.cache) do
		print(iter_9_1.name)
	end

	return
end
;({
	mark = 1,
	cache = 1
}).stop = function(arg_10_0)
	debug.sethook(nil)

	arg_10_0.cache = nil

	return
end

return {
	mark = 1,
	cache = 1
}
