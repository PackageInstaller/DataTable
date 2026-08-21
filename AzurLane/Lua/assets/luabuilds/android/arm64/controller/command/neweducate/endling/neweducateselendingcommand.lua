local var_0_0 = class("NewEducateSelEndingCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.isMain

	pg.ConnectionMgr.GetInstance():Send(29005, {
		id = var_1_0.id,
		ending_id = var_1_0.endingId
	}, 29006, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy)

			var_2_0:AddFinishedEnding(var_0)
			var_2_0:GetCurChar():GetFSM():GetState(NewEducateFSM.SYSTEM.ENDING):SelEnding(var_0)
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_SEL_ENDING_DONE, {
				id = var_0,
				isMain = var_1_1
			})
			pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataEnding(var_0, var_2_0:GetCurChar():GetGameCnt(), var_0))
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_SelTalent: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
