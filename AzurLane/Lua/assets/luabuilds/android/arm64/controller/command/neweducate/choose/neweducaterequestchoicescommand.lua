local var_0_0 = class("NewEducateRequestChoicesCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(29107, {
		id = var_1_0.id
	}, 29108, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(NewEducateProxy):GetCurChar():GetFSM():GetPriorityState():UpdataData(arg_2_0.cache)
			existCall(var_1_1)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_RequestChoice_Error: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
