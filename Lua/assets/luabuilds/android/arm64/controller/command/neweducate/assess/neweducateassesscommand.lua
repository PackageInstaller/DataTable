local var_0_0 = class("NewEducateAssessCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2, var_1_3

	if var_1_0 then
		::label_1_0::

		local var_1_1 = var_1_0.callback

		var_1_2 = var_1_0.rank
		var_1_3 = var_1_0.endlessFail
	end

	;({}).id = var_1_0.id
	;({}).rank = var_1_0.rank

	pg.ConnectionMgr.GetInstance():Send(29013, {}, 29014, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar()

			var_2_0:GetFSM():SetCurNode(arg_2_0.first_node)
			var_2_0:GetFSM():SetSystemNo(NewEducateFSM.SYSTEM.ASSESS)
			var_2_0:GetFSM():GetState(NewEducateFSM.SYSTEM.ASSESS):MarkFinish()

			if var_1_3 then
				var_2_0:GetRoundData():SetEndlessFail()
			end

			var_2_0:AddAssessRecord(var_2_0:GetRoundData().round, var_1_2)
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_ASSESS_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop),
				node = arg_2_0.first_node
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_Assess: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
