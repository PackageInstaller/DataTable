local EvaluateShipCommand = class("EvaluateShipCommand", pm.SimpleCommand)

function EvaluateShipCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.groupId

	pg.ConnectionMgr.GetInstance():Send(17103, {
		ship_group_id = var_1_0.groupId,
		context = var_1_0.content
	}, 17104, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(CollectionProxy)
			local var_2_1 = var_2_0:getShipGroup(var_1_1)

			if var_2_1 then
				var_2_1.evaluation = ShipEvaluation.New(arg_2_0.ship_discuss)

				var_2_0:updateShipGroup(var_2_1)
				self:sendNotification(CollectionProxy.GROUP_EVALUATION_UPDATE, var_1_1)
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("eva_ship_success"))
		elseif arg_2_0.result == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("report_ship_cannot_comment"))
		elseif arg_2_0.result == 2011 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("evaluate_too_loog"))
		elseif arg_2_0.result == 2013 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("evaluate_ban_word"))
		elseif arg_2_0.result == 40 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("report_cannot_comment_level_2"))
		elseif arg_2_0.result == 41 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("report_cannot_comment_level_1", arg_2_0.need_level))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("eva_ship", arg_2_0.result))
		end

		return
	end)

	return
end

return EvaluateShipCommand
