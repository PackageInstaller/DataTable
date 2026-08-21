local var_0_0 = class("FleetRenameCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.name
	local var_1_3 = getProxy(FleetProxy)

	if not getProxy(FleetProxy):getFleetById(var_1_0.id) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("fleet_error_no_fleet"))

		return
	end

	if not nameValidityCheck(var_1_0.name, 2, 24, {
		"spece_illegal_tip",
		"login_newPlayerScene_name_tooShort",
		"login_newPlayerScene_name_tooLong",
		"playerinfo_mask_word"
	}) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(12104, {
		id = var_1_0.id,
		name = var_1_0.name
	}, 12105, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:renameFleet(var_1_1, var_1_2)
			arg_1_0:sendNotification(GAME.RENAME_FLEET_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result])
		end

		return
	end)

	return
end

return var_0_0
