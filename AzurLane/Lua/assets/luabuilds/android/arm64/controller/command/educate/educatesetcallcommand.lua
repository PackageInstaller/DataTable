local var_0_0 = class("EducateSetCallCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(27031, {
		name = var_1_0.name
	}, 27032, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(EducateProxy):GetCharData():SetCallName(var_1_0.name)
			arg_1_0:sendNotification(GAME.EDUCATE_SET_CALL_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate set call name error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
