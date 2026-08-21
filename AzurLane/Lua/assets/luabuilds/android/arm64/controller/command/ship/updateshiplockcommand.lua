local var_0_0 = class("UpdateShipLockCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.ship_id_list
	local var_1_2 = var_1_0.callback

	if var_1_0.is_locked == Ship.LOCK_STATE_UNLOCK then
		pg.SecondaryPWDMgr:LimitedOperation(pg.SecondaryPWDMgr.UNLOCK_SHIP, var_1_0.ship_id_list, function()
			pg.ConnectionMgr.GetInstance():Send(12022, {
				ship_id_list = var_1_1,
				is_locked = var_0
			}, 12023, function(arg_3_0)
				if arg_3_0.result == 0 then
					local var_3_0 = getProxy(BayProxy)
					local var_3_1

					if var_0 == Ship.LOCK_STATE_LOCK then
						var_3_1 = "ship_updateShipLock_ok_lock"
					elseif var_0 == Ship.LOCK_STATE_UNLOCK then
						var_3_1 = "ship_updateShipLock_ok_unlock"
					end

					for iter_3_0, iter_3_1 in ipairs(var_1_1) do
						local var_3_2 = var_3_0:getShipById(iter_3_1)

						var_3_2:SetLockState(var_0)
						var_3_0:updateShip(var_3_2)
						arg_1_0:sendNotification(GAME.UPDATE_LOCK_DONE, var_3_2)
						pg.TipsMgr.GetInstance():ShowTips(i18n(var_3_1, var_3_2:getName()))
					end

					if var_1_2 then
						var_1_2()
					end
				else
					pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_updateShipLock", arg_3_0.result))
				end

				return
			end)

			return
		end)
	else
		(function()
			pg.ConnectionMgr.GetInstance():Send(12022, {
				ship_id_list = var_1_1,
				is_locked = var_0
			}, 12023, function(arg_3_0)
				if arg_3_0.result == 0 then
					local var_3_0 = getProxy(BayProxy)
					local var_3_1

					if var_0 == Ship.LOCK_STATE_LOCK then
						var_3_1 = "ship_updateShipLock_ok_lock"
					elseif var_0 == Ship.LOCK_STATE_UNLOCK then
						var_3_1 = "ship_updateShipLock_ok_unlock"
					end

					for iter_3_0, iter_3_1 in ipairs(var_1_1) do
						local var_3_2 = var_3_0:getShipById(iter_3_1)

						var_3_2:SetLockState(var_0)
						var_3_0:updateShip(var_3_2)
						arg_1_0:sendNotification(GAME.UPDATE_LOCK_DONE, var_3_2)
						pg.TipsMgr.GetInstance():ShowTips(i18n(var_3_1, var_3_2:getName()))
					end

					if var_1_2 then
						var_1_2()
					end
				else
					pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_updateShipLock", arg_3_0.result))
				end

				return
			end)

			return
		end)()
	end

	return
end

return var_0_0
