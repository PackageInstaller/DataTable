local var_0_0 = class("SetCommanderPrefabFleetNameCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.name
	local var_1_3 = var_1_0.onFailed
	local var_1_4 = getProxy(CommanderProxy):getPrefabFleetById(var_1_0.id)

	if var_1_4:getName() == var_1_0.name or var_1_0.name == "" then
		if var_1_0.onFailed then
			var_1_0.onFailed()
		end

		pg.TipsMgr.GetInstance():ShowTips(i18n("login_newPlayerScene_name_tooShort"))

		return
	end

	local var_1_5, var_1_6 = var_1_4:canRename()

	if not var_1_5 then
		pg.TipsMgr.GetInstance():ShowTips(var_1_6)

		if var_1_0.onFailed then
			var_1_0.onFailed()
		end

		return
	end

	if not nameValidityCheck(var_1_0.name, 0, 12, {
		"spece_illegal_tip",
		"login_newPlayerScene_name_tooShort",
		"login_newPlayerScene_name_tooLong",
		"playerinfo_mask_word"
	}) then
		if var_1_0.onFailed then
			var_1_0.onFailed()
		end

		return
	end

	pg.ConnectionMgr.GetInstance():Send(25024, {
		id = var_1_0.id,
		name = var_1_0.name
	}, 25025, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(CommanderProxy):updatePrefabFleetName(var_1_1, var_1_2)
			arg_1_0:sendNotification(GAME.SET_COMMANDER_PREFAB_NAME_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_prefab_rename_success"))
		else
			if var_1_3 then
				var_1_3()
			end

			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result])
		end

		return
	end)

	return
end

return var_0_0
