class = var_0_10000

local var_0_0 = "WorldTriggerTaskCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskId
	local var_1_1 = var_2.portId

	nowWorld = var_1_10005

	local var_1_2 = var_1_10005()
	local var_1_3 = var_5.GetTaskProxy(var_1_2)

	WorldTask = var_1_10007

	local var_1_4, var_1_5 = var_1_10007.canTrigger(var_1_0)

	if not var_1_4 then
		pg = var_9

		local var_1_6 = var_9.TipsMgr.GetInstance()

		var_9.ShowTips(var_1_6, var_1_5)

		return
	end

	pg = var_9

	local var_1_7 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_7, 33205, {
		taskId = var_1_0
	}, 33206, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_2

			if var_1_1 then
				local var_2_0 = var_0
				local var_2_1 = var_2_2.GetActiveMap(var_2_0)

				var_2_2 = var_2_2.GetPort(var_2_1)
				underscore = var_2_10002

				local var_2_3 = var_2_10002.rest(var_2_2.taskIds, 1)

				table = var_2_1

				var_2_1.removebyvalue(var_2_3, var_1_0)
				var_2_2:UpdateTaskIds(var_2_3)
			end

			WorldTask = var_2_2

			local var_2_4 = var_2_2.New(arg_2_0.task)

			var_2_4.new = 1
			var_2_10004 = var_1_3

			var_2.addTask(var_2_10004, var_2_4)

			if #var_2_4.config.task_op > 0 then
				pg = var_2
				var_2_10004 = var_2.NewStoryMgr.GetInstance()

				var_2.Play(var_2_10004, var_2_4.config.task_op, nil, true)
			end

			var_2_10004 = arg_1_0

			local var_2_5 = var_2.sendNotification

			GAME = var_5

			var_2_5(var_2_10004, var_5.WORLD_TRIGGER_TASK_DONE, {
				task = var_2_4
			})
		else
			local var_2_7

			if arg_2_0.result == 6 then
				pg = var_2_7

				local var_2_6 = var_2_7.TipsMgr.GetInstance()

				var_2_7 = var_2_7.ShowTips
				i18n = var_2_10004

				var_2_7(var_2_6, var_2_10004("world_task_refuse1"))
			else
				pg = var_2_7

				local var_2_8 = var_2_7.TipsMgr.GetInstance()

				var_1.ShowTips(var_2_8, "trigger task fail:" .. arg_2_0.result)
			end
		end

		return
	end)

	return
end

return var_0_1
