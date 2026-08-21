local var_0_0 = class("NewEducateSelTalentCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.idx

	pg.ConnectionMgr.GetInstance():Send(29023, {
		id = var_1_0.id,
		talent = var_1_0.talentId
	}, 29024, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM():GetState(NewEducateFSM.SYSTEM.TALENT)

			var_2_0:MarkFinish()
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_SEL_TALENT_DONE, {
				idx = var_1_1,
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop)
			})

			local var_2_1 = getProxy(NewEducateProxy):GetCurChar()

			pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataTalent(var_2_1.id, var_2_1:GetGameCnt(), var_2_1:GetRoundData().round, 2, var_0, table.concat(var_2_0:GetTalents(), ",")))
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_SelTalent: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
