class = var_0_10000

local var_0_0 = "RenameCommanderCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().commanderId
	local var_1_1 = var_2.name

	getProxy = var_1_10005
	CommanderProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if not var_5.getCommanderById(var_1_2, var_1_0) then
		return
	end

	if not var_6:canModifyName() then
		return
	end

	if not var_1_1 or var_1_1 == "" then
		return
	end

	if var_6:getName() == var_1_1 then
		return
	end

	nameValidityCheck = var_7

	if not var_7(var_1_1, 0, 20, {
		"spece_illegal_tip",
		"login_newPlayerScene_name_tooShort",
		"login_newPlayerScene_name_tooLong",
		"playerinfo_mask_word"
	}) then
		return
	end

	pg = var_7

	local var_1_3 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_3, 25020, {
		commanderid = var_1_0,
		name = var_1_1
	}, 25021, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1.setName(var_2_0, var_1_1)

			pg = var_2_1
			var_2_1 = var_2_1.gameset.commander_rename_coldtime.key_value
			pg = var_2_0
			var_2_10003 = var_2_0.TimeMgr.GetInstance()

			local var_2_2 = var_2.GetServerTime(var_2_10003) + var_2_1
			local var_2_3 = var_0

			var_2_10003.setRenameTime(var_2_3, var_2_2)

			local var_2_4 = var_0

			var_2_10003.updateCommander(var_2_4, var_0)

			local var_2_5 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_5

			var_2_10003(var_2_5, var_5.COMMANDER_RENAME_DONE, {
				id = var_0.id,
				name = var_1_1
			})
		else
			pg = var_2_1

			local var_2_6 = var_2_1.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			i18n = var_2_10003

			var_2_7(var_2_6, var_2_10003("rename_commander_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
