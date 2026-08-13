class = var_0_10000

local var_0_0 = "MiniGameTaskProgressUpdateCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().actId
	local var_1_1 = var_2.taskId

	getProxy = var_1_10005
	ActivityTaskProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	getProxy = var_1_10006
	TaskProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)
	local var_1_4

	if not var_1_0 or not var_1_2:getTaskVo(var_1_0, var_1_1) then
		var_1_4 = var_1_3:getTaskById(var_1_1)
	end

	if not var_1_4 then
		return
	end

	local var_1_5 = var_1_4
	local var_1_6 = var_1_4.getConfig(var_1_5, "sub_type")

	tonumber = var_1_5

	local var_1_7 = var_1_4
	local var_1_8 = var_1_5(var_1_4.getConfig(var_1_7, "target_id"))
	local var_1_9 = var_2.progressAdd

	pg = var_1_7

	local var_1_10 = var_1_7.ConnectionMgr.GetInstance()

	var_11.Send(var_1_10, 20016, {
		event_type = var_1_6,
		event_target = var_1_8,
		event_count = var_1_9
	}, 20017, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_1_4.progress + var_1_9

			if var_1_0 then
				var_2_10003 = var_1_2

				var_2.updateProgressBySubType(var_2_10003, var_1_0, var_1_6, var_2_0)
			else
				var_2_10003 = var_1_4

				var_2.updateProgress(var_2_10003, var_2_0)

				var_2_10003 = var_1_3

				var_2.updateTask(var_2_10003, var_1_4)
			end
		else
			pg = var_2_0

			local var_2_1 = var_2_0.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_2(var_2_1, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
