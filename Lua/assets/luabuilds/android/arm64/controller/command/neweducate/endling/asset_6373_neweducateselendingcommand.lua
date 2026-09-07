local NewEducateSelEndingCommand = class("NewEducateSelEndingCommand", pm.SimpleCommand)

function NewEducateSelEndingCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.endingId
	local var_1_3 = var_1_0.isMain

	pg.ConnectionMgr.GetInstance():Send(29005, {
		id = var_1_0.id,
		ending_id = var_1_0.endingId
	}, 29006, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy)

			var_2_0:AddFinishedEnding(var_1_2)
			var_2_0:GetCurChar():GetFSM():GetState(NewEducateFSM.SYSTEM.ENDING):SelEnding(var_1_2)
			self:sendNotification(GAME.NEW_EDUCATE_SEL_ENDING_DONE, {
				id = var_1_2,
				isMain = var_1_3
			})
			pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataEnding(var_1_1, var_2_0:GetCurChar():GetGameCnt(), var_1_2))
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_SelTalent: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateSelEndingCommand
