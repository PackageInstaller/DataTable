local var_0_0 = class("Proxy", (import("..observer.Notifier")))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 ~= nil then
		arg_1_0:setData(arg_1_1)
	end

	local var_1_0

	if not arg_1_2 then
		::label_1_0::

		var_1_0 = arg_1_0.__cname or var_0_0.NAME
	end

	arg_1_0.proxyName = var_1_0

	return
end

var_0_0.NAME = "Proxy"

function var_0_0.getProxyName(arg_2_0)
	return arg_2_0.proxyName
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0.data = arg_3_1

	return
end

function var_0_0.getData(arg_4_0)
	return arg_4_0.data
end

function var_0_0.onRegister(arg_5_0)
	return
end

function var_0_0.onRemove(arg_6_0)
	return
end

return var_0_0
