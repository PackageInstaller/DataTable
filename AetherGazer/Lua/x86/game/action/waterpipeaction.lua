local var_0_0 = {}

manager.net:Bind(86013, function(arg_1_0)
	WaterPipeData:InitData(arg_1_0)
end)

function var_0_0.FinishWaterPipeStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_3 = math.floor(arg_2_3 + 0.5)

	manager.net:SendWithLoadingNew(86014, {
		stage_id = arg_2_1,
		activity_id = arg_2_2,
		time = arg_2_3 or 0
	}, 86015, function(arg_3_0, arg_3_1)
		var_0_0:OnFinishWaterPipeStageCallBack(arg_3_0, arg_3_1, arg_2_4)
	end)
end

function var_0_0.OnFinishWaterPipeStageCallBack(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if isSuccess(arg_4_1.result) then
		WaterPipeData:UpdateStageData(arg_4_2.stage_id)

		if arg_4_3 then
			arg_4_3()
		end
	end
end

function var_0_0.FinishWaterPipeLetter(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	manager.net:SendWithLoadingNew(86016, {
		stage_id = arg_5_1,
		activity_id = arg_5_2
	}, 86017, function(arg_6_0, arg_6_1)
		var_0_0:OnFinishWaterPipeLetter(arg_6_0, arg_6_1, arg_5_3)
	end)
end

function var_0_0.OnFinishWaterPipeLetter(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if isSuccess(arg_7_1.result) then
		getReward2(mergeReward2(arg_7_1.reward_list))
		WaterPipeData:UpdateStageData(arg_7_2.stage_id, true)

		if arg_7_3 then
			arg_7_3()
		end
	end
end

return var_0_0
