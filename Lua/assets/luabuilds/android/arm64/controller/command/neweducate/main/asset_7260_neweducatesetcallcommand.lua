local NewEducateSetCallCommand = class("NewEducateSetCallCommand", pm.SimpleCommand)

function NewEducateSetCallCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.name

	pg.ConnectionMgr.GetInstance():Send(29009, {
		id = var_1_0.id,
		name = var_1_0.name
	}, 29010, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(NewEducateProxy):GetCurChar():SetCallName(var_1_1)
			self:sendNotification(GAME.NEW_EDUCATE_SET_CALL_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_SetCall: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateSetCallCommand
