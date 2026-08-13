class = var_0_10000

local var_0_0 = var_0_10000("IslandBaseMonitor")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.island = arg_1_1

	arg_1_0:onRegister()

	return
end

function var_0_0.emitCore(arg_2_0, arg_2_1, ...)
	local var_2_0 = arg_2_0:GetIsland()
	local var_2_1 = var_2.DispatchEvent

	IslandProxy = var_1_10005

	var_2_1(var_2_0, var_1_10005.LINK_CORE, arg_2_1, ...)

	return
end

function var_0_0.GetIsland(arg_3_0)
	return arg_3_0.island
end

function var_0_0.IsCurrentIsland(arg_4_0, arg_4_1)
	return arg_4_0.island.id == arg_4_1
end

function var_0_0.onRegister(arg_5_0)
	arg_5_0.event = {}

	arg_5_0:register()

	return
end

function var_0_0.on(arg_6_0, arg_6_1, arg_6_2)
	pg = var_1_10003

	local var_6_0 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.On(var_6_0, arg_6_1, function(arg_7_0)
		arg_6_2(arg_7_0)

		return
	end)

	table = var_3

	var_3.insert(arg_6_0.event, arg_6_1)

	return
end

function var_0_0.onRemove(arg_8_0)
	arg_8_0:remove()

	ipairs = var_1

	for iter_8_0, iter_8_1 in var_1(arg_8_0.event) do
		pg = var_1_10006

		local var_8_0 = var_1_10006.ConnectionMgr.GetInstance()

		var_1_10006.Off(var_8_0, iter_8_1)
	end

	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:onRemove()

	return
end

function var_0_0.register(arg_10_0)
	return
end

function var_0_0.remove(arg_11_0)
	return
end

return var_0_0
