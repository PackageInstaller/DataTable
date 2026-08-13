class = var_0_10000

local var_0_0 = "WorldTriggerDailyTaskCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskIds

	nowWorld = var_1_10004

	local var_1_1 = var_1_10004()
	local var_1_2 = var_4.GetTaskProxy(var_1_1)

	pg = var_1_1

	local var_1_3 = var_1_1.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 7, {
		task_list = var_1_0
	}, 8, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2
			local var_2_1 = var_1.getDailyTaskIds(var_2_0)

			ipairs = var_2_0

			for iter_2_0, iter_2_1 in var_2_0(arg_2_0.task_list) do
				WorldTask = var_2_10007
				var_2_10007 = var_2_10007.New(iter_2_1)
				var_2_10007.new = 1
				table = var_8

				var_8.removebyvalue(var_2_1, var_2_10007.id)

				local var_2_2 = var_1_2

				var_8.addTask(var_2_2, var_2_10007)

				if #var_2_10007.config.task_op > 0 then
					pg = var_8

					local var_2_3 = var_8.NewStoryMgr.GetInstance()

					var_8.Play(var_2_3, var_2_10007.config.task_op, nil, true)
				end

				local var_2_4 = arg_1_0
				local var_2_5 = var_8.sendNotification

				GAME = var_10

				var_2_5(var_2_4, var_10.WORLD_TRIGGER_TASK_DONE, {
					task = var_2_10007
				})
			end

			var_2_10003 = var_1_2

			var_2.UpdateDailyTaskIds(var_2_10003, var_2_1)

			var_2_10003 = arg_1_0

			local var_2_6 = var_2.sendNotification

			GAME = var_4

			var_2_6(var_2_10003, var_4.WORLD_TRIGGER_DAILY_TASK_DONE)
		elseif arg_2_0.result == 6 then
			pg = var_1

			local var_2_7 = var_1.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			i18n = var_2_10003

			var_2_8(var_2_7, var_2_10003("world_task_refuse1"))
		else
			local var_2_10

			if arg_2_0.result == 20 then
				pg = var_2_10

				local var_2_9 = var_2_10.TipsMgr.GetInstance()

				var_2_10 = var_2_10.ShowTips
				i18n = var_2_10003

				var_2_10(var_2_9, var_2_10003("world_sametask_tip"))
			else
				pg = var_2_10

				local var_2_11 = var_2_10.TipsMgr.GetInstance()

				var_1.ShowTips(var_2_11, "trigger task fail:" .. arg_2_0.result)
			end
		end

		return
	end)

	return
end

return var_0_1
