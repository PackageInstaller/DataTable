pcall = var_0_10000
pairs = var_0_10001
error = var_0_10002
rawset = var_0_10003
rawget = var_0_10004
string = var_0_10005
tolua_tag = var_0_10006
getmetatable = var_0_10007

local var_0_0

require = var_0_10009

local var_0_1 = var_0_10009("Framework.tolua.System.Injection.InjectionBridgeInfo")

local function var_0_2(arg_1_0)
	local var_1_0 = var_0_10007(arg_1_0)

	if var_0_10004(var_1_0, var_0_10006) ~= 1 then
		var_0_10002("Can't Inject")
	end

	return var_1_0
end

local function var_0_3()
	if var_0_0 == nil then
		LuaInterface = var_0
		var_0_0 = var_0.LuaInjectionStation
	end

	return
end

local function var_0_4(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.__index
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in var_0_10001(arg_3_1) do
		local var_3_2, var_3_3 = iter_3_1()

		LuaInterface = var_1_10011

		if var_3_3 ~= var_1_10011.InjectType.Replace then
			LuaInterface = var_1_10011

			if var_3_3 ~= var_1_10011.InjectType.ReplaceWithPostInvokeBase then
				LuaInterface = var_1_10011

				if var_3_3 == var_1_10011.InjectType.ReplaceWithPreInvokeBase then
					var_0_10003(var_3_1, iter_3_0, var_3_2)
				end
			end
		end
	end

	function arg_3_0.__index(arg_4_0, arg_4_1)
		if var_0_10004(var_3_1, arg_4_1) ~= nil then
			return var_2
		end

		local var_4_0, var_4_1 = var_0_10000(var_3_0, arg_4_0, arg_4_1)

		if var_4_0 then
			return var_4_1
		else
			var_0_10002(var_4_1)

			return nil
		end

		return
	end

	return
end

local function var_0_5(arg_5_0, arg_5_1)
	local var_5_0 = var_0_2(arg_5_0)[".name"]

	InjectByName = var_4

	var_4(var_5_0, arg_5_1)
	var_0_4(var_2, arg_5_1)

	return
end

local var_0_6 = InjectByModule

local function var_0_7(arg_6_0, arg_6_1)
	var_0_3()

	if var_0_10004(var_0_1, arg_6_0) == nil then
		var_0_10002(var_0_10005.format("Module %s Can't Inject", arg_6_0))
	end

	for iter_6_0, iter_6_1 in var_0_10001(arg_6_1) do
		local var_6_0, var_6_1 = iter_6_1()

		if var_0_10004(var_2, iter_6_0) == nil then
			var_0_10002(var_0_10005.format("Function %s Doesn't Exist In Module %s", iter_6_0, arg_6_0))
		end

		var_0_0.CacheInjectFunction(var_10, var_6_1:ToInt(), var_6_0)
	end

	return
end

require = InjectByName

var_13("Framework.tolua.System.Injection.LuaInjectionBus")

return
