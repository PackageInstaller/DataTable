local BuildShipImmediatelyCommand = class("BuildShipImmediatelyCommand", pm.SimpleCommand)

function BuildShipImmediatelyCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.type

	if not var_1_0.type then
		var_1_1 = 1

		local var_1_2 = getProxy(BuildShipProxy)
	end

	local var_1_3 = underscore.filter(var_1_0.pos_list, function(arg_2_0)
		return var_1_2:getBuildShip(arg_2_0).state ~= BuildShip.FINISH
	end)

	if #var_1_3 == 0 then
		existCall(var_1_0.callback)

		return
	end

	local var_1_4 = getProxy(BagProxy)
	local var_1_5 = var_1_4:getItemCountById(ITEM_ID_EQUIP_QUICK_FINISH)

	if var_1_5 == 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

		return
	else
		var_1_3 = underscore.slice(var_1_3, 1, var_1_5)
	end

	pg.ConnectionMgr.GetInstance():Send(12008, {
		type = var_1_1,
		pos_list = var_1_3
	}, 12009, function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.pos_list) do
			var_1_4:removeItemById(ITEM_ID_EQUIP_QUICK_FINISH, 1)
			var_1_2:getBuildShip(iter_3_1):finish()
			var_1_2:finishBuildShip(iter_3_1)
		end

		if arg_3_0.result == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_speedUp") .. i18n("word_succeed"))
			self:sendNotification(GAME.BUILD_SHIP_IMMEDIATELY_DONE)
			existCall(var_1_0.callback)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_buildShipImmediately", arg_3_0.result))
		end

		return
	end)

	return
end

return BuildShipImmediatelyCommand
