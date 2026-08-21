local var_0_0 = class("ChangeSkinABCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().skin_id
	local var_1_1 = ShipSkin.GetChangeSkinNextId(var_1_0)
	local var_1_2 = getProxy(PlayerProxy):getRawData():GetFlagShip()

	if var_1_0 ~= getProxy(PlayerProxy):getRawData():GetFlagShip():getSkinId() then
		return
	end

	local var_1_3 = pg.ChangeSkinMgr.GetInstance()

	if not var_1_3:isAble() then
		return
	end

	pg.ChangeSkinMgr.GetInstance():preloadChangeAction(ShipSkin.GetChangeSkinNextId(var_1_0), function()
		arg_1_0:startChangeAction(var_1_0, var_1_1, var_1_2)

		return
	end)

	return
end

function var_0_0.startChangeAction(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = getProxy(SettingsProxy):getCharacterSetting(arg_3_3.id, SHIP_FLAG_L2D)

	if var_3_0 and Live2dConst.GetLive2DArm32MatchAble() then
		getProxy(SettingsProxy):setCharacterSetting(arg_3_3.id, SHIP_FLAG_L2D, false)
	elseif not var_3_0 and not Live2dConst.GetLive2DArm32MatchAble() then
		getProxy(SettingsProxy):setCharacterSetting(arg_3_3.id, SHIP_FLAG_L2D, true)
	end

	arg_3_0:sendNotification(GAME.PLAY_CHANGE_SKIN_OUT, {
		callback = function(arg_4_0)
			if arg_4_0.flag then
				ShipSkin.SetStoreChangeSkinId(arg_3_2, arg_3_3:GetShipPhantomMark())

				local var_4_0 = ShipSkin.GetChangeSkinCustomDataId(arg_3_2, "asmr") == 1

				pg.ChangeSkinMgr.GetInstance():play(arg_3_2, function()
					arg_3_0:sendNotification(GAME.CHANGE_SKIN_EXCHANGE, {
						callback = function()
							return
						end,
						asmr = var_4_0
					})

					return
				end, function()
					arg_3_0:sendNotification(GAME.PLAY_CHANGE_SKIN_IN)

					return
				end, function()
					arg_3_0:sendNotification(GAME.PLAY_CHANGE_SKIN_FINISH)

					return
				end)
			end

			if arg_4_0.tip then
				pg.TipsMgr.GetInstance():ShowTips(arg_3_1)
			end

			return
		end
	})

	return
end

return var_0_0
