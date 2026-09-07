local ActivityCardPuzzleCombatCommand = class("ActivityCardPuzzleCombatCommand", pm.SimpleCommand)

function ActivityCardPuzzleCombatCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2 = getProxy(ActivityProxy):getActivityById(var_1_0.activity_id)

	if not var_1_2 or var_1_2:isEnd() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		arg2 = 0,
		activity_id = var_1_0.activity_id,
		arg1 = var_1_0.arg1,
		arg_list = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			if not table.contains(var_1_2.data2_list, var_1_0.arg1) then
				table.insert(var_1_2.data2_list, var_1_0.arg1)
				getProxy(ActivityProxy):updateActivity(var_1_2)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return ActivityCardPuzzleCombatCommand
