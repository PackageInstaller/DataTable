class = var_0_10000

local var_0_0 = "RenameShipCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.name

	getProxy = var_1_10005
	BayProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if not var_5.getShipById(var_1_2, var_1_0) then
		pg = var_1_2

		local var_1_3 = var_1_2.TipsMgr.GetInstance()
		local var_1_4 = var_7.ShowTips

		i18n = var_1_10009

		var_1_4(var_1_3, var_1_10009("ship_error_noShip", var_1_0))

		return
	end

	if var_6:isRemoulded() then
		pg = var_1_5

		local var_1_5

		if not var_1_5.ship_skin_template[var_6:getRemouldSkinId()].name then
			pg = var_1_5
			var_1_5 = var_1_5.ship_data_statistics[var_6.configId].name
		end

		local var_1_6 = var_6
		local var_1_7

		if var_6.getName(var_1_6) == var_1_1 then
			var_1_6 = arg_1_0
			var_1_7 = arg_1_0.sendNotification
			GAME = var_1_10010

			var_1_7(var_1_6, var_1_10010.RENAME_SHIP_DONE, {
				ship = var_6
			})

			return
		end

		if var_1_1 == "" then
			pg = var_1_7
			var_1_6 = var_1_7.TipsMgr.GetInstance()
			var_1_7 = var_1_7.ShowTips
			i18n = var_1_10010

			var_1_7(var_1_6, var_1_10010("login_createNewPlayer_error_nameNull"))

			return
		end

		if var_1_1 ~= var_1_5 then
			nameValidityCheck = var_1_7

			if not var_1_7(var_1_1, 0, 40, {
				"spece_illegal_tip",
				"login_newPlayerScene_name_tooShort",
				"ship_renameShip_error_2011",
				"playerinfo_mask_word"
			}) then
				return
			end
		end

		local function var_1_8()
			pg = var_2_10000

			local var_2_0 = var_2_10000.ConnectionMgr.GetInstance()

			var_0.Send(var_2_0, 12034, {
				ship_id = var_1_0,
				name = var_1_1 == var_1_5 and "" or var_1_1
			}, 12035, function(arg_3_0)
				local var_3_0

				if arg_3_0.result == 0 then
					var_3_0 = var_0
					var_3_0.name = var_1_1
					var_3_0 = var_0
					pg = var_2
					var_3_10003 = var_2.TimeMgr.GetInstance()
					var_3_0.renameTime = var_2.GetServerTime(var_3_10003)

					local var_3_1 = var_0

					var_3_0.updateShip(var_3_1, var_0)

					local var_3_2 = arg_1_0

					var_3_0 = var_3_0.sendNotification
					BayProxy = var_3_10003

					var_3_0(var_3_2, var_3_10003.SHIP_UPDATED, var_0)

					local var_3_3 = arg_1_0

					var_3_0 = var_3_0.sendNotification
					GAME = var_3_10003

					var_3_0(var_3_3, var_3_10003.RENAME_SHIP_DONE, {
						ship = var_0
					})
				else
					pg = var_3_0

					local var_3_4 = var_3_0.TipsMgr.GetInstance()
					local var_3_5 = var_1.ShowTips

					errorTip = var_3_10003

					var_3_5(var_3_4, var_3_10003("ship_renameShip", arg_3_0.result))
				end

				return
			end)

			return
		end

		pg = var_1_6

		local var_1_9 = var_1_6.MsgboxMgr.GetInstance()
		local var_1_10 = var_9.ShowMsgBox
		local var_1_11 = {}

		i18n = var_1_10012
		var_1_11.content = var_1_10012("word_rename_time_warning", var_6:getName(), var_1_1)

		function var_1_11.onYes()
			var_1_8()

			return
		end

		var_1_10(var_1_9, var_1_11)

		return
	end
end

return var_0_1
