local NewEducateRequestCommand = class("NewEducateRequestCommand", pm.SimpleCommand)

function NewEducateRequestCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(29001, {
		id = var_1_0.id
	}, 29002, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(NewEducateProxy):UpdateChar(arg_2_0.tb, arg_2_0.permanent)
			existCall(var_1_1)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_Request: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateRequestCommand
