class = var_0_10000

local var_0_0 = "ConfirmReforgeSpWeaponCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1:getBody().uid then
		var_1_0 = 0
	end

	local var_1_1

	if not var_2.shipId then
		var_1_1 = 0
	end

	local var_1_2 = var_2.op

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 14207, {
		ship_id = var_1_1,
		spweapon_id = var_1_0,
		cmd = var_1_2
	}, 14208, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			EquipmentProxy = var_2_0

			local var_2_1

			var_2_0, var_2_1 = var_2_0.StaticGetSpWeapon(var_1_1, var_1_0)

			local var_2_2 = var_1_2

			SpWeapon = var_2_10004

			if var_2_2 == var_2_10004.CONFIRM_OP_EXCHANGE then
				local var_2_3 = var_2_0:GetAttributeOptions()

				var_2_0:SetBaseAttributes(var_2_3)
			end

			local var_2_4 = var_2_0

			var_2_0.SetAttributeOptions(var_2_4, {
				0,
				0
			})

			if var_2_1 then
				var_2_4 = var_2_1

				var_2_1.UpdateSpWeapon(var_2_4, var_2_0)

				getProxy = var_3
				BayProxy = var_2_4
				var_2_4 = var_3(var_2_4)

				var_3.updateShip(var_2_4, var_2_1)
			else
				getProxy = var_3
				EquipmentProxy = var_2_4

				local var_2_5 = var_3(var_2_4)

				var_3.AddSpWeapon(var_2_5, var_2_0)
			end

			local var_2_6 = arg_1_0
			local var_2_7 = var_3.sendNotification

			GAME = var_6

			var_2_7(var_2_6, var_6.CONFIRM_REFORGE_SPWEAPON_DONE, var_2_0)
		else
			pg = var_2_0

			local var_2_8 = var_2_0.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_9(var_2_8, var_2_10004("common", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
