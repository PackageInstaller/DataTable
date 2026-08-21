local var_0_0 = class("IslandBaseMonitor")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.island = arg_1_1

	arg_1_0:onRegister()

	return
end

function var_0_0.emitCore(arg_2_0, arg_2_1, ...)
	arg_2_0:GetIsland():DispatchEvent(IslandProxy.LINK_CORE, arg_2_1, ...)

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
	pg.ConnectionMgr.GetInstance():On(arg_6_1, function(arg_7_0)
		arg_6_2(arg_7_0)

		return
	end)
	table.insert(arg_6_0.event, arg_6_1)

	return
end

function var_0_0.onRemove(arg_8_0)
	arg_8_0:remove()

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.event) do
		pg.ConnectionMgr.GetInstance():Off(iter_8_1)
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
