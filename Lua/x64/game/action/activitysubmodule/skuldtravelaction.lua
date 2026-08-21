local var_0_0 = {}

manager.net:Bind(24019, function(arg_1_0)
	SkuldTravelData:SetData(arg_1_0)
	manager.notify:CallUpdateFunc(SKULD_STATE_CHANGE)
end)

function var_0_0.GotoTravel(arg_2_0, arg_2_1)
	manager.net:SendWithLoadingNew(24020, {
		plot_id = arg_2_1
	}, 24021, handler(arg_2_0, arg_2_0.OnGotoTravel))
end

function var_0_0.OnGotoTravel(arg_3_0, arg_3_1, arg_3_2)
	if isSuccess(arg_3_1.result) then
		SkuldTravelData:SetTravelStatu(1)
		JumpTools.OpenPageByJump("skuldTravelTipsView")
		manager.notify:CallUpdateFunc(SKULD_STATE_CHANGE)
	else
		ShowTips(arg_3_1.result)
	end
end

function var_0_0.OpenEnding(arg_4_0, arg_4_1)
	manager.net:SendWithLoadingNew(24022, {
		ending_id = arg_4_1
	}, 24023, handler(arg_4_0, arg_4_0.OnOpenEnding))
end

function var_0_0.OnOpenEnding(arg_5_0, arg_5_1, arg_5_2)
	if isSuccess(arg_5_1.result) then
		SkuldTravelData:OpenEnding(arg_5_2.ending_id)

		if table.indexof(TravelSkuldEndingCfg.all, arg_5_2.ending_id) > 3 then
			local var_5_0 = GameSetting.travel_skuld_new_ending_stage_id.value[1]

			BattleController.GetInstance():LaunchStoryBattle(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, var_5_0, 0)
		else
			JumpTools.OpenPageByJump("skuldTravelFinalPlotView", {
				endingid = arg_5_2.ending_id
			})
		end

		manager.notify:CallUpdateFunc(SKULD_OPENENDING)
	else
		ShowTips(arg_5_1.result)
	end
end

function var_0_0.GetTravelReward(arg_6_0, arg_6_1)
	manager.net:SendWithLoadingNew(24024, {
		task_id = arg_6_1
	}, 24025, handler(arg_6_0, arg_6_0.OnGetTravelReward))
end

function var_0_0.OnGetTravelReward(arg_7_0, arg_7_1, arg_7_2)
	if isSuccess(arg_7_1.result) then
		getReward2(arg_7_1.reward_list)
		SkuldTravelData:GetedTaskReward(arg_7_2.task_id)
		manager.notify:CallUpdateFunc(SKULD_GETREWARD)
	else
		ShowTips(arg_7_1.result)
	end
end

function var_0_0.ReadTravelResult(arg_8_0)
	manager.net:SendWithLoadingNew(24026, {}, 24027, handler(arg_8_0, arg_8_0.OnReadTravelResult))
end

function var_0_0.OnReadTravelResult(arg_9_0, arg_9_1)
	if isSuccess(arg_9_1.result) then
		SkuldTravelData:SetTravelStatu(0)
		manager.notify:CallUpdateFunc(SKULD_STATE_CHANGE)
	else
		ShowTips(arg_9_1.result)
	end
end

function var_0_0.CheckUnBindActivitySkuld(arg_10_0)
	local var_10_0 = RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	local var_10_1 = RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	local var_10_2 = RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	local var_10_3 = RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	local var_10_4 = RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_1_6) then
		manager.redPoint:addGroup(var_10_0, {
			var_10_3,
			var_10_1,
			var_10_2
		})
		manager.redPoint:addGroup(var_10_4, {
			var_10_3,
			var_10_1,
			var_10_2
		})
	else
		manager.redPoint:delGroup(var_10_0, {
			var_10_3,
			var_10_1
		})
	end
end

function var_0_0.CheckUnBindChapterKey(arg_11_0)
	local var_11_0 = RedPointConst.TRAVEL_SKULD_CHAPTER .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	local var_11_1 = RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_1_6) then
		manager.redPoint:addGroup(var_11_0, {
			var_11_1
		})
	elseif ChapterTools.IsFinishPreChapter(SkuldTravelData:GetChapterID()) then
		manager.redPoint:addGroup(var_11_0, {
			var_11_1
		})
	else
		manager.redPoint:delGroup(var_11_0, {
			var_11_1
		})
	end
end

return var_0_0
