local var_0_0 = class("ProposeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = getProxy(BayProxy)
	local var_1_2 = getProxy(BayProxy):getShipById(var_1_0)

	if not var_1_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_error_noShip", var_1_0))

		return
	end

	local var_1_3 = getProxy(BagProxy)

	if var_1_2:getProposeType() == "imas" then
		local var_1_4 = ITEM_ID_FOR_PROPOSE_IMAS or ITEM_ID_FOR_PROPOSE

		if var_1_3:getItemCountById(var_1_4) < 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

			return
		end

		pg.ConnectionMgr.GetInstance():Send(12032, {
			ship_id = var_1_0
		}, 12033, function(arg_2_0)
			if arg_2_0.result == 0 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_PROPOSE_SHIP, var_1_2.groupId)
				var_1_3:removeItemById(var_1_4, 1)

				var_1_2.propose = true
				var_1_2.proposeTime = arg_2_0.time

				if not var_1_2:IsLocked() then
					var_1_2:SetLockState(Ship.LOCK_STATE_LOCK)
					var_1_1:updateShip(var_1_2)
					arg_1_0:sendNotification(GAME.UPDATE_LOCK_DONE, var_1_2)
				else
					var_1_1:updateShip(var_1_2)
				end

				getProxy(CollectionProxy).shipGroups[var_1_2.groupId]:updateMarriedFlag()

				local var_2_0 = getProxy(PlayerProxy)
				local var_2_1 = var_2_0:getData()

				var_2_1:SetProposeShipId(var_1_0)
				var_2_0:updatePlayer(var_2_1)
				arg_1_0:sendNotification(GAME.PROPOSE_SHIP_DONE, {
					ship = var_1_2
				})
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_proposeShip", arg_2_0.result))
			end

			return
		end)

		return
	end
end

return var_0_0
