local NewEducateGetMapCommand = class("NewEducateGetMapCommand", pm.SimpleCommand)

function NewEducateGetMapCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	pg.ConnectionMgr.GetInstance():Send(29060, {
		id = var_1_0
	}, 29061, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar()

			var_2_0:GetFSM():SetState(NewEducateFSM.SYSTEM.MAP, (NewEducateMapState.New(var_1_0, arg_2_0.fsm_site)))
			var_2_0:SetShipIds(arg_2_0.characters or {})
			self:sendNotification(GAME.NEW_EDUCATE_GET_MAP_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_GetMap: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateGetMapCommand
