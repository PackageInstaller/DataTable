local NewEducateChangePhaseCommand = class("NewEducateChangePhaseCommand", pm.SimpleCommand)

function NewEducateChangePhaseCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(29025, {
		id = arg_1_1:getBody().id
	}, 29026, function(arg_2_0)
		if arg_2_0.result == 0 then
			NewEducateHelper.TrackRoundEnd()

			local var_2_0 = getProxy(NewEducateProxy):GetCurChar()

			var_2_0:GetFSM():SetCurNode(arg_2_0.first_node)
			var_2_0:GetFSM():SetSystemNo(NewEducateFSM.SYSTEM.PHASE)
			getProxy(NewEducateProxy):NextRound()
			self:sendNotification(GAME.NEW_EDUCATE_CHANGE_PHASE_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop),
				node = arg_2_0.first_node
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_ChangePhase: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateChangePhaseCommand
