local var_0_0 = class("EventListener")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.listeners = {}
end

function var_0_0.Register(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:Remove(arg_2_1)

	arg_2_0.listeners[arg_2_1] = arg_2_2

	manager.notify:RegistListener(arg_2_1, arg_2_2)
end

function var_0_0.Remove(arg_3_0, arg_3_1)
	if arg_3_0.listeners[arg_3_1] then
		manager.notify:RemoveListener(arg_3_1, arg_3_0.listeners[arg_3_1])
	end
end

function var_0_0.RemoveAll(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.listeners) do
		manager.notify:RemoveListener(iter_4_0, iter_4_1)

		arg_4_0.listeners[iter_4_0] = nil
	end
end

return var_0_0
