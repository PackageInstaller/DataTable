local var_0_0 = class("NewTrackingCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.para1 or ""
	local var_1_2 = var_1_0.para2 or ""
	local var_1_3 = var_1_0.para3 or ""

	print(var_1_0.type, var_1_0.eventId, var_1_1, var_1_2)
	pg.ConnectionMgr.GetInstance():Send(10992, {
		track_type = var_1_0.type,
		event_id = var_1_0.eventId,
		para1 = var_1_1,
		para2 = var_1_2,
		para3 = var_1_3
	})

	return
end

return var_0_0
