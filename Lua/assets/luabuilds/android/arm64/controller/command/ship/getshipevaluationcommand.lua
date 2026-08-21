local var_0_0 = class("GetShipEvaluationCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(31, {
		shipId = arg_1_1:getBody().shipId
	}, 31, function(arg_2_0)
		if arg_2_0.result == 0 then
			arg_1_0:sendNotification(GAME.GET_SHIP_EVALUATION_DONE, (getProxy(BayProxy):getShipById(var_0)))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("get_ship_evaluation", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
