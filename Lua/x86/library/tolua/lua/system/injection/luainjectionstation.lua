local var_0_0 = pcall
local var_0_1 = pairs
local var_0_2 = error
local var_0_3 = rawset
local var_0_4 = rawget
local var_0_5 = string
local var_0_6 = tolua_tag
local var_0_7 = getmetatable
local var_0_8
local var_0_9 = require("System.Injection.InjectionBridgeInfo")

local function var_0_10(arg_1_0)
	local var_1_0 = var_0_7(arg_1_0)

	if var_0_4(var_1_0, var_0_6) ~= 1 then
		var_0_2("Can't Inject")
	end

	return var_1_0
end

local function var_0_11()
	if var_0_8 == nil then
		var_0_8 = LuaInterface.LuaInjectionStation
	end
end

local function var_0_12(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.__index
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in var_0_1(arg_3_1) do
		local var_3_2, var_3_3 = iter_3_1()

		if var_3_3 == LuaInterface.InjectType.Replace or var_3_3 == LuaInterface.InjectType.ReplaceWithPostInvokeBase or var_3_3 == LuaInterface.InjectType.ReplaceWithPreInvokeBase then
			var_0_3(var_3_1, iter_3_0, var_3_2)
		end
	end

	function arg_3_0.__index(arg_4_0, arg_4_1)
		local var_4_0 = var_0_4(var_3_1, arg_4_1)

		if var_4_0 ~= nil then
			return var_4_0
		end

		local var_4_1, var_4_2 = var_0_0(var_3_0, arg_4_0, arg_4_1)

		if var_4_1 then
			return var_4_2
		else
			var_0_2(var_4_2)

			return nil
		end
	end
end

function InjectByModule(arg_5_0, arg_5_1)
	local var_5_0 = var_0_10(arg_5_0)
	local var_5_1 = var_5_0[".name"]

	InjectByName(var_5_1, arg_5_1)
	var_0_12(var_5_0, arg_5_1)
end

function InjectByName(arg_6_0, arg_6_1)
	var_0_11()

	local var_6_0 = var_0_4(var_0_9, arg_6_0)

	if var_6_0 == nil then
		var_0_2(var_0_5.format("Module %s Can't Inject", arg_6_0))
	end

	for iter_6_0, iter_6_1 in var_0_1(arg_6_1) do
		local var_6_1, var_6_2 = iter_6_1()
		local var_6_3 = var_0_4(var_6_0, iter_6_0)

		if var_6_3 == nil then
			var_0_2(var_0_5.format("Function %s Doesn't Exist In Module %s", iter_6_0, arg_6_0))
		end

		var_0_8.CacheInjectFunction(var_6_3, var_6_2:ToInt(), var_6_1)
	end
end

require("System.Injection.LuaInjectionBus")
