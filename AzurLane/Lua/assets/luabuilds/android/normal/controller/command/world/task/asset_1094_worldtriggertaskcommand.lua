class = var_0_10000

local var_0_0 = "WorldTriggerTaskCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskId
	local var_1_1 = var_2.portId

	nowWorld = var_1_10005

	local var_1_2 = var_1_10005()
	local var_1_3 = var_5.GetTaskProxy(var_1_2)

	WorldTask = var_1_2

	local var_1_4, var_1_5 = var_1_2.canTrigger(var_1_0)

	if not var_1_4 then
		pg = var_1_10009

		local var_1_6 = var_1_10009.TipsMgr.GetInstance()

		var_1_10009.ShowTips(var_1_6, var_1_5)

		return
	end

	pg = var_1_10009

	local var_1_7 = var_1_10009.ConnectionMgr.GetInstance()

	var_9.Send(var_1_7, 33205, {
		taskId = var_1_0
	}, 33206, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_2

			if var_1_1 then
				local var_2_0 = var_0
				local var_2_1 = var_2_2.GetActiveMap(var_2_0)

				var_2_2 = var_2_2.GetPort(var_2_1)
				underscore = var_2_1

				local var_2_3 = var_2_1.rest(var_2_2.taskIds, 1)

				table = var_2_10003

				var_2_10003.removebyvalue(var_2_3, var_1_0)
				var_2_2:UpdateTaskIds(var_2_3)
			end

			WorldTask = var_2_2

			local var_2_4 = var_2_2.New(arg_2_0.task)

			var_2_4.new = 1
			var_2_10003 = var_1_3

			var_2.addTask(var_2_10003, var_2_4)

			local var_2_5 = #var_2_4.config.task_op

			if 0 < var_2_5 then
				pg = var_2_5
				var_2_10003 = var_2_5.NewStoryMgr.GetInstance()

				var_2.Play(var_2_10003, var_2_4.config.task_op, nil, true)
			end

			var_2_10003 = arg_1_0

			local var_2_6 = var_2.sendNotification

			GAME = var_4

			var_2_6(var_2_10003, var_4.WORLD_TRIGGER_TASK_DONE, {
				task = var_2_4
			})
		else
			local var_2_8

			if arg_2_0.result == 6 then
				pg = var_2_8

				local var_2_7 = var_2_8.TipsMgr.GetInstance()

				var_2_8 = var_2_8.ShowTips
				i18n = var_2_10003

				var_2_8(var_2_7, var_2_10003("world_task_refuse1"))
			else
				pg = var_2_8

				local var_2_9 = var_2_8.TipsMgr.GetInstance()

				var_1.ShowTips(var_2_9, "trigger task fail:" .. arg_2_0.result)
			end
		end

		return
	end)

	return
end

return var_0_1
