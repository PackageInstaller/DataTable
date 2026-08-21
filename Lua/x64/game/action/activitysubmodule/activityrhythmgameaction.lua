local var_0_0 = {}

manager.net:Bind(83124, function(arg_1_0)
	ActivityRhythmGameData:InitStageDataList(arg_1_0.rhythm_stage_list)
	ActivityRhythmGameData:InitUnlockStageData()
	ActivityRhythmGameData:InitUnlockCommandData()
	ActivityRhythmGameData:InitStoryListData(arg_1_0.story_id_list)
end)
manager.net:Bind(83125, function(arg_2_0)
	ActivityRhythmGameData:UpdateStageDataList(arg_2_0)
	ActivityRhythmGameData:InitUnlockCommandData()
end)

function var_0_0.PlayStory(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {
		activity_id = arg_3_0,
		story_id = arg_3_1
	}

	ActivityRhythmGameData:UpdateStoryListData(arg_3_1)
	manager.net:SendWithLoadingNew(83126, var_3_0, 83127, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			arg_3_2()
		else
			ShowTips(GetTips(arg_4_0.result))
		end
	end)
end

return var_0_0
