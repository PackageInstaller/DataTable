local var_0_0 = class("NewEducateGetMapCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(29060, {
		id = arg_1_1:getBody().id
	}, 29061, function(arg_2_0)
		local var_2_9000

		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy)
			local var_2_1 = var_2_0.GetCurChar(var_2_9000)

			var_2_1:GetFSM().SetState(var_2_0, NewEducateFSM.SYSTEM.MAP, (NewEducateMapState.New(var_0, arg_2_0.fsm_site)))

			local var_2_2 = arg_2_0.characters or {}

			var_2_1:SetShipIds(var_2_2)
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_GET_MAP_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_GetMap: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
