local var_0_0 = class("IslandSubmitTaskCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(21038, {
		task_id = var_1_0.taskId
	}, 21039, function(arg_2_0)
		local var_2_9000

		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy)
			local var_2_1 = var_2_0.GetIsland(var_2_9000)
			local var_2_2 = var_2_1:GetTaskAgency()
			local var_2_3 = var_2_2:GetTask(var_0)
			local var_2_4 = var_2_0.id == var_2_2:GetTraceId() or var_2_3.id == var_2_2:GetMainTraceId()
			local var_2_5 = var_2_3:GetExp()

			if var_2_3:GetType() == IslandTaskType.MAIN then
				IslandAchievementHelper.UpdateRecord(IslandAchievementType.FINISH_MAIN_TASK, var_0, 1)
			end

			local var_2_6 = var_2_1:GetInventoryAgency()

			for iter_2_0, iter_2_1 in ipairs(var_2_3:GetRecycleItemInfos()) do
				var_2_6:RemoveItem(iter_2_1.id, iter_2_1.count)
			end

			if var_2_3:getConfig("is_tech_task") == 1 then
				var_2_1:GetTechnologyAgency():TryAutoUnlock()
			end

			var_2_2:RemoveTask(var_0)
			var_2_2:AddFinishId(var_0)
			IslandTaskHelper.OnSubmitTask({
				var_0
			})
			var_2_2:TryAcceptAutoTasks(function()
				if var_2_4 then
					getProxy(IslandProxy):GetIsland():GetTaskAgency():TryAutoTrackTask()
				end

				return
			end)
			arg_1_0:sendNotification(GAME.ISLAND_SUBMIT_TASK_DONE, {
				taskId = var_0,
				dropData = IslandDropHelper.AddItems(arg_2_0, var_2_5),
				callback = var_1_1
			})
			arg_1_0:UpdateGuide(var_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_0.UpdateGuide(arg_4_0, arg_4_1)
	switch(arg_4_1, {
		[IslandGuideChecker.MOVE_TASK_ID] = function()
			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = "ISLAND_GUIDE_2"
			})

			return
		end,
		[IslandGuideChecker.ORDER_TASK_ID] = function()
			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = "ISLAND_GUIDE_7"
			})

			return
		end,
		[IslandGuideChecker.INVITE_TASK_ID] = function()
			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = "ISLAND_GUIDE_9"
			})

			return
		end
	}, function()
		return
	end)

	return
end

return var_0_0
