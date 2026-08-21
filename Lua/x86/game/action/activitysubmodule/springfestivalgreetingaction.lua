local var_0_0 = {}

manager.net:Bind(64041, function(arg_1_0)
	SpringFestivalGreetingData:InitData(arg_1_0)
end)

function var_0_0.GetGreetingReward(arg_2_0, arg_2_1, arg_2_2)
	manager.net:SendWithLoadingNew(60054, {
		point_reward_id_list = {
			arg_2_1
		}
	}, 60055, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			SpringFestivalGreetingData:ReceiveReward(arg_2_0)
		end

		arg_2_2(arg_3_0)
	end)
end

return var_0_0
