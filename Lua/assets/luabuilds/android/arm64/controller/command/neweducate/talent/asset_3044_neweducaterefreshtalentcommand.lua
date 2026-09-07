local NewEducateRefreshTalentCommand = class("NewEducateRefreshTalentCommand", pm.SimpleCommand)

function NewEducateRefreshTalentCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.talentId
	local var_1_2 = var_1_0.idx

	pg.ConnectionMgr.GetInstance():Send(29021, {
		id = var_1_0.id,
		talent = var_1_0.talentId
	}, 29022, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(NewEducateProxy):GetCurChar():GetFSM():GetState(NewEducateFSM.SYSTEM.TALENT):OnRefreshTalent(var_1_1, arg_2_0.talent)
			self:sendNotification(GAME.NEW_EDUCATE_REFRESH_TALENT_DONE, {
				idx = var_1_2,
				newId = arg_2_0.talent
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_RefreshTalent: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateRefreshTalentCommand
