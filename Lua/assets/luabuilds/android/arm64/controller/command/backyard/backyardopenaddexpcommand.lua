local var_0_0 = class("BackYardOpenAddExpCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if var_1_0 == 1 then
		getProxy(DormProxy):OnEnterBackyard()
	elseif var_1_0 == 0 then
		getProxy(DormProxy):OnExitBackyard()
	end

	return
end

return var_0_0
