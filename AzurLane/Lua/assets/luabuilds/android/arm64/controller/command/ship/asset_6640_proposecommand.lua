class = var_0_10000

local var_0_0 = "ProposeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).shipId

	getProxy = var_1_0
	BayProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3

	if not var_4.getShipById(var_1_2, var_1_1) then
		pg = var_1_10006
		var_1_3 = var_1_10006.TipsMgr.GetInstance()
		var_1_10006 = var_1_10006.ShowTips
		i18n = var_1_10009

		var_1_10006(var_1_3, var_1_10009("ship_error_noShip", var_1_1))

		return
	end

	getProxy = var_1_10006
	BagProxy = var_1_3

	local var_1_4 = var_1_10006(var_1_3)

	if var_5:getProposeType() == "imas" then
		ITEM_ID_FOR_PROPOSE_IMAS = var_7

		if not var_7 then
			ITEM_ID_FOR_PROPOSE = var_7
		end

		local var_1_6

		if var_1_4:getItemCountById(var_7) < 1 then
			pg = var_1_6

			local var_1_5 = var_1_6.TipsMgr.GetInstance()

			var_1_6 = var_1_6.ShowTips
			i18n = var_1_10012

			var_1_6(var_1_5, var_1_10012("common_no_item_1"))

			return
		end

		pg = var_1_6

		local var_1_7 = var_1_6.ConnectionMgr.GetInstance()

		var_9.Send(var_1_7, 12032, {
			ship_id = var_1_1
		}, 12033, function(arg_2_0)
			local var_2_1

			if arg_2_0.result == 0 then
				pg = var_2_1

				local var_2_0 = var_2_1.TrackerMgr.GetInstance()

				var_2_1 = var_2_1.Tracking
				TRACKING_PROPOSE_SHIP = var_2_10004

				var_2_1(var_2_0, var_2_10004, var_0.groupId)

				local var_2_2 = var_1_4

				var_2_1.removeItemById(var_2_2, var_0, 1)

				var_2_1 = var_0
				var_2_1.propose = true
				var_2_1 = var_0
				var_2_1.proposeTime = arg_2_0.time

				local var_2_3 = var_0

				if not var_2_1.IsLocked(var_2_3) then
					var_2_3 = var_0
					var_2_1 = var_2_1.SetLockState
					Ship = var_2_10004

					var_2_1(var_2_3, var_2_10004.LOCK_STATE_LOCK)

					var_2_3 = var_0

					var_2_1.updateShip(var_2_3, var_0)

					var_2_3 = arg_1_0
					var_2_1 = var_2_1.sendNotification
					GAME = var_2_10004

					var_2_1(var_2_3, var_2_10004.UPDATE_LOCK_DONE, var_0)
				else
					var_2_3 = var_0

					var_2_1.updateShip(var_2_3, var_0)
				end

				getProxy = var_2_1
				CollectionProxy = var_2_3

				local var_2_4 = var_2_1(var_2_3).shipGroups[var_0.groupId]

				var_2.updateMarriedFlag(var_2_4)

				getProxy = var_3
				PlayerProxy = var_2_4

				local var_2_5 = var_3(var_2_4)
				local var_2_6 = var_3.getData(var_2_5)

				var_2_10004.SetProposeShipId(var_2_6, var_1_1)
				var_3:updatePlayer(var_2_10004)

				local var_2_7 = arg_1_0
				local var_2_8 = var_5.sendNotification

				GAME = var_8

				var_2_8(var_2_7, var_8.PROPOSE_SHIP_DONE, {
					ship = var_0
				})
			else
				pg = var_2_1

				local var_2_9 = var_2_1.TipsMgr.GetInstance()
				local var_2_10 = var_1.ShowTips

				errorTip = var_2_10004

				var_2_10(var_2_9, var_2_10004("ship_proposeShip", arg_2_0.result))
			end

			return
		end)

		return
	end
end

return var_0_1
