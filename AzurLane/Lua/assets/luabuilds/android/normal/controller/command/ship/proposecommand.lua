class = var_0_10000

local var_0_0 = "ProposeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId

	getProxy = var_1_10004
	BayProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2

	if not var_4.getShipById(var_1_1, var_1_0) then
		pg = var_1_1
		var_1_2 = var_1_1.TipsMgr.GetInstance()
		var_1_1 = var_1_1.ShowTips
		i18n = var_1_10008

		var_1_1(var_1_2, var_1_10008("ship_error_noShip", var_1_0))

		return
	end

	getProxy = var_1_1
	BagProxy = var_1_2

	local var_1_3 = var_1_1(var_1_2)

	if var_5:getProposeType() == "imas" then
		ITEM_ID_FOR_PROPOSE_IMAS = var_7

		if not var_7 then
			ITEM_ID_FOR_PROPOSE = var_7
		end

		local var_1_5

		if var_1_3:getItemCountById(var_7) < 1 then
			pg = var_1_5

			local var_1_4 = var_1_5.TipsMgr.GetInstance()

			var_1_5 = var_1_5.ShowTips
			i18n = var_1_10011

			var_1_5(var_1_4, var_1_10011("common_no_item_1"))

			return
		end

		pg = var_1_5

		local var_1_6 = var_1_5.ConnectionMgr.GetInstance()

		var_9.Send(var_1_6, 12032, {
			ship_id = var_1_0
		}, 12033, function(arg_2_0)
			local var_2_1

			if arg_2_0.result == 0 then
				pg = var_2_1

				local var_2_0 = var_2_1.TrackerMgr.GetInstance()

				var_2_1 = var_2_1.Tracking
				TRACKING_PROPOSE_SHIP = var_2_10003

				var_2_1(var_2_0, var_2_10003, var_0.groupId)

				local var_2_2 = var_1_3

				var_2_1.removeItemById(var_2_2, var_0, 1)

				var_2_1 = var_0
				var_2_1.propose = true
				var_2_1 = var_0
				var_2_1.proposeTime = arg_2_0.time

				local var_2_3 = var_0

				if not var_2_1.IsLocked(var_2_3) then
					var_2_3 = var_0
					var_2_1 = var_2_1.SetLockState
					Ship = var_2_10003

					var_2_1(var_2_3, var_2_10003.LOCK_STATE_LOCK)

					var_2_3 = var_0

					var_2_1.updateShip(var_2_3, var_0)

					var_2_3 = arg_1_0
					var_2_1 = var_2_1.sendNotification
					GAME = var_2_10003

					var_2_1(var_2_3, var_2_10003.UPDATE_LOCK_DONE, var_0)
				else
					var_2_3 = var_0

					var_2_1.updateShip(var_2_3, var_0)
				end

				getProxy = var_2_1
				CollectionProxy = var_2_3

				local var_2_4 = var_2_1(var_2_3).shipGroups[var_0.groupId]

				var_2.updateMarriedFlag(var_2_4)

				getProxy = var_2_10003
				PlayerProxy = var_2_4

				local var_2_5 = var_2_10003(var_2_4)
				local var_2_6 = var_2_10003.getData(var_2_5)

				var_4.SetProposeShipId(var_2_6, var_1_0)
				var_2_10003:updatePlayer(var_4)

				local var_2_7 = arg_1_0
				local var_2_8 = var_5.sendNotification

				GAME = var_7

				var_2_8(var_2_7, var_7.PROPOSE_SHIP_DONE, {
					ship = var_0
				})
			else
				pg = var_2_1

				local var_2_9 = var_2_1.TipsMgr.GetInstance()
				local var_2_10 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_10(var_2_9, var_2_10003("ship_proposeShip", arg_2_0.result))
			end

			return
		end)

		return
	end
end

return var_0_1
