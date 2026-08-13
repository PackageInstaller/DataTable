class = var_0_10000

local var_0_0 = "SetCommanderPrefabFleetNameCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.name
	local var_1_2 = var_2.onFailed

	getProxy = var_1_10006
	CommanderProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.getPrefabFleetById(var_1_3, var_1_0)

	if var_6.getName(var_1_4) == var_1_1 or var_1_1 == "" then
		if var_1_2 then
			var_1_2()
		end

		pg = var_7

		local var_1_5 = var_7.TipsMgr.GetInstance()
		local var_1_6 = var_7.ShowTips

		i18n = var_1_10010

		var_1_6(var_1_5, var_1_10010("login_newPlayerScene_name_tooShort"))

		return
	end

	local var_1_7 = var_6
	local var_1_8, var_1_9 = var_6.canRename(var_1_7)

	if not var_1_8 then
		pg = var_1_7

		local var_1_10 = var_1_7.TipsMgr.GetInstance()

		var_1_7.ShowTips(var_1_10, var_1_9)

		if var_1_2 then
			var_1_2()
		end

		return
	end

	nameValidityCheck = var_1_7

	if not var_1_7(var_1_1, 0, 12, {
		"spece_illegal_tip",
		"login_newPlayerScene_name_tooShort",
		"login_newPlayerScene_name_tooLong",
		"playerinfo_mask_word"
	}) then
		if var_1_2 then
			var_1_2()
		end

		return
	end

	pg = var_9

	local var_1_11 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_11, 25024, {
		id = var_1_0,
		name = var_1_1
	}, 25025, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			CommanderProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_1.updatePrefabFleetName(var_2_0, var_1_0, var_1_1)

			local var_2_1 = arg_1_0
			local var_2_2 = var_1.sendNotification

			GAME = var_2_10004

			var_2_2(var_2_1, var_2_10004.SET_COMMANDER_PREFAB_NAME_DONE)

			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			i18n = var_2_10004

			var_2_4(var_2_3, var_2_10004("commander_prefab_rename_success"))
		else
			if var_1_2 then
				var_1_2()
			end

			pg = var_1

			local var_2_5 = var_1.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_6(var_2_5, var_2_10004[arg_2_0.result])
		end

		return
	end)

	return
end

return var_0_1
