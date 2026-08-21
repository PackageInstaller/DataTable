local var_0_0 = class("RenameCommanderCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.name
	local var_1_2 = getProxy(CommanderProxy)
	local var_1_3 = getProxy(CommanderProxy):getCommanderById(var_1_0.commanderId)

	if not var_1_3 then
		return
	end

	if not var_1_3:canModifyName() then
		return
	end

	if not var_1_0.name or var_1_0.name == "" then
		return
	end

	if var_1_3:getName() == var_1_0.name then
		return
	end

	if not nameValidityCheck(var_1_0.name, 0, 20, {
		"spece_illegal_tip",
		"login_newPlayerScene_name_tooShort",
		"login_newPlayerScene_name_tooLong",
		"playerinfo_mask_word"
	}) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(25020, {
		commanderid = var_1_0.commanderId,
		name = var_1_0.name
	}, 25021, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:setName(var_1_1)
			var_1_3:setRenameTime(pg.TimeMgr.GetInstance():GetServerTime() + pg.gameset.commander_rename_coldtime.key_value)
			var_1_2:updateCommander(var_1_3)
			arg_1_0:sendNotification(GAME.COMMANDER_RENAME_DONE, {
				id = var_1_3.id,
				name = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("rename_commander_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
