local var_0_0 = {}
local var_0_1 = DispatcherManager.getDispatcher(DispatcherManager.getNewId())

function var_0_0.addEventListener(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1:addEventListener(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.removeEventListener(arg_2_0, arg_2_1, arg_2_2)
	var_0_1:removeEventListener(arg_2_0, arg_2_1, arg_2_2)
end

function var_0_0.dispatchEvent(arg_3_0, ...)
	var_0_1:dispatchEvent(arg_3_0, ...)
end

function var_0_0.hasEventListener(arg_4_0)
	var_0_1:hasEventListener(arg_4_0)
end

function var_0_0.clear()
	var_0_1:clear()
end

function var_0_0.__newindex(arg_6_0, arg_6_1, arg_6_2)
	error("[Dispatcher] Can't create new property or function!")
end

return var_0_0
