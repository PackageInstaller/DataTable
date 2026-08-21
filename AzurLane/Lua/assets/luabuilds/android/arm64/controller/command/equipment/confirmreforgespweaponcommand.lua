local var_0_0 = class("ConfirmReforgeSpWeaponCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.uid or 0
	local var_1_2 = var_1_0.shipId or 0

	;({
		ship_id = var_1_2,
		spweapon_id = var_1_1
	}).cmd = var_1_0.op

	pg.ConnectionMgr.GetInstance():Send(14207, {
		ship_id = var_1_2,
		spweapon_id = var_1_1
	}, 14208, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0, var_2_1 = EquipmentProxy.StaticGetSpWeapon(var_1_2, var_1_1)

			if var_0 == SpWeapon.CONFIRM_OP_EXCHANGE then
				var_2_0:SetBaseAttributes((var_2_0:GetAttributeOptions()))
			end

			var_2_0:SetAttributeOptions({
				0,
				0
			})

			if var_2_1 then
				var_2_1:UpdateSpWeapon(var_2_0)
				getProxy(BayProxy):updateShip(var_2_1)
			else
				getProxy(EquipmentProxy):AddSpWeapon(var_2_0)
			end

			arg_1_0:sendNotification(GAME.CONFIRM_REFORGE_SPWEAPON_DONE, var_2_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("common", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
