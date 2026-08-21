local var_0_0 = {}

manager.net:Bind(68171, function(arg_1_0)
	OsirisPlayGameData:Init(arg_1_0)
	OsirisPlayGameData:InitRedPointGroup()
end)
manager.net:Bind(68173, function(arg_2_0)
	OsirisPlayGameData:UpdatePassStages(arg_2_0)
	OsirisPlayGameData:UpdateOsirisTaskRedPoint()
end)
manager.net:Bind(68175, function(arg_3_0)
	OsirisPlayGameData:UpdatePassChapters(arg_3_0)
	OsirisPlayGameData:UpdateOsirisTaskRedPoint()
end)
manager.net:Bind(68177, function(arg_4_0)
	OsirisPlayGameData:UpdateCurStageInfo(arg_4_0)
end)

function var_0_0.GetPointReward(arg_5_0)
	local var_5_0 = {
		point_reward_id_list = arg_5_0
	}

	manager.net:SendWithLoadingNew(60054, var_5_0, 60055, function(arg_6_0)
		if isSuccess(arg_6_0.result) then
			getReward2(mergeReward2(arg_6_0.reward_list))
			OsirisPlayGameData:RefreshTaskData(arg_5_0)
		else
			ShowTips(arg_6_0.result)
		end
	end)
end

return var_0_0
