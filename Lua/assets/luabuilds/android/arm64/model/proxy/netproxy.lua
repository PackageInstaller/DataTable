local var_0_0 = class("NetProxy", pm.Proxy)

function var_0_0.onRegister(arg_1_0)
	arg_1_0.event = {}

	arg_1_0:register()

	return
end

function var_0_0.register(arg_2_0)
	return
end

function var_0_0.on(arg_3_0, arg_3_1, arg_3_2)
	pg.ConnectionMgr.GetInstance():On(arg_3_1, function(arg_4_0)
		arg_3_2(arg_4_0)

		return
	end)
	table.insert(arg_3_0.event, arg_3_1)

	return
end

function var_0_0.onRemove(arg_5_0)
	arg_5_0:remove()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.event) do
		pg.ConnectionMgr.GetInstance():Off(iter_5_1)
	end

	return
end

function var_0_0.remove(arg_6_0)
	return
end

function var_0_0.getRawData(arg_7_0)
	return arg_7_0.data
end

function var_0_0.getData(arg_8_0)
	return Clone(arg_8_0.data)
end

function var_0_0.timeCall(arg_9_0)
	return {}
end

return var_0_0
