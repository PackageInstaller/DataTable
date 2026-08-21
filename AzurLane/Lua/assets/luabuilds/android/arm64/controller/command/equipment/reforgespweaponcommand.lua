local var_0_0 = class("ReforgeSpWeaponCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.uid or 0
	local var_1_2 = var_1_0.shipId or 0
	local var_1_3 = getProxy(BagProxy)
	local var_1_4 = getProxy(PlayerProxy)

	if not (function()
		local var_2_0, var_2_1 = EquipmentProxy.StaticGetSpWeapon(var_1_2, var_1_1)

		if not _.all(var_2_0:GetAttributeOptions(), function(arg_3_0)
			return arg_3_0 == 0
		end) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_attr_modify"))

			return
		end

		local var_2_2 = var_1_3:getRawData()
		local var_2_3 = var_1_4:getData()

		if not _.all(var_2_0:GetUpgradeConfig().reset_use_item, function(arg_4_0)
			if var_2_2[arg_4_0[1]] then
				local var_4_0 = var_2_2[arg_4_0[1]].count or 0

				return arg_4_0[2] <= var_4_0
			end
		end) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_materal_no_enough"))

			return
		end

		if table.equal(var_2_0:GetBaseAttributes(), (var_2_0:GetAttributesRange())) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_transform_attrmax"))

			return
		end

		return true
	end)() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(14205, {
		ship_id = var_1_2,
		spweapon_id = var_1_1
	}, 14206, function(arg_5_0)
		if arg_5_0.result == 0 then
			local var_5_0, var_5_1 = EquipmentProxy.StaticGetSpWeapon(var_1_2, var_1_1)

			var_5_0:SetAttributeOptions({
				arg_5_0.attr_temp_1,
				arg_5_0.attr_temp_2
			})

			if var_5_1 then
				var_5_1:UpdateSpWeapon(var_5_0)
				getProxy(BayProxy):updateShip(var_5_1)
			else
				getProxy(EquipmentProxy):AddSpWeapon(var_5_0)
			end

			_.each(var_5_0:GetUpgradeConfig().reset_use_item, function(arg_6_0)
				var_1_3:removeItemById(arg_6_0[1], arg_6_0[2])

				return
			end)
			arg_1_0:sendNotification(GAME.REFORGE_SPWEAPON_DONE, var_5_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("common", arg_5_0.result))
		end

		return
	end)

	return
end

return var_0_0
