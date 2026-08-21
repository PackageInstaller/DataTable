local var_0_0 = class("Dorm3dInsPhoneOpCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if not _.detect(getProxy(Dorm3dInsProxy):GetPhoneListByGroup(var_1_0.groupId), function(arg_2_0)
		return arg_2_0.id == var_1_0.id
	end) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(28026, {
		type = 2,
		ship_id = var_1_0.groupId,
		id_list = {
			var_1_0.id
		}
	}, 28027, function(arg_3_0)
		if arg_3_0.result == 0 then
			var_0:MarkRead()
			arg_1_0:sendNotification(GAME.DORM3D_INS_PHONE_OP_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

return var_0_0
