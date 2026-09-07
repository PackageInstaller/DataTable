local BlackWhiteGridOPCommand = class("BlackWhiteGridOPCommand", pm.SimpleCommand)

function BlackWhiteGridOPCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_3 = var_1_0.score

	if var_1_0.score < 0 then
		return
	end

	local var_1_4 = getProxy(ActivityProxy)
	local var_1_5 = var_1_4:getActivityById(var_1_0.activityId)

	if not var_1_5 or var_1_5:isEnd() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = var_1_0.activityId,
		arg1 = var_1_0.id,
		arg2 = var_1_0.score,
		arg_list = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			if not table.contains(var_1_5.data1_list, var_1_1) then
				table.insert(var_1_5.data1_list, var_1_1)
			end

			local var_2_0 = table.indexof(var_1_5.data1_list, var_1_1)

			assert(var_2_0)

			var_1_5.data2_list[var_2_0] = var_1_3

			var_1_4:updateActivity(var_1_5)
			self:sendNotification(GAME.BLACK_WHITE_GRID_OP_DONE, {
				awards = PlayerConst.addTranDrop(arg_2_0.award_list)
			})
		else
			originalPrint(arg_2_0.result)
		end

		return
	end)

	return
end

return BlackWhiteGridOPCommand
