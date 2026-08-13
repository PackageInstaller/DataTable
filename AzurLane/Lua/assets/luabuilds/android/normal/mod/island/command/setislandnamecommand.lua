class = var_0_10000

local var_0_0 = "SetIslandNameCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().name
	local var_1_1 = var_2.currency

	getProxy = var_1_10005
	IslandProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.GetIsland(var_1_2)

	if not var_5.CanModifyName(var_1_3) then
		return
	end

	nameValidityCheck = var_6

	if not var_6(var_1_0, 1, 18, {
		"island_name_exist_special_word",
		"island_name_too_long_or_too_short",
		"island_name_too_long_or_too_short",
		"island_name_exist_ban_word"
	}) then
		return
	end

	local var_1_5

	if var_1_1 == 2 then
		pg = var_1_5

		local var_1_4 = var_1_5.MsgboxMgr.GetInstance()

		var_1_5 = var_1_5.ShowMsgBox

		local var_1_6 = {}

		i18n = var_9
		var_1_6.content = var_9("island_rename_tip")

		function var_1_6.onYes()
			local var_2_0 = arg_1_0

			var_0.Send(var_2_0, var_1_0, var_1_1)

			return
		end

		var_1_5(var_1_4, var_1_6)
	else
		pg = var_1_5

		local var_1_7 = var_1_5.MsgboxMgr.GetInstance()
		local var_1_8 = var_6.ShowMsgBox
		local var_1_9 = {}

		i18n = var_9
		var_1_9.content = var_9("island_rename_confirm", var_1_0)

		function var_1_9.onYes()
			local var_3_0 = arg_1_0

			var_0.Send(var_3_0, var_1_0, var_1_1)

			return
		end

		var_1_8(var_1_7, var_1_9)
	end

	return
end

function var_0_1.Send(arg_4_0, arg_4_1, arg_4_2)
	pg = var_1_10003

	local var_4_0 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_4_0, 21004, {
		name = arg_4_1,
		type = arg_4_2
	}, 21005, function(arg_5_0)
		if arg_5_0.ret == 0 then
			getProxy = var_1
			IslandProxy = var_2_10002

			local var_5_0 = var_1(var_2_10002)

			var_2_10003 = var_1.GetIsland(var_5_0)

			if not var_1.IsNew(var_2_10003) then
				-- block empty
			end

			var_2_10003 = var_1

			var_1.SetName(var_2_10003, arg_4_1)

			var_2_10003 = arg_4_0

			local var_5_1 = var_2.sendNotification

			GAME = var_4

			var_5_1(var_2_10003, var_4.ISLAND_SET_NAME_DONE, {
				name = arg_4_1
			})
		else
			pg = var_1

			local var_5_2 = var_1.TipsMgr.GetInstance()
			local var_5_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_5_3(var_5_2, var_2_10003[arg_5_0.ret] .. arg_5_0.ret)
		end

		return
	end)

	return
end

return var_0_1
