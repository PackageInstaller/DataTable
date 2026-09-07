local ChangePlayerIconCommand = class("ChangePlayerIconCommand", pm.SimpleCommand)

function ChangePlayerIconCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.skinPage
	local var_1_2 = var_1_0.after
	local var_1_3 = var_1_0.callback
	local var_1_4 = getProxy(PlayerProxy)
	local var_1_5 = var_1_4:getData()
	local var_1_6 = var_1_5:GetShipPhantomMarks()

	if #var_1_0.after <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_error"))

		return
	end

	if #var_1_6 == #var_1_0.after and underscore.all(underscore.keys(var_1_0.after), function(arg_2_0)
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

	local var_1_7 = underscore.map(var_1_0.after, function(arg_3_0)
		local var_3_0, var_3_1 = ShipPhantom.UnpackMark(arg_3_0)

		return {
			key = var_3_0,
			value = var_3_1
		}
	end)

	pg.ConnectionMgr.GetInstance():Send(11011, {
		character = var_1_7
	}, 11012, function(arg_4_0)
		if arg_4_0.result == 0 then
			ChangePlayerIconCommand.UpdayePlayerCharas(var_1_5, var_1_7)
			var_1_4:updatePlayer(var_1_5)
			pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inAdmiral")

			if var_1_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("change_skin_secretary_ship"))
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("player_changePlayerIcon_ok"))
			end

			self:sendNotification(GAME.CHANGE_PLAYER_ICON_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("player_changePlayerIcon", arg_4_0.result))
		end

		existCall(var_1_3)

		return
	end)

	return
end

function ChangePlayerIconCommand:UpdayePlayerCharas(arg_5_1)
	self.characters = underscore.map(arg_5_1, function(arg_6_0)
		return arg_6_0.key
	end)
	self.phantoms = underscore.map(arg_5_1, function(arg_7_0)
		return arg_7_0.value
	end)
	self.character = self.characters[1]
	self.phantomId = self.phantoms[1] or 0

	local var_5_0 = ShipPhantom.Change(getProxy(BayProxy):getShipById(self.character), self.phantoms[1])

	self.icon = var_5_0.configId
	self.skinId = var_5_0:getSkinId()

	return
end

return ChangePlayerIconCommand
