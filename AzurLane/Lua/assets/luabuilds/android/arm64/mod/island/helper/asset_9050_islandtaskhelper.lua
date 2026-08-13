class = var_0_10000

local var_0_0 = var_0_10000("IslandTaskHelper")

function var_0_0.GetRuntimeData(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[1]

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.GetIsland(var_1_1)
	local var_1_3 = var_3.GetCharacterAgency(var_1_2)

	switch = var_1_1

	local var_1_4 = arg_1_0
	local var_1_5 = {}

	IslandTaskTargetType = var_1_10009
	var_1_5[var_1_10009.RECYCLE] = function()
		local var_2_0 = var_0
		local var_2_1 = var_0.GetInventoryAgency(var_2_0)

		return var_0.GetOwnCount(var_2_1, var_1_0)
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.TECHNOLOGY] = function()
		local var_3_0 = var_0
		local var_3_1 = var_0.GetTechnologyAgency(var_3_0)

		return var_0.IsFinishedTech(var_3_1, var_1_0) and 1 or 0
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.ISLAND_LV] = function()
		local var_4_0 = var_0

		return var_0.GetLevel(var_4_0)
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.FRAGMENT] = function()
		local var_5_0 = var_0
		local var_5_1 = var_0.GetWildCollectAgency(var_5_0)

		return var_0.ExistFragment(var_5_1, var_1_0) and 1 or 0
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.UNLOCK_SHIP] = function()
		local var_6_0 = var_1_3

		return var_0.GetShipById(var_6_0, var_1_0) and 1 or 0
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.FURNITURE] = function()
		local var_7_0 = var_0
		local var_7_1 = var_0.GetAgoraAgency(var_7_0)
		local var_7_2

		if var_1_0 ~= 0 or not #var_7_1:GetFurnitures() then
			var_7_2 = #var_7_1:GetFurnituresByType(var_1_0)
		end

		return var_7_2
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.COMMANDER_DRESS] = function()
		local var_8_0 = var_0
		local var_8_1 = var_0.GetDressUpAgency(var_8_0)
		local var_8_2

		if var_1_0 ~= 0 or not #var_8_1:GetAllHasDress() then
			var_8_2 = #var_8_1:GetHasDressByType(var_1_0)
		end

		return var_8_2
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.SHIP_DRESS] = function()
		if var_1_0 == 0 then
			local var_9_0 = var_1_3
			local var_9_2

			if not var_0.GetDiffDressCnt(var_9_0) then
				local var_9_1 = var_1_3

				var_9_2 = var_0.GetDiffDressCntByType(var_9_1, var_1_0)
			end

			return var_9_2
		end
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.SHIP_SKIN] = function()
		if var_1_0 == 0 then
			local var_10_0 = var_1_3
			local var_10_2

			if not var_0.GetAllSkinCnt(var_10_0) then
				local var_10_1 = var_1_3

				var_10_2 = #var_0.GetOwnSkinListByShipId(var_10_1, var_1_0)
			end

			return var_10_2
		end
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.SKIN_ALL_COLOR] = function()
		local var_11_0 = var_1_3

		return var_0.GetSkinData(var_11_0, var_1_0) and var_0:IsOwnAllColor() and 1 or 0
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.SKIN_COLOR] = function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.island_skin_colordiff_template[var_1_0].skin_group
		local var_12_1 = var_1_3

		return var_1.GetSkinData(var_12_1, var_12_0) and var_1:CheckColorOwned(var_1_0) and 1 or 0
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.ACHIEVEMENT] = function()
		local var_13_0 = var_0
		local var_13_1 = var_0.GetAchievementAgency(var_13_0)

		return var_0.IsGot(var_13_1, var_1_0) and 1 or 0
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.TASK] = function()
		pg = var_2_10000

		local var_14_2

		if var_2_10000.island_task[var_1_0].count_offset == 1 then
			local var_14_0 = var_0
			local var_14_1 = var_0.GetTaskAgency(var_14_0)

			if var_0.IsFinishTask(var_14_1, var_1_0) then
				var_14_2 = 1

				goto label_14_0
			end
		end

		var_14_2 = 0

		::label_14_0::

		return var_14_2
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.TASK_TYPE_PLUS] = function()
		local var_15_0 = var_0
		local var_15_1 = var_0.GetTaskAgency(var_15_0)

		return var_0.GetFinishCntByType(var_15_1, var_1_0, true)
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.RESTAURANT_RANK] = function()
		local var_16_0 = var_0
		local var_16_1 = var_0.GetManageAgency(var_16_0)

		return var_0.GetCntByRestLevel(var_16_1, var_1_0)
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.STORY] = function()
		pg = var_2_10000

		local var_17_0 = var_2_10000.NewStoryMgr.GetInstance()
		local var_17_1 = var_0.StoryId2StoryName(var_17_0, var_1_0)

		return var_0:IsPlayed(var_17_1) and 1 or 0
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.ACTION] = function()
		local var_18_0 = var_0
		local var_18_1 = var_0.GetActionAgency(var_18_0)

		return var_0.ExistAction(var_18_1, var_1_0) and 1 or 0
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.COMMANDER_DRESS_ID] = function()
		local var_19_0 = var_0
		local var_19_1 = var_0.GetDressUpAgency(var_19_0)

		return var_0.CheckOwnDress(var_19_1, var_1_0) and 1 or 0
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.SHIP_DRESS_ID] = function()
		local var_20_0 = var_1_3

		return var_0.GetDressIdRealCount(var_20_0, var_1_0)
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.ACTIVITY_ORDER] = function()
		local var_21_0 = var_0
		local var_21_1 = var_0.GetOrderAgency(var_21_0)

		return var_0.GetFinishedCntByActId(var_21_1, var_1_0)
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.ORDER_DAILY] = function()
		local var_22_0 = var_0
		local var_22_1 = var_0.GetOrderAgency(var_22_0)

		return var_0.GetFinishCnt(var_22_1)
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.ACTION_HELLO_DAILY] = function()
		local var_23_0 = var_0
		local var_23_1 = var_0.GetNpcFeedbackAgency(var_23_0)

		return #var_0.GetNpcList(var_23_1)
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.TASK_DAILY_IN_WEEK] = function()
		local var_24_0 = var_0
		local var_24_1 = var_0.GetTaskAgency(var_24_0)

		return var_0.GetFinishedDailyCntInWeek(var_24_1)
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.GAME_MAX_SCORE] = function()
		pg = var_2_10000

		local var_25_0 = var_2_10000.mode_room[var_1_0].activity_type

		getProxy = var_1
		ActivityProxy = var_2_10003

		local var_25_1 = var_1(var_2_10003)
		local var_25_2

		if not var_1.getActivityByType(var_25_1, var_25_0) or not var_1.data2 then
			var_25_2 = 0
		end

		return var_25_2
	end
	IslandTaskTargetType = var_9
	var_1_5[var_9.GAME_CUR_SCORE] = function()
		pg = var_2_10000

		local var_26_0 = var_2_10000.mode_room[var_1_0].activity_type

		getProxy = var_1
		ActivityProxy = var_2_10003

		local var_26_1 = var_1(var_2_10003)
		local var_26_2

		if not var_1.getActivityByType(var_26_1, var_26_0) or not var_1.data1 then
			var_26_2 = 0
		end

		return var_26_2
	end

	return var_1_1(var_1_4, var_1_5, function()
		assert = var_2_10000

		var_2_10000(false, "not exist runtime type: " .. arg_1_0)

		return
	end)
end

function var_0_0.UpdateRuntimeTaskByTargetType(arg_28_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_28_0 = var_1_10001(var_1_10003)
	local var_28_1 = var_1.GetIsland(var_28_0)
	local var_28_2 = var_1.GetTaskAgency(var_28_1)

	pairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(var_28_2:GetTasks()) do
		if iter_28_1:ExistTargetType(arg_28_0) then
			var_28_2:UpdateTask(iter_28_1)
		end
	end

	return
end

function var_0_0.UpdateClientTaskProgress(arg_29_0, arg_29_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_29_0 = var_1_10002(var_1_10004)
	local var_29_1 = var_2.GetIsland(var_29_0)
	local var_29_2 = var_2.GetTaskAgency(var_29_1)
	local var_29_3 = var_2.GetDiffTargetIdsByTypeAndParam(var_29_2, arg_29_0, arg_29_1)

	ipairs = var_29_1

	for iter_29_0, iter_29_1 in var_29_1(var_29_3) do
		pg = var_1_10009

		local var_29_4 = var_1_10009.m02

		var_1_10009 = var_1_10009.sendNotification
		GAME = var_1_10012

		var_1_10009(var_29_4, var_1_10012.ISLAND_UPDATE_TASK, {
			progress = 1,
			taskId = 0,
			targetId = iter_29_1
		})
	end

	return
end

function var_0_0.OnApproach(arg_30_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_31_0)
			local var_31_0 = {}

			pairs = var_2_10002
			getProxy = var_2_10004
			IslandProxy = var_2_10006

			local var_31_1 = var_2_10004(var_2_10006)
			local var_31_2 = var_4.GetIsland(var_31_1)
			local var_31_3 = var_4.GetTaskAgency(var_31_2)

			for iter_31_0, iter_31_1 in var_2_10002(var_4.GetCanAcceptTasks(var_31_3)) do
				if iter_31_1:CheckAcceptOnApproach(arg_30_0) then
					table = var_7

					var_7.insert(var_31_0, iter_31_1.id)
				end
			end

			if #var_31_0 > 0 then
				pg = var_2

				local var_31_4 = var_2.m02
				local var_31_5 = var_2.sendNotification

				GAME = iter_31_0

				var_31_5(var_31_4, iter_31_0.ISLAND_ACCEPT_TASK, {
					taskIds = var_31_0,
					callback = arg_31_0
				})
			else
				arg_31_0()
			end

			return
		end,
		function(arg_32_0)
			local var_32_0 = {}

			pairs = var_2_10002
			getProxy = var_2_10004
			IslandProxy = var_2_10006

			local var_32_1 = var_2_10004(var_2_10006)
			local var_32_2 = var_4.GetIsland(var_32_1)
			local var_32_3 = var_4.GetTaskAgency(var_32_2)

			for iter_32_0, iter_32_1 in var_2_10002(var_4.GetCanSubmitTasks(var_32_3)) do
				if iter_32_1:CheckSubmitOnApproach(arg_30_0) then
					table = var_7

					var_7.insert(var_32_0, iter_32_1.id)
				end
			end

			local var_32_4 = {}

			ipairs = var_3

			for iter_32_2, iter_32_3 in var_3(var_32_0) do
				table = var_2_10008

				var_2_10008.insert(var_32_4, function(arg_33_0)
					pg = var_3_10001

					local var_33_0 = var_3_10001.m02
					local var_33_1 = var_1.sendNotification

					GAME = var_3_10004

					var_33_1(var_33_0, var_3_10004.ISLAND_SUBMIT_TASK, {
						taskId = iter_32_3,
						callback = arg_33_0
					})

					return
				end)
			end

			seriesAsync = var_3

			var_3(var_32_4, arg_32_0)

			return
		end
	}, function()
		local var_34_0 = var_0_0.UpdateClientTaskProgress

		IslandTaskTargetType = var_2_10002

		var_34_0(var_2_10002.APPROACH, arg_30_0)

		return
	end)

	return
end

function var_0_0.OnActionEnd(arg_35_0)
	local var_35_0 = var_0_0.UpdateClientTaskProgress

	IslandTaskTargetType = var_1_10003

	var_35_0(var_1_10003.ACTION_END, arg_35_0)

	local var_35_1 = var_0_0.UpdateClientTaskProgress

	IslandTaskTargetType = var_3

	var_35_1(var_3.ACTION_END, 0)

	return
end

function var_0_0.OnSubmitTask(arg_36_0)
	IslandTaskHelper = var_1_10001

	local var_36_0 = var_1_10001.UpdateRuntimeTaskByTargetType

	IslandTaskTargetType = var_1_10003

	var_36_0(var_1_10003.TASK)

	IslandTaskHelper = var_36_0

	local var_36_1 = var_36_0.UpdateRuntimeTaskByTargetType

	IslandTaskTargetType = var_3

	var_36_1(var_3.TASK_TYPE_PLUS)

	underscore = var_36_1

	if var_36_1.any(arg_36_0, function(arg_37_0)
		pg = var_2_10001

		local var_37_0 = var_2_10001.island_task[arg_37_0].type

		IslandTaskType = var_2_10003

		return var_37_0 == var_2_10003.DAILY and var_1.count_offset == 1
	end) then
		IslandTaskHelper = var_1

		local var_36_2 = var_1.UpdateRuntimeTaskByTargetType

		IslandTaskTargetType = var_3

		var_36_2(var_3.TASK_DAILY_IN_WEEK)
	end

	return
end

function var_0_0._GetTaskAcceptStoryId(arg_38_0)
	pg = var_1_10001

	local var_38_0 = var_1_10001.island_task[arg_38_0].rec_perform

	pg = var_1_10002

	local var_38_1 = var_1_10002.NewStoryMgr.GetInstance()

	return var_2.StoryName2StoryId(var_38_1, var_38_0)
end

function var_0_0._GetTaskTargetLinkStoryIds(arg_39_0)
	pg = var_1_10001

	local var_39_0 = var_1_10001.island_task_target[arg_39_0].type

	IslandTaskTargetType = var_1_10003

	if var_39_0 ~= var_1_10003.INTERACTION then
		return nil
	end

	pg = var_39_0

	local var_39_1 = var_39_0.island_task_target[arg_39_0].target_param[1]

	pg = var_3

	local var_39_2 = var_3.island_interaction[var_39_1].type

	IslandInteractionUntil = var_1_10005

	local var_39_4

	if var_39_2 == var_1_10005.TYPE_STORY then
		pg = var_39_2

		local var_39_3 = var_39_2.NewStoryMgr.GetInstance()

		if not var_4.StoryName2StoryId(var_39_3, var_3.param) or not {
			var_4
		} then
			var_39_4 = nil
		end

		return var_39_4
	else
		local var_39_5 = var_3.type

		IslandInteractionUntil = var_39_4

		if var_39_5 == var_39_4.TYPE_PERFORMANCE then
			IslandPerformancePerformer = var_39_5

			return var_39_5.GetStoryNameList(var_3.param)
		end
	end

	return nil
end

function var_0_0._GetTaskSubmitStoryIds(arg_40_0)
	pg = var_1_10001

	if not var_1_10001.island_task[arg_40_0].com_perform[1] then
		return nil
	end

	local var_40_0 = var_1[2]

	if var_2 == 1 then
		pg = var_1_10004

		local var_40_1 = var_1_10004.NewStoryMgr.GetInstance()
		local var_40_2

		if not var_1_10004.StoryName2StoryId(var_40_1, var_40_0) or not {
			var_1_10004
		} then
			var_40_2 = nil
		end

		return var_40_2
	elseif var_2 == 2 then
		IslandPerformancePerformer = var_1_10004

		return var_1_10004.GetStoryNameList(var_40_0)
	end

	return nil
end

function var_0_0._GetTaskLinkStoryIds(arg_41_0)
	local var_41_0 = {}

	if var_0_0._GetTaskAcceptStoryId(arg_41_0.id) then
		table = var_1_10003

		var_1_10003.insert(var_41_0, var_2)
	end

	ipairs = var_1_10003

	for iter_41_0, iter_41_1 in var_1_10003(arg_41_0:GetTargetList()) do
		if iter_41_1:IsFinish() and var_0_0._GetTaskTargetLinkStoryIds(iter_41_1.id) then
			table = var_1_10009

			var_1_10009.insertto(var_41_0, var_8)
		end
	end

	return var_41_0
end

function var_0_0._GetFinishTaskLinkStoryIds(arg_42_0)
	local var_42_0 = {}

	if var_0_0._GetTaskAcceptStoryId(arg_42_0) then
		table = var_1_10003

		var_1_10003.insert(var_42_0, var_2)
	end

	ipairs = var_1_10003
	pg = var_1_10005

	for iter_42_0, iter_42_1 in var_1_10003(var_1_10005.island_task[arg_42_0].target_id) do
		if var_0_0._GetTaskTargetLinkStoryIds(iter_42_1) then
			table = var_1_10009

			var_1_10009.insertto(var_42_0, var_8)
		end
	end

	if var_0_0._GetTaskSubmitStoryIds(arg_42_0) then
		table = var_4

		var_4.insertto(var_42_0, var_3)
	end

	return var_42_0
end

function var_0_0.FixTaskLinksStory(arg_43_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_43_0 = var_1_10001(var_1_10003)
	local var_43_1 = var_1.GetIsland(var_43_0)
	local var_43_2 = var_1.GetTaskAgency(var_43_1)
	local var_43_3 = {}

	pairs = var_43_1

	for iter_43_0, iter_43_1 in var_43_1(var_43_2:GetTasks()) do
		table = var_1_10008

		var_1_10008.insertto(var_43_3, var_0_0._GetTaskLinkStoryIds(iter_43_1))
	end

	ipairs = var_3

	for iter_43_2, iter_43_3 in var_3(var_43_2:GetFinishedIds()) do
		table = var_1_10008

		var_1_10008.insertto(var_43_3, var_0_0._GetFinishTaskLinkStoryIds(iter_43_3))
	end

	for iter_43_4 = 3110000, 3119999 do
		pg = iter_43_3

		local var_43_4 = iter_43_3.NewStoryMgr.GetInstance()

		if iter_43_3.StoryId2StoryName(var_43_4, iter_43_4) then
			pg = var_1_10008

			local var_43_5 = var_1_10008.NewStoryMgr.GetInstance()

			if var_1_10008.GetPlayedFlag(var_43_5, iter_43_4) then
				IslandPerformancePerformer = var_1_10008
				var_1_10008 = var_1_10008.GetStoryNameList(iter_43_3)
				ipairs = var_43_4

				for iter_43_5, iter_43_6 in var_43_4(var_1_10008) do
					table = var_1_10014

					var_1_10014.insert(var_43_3, iter_43_6)
				end
			end
		end
	end

	if #var_43_3 > 0 then
		pg = var_3

		local var_43_6 = var_3.m02
		local var_43_7 = var_3.sendNotification

		GAME = iter_43_4

		var_43_7(var_43_6, iter_43_4.STORY_UPDATE_LIST, {
			storyIds = var_43_3,
			callback = arg_43_0
		})
	else
		arg_43_0()
	end

	return
end

return var_0_0
