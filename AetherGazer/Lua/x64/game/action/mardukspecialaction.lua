local var_0_0 = {
	Init = function(arg_1_0)
		return
	end
}

manager.net:Bind(64001, function(arg_2_0)
	MardukSpecialData:InitDataFromServer(arg_2_0)
	var_0_0.UpdateNotFightRedPoint(arg_2_0.activity_id)
end)
manager.notify:RegistListener(ACTIVITY_REWARD_GET, function(arg_3_0)
	MardukSpecialData:OnGotReward(arg_3_0.point_reward_id_list)
end)

function var_0_0.UpdateRedPoint(arg_4_0)
	local var_4_0 = false
	local var_4_1 = ActivityCfg[arg_4_0].sub_activity_list

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_2 = MardukSpecialData:GetPoint(iter_4_1)
		local var_4_3

		for iter_4_2, iter_4_3 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[iter_4_1]) do
			local var_4_4 = ActivityPointRewardCfg[iter_4_3]
			local var_4_5 = MardukSpecialData:HaveGotReward(iter_4_1, iter_4_3)

			if var_4_2 >= var_4_4.need and not var_4_5 then
				var_4_0 = true
				var_4_3 = true

				break
			end
		end

		if var_4_3 then
			break
		end
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, arg_4_0), var_4_0 and 1 or 0)
end

function var_0_0.UpdateNotFightRedPoint(arg_5_0)
	local var_5_0 = manager.time:GetServerTime()
	local var_5_1 = true
	local var_5_2

	if MardukSpecialData:GetPoint(arg_5_0) > 0 then
		var_5_2 = false
	else
		local var_5_3 = getData(tostring(arg_5_0), "nextTime")

		var_5_2 = not var_5_3 or not (var_5_0 < var_5_3)
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, arg_5_0), var_5_2 and 1 or 0)
end

function var_0_0.ClickMardukSpecial(arg_6_0)
	saveData(tostring(arg_6_0), "nextTime", _G.gameTimer:GetNextDayFreshTime())
	var_0_0.UpdateNotFightRedPoint(arg_6_0)
end

return var_0_0
