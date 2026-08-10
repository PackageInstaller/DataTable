local var_0_0 = singletonClass("ActivityMultiRewardData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = 0
local var_0_5 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_5 = {}

	for iter_1_0, iter_1_1 in ipairs(ActivityMultiRewardCfg.all) do
		local var_1_0 = ActivityMultiRewardCfg[iter_1_1]

		if not var_0_1[var_1_0.activity_id] then
			var_0_1[var_1_0.activity_id] = {}
			var_0_1[var_1_0.activity_id].ratio = var_1_0.reward_ratio
			var_0_1[var_1_0.activity_id].count = var_1_0.count
		elseif var_0_1[var_1_0.activity_id].ratio ~= var_1_0.reward_ratio or var_0_1[var_1_0.activity_id].count ~= var_1_0.count then
			Debug.LogError("多倍掉落的活动配置表出现错误！！！")

			return
		end

		if not var_0_5[var_1_0.chapter_id] then
			var_0_5[var_1_0.chapter_id] = {}
		end

		if not table.keyof(var_0_5[var_1_0.chapter_id], var_1_0.activity_id) then
			table.insert(var_0_5[var_1_0.chapter_id], var_1_0.activity_id)
		end
	end

	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = 0
end

function var_0_0.GetCountByActivityID(arg_2_0, arg_2_1)
	return var_0_2[arg_2_1].count, var_0_1[arg_2_1].count
end

function var_0_0.GetTimeByActivityID(arg_3_0, arg_3_1)
	return var_0_2[arg_3_1].time
end

function var_0_0.GetLastBattleMultiData(arg_4_0)
	if var_0_4 == 0 then
		return 0
	end

	return var_0_2[var_0_4].count, var_0_1[var_0_4].count, var_0_1[var_0_4].ratio
end

function var_0_0.GetBattleUseMultiCount(arg_5_0)
	if var_0_4 == 0 then
		return 0
	end

	local var_5_0 = (var_0_3[var_0_4] and var_0_3[var_0_4].count or 0) - var_0_2[var_0_4].count

	var_0_3[var_0_4] = var_0_2[var_0_4]

	return var_5_0
end

function var_0_0.ParseBattleMultiReward(arg_6_0, arg_6_1)
	var_0_3[arg_6_1.activity_id] = var_0_2[arg_6_1.activity_id]
	var_0_2[arg_6_1.activity_id] = {
		count = arg_6_1.count,
		time = arg_6_1.next_refresh_time
	}
	var_0_4 = arg_6_1.activity_id
end

function var_0_0.CheckMultiReward(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(var_0_2) do
		if ActivityData:GetActivityIsOpen(iter_7_0) then
			return true
		end
	end

	return false
end

function var_0_0.GetMultiRatioByChapterOrToggle(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0:CheckMultiReward() then
		return 0
	end

	local var_8_0 = 0
	local var_8_1

	if arg_8_1 then
		local var_8_2 = ChapterClientCfg.get_id_list_by_toggle[arg_8_1]

		if var_8_2 then
			local var_8_3 = false

			for iter_8_0, iter_8_1 in ipairs(var_8_2) do
				if var_8_3 then
					break
				end

				activityList = var_0_5[iter_8_1]

				if activityList then
					for iter_8_2, iter_8_3 in ipairs(activityList) do
						if iter_8_3 and var_0_2[iter_8_3] then
							var_8_0 = var_0_1[iter_8_3].ratio

							if arg_8_3 and var_0_2[iter_8_3].count <= 0 then
								var_8_0 = 0
							end

							var_8_1 = iter_8_3
							var_8_3 = true

							break
						end
					end
				end
			end
		end
	end

	if arg_8_2 then
		activityList = var_0_5[arg_8_2]

		if activityList then
			for iter_8_4, iter_8_5 in ipairs(activityList) do
				if iter_8_5 and var_0_2[iter_8_5] then
					var_8_0 = var_0_1[iter_8_5].ratio

					if arg_8_3 and var_0_2[iter_8_5].count <= 0 then
						var_8_0 = 0
					end

					var_8_1 = iter_8_5

					break
				end
			end
		end
	end

	return var_8_0, var_8_1
end

return var_0_0
