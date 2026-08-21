local var_0_0 = class("NewEducateMapShipCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipId

	if getProxy(NewEducateProxy):GetCurChar():GetFSM():CheckPriorityStystem() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(29068, {
		id = var_1_0.id,
		character = var_1_0.shipId
	}, 29069, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy)
			local var_2_1 = pg.child2_site_character[var_1_1]

			var_2_0:Cost(NewEducateHelper.Config2Drop(pg.child2_site_character[var_1_1].cost))

			local var_2_2 = underscore.detect(pg.child2_site_character.get_id_list_by_group[pg.child2_site_character[var_1_1].group], function(arg_3_0)
				return pg.child2_site_character[arg_3_0].level == var_2_1.level + 1
			end)

			if var_2_2 then
				var_2_0:GetCurChar():UpdateShipId(var_1_1, var_2_2)
			end

			local var_2_3 = var_2_0:GetCurChar()
			local var_2_4 = var_2_3:GetFSM()

			var_2_4:SetCurNode(arg_2_0.first_node)
			var_2_4:SetSystemNo(NewEducateFSM.SYSTEM.MAP)

			local var_2_5 = var_2_4:GetState(NewEducateFSM.SYSTEM.MAP)

			var_2_5:SetSiteState({
				key = NewEducateConst.SITE_STATE_TYPE.SHIP,
				value = var_1_1
			})

			if var_2_2 then
				var_2_5:AddSelectedShip(var_2_2)
			end

			;({}).drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop)
			;({}).node = arg_2_0.first_node

			arg_1_0:sendNotification(GAME.NEW_EDUCATE_MAP_SHIP_DONE, {})
			pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataSite(var_2_3.id, var_2_3:GetGameCnt(), var_2_3:GetRoundData().round, 3, var_1_1))
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_MapShip: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
