local EventFlushCommand = class("EventFlushCommand", pm.SimpleCommand)

function EventFlushCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(13009, {
		type = 0
	}, 13010, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(EventProxy):updateAll(arg_2_0.collection_list)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("event_flush_fail", arg_2_0.result))
		end

		return
	end)

	return
end

return EventFlushCommand
