local var_0_0 = class("ZanShipEvaCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(17105, {
		ship_group_id = var_1_0.groupId,
		discuss_id = var_1_0.evaId,
		good_or_bad = var_1_0.operation
	}, 17106, function(arg_2_0)
		local var_2_0 = getProxy(CollectionProxy)
		local var_2_1 = var_2_0:getShipGroup(var_0)
		local var_2_2

		if var_2_1 then
			if var_2_1.evaluation then
				var_2_2 = _.detect(var_2_1.evaluation.evas, function(arg_3_0)
					return arg_3_0.id == var_0
				end)
			end
		end

		if arg_2_0.result == 0 then
			if var_2_2 then
				if var_0 == 0 then
					var_2_2.good_count = var_2_2.good_count + 1
				elseif var_0 == 1 then
					var_2_2.bad_count = var_2_2.bad_count + 1
				end

				var_2_2.izan = true

				var_2_1.evaluation:sortEvas()
				var_2_0:updateShipGroup(var_2_1)
				arg_1_0:sendNotification(CollectionProxy.GROUP_EVALUATION_UPDATE, var_0)
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("zan_ship_eva_success"))
		elseif arg_2_0.result == 7 then
			if var_2_2 then
				var_2_2.izan = true

				var_2_0:updateShipGroup(var_2_1)
				arg_1_0:sendNotification(CollectionProxy.GROUP_EVALUATION_UPDATE, var_0)
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("zan_ship_eva_error_7"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("zan_ship_eva", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
