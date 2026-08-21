local var_0_0 = class("MiniGameTaskProgressUpdateCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.actId
	local var_1_2 = getProxy(ActivityTaskProxy)
	local var_1_3 = getProxy(TaskProxy)
	local var_1_4 = var_1_0.actId and getProxy(ActivityTaskProxy):getTaskVo(var_1_0.actId, var_1_0.taskId) or getProxy(TaskProxy):getTaskById(var_1_0.taskId)
	local var_1_5

	if not var_1_4 then
		do return end

		var_1_5 = var_1_0.progressAdd
	end

	;({}).event_type = var_1_4:getConfig("sub_type")
	;({}).event_target = tonumber(var_1_4:getConfig("target_id"))
	;({}).event_count = var_1_0.progressAdd

	pg.ConnectionMgr.GetInstance():Send(20016, {}, 20017, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_1 then
				var_1_2:updateProgressBySubType(var_1_1, var_0, var_1_4.progress + var_1_5)
			else
				var_1_4:updateProgress(var_1_4.progress + var_1_5)
				var_1_3:updateTask(var_1_4)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
