local SetShipSkinCommand = class("SetShipSkinCommand", pm.SimpleCommand)

SetShipSkinCommand.SKIN_UPDATED = "skin updated"

function SetShipSkinCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipId
	local var_1_2 = var_1_0.phantomId
	local var_1_3 = var_1_0.skinId
	local var_1_4 = var_1_0.hideTip

	if var_1_0.skinId ~= 0 then
		var_1_3 = ShipSkin.GetChangeSkinMainId(var_1_3)
	end

	pg.ConnectionMgr.GetInstance():Send(12202, {
		ship_id = var_1_0.shipId,
		skin_id = var_1_3,
		skin_shadow = var_1_0.phantomId
	}, 12203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(BayProxy)

			var_2_0:updateShipSkin(var_1_1, var_1_2, var_1_3)

			local var_2_1 = var_2_0:GetShipPhantom(ShipPhantom.PackMark(var_1_1, var_1_2))
			local var_2_2 = getProxy(PlayerProxy)
			local var_2_3 = var_2_2:getData()

			if var_2_3:GetFlagShipPhantomMark() == var_2_1:GetShipPhantomMark() then
				var_2_3.skinId = var_2_1:getSkinId()

				var_2_2:updatePlayer(var_2_3)
			end

			self:sendNotification(SetShipSkinCommand.SKIN_UPDATED, {
				ship = var_2_1
			})

			if not var_1_4 then
				if var_1_2 == 0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("ship_set_skin_success"))
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("shadow_skin_change_success"))
				end
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_set_skin_error", arg_2_0.result))
		end

		return
	end)

	return
end

return SetShipSkinCommand
