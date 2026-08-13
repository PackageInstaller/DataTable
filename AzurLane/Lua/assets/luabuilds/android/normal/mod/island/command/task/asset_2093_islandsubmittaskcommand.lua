class = var_0_10000

local var_0_0 = "IslandSubmitTaskCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskId
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 21038, {
		task_id = var_1_0
	}, 21039, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_2_10003 = var_1.GetIsland(var_2_0)

			local var_2_1 = var_1.GetTaskAgency(var_2_10003)
			local var_2_2 = var_2.GetTask(var_2_1, var_1_0).id == var_2:GetTraceId() or var_2_10003.id == var_2:GetMainTraceId()
			local var_2_3 = var_2_10003:GetExp()
			local var_2_4 = var_2_10003
			local var_2_5 = var_2_10003.GetType(var_2_4)

			IslandTaskType = var_2_4

			if var_2_5 == var_2_4.MAIN then
				IslandAchievementHelper = var_2_5

				local var_2_6 = var_2_5.UpdateRecord

				IslandAchievementType = var_7

				var_2_6(var_7.FINISH_MAIN_TASK, var_1_0, 1)
			end

			local var_2_7 = var_1
			local var_2_8 = var_1.GetInventoryAgency(var_2_7)

			ipairs = var_2_7

			for iter_2_0, iter_2_1 in var_2_7(var_2_10003:GetRecycleItemInfos()) do
				var_2_8:RemoveItem(iter_2_1.id, iter_2_1.count)
			end

			if var_2_10003:getConfig("is_tech_task") == 1 then
				local var_2_9 = var_1:GetTechnologyAgency()

				var_7.TryAutoUnlock(var_2_9)
			end

			var_2:RemoveTask(var_1_0)
			var_2:AddFinishId(var_1_0)

			IslandTaskHelper = var_7

			var_7.OnSubmitTask({
				var_1_0
			})

			IslandDropHelper = var_7

			local var_2_10 = var_7.AddItems(arg_2_0, var_2_3)

			var_2:TryAcceptAutoTasks(function()
				if var_2_2 then
					getProxy = var_0
					IslandProxy = var_3_10001

					local var_3_0 = var_0(var_3_10001)
					local var_3_1 = var_0.GetIsland(var_3_0)
					local var_3_2 = var_0.GetTaskAgency(var_3_1)

					var_0.TryAutoTrackTask(var_3_2)
				end

				return
			end)

			local var_2_11 = arg_1_0
			local var_2_12 = var_8.sendNotification

			GAME = var_10

			var_2_12(var_2_11, var_10.ISLAND_SUBMIT_TASK_DONE, {
				taskId = var_1_0,
				dropData = var_2_10,
				callback = var_1_1
			})

			local var_2_13 = arg_1_0

			var_8.UpdateGuide(var_2_13, var_1_0)
		else
			pg = var_1

			local var_2_14 = var_1.TipsMgr.GetInstance()
			local var_2_15 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_15(var_2_14, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_1.UpdateGuide(arg_4_0, arg_4_1)
	switch = var_1_10002

	local var_4_0 = arg_4_1
	local var_4_1 = {}

	IslandGuideChecker = var_1_10005
	var_4_1[var_1_10005.MOVE_TASK_ID] = function()
		pg = var_2_10000

		local var_5_0 = var_2_10000.m02
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10002

		var_5_1(var_5_0, var_2_10002.STORY_UPDATE, {
			storyId = "ISLAND_GUIDE_2"
		})

		return
	end
	IslandGuideChecker = var_5
	var_4_1[var_5.ORDER_TASK_ID] = function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10002

		var_6_1(var_6_0, var_2_10002.STORY_UPDATE, {
			storyId = "ISLAND_GUIDE_7"
		})

		return
	end
	IslandGuideChecker = var_5
	var_4_1[var_5.INVITE_TASK_ID] = function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10002

		var_7_1(var_7_0, var_2_10002.STORY_UPDATE, {
			storyId = "ISLAND_GUIDE_9"
		})

		return
	end

	var_1_10002(var_4_0, var_4_1, function()
		return
	end)

	return
end

return var_0_1
