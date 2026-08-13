class = var_0_10000

local var_0_0 = "FleetRenameCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.name

	getProxy = var_1_10005
	FleetProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	if not var_5.getFleetById(var_1_2, var_1_0) then
		pg = var_1_10007

		local var_1_3 = var_1_10007.TipsMgr.GetInstance()

		var_1_10007 = var_1_10007.ShowTips
		i18n = var_1_10010

		var_1_10007(var_1_3, var_1_10010("fleet_error_no_fleet"))

		return
	end

	nameValidityCheck = var_1_10007

	if not var_1_10007(var_1_1, 2, 24, {
		"spece_illegal_tip",
		"login_newPlayerScene_name_tooShort",
		"login_newPlayerScene_name_tooLong",
		"playerinfo_mask_word"
	}) then
		return
	end

	pg = var_7

	local var_1_4 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 12104, {
		id = var_1_0,
		name = var_1_1
	}, 12105, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_2.renameFleet(var_2_0, var_1_0, var_1_1)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004

			var_2_2(var_2_1, var_2_10004.RENAME_FLEET_DONE)
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_4(var_2_3, var_2_10004[arg_2_0.result])
		end

		return
	end)

	return
end

return var_0_1
