local var_0_0 = class("LikeShipCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(17107, {
		ship_group_id = arg_1_1:getBody()
	}, 17108, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(CollectionProxy)
			local var_2_1 = var_2_0:getShipGroup(var_0)

			if var_2_1 then
				var_2_1.iheart = true
				var_2_1.hearts = var_2_1.hearts + 1
				var_2_1.evaluation.hearts = var_2_1.evaluation.hearts + 1

				var_2_0:updateShipGroup(var_2_1)
				arg_1_0:sendNotification(CollectionProxy.GROUP_INFO_UPDATE, var_0)
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("like_ship_success"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("like_ship", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
