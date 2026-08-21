local var_0_0 = {}

manager.net:Bind(60201, function(arg_1_0)
	if arg_1_0.activity_id == ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME then
		OsirisPlayGameData:InitActivityPointData(arg_1_0)
	elseif arg_1_0.activity_id == ActivityConst.ACTIVITY_ACCUMULATE_4_0 then
		ActivityAccumulativeData:InitData(arg_1_0)
		manager.notify:Invoke(ACCUMULATIVEGACHA_UPDATE)
	elseif arg_1_0.activity_id == ActivityConst.ACTIVITY_ACCUMULATE_5_0 then
		ActivityAccumulativeData:InitData(arg_1_0)
		manager.notify:Invoke(ACCUMULATIVEGACHA_UPDATE)
	elseif arg_1_0.activity_id == ActivityConst.ACTIVITY_ASH_MAIN then
		AshSystemData:InitActivityPointData(arg_1_0)
		AshSystemData:UpdateTaskRedPoint()
	end
end)

function var_0_0.GetAccumulateReward(arg_2_0, arg_2_1)
	local var_2_0 = {
		point_reward_id_list = {
			arg_2_0
		}
	}

	manager.net:SendWithLoadingNew(60054, var_2_0, 60055, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			getReward2(arg_3_0.reward_list)
			ActivityAccumulativeData:RefreshData(arg_2_0)
			manager.notify:Invoke(ACCUMULATIVEGACHA_UPDATE)

			if arg_2_1 then
				arg_2_1()
			end
		else
			ShowTips(arg_3_0.result)
		end
	end)
end

return var_0_0
