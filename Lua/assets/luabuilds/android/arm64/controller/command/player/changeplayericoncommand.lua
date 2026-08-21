local var_0_0 = class("ChangePlayerIconCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.skinPage
	local var_1_2 = var_1_0.after
	local var_1_3 = var_1_0.callback
	local var_1_4 = getProxy(PlayerProxy)
	local var_1_5 = getProxy(PlayerProxy):getData()
	local var_1_6 = getProxy(PlayerProxy):getData():GetShipPhantomMarks()

	if #var_1_0.after <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_error"))

		return
	end

	if #getProxy(PlayerProxy):getData():GetShipPhantomMarks() == #var_1_0.after and underscore.all(underscore.keys(var_1_0.after), function(arg_2_0)
		return var_1_6[arg_2_0] == var_1_2[arg_2_0]
	end) then
		if var_1_0.skinPage then
			pg.TipsMgr.GetInstance():ShowTips(i18n("change_skin_secretary_ship"))
		end

		existCall(var_1_0.callback)

		return
	end

	for iter_1_0 = #var_1_0.after, 1, -1 do
		for iter_1_1 = iter_1_0 - 1, 1, -1 do
			print(var_1_0.after[iter_1_0], var_1_0.after[iter_1_1])

			if var_1_0.after[iter_1_0] == var_1_0.after[iter_1_1] then
				table.remove(var_1_0.after, iter_1_0)

				break
			end
		end
	end

	pg.ConnectionMgr.GetInstance():Send(11011, {
		character = underscore.map(var_1_0.after, function(arg_3_0)
			local var_3_0, var_3_1 = ShipPhantom.UnpackMark(arg_3_0)

			return {
				key = var_3_0,
				value = var_3_1
			}
		end)
	}, 11012, function(arg_4_0)
		if arg_4_0.result == 0 then
			var_0_0.UpdayePlayerCharas(var_1_5, var_0)
			var_1_4:updatePlayer(var_1_5)
			pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inAdmiral")

			if var_1_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("change_skin_secretary_ship"))
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("player_changePlayerIcon_ok"))
			end

			arg_1_0:sendNotification(GAME.CHANGE_PLAYER_ICON_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("player_changePlayerIcon", arg_4_0.result))
		end

		existCall(var_1_3)

		return
	end)

	return
end

function var_0_0.UpdayePlayerCharas(arg_5_0, arg_5_1)
	arg_5_0.characters = underscore.map(arg_5_1, function(arg_6_0)
		return arg_6_0.key
	end)
	arg_5_0.phantoms = underscore.map(arg_5_1, function(arg_7_0)
		return arg_7_0.value
	end)
	arg_5_0.character = arg_5_0.characters[1]
	arg_5_0.phantomId = arg_5_0.phantoms[1] or 0

	local var_5_0 = ShipPhantom.Change(getProxy(BayProxy):getShipById(arg_5_0.character), arg_5_0.phantoms[1])

	arg_5_0.icon = var_5_0.configId
	arg_5_0.skinId = var_5_0:getSkinId()

	return
end

return var_0_0
