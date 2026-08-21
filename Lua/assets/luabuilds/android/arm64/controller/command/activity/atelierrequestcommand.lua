local var_0_0 = class("AtelierRequestCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(26051, {
		act_id = arg_1_1.body
	}, 26052, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(ActivityProxy):getActivityById(var_0)

			var_2_0:InitItems(arg_2_0.items)
			var_2_0:InitFormulaUseCounts(arg_2_0.recipes)
			var_2_0:UpdateBuffSlots(arg_2_0.slots)
			getProxy(ActivityProxy):updateActivity(var_2_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
