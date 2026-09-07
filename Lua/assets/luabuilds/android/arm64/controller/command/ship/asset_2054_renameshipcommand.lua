local RenameShipCommand = class("RenameShipCommand", pm.SimpleCommand)

function RenameShipCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipId
	local var_1_2 = var_1_0.name
	local var_1_3 = getProxy(BayProxy)
	local var_1_4 = var_1_3:getShipById(var_1_0.shipId)

	if not var_1_4 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_error_noShip", var_1_0.shipId))

		return
	end

	local var_1_5 = var_1_4:isRemoulded() and pg.ship_skin_template[var_1_4:getRemouldSkinId()].name or pg.ship_data_statistics[var_1_4.configId].name

	if var_1_4:getName() == var_1_2 then
		self:sendNotification(GAME.RENAME_SHIP_DONE, {
			ship = var_1_4
		})

		return
	end

	if var_1_2 == "" then
		pg.TipsMgr.GetInstance():ShowTips(i18n("login_createNewPlayer_error_nameNull"))

		return
	end

	if var_1_2 ~= var_1_5 and not nameValidityCheck(var_1_2, 0, 40, {
		"spece_illegal_tip",
		"login_newPlayerScene_name_tooShort",
		"ship_renameShip_error_2011",
		"playerinfo_mask_word"
	}) then
		return
	end

	local function var_1_6()
		pg.ConnectionMgr.GetInstance():Send(12034, {
			ship_id = var_1_1,
			name = var_1_2 == var_1_5 and "" or var_1_2
		}, 12035, function(arg_3_0)
			if arg_3_0.result == 0 then
				var_1_4.name = var_1_2
				var_1_4.renameTime = pg.TimeMgr.GetInstance():GetServerTime()

				var_1_3:updateShip(var_1_4)
				self:sendNotification(BayProxy.SHIP_UPDATED, var_1_4)
				self:sendNotification(GAME.RENAME_SHIP_DONE, {
					ship = var_1_4
				})
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_renameShip", arg_3_0.result))
			end

			return
		end)

		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("word_rename_time_warning", var_1_4:getName(), var_1_2),
		onYes = function()
			var_1_6()

			return
		end
	})

	return
end

return RenameShipCommand
