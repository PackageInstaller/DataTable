local var_0_0 = class("NewEducateReplaceTarotCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(29120, {
		id = var_1_0.id,
		tarot_id = var_1_0.tarotId
	}, 29121, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

			var_2_0:GetPriorityState():ClearIds()
			var_2_0:CheckPriorityStystem()
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_REPLACE_TAROT_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_ReplaceTarot_Error: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
