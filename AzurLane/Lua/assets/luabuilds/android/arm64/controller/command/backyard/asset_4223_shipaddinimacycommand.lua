class = var_0_10000

local var_0_0 = "ShipAddInimacyCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 19011, {
		id = var_1_0
	}, 19012, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			getProxy = var_2_1
			BayProxy = var_2_10003

			local var_2_0 = var_2_1(var_2_10003)

			var_2_1 = var_2_1.getShipById(var_2_0, var_1_0)
			getProxy = var_2_10002
			DormProxy = var_2_10004

			local var_2_2 = var_2_10002(var_2_10004)
			local var_2_3 = var_2.getRawData(var_2_2)
			local var_2_4

			var_2_10004, var_2_4 = var_3.HarvestInimacyAndMoney(var_2_3, var_1_0)

			local var_2_5 = var_2
			local var_2_6 = var_2.updateDrom
			local var_2_7 = var_3

			BackYardConst = var_2_10010

			var_2_6(var_2_5, var_2_7, var_2_10010.DORM_UPDATE_TYPE_SHIP)

			inimacy = var_2_6

			if var_2_6 == 0 then
				pg = var_2_6

				local var_2_8 = var_2_6.TipsMgr.GetInstance()

				var_2_6 = var_2_6.ShowTips
				i18n = var_2_7

				var_2_6(var_2_8, var_2_7("backyard_getResource_emptry"))
			else
				pg = var_2_6

				local var_2_9 = var_2_6.TipsMgr.GetInstance()
				local var_2_10 = var_6.ShowTips

				i18n = var_2_7

				var_2_10(var_2_9, var_2_7("backyard_shipAddInimacy_ok", var_2_1:getName()))
			end

			local var_2_11 = arg_1_0
			local var_2_12 = var_6.sendNotification

			GAME = var_2_7

			var_2_12(var_2_11, var_2_7.BACKYARD_ADD_INTIMACY_DONE, {
				id = var_1_0
			})
		else
			pg = var_2_1

			local var_2_13 = var_2_1.TipsMgr.GetInstance()
			local var_2_14 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_14(var_2_13, var_2_10004("backyard_shipAddInimacy", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
