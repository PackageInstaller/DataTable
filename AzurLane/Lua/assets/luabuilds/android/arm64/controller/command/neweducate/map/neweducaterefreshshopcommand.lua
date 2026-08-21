local var_0_0 = class("NewEducateRefreshShopCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	if getProxy(NewEducateProxy):GetCurChar():GetFSM():CheckPriorityStystem() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

		return
	end

	local var_1_0 = getProxy(NewEducateProxy):GetCurChar()
	local var_1_1 = pg.gameset.child2_shop_refresh_price.key_value

	if var_1_0:GetResByType(NewEducateChar.RES_TYPE.REFRESH_SHOP) <= 0 and var_1_0:GetResByType(NewEducateChar.RES_TYPE.MONEY) < pg.gameset.child2_shop_refresh_price.key_value then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(29072, {
		id = arg_1_1:getBody().id
	}, 29073, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_0 > 0 then
				local var_2_0 = var_1_0:GetResIdByType(NewEducateChar.RES_TYPE.REFRESH_SHOP)
				local var_2_1

				if not var_2_0 then
					var_2_0 = var_1_0:GetResIdByType(NewEducateChar.RES_TYPE.MONEY)
					var_2_1 = getProxy(NewEducateProxy)
				end

				;({
					type = NewEducateConst.DROP_TYPE.RES,
					id = var_2_0
				}).number = var_0 > 0 and 1 or var_1_1

				var_2_1:Cost({
					type = NewEducateConst.DROP_TYPE.RES,
					id = var_2_0
				})
				getProxy(NewEducateProxy):GetCurChar():GetFSM():GetState(NewEducateFSM.SYSTEM.MAP):OnRefreshShopDone(arg_2_0.shops, var_0 <= 0)
				arg_1_0:sendNotification(GAME.NEW_EDUCATE_REFRESH_SHOP_DONE)

				if false then
					pg.TipsMgr.GetInstance():ShowTips("NewEducate_RefreshShop_Error: " .. arg_2_0.result)
				end

				return
			end
		end
	end)

	return
end

return var_0_0
