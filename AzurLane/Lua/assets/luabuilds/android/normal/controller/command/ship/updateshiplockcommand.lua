class = var_0_10000

local var_0_0 = "UpdateShipLockCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().ship_id_list
	local var_1_1 = var_2.is_locked
	local var_1_2 = var_2.callback

	local function var_1_3()
		pg = var_2_10000

		local var_2_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_2_0, 12022, {
			ship_id_list = var_1_0,
			is_locked = var_1_1
		}, 12023, function(arg_3_0)
			local var_3_0

			if arg_3_0.result == 0 then
				getProxy = var_3_0
				BayProxy = var_3_10002
				var_3_0 = var_3_0(var_3_10002)

				local var_3_1

				var_3_10003 = var_1_1
				Ship = var_3_10004

				if var_3_10003 == var_3_10004.LOCK_STATE_LOCK then
					var_3_1 = "ship_updateShipLock_ok_lock"
				else
					var_3_10003 = var_1_1
					Ship = var_4

					if var_3_10003 == var_4.LOCK_STATE_UNLOCK then
						var_3_1 = "ship_updateShipLock_ok_unlock"
					end
				end

				ipairs = var_3_10003

				for iter_3_0, iter_3_1 in var_3_10003(var_1_0) do
					local var_3_2 = var_3_0:getShipById(iter_3_1)

					var_8.SetLockState(var_3_2, var_1_1)
					var_3_0:updateShip(var_8)

					local var_3_3 = arg_1_0
					local var_3_4 = var_9.sendNotification

					GAME = var_11

					var_3_4(var_3_3, var_11.UPDATE_LOCK_DONE, var_8)

					pg = var_3_4

					local var_3_5 = var_3_4.TipsMgr.GetInstance()
					local var_3_6 = var_9.ShowTips

					i18n = var_11

					var_3_6(var_3_5, var_11(var_3_1, var_8:getName()))
				end

				if var_1_2 then
					var_1_2()
				end
			else
				pg = var_3_0

				local var_3_7 = var_3_0.TipsMgr.GetInstance()
				local var_3_8 = var_1.ShowTips

				errorTip = var_3_10003

				var_3_8(var_3_7, var_3_10003("ship_updateShipLock", arg_3_0.result))
			end

			return
		end)

		return
	end

	Ship = var_1_10007

	if var_1_1 == var_1_10007.LOCK_STATE_UNLOCK then
		pg = var_7

		local var_1_4 = var_7.SecondaryPWDMgr

		var_7.LimitedOperation(var_1_4, var_7.UNLOCK_SHIP, var_2.ship_id_list, var_1_3)
	else
		var_1_3()
	end

	return
end

return var_0_1
