local var_0_0 = require("cjson")
local var_0_1 = class("profiler")
local var_0_2 = {}
local var_0_3

function var_0_1.Start()
	for iter_1_0, iter_1_1 in pairs(_G) do
		local var_1_0, var_1_1 = string.find(iter_1_0, "Tools")

		if type(iter_1_1) == "table" and rawget(iter_1_1, "__ctype") ~= nil and iter_1_1.__ctype == 2 then
			if var_0_1.InstanceOf(iter_1_1, "BaseView") then
				iter_1_1.New = var_0_1.OverrideConstructor(iter_1_1.New)
			end
		elseif type(iter_1_1) == "table" and rawget(iter_1_1, "_singletonInstance") ~= nil and iter_1_1._singletonInstance ~= nil then
			iter_1_1.GetInstance = var_0_1.OverrideConstructor(iter_1_1.GetInstance)
		elseif var_1_0 and type(iter_1_1) == "table" then
			local var_1_2 = iter_1_1

			for iter_1_2, iter_1_3 in pairs(var_1_2) do
				if type(iter_1_3) == "function" then
					var_1_2[iter_1_2] = var_0_1.ProfilerDecorator(var_1_2[iter_1_2], iter_1_0 .. ":" .. iter_1_2)
				end
			end
		elseif type(iter_1_1) == "function" and iter_1_0 ~= "unpack" and iter_1_0 ~= "import" and iter_1_0 ~= "require" and iter_1_0 ~= "module" and iter_1_0 ~= "setmetatable" and iter_1_0 ~= "getmetatable" and iter_1_0 ~= "clone" then
			_G[iter_1_0] = var_0_1.ProfilerDecorator(iter_1_1, iter_1_0)
		end
	end

	var_0_3 = os.clock()
end

function var_0_1.GetStatJson()
	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in pairs(var_0_2) do
		table.insert(var_2_1, iter_2_1)
	end

	local var_2_2 = {
		infos = var_2_1,
		seconds = math.floor(os.clock() - (var_0_3 or 0))
	}

	return (var_0_0.encode(var_2_2))
end

function var_0_1.Reset()
	var_0_2 = {}
	var_0_3 = os.clock()
end

function var_0_1.OverrideConstructor(arg_4_0)
	return function(...)
		local var_5_0 = arg_4_0(...)

		for iter_5_0, iter_5_1 in pairs(getmetatable(var_5_0).__index) do
			if type(iter_5_1) == "function" then
				var_5_0[iter_5_0] = var_0_1.ProfilerDecorator(var_5_0[iter_5_0], var_5_0.class.__cname .. ":" .. iter_5_0)
			end
		end

		return var_5_0
	end
end

function var_0_1.ProfilerDecorator(arg_6_0, arg_6_1)
	return function(...)
		local var_7_0 = os.clock()
		local var_7_1 = {
			arg_6_0(...)
		}
		local var_7_2 = (os.clock() - var_7_0) * 1000

		if not var_0_2[arg_6_1] then
			var_0_2[arg_6_1] = {
				time = 0,
				count = 0,
				name = arg_6_1,
				firstTime = var_7_2
			}
		end

		var_0_2[arg_6_1].count = var_0_2[arg_6_1].count + 1
		var_0_2[arg_6_1].time = var_0_2[arg_6_1].time + var_7_2

		return unpack(var_7_1)
	end
end

function var_0_1.InstanceOf(arg_8_0, arg_8_1)
	while arg_8_0 do
		if arg_8_0.__cname == arg_8_1 then
			return true
		end

		arg_8_0 = arg_8_0.super
	end

	return false
end

return var_0_1
