class = var_0_10000

local var_0_0 = "SetShipSkinCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

var_0_1.SKIN_UPDATED = "skin updated"

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.phantomId
	local var_1_2 = var_2.skinId
	local var_1_3 = var_2.hideTip

	if var_1_2 ~= 0 then
		ShipSkin = var_1_10007
		var_1_2 = var_1_10007.GetChangeSkinMainId(var_1_2)
	end

	pg = var_1_10007

	local var_1_4 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 12202, {
		ship_id = var_1_0,
		skin_id = var_1_2,
		skin_shadow = var_1_1
	}, 12203, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			BayProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			var_1.updateShipSkin(var_2_10003, var_1_0, var_1_1, var_1_2)

			var_2_10003 = var_1

			local var_2_0 = var_1.GetShipPhantom

			ShipPhantom = var_4

			local var_2_1 = var_2_0(var_2_10003, var_4.PackMark(var_1_0, var_1_1))

			getProxy = var_2_10003
			PlayerProxy = var_4

			local var_2_2 = var_2_10003(var_4)
			local var_2_3 = var_2_10003.getData(var_2_2)

			if var_4.GetFlagShipPhantomMark(var_2_3) == var_2_1:GetShipPhantomMark() then
				var_4.skinId = var_2_1:getSkinId()

				var_2_10003:updatePlayer(var_4)
			end

			local var_2_4 = arg_1_0

			var_5.sendNotification(var_2_4, var_0_1.SKIN_UPDATED, {
				ship = var_2_1
			})

			if not var_1_3 then
				local var_2_6

				if var_1_1 == 0 then
					pg = var_2_6

					local var_2_5 = var_2_6.TipsMgr.GetInstance()

					var_2_6 = var_2_6.ShowTips
					i18n = var_7

					var_2_6(var_2_5, var_7("ship_set_skin_success"))
				else
					pg = var_2_6

					local var_2_7 = var_2_6.TipsMgr.GetInstance()
					local var_2_8 = var_5.ShowTips

					i18n = var_7

					var_2_8(var_2_7, var_7("shadow_skin_change_success"))
				end
			end
		else
			pg = var_1

			local var_2_9 = var_1.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_10(var_2_9, var_2_10003("ship_set_skin_error", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
