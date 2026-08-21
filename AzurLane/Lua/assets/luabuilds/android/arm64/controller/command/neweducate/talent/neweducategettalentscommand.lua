local var_0_0 = class("NewEducateGetTalentsCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(29019, {
		id = var_1_0.id
	}, 29020, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

			var_2_0:SetSystemNo(NewEducateFSM.SYSTEM.TALENT)

			local var_2_1 = NewEducateTalentState.New({
				finished = 0,
				talents = arg_2_0.talents,
				retalents = {}
			})

			var_2_0:SetState(NewEducateFSM.SYSTEM.TALENT, var_2_1)

			if #arg_2_0.talents == 0 then
				var_2_1:MarkFinish()
			else
				local var_2_2 = getProxy(NewEducateProxy):GetCurChar()

				pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataTalent(var_2_2.id, var_2_2:GetGameCnt(), var_2_2:GetRoundData().round, 1, 0, table.concat(arg_2_0.talents, ",")))
			end

			existCall(var_1_1)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_GetTalents: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
