local NewEducateRefreshShopCommand = class("NewEducateRefreshShopCommand", pm.SimpleCommand)

function NewEducateRefreshShopCommand:execute(arg_1_1)
	if getProxy(NewEducateProxy):GetCurChar():GetFSM():CheckPriorityStystem() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

		return
	end

	local var_1_0 = getProxy(NewEducateProxy):GetCurChar()
	local var_1_1 = var_1_0:GetResByType(NewEducateChar.RES_TYPE.REFRESH_SHOP)
	local var_1_2 = pg.gameset.child2_shop_refresh_price.key_value

	if var_1_1 <= 0 and var_1_0:GetResByType(NewEducateChar.RES_TYPE.MONEY) < pg.gameset.child2_shop_refresh_price.key_value then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(29072, {
		id = arg_1_1:getBody().id
	}, 29073, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_1 > 0 then
				local var_2_0 = var_1_0:GetResIdByType(NewEducateChar.RES_TYPE.REFRESH_SHOP)
				local var_2_2
				local var_2_1

				if not var_2_0 then
					var_2_0 = var_1_0:GetResIdByType(NewEducateChar.RES_TYPE.MONEY)
					var_2_1 = getProxy(NewEducateProxy)
					var_2_2 = {
						type = NewEducateConst.DROP_TYPE.RES,
						id = var_2_0
					}
				end
			end

			var_2_2.number = var_1_1 > 0 and 1 or var_1_2

			var_2_1:Cost(var_2_2)
			getProxy(NewEducateProxy):GetCurChar():GetFSM():GetState(NewEducateFSM.SYSTEM.MAP):OnRefreshShopDone(arg_2_0.shops, var_1_1 <= 0)
			self:sendNotification(GAME.NEW_EDUCATE_REFRESH_SHOP_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_RefreshShop_Error: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateRefreshShopCommand
