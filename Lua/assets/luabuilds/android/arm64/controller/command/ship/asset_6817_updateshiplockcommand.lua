local UpdateShipLockCommand = class("UpdateShipLockCommand", pm.SimpleCommand)

function UpdateShipLockCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.ship_id_list
	local var_1_2 = var_1_0.is_locked
	local var_1_3 = var_1_0.callback

	local function var_1_4()
		pg.ConnectionMgr.GetInstance():Send(12022, {
			ship_id_list = var_1_1,
			is_locked = var_1_2
		}, 12023, function(arg_3_0)
			if arg_3_0.result == 0 then
				local var_3_0 = getProxy(BayProxy)
				local var_3_1

				if var_1_2 == Ship.LOCK_STATE_LOCK then
					var_3_1 = "ship_updateShipLock_ok_lock"
				elseif var_1_2 == Ship.LOCK_STATE_UNLOCK then
					var_3_1 = "ship_updateShipLock_ok_unlock"
				end

				for iter_3_0, iter_3_1 in ipairs(var_1_1) do
					local var_3_2 = var_3_0:getShipById(iter_3_1)

					var_3_2:SetLockState(var_1_2)
					var_3_0:updateShip(var_3_2)
					self:sendNotification(GAME.UPDATE_LOCK_DONE, var_3_2)
					pg.TipsMgr.GetInstance():ShowTips(i18n(var_3_1, var_3_2:getName()))
				end

				if var_1_3 then
					var_1_3()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_updateShipLock", arg_3_0.result))
			end

			return
		end)

		return
	end

	if var_1_0.is_locked == Ship.LOCK_STATE_UNLOCK then
		pg.SecondaryPWDMgr:LimitedOperation(pg.SecondaryPWDMgr.UNLOCK_SHIP, var_1_0.ship_id_list, var_1_4)
	else
		var_1_4()
	end

	return
end

return UpdateShipLockCommand
