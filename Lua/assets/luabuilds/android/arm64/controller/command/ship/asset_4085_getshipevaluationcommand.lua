local GetShipEvaluationCommand = class("GetShipEvaluationCommand", pm.SimpleCommand)

function GetShipEvaluationCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId

	pg.ConnectionMgr.GetInstance():Send(31, {
		shipId = var_1_0
	}, 31, function(arg_2_0)
		if arg_2_0.result == 0 then
			self:sendNotification(GAME.GET_SHIP_EVALUATION_DONE, (getProxy(BayProxy):getShipById(var_1_0)))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("get_ship_evaluation", arg_2_0.result))
		end

		return
	end)

	return
end

return GetShipEvaluationCommand
