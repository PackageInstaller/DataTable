class = var_0_10000

local var_0_0 = "ProposeRegiesterShipCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).shipId

	getProxy = var_1_0
	BayProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if not var_4.getShipById(var_1_2, var_1_1) then
		pg = var_1_10006

		local var_1_3 = var_1_10006.TipsMgr.GetInstance()
		local var_1_4 = var_6.ShowTips

		i18n = var_1_10009

		var_1_4(var_1_3, var_1_10009("ship_error_noShip", var_1_1))

		return
	end

	if not var_5.propose or var_5:ShowPropose() then
		return
	end

	pg = var_6

	local var_1_5 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_5, 12032, {
		ship_id = var_1_1
	}, 12033, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			PlayerProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getData(var_2_10004)

			var_2.SetProposeShipId(var_2_0, var_1_1)
			var_1:updatePlayer(var_2)

			local var_2_1 = arg_1_0
			local var_2_2 = var_3.sendNotification

			GAME = var_6

			var_2_2(var_2_1, var_6.PROPOSE_REGISTER_SHIP_DONE)
		else
			pg = var_1

			local var_2_3 = var_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_4(var_2_3, var_2_10004("ship_proposeShip", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
