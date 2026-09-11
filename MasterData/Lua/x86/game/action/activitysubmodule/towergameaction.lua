local var_0_0 = {}

manager.net:Bind(61075, function(arg_1_0)
	TowerGameData:SetData(arg_1_0)
	manager.notify:CallUpdateFunc(TOWERGAME_REFRESH)
end)
manager.net:Bind(61079, function(arg_2_0)
	TowerGameData:SetSeverPoint(arg_2_0.point)
end)

function var_0_0.GetReward(arg_3_0, arg_3_1)
	manager.net:SendWithLoadingNew(61076, {
		point_id = arg_3_1
	}, 61077, function(arg_4_0, arg_4_1)
		if isSuccess(arg_4_0.result) then
			TowerGameData:GetReward(arg_4_1.point_id)
			getReward2(arg_4_0.reward_list)
			manager.notify:CallUpdateFunc(TOWERGAME_GETREWARD)
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

return var_0_0
