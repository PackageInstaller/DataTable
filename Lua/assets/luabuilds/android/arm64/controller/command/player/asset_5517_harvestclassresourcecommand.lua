local HarvestClassResourceCommand = class("HarvestClassResourceCommand", pm.SimpleCommand)

function HarvestClassResourceCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(NavalAcademyProxy):GetClassVO()
	local var_1_2 = var_1_1:GetCanGetResCnt()

	if var_1_2 <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("player_harvestResource_error_fullBag"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(22009, {
		type = 0
	}, 22010, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = Drop.New({
				type = DROP_TYPE_ITEM,
				id = var_1_1:GetResourceType(),
				count = var_1_2
			})

			self:sendNotification(GAME.ADD_ITEM, var_2_0)

			local var_2_1 = getProxy(PlayerProxy):getData()

			var_2_1:consume({
				[id2res(PlayerConst.ResClassField)] = var_1_2 * var_1_1:GetTarget()
			})
			getProxy(PlayerProxy):updatePlayer(var_2_1)
			pg.TipsMgr.GetInstance():ShowTips(i18n("commission_get_award", var_2_0:getConfig("name"), var_1_2))
			getProxy(NavalAcademyProxy):getCourse():SetProficiency(arg_2_0.exp_in_well)
			self:sendNotification(GAME.HARVEST_CLASS_RES_DONE, {
				award = var_2_0,
				value = var_1_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return HarvestClassResourceCommand
