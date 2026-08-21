local var_0_0 = class("CommanderChangeCatteryStyleCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.styleId
	local var_1_2 = getProxy(CommanderProxy):GetCommanderHome()

	if not var_1_2 then
		return
	end

	local var_1_3 = var_1_2:GetCatteryById(var_1_0.id)

	if not var_1_3 then
		return
	end

	if var_1_3:GetStyle() == var_1_0.styleId then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(25032, {
		slotidx = var_1_0.id,
		styleidx = var_1_0.styleId
	}, 25033, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:UpdateStyle(var_1_1)
			pg.TipsMgr.GetInstance():ShowTips(i18n("cattery_style_change_success"))
			arg_1_0:sendNotification(GAME.COMMANDER_CHANGE_CATTERY_STYLE_DONE, {
				id = var_1_3.id
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
