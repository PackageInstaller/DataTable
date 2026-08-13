class = var_0_10000

local var_0_0 = "RenameShipCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.name

	getProxy = var_1_10005
	BayProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	if not var_5.getShipById(var_1_2, var_1_0) then
		pg = var_1_10007

		local var_1_3 = var_1_10007.TipsMgr.GetInstance()
		local var_1_4 = var_7.ShowTips

		i18n = var_1_10010

		var_1_4(var_1_3, var_1_10010("ship_error_noShip", var_1_0))

		return
	end

	local var_1_5 = var_6

	if var_6.isRemoulded(var_1_5) then
		pg = var_1_6

		local var_1_6

		if not var_1_6.ship_skin_template[var_6:getRemouldSkinId()].name then
			pg = var_1_6
			var_1_6 = var_1_6.ship_data_statistics[var_6.configId].name
		end

		local var_1_8

		if var_6:getName() == var_1_1 then
			local var_1_7 = arg_1_0

			var_1_8 = arg_1_0.sendNotification
			GAME = var_1_10011

			var_1_8(var_1_7, var_1_10011.RENAME_SHIP_DONE, {
				ship = var_6
			})

			return
		end

		if var_1_1 == "" then
			pg = var_1_8

			local var_1_9 = var_1_8.TipsMgr.GetInstance()

			var_1_8 = var_1_8.ShowTips
			i18n = var_1_10011

			var_1_8(var_1_9, var_1_10011("login_createNewPlayer_error_nameNull"))

			return
		end

		if var_1_1 ~= var_1_6 then
			nameValidityCheck = var_1_8

			if not var_1_8(var_1_1, 0, 40, {
				"spece_illegal_tip",
				"login_newPlayerScene_name_tooShort",
				"ship_renameShip_error_2011",
				"playerinfo_mask_word"
			}) then
				return
			end
		end

		local function var_1_10()
			pg = var_2_10000

			local var_2_0 = var_2_10000.ConnectionMgr.GetInstance()

			var_0.Send(var_2_0, 12034, {
				ship_id = var_1_0,
				name = var_1_1 == var_1_6 and "" or var_1_1
			}, 12035, function(arg_3_0)
				local var_3_0

				if arg_3_0.result == 0 then
					var_3_0 = var_0
					var_3_0.name = var_1_1
					var_3_0 = var_0
					pg = var_2
					var_3_10004 = var_2.TimeMgr.GetInstance()
					var_3_0.renameTime = var_2.GetServerTime(var_3_10004)

					local var_3_1 = var_0

					var_3_0.updateShip(var_3_1, var_0)

					local var_3_2 = arg_1_0

					var_3_0 = var_3_0.sendNotification
					BayProxy = var_3_10004

					var_3_0(var_3_2, var_3_10004.SHIP_UPDATED, var_0)

					local var_3_3 = arg_1_0

					var_3_0 = var_3_0.sendNotification
					GAME = var_3_10004

					var_3_0(var_3_3, var_3_10004.RENAME_SHIP_DONE, {
						ship = var_0
					})
				else
					pg = var_3_0

					local var_3_4 = var_3_0.TipsMgr.GetInstance()
					local var_3_5 = var_1.ShowTips

					errorTip = var_3_10004

					var_3_5(var_3_4, var_3_10004("ship_renameShip", arg_3_0.result))
				end

				return
			end)

			return
		end

		pg = var_1_5

		local var_1_11 = var_1_5.MsgboxMgr.GetInstance()
		local var_1_12 = var_9.ShowMsgBox
		local var_1_13 = {}

		i18n = var_1_10013
		var_1_13.content = var_1_10013("word_rename_time_warning", var_6:getName(), var_1_1)

		function var_1_13.onYes()
			var_1_10()

			return
		end

		var_1_12(var_1_11, var_1_13)

		return
	end
end

return var_0_1
