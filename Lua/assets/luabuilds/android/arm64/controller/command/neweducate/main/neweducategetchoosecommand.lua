local var_0_0 = class("NewEducateGetChooseCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(29126, {
		id = var_1_0.id
	}, 29127, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(NewEducateProxy):GetCurChar():InitFSM(arg_2_0.fsm)
			existCall(var_1_1)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_GetChoose: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
