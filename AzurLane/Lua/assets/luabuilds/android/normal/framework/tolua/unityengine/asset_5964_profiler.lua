LuaProfiler = var_0_10000
jit = var_0_10001

if var_0_10001 then
	require = var_0_10001
	var_0_10001 = var_0_10001("jit.vmdef")
end

local var_0_0 = {
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
local var_0_1 = {
	["_xpcall.__call"] = 1,
	ipairs_aux = 1,
	unknow = 1
}
local var_0_2 = {
	mark = 1,
	cache = 1
}
local var_0_3 = {}

function var_0_2.scan(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_0.mark[arg_1_1] then
		return
	end

	local var_1_0 = arg_1_0.mark

	var_1_0[arg_1_1] = true
	pairs = var_1_0

	for iter_1_0, iter_1_1 in var_1_0(arg_1_1) do
		type = var_1_10008

		if var_1_10008(iter_1_0) == "string" then
			type = var_1_10008

			if var_1_10008(iter_1_1) == "function" then
				var_1_10008 = iter_1_0

				if arg_1_2 then
					var_1_10008 = arg_1_2 .. "." .. var_1_10008
				end

				if not var_0_1[var_1_10008] and iter_1_0 ~= "__index" and iter_1_0 ~= "__newindex" then
					arg_1_0.cache[iter_1_1] = {
						id = -1,
						name = var_1_10008
					}
				end
			else
				type = var_1_10008

				if var_1_10008(iter_1_1) == "table" and not arg_1_0.mark[iter_1_1] then
					arg_1_0:scan(iter_1_1, iter_1_0)
				end
			end

			goto label_1_0
		end

		if arg_1_2 then
			tolua = var_1_10008

			if iter_1_0 ~= var_1_10008.gettag then
				tolua = var_1_10008

				if iter_1_0 == var_1_10008.settag then
					arg_1_0:scan(iter_1_1, arg_1_2)
				end

				::label_1_0::
			end
		end
	end

	return
end

function var_0_2.scanlibs(arg_2_0)
	package = var_1_10001

	local var_2_0 = var_1_10001.loaded
	local var_2_1 = arg_2_0.mark

	var_2_1[var_2_0] = true
	pairs = var_2_1

	for iter_2_0, iter_2_1 in var_2_1(var_2_0) do
		type = var_1_10007

		if var_1_10007(iter_2_0) == "string" then
			type = var_1_10007

			if var_1_10007(iter_2_1) == "table" then
				arg_2_0:scan(iter_2_1, iter_2_0)

				getmetatable = var_1_10007

				if var_1_10007(iter_2_1) then
					arg_2_0:scan(var_1_10007, iter_2_0)
				end
			end
		end
	end

	return
end

local function var_0_4(arg_3_0)
	local var_3_0 = #var_0_3 + 1

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(var_0_3) do
		if iter_3_1 == arg_3_0 then
			var_3_0 = iter_3_0
		end
	end

	return var_3_0
end

local function var_0_5(arg_4_0)
	local var_4_0 = #var_0_3

	if 0 < var_4_0 then
		debug = var_2

		if var_2.getinfo(5, "f") then
			local var_4_1 = var_2.func
			local var_4_3

			if var_4_0 < var_0_4(var_4_1) then
				debug = var_5

				if var_5.getinfo(6, "f") then
					local var_4_2 = var_2.func

					var_4_3 = var_0_4(var_4_2) or var_4_3
				end
			end

			for iter_4_0 = var_4_3 + 1, var_4_0 do
				table = var_1_10009

				var_1_10009.remove(var_0_3)
				var_0_10000.EndSample()
			end
		end
	end

	return
end

local function var_0_6(arg_5_0, arg_5_1, arg_5_2)
	var_0_5()

	table = var_3

	var_3.insert(var_0_3, arg_5_1)

	if arg_5_2.id == -1 then
		arg_5_2.name = arg_5_0
		arg_5_2.id = var_0_10000.GetID(arg_5_0)
	end

	var_0_10000.BeginSample(arg_5_2.id)

	return
end

local function var_0_7(arg_6_0, arg_6_1, arg_6_2)
	var_0_5()

	table = var_3

	var_3.insert(var_0_3, arg_6_1)

	local var_6_0 = -1

	if arg_6_2.nick == nil then
		arg_6_2.nick = {}
	end

	local var_6_1

	if not arg_6_2.nick[arg_6_0] then
		var_6_1 = var_0_10000.GetID(arg_6_0)
		arg_6_2.nick[arg_6_0] = var_6_1
	end

	var_0_10000.BeginSample(var_6_1)

	return
end

local function var_0_8(arg_7_0, arg_7_1)
	if arg_7_0 == "call" then
		local var_7_0

		debug = var_1_10003
		var_1_10003 = var_1_10003.getinfo(2, "f").func

		if var_0_2.cache[var_1_10003] then
			var_7_0 = var_7_6.name
		end

		if var_0_1[var_7_0] then
			return
		end

		local var_7_1

		if var_7_0 == "event.__call" then
			debug = var_7_1
			var_7_1 = var_7_1.getinfo(2, "n")

			local var_7_2 = var_0_7
			local var_7_3

			if not var_7_1.name then
				var_7_3 = var_7_0
			end

			var_7_2(var_7_3, var_1_10003, var_7_6)
		elseif var_7_0 then
			var_0_6(var_7_0, var_1_10003, var_7_6)
		else
			debug = var_7_1

			local var_7_4 = var_7_1.getinfo(2, "Sn").name
			local var_7_5 = var_5.linedefined
			local var_7_6

			if not var_7_6 then
				var_7_6 = {
					id = -1,
					name = "unknow"
				}
				var_0_2.cache[var_1_10003] = var_7_6
			end

			if var_5.short_src == "[C]" then
				if var_7_4 == "__index" or var_7_4 == "__newindex" then
					return
				end

				tostring = var_8

				local var_7_7 = var_8(var_1_10003)

				if not var_8.match(var_7_7, "function: builtin#(%d+)") then
					if var_7_4 then
						local var_7_8 = var_7_4

						var_0_6(var_7_4, var_1_10003, var_7_6)
					elseif var_7_5 ~= -1 then
						local var_7_9 = var_5.short_src .. var_7_5

						var_0_6(var_7_9, var_1_10003, var_7_6)
					end
				else
					local var_7_10 = var_0_10001.ffnames

					tonumber = var_11

					local var_7_11 = var_7_10[var_11(var_1_10009)]

					if not var_0_1[var_7_11] then
						var_0_6(var_7_11, var_1_10003, var_7_6)
					end
				end
			elseif var_7_5 ~= -1 or var_7_4 then
				local var_7_12 = var_5.short_src

				var_7_4 = var_7_4 or var_7_5
				var_1_10009 = nil

				if not var_7_12:match("([^/\\]+)%.%w+$") then
					var_1_10009 = var_7_12:match("([^/\\]+)$")
				end

				if var_0_0[var_1_10009] then
					var_1_10009 = var_10[var_7_5]
				else
					var_1_10009 = var_1_10009 .. "." .. var_7_4
				end

				var_1_10009 = var_1_10009 or var_7_12 .. "." .. var_7_4

				var_0_6(var_1_10009, var_1_10003, var_7_6)
			else
				var_0_6(var_7_0, var_1_10003, var_7_6)
			end
		end
	elseif arg_7_0 == "return" then
		if #var_0_3 == 0 then
			return
		end

		debug = var_1_10003

		if var_1_10003.getinfo(2, "f").func == var_0_3[var_2] then
			table = var_4

			var_4.remove(var_0_3)
			var_0_10000.EndSample()
		else
			if var_2 < var_0_4(var_3.func) then
				return
			end

			for iter_7_0 = var_4, var_2 do
				table = var_1_10009

				var_1_10009.remove(var_0_3)
				var_0_10000.EndSample()
			end
		end
	end

	return
end

local var_0_9 = profiler_hook

function var_0_2.start(arg_8_0)
	arg_8_0.mark = {}
	arg_8_0.cache = {
		__mode = "k"
	}

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.scan

	_G = var_1_10003

	var_8_1(var_8_0, var_1_10003, nil)

	local var_8_2 = arg_8_0

	arg_8_0.scanlibs(var_8_2)

	arg_8_0.mark = nil
	debug = var_1

	local var_8_3 = var_1.sethook

	profiler_hook = var_8_2

	var_8_3(var_8_2, "cr", 0)

	return
end

function var_0_2.print(arg_9_0)
	pairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.cache) do
		print = var_1_10006

		var_1_10006(iter_9_1.name)
	end

	return
end

function var_0_2.stop(arg_10_0)
	debug = var_1_10001

	var_1_10001.sethook(nil)

	arg_10_0.cache = nil

	return
end

return var_0_2
