local var_0_0 = singletonClass("WaterPipeData")
local var_0_1

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.UpdateAllStageRed(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(ActivityWaterPipeStageCfg.all) do
		arg_2_0:UpdateTargetStageRed(iter_2_1)
	end
end

function var_0_0.UpdateTargetStageRed(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:CheckStageIsUnLock(arg_3_1)
	local var_3_1 = false

	if var_3_0 then
		local var_3_2 = arg_3_0:GetStageInfoByStageID(arg_3_1)

		if not var_3_2 then
			var_3_1 = true
		elseif var_3_2 and var_3_2.letter_reward == false then
			var_3_1 = true
		end
	end

	if var_3_1 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_WATER_PIPE_STAGE, arg_3_1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_WATER_PIPE_STAGE, arg_3_1), 0)
	end
end

function var_0_0.GetMainActivityID(arg_4_0)
	return ActivityConst.ACTIVITY_WATER_PIPE
end

function var_0_0.InitData(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1.stage_info_list) do
		var_0_1[iter_5_1.finish_stage_id] = {
			stage_id = iter_5_1.finish_stage_id,
			letter_reward = iter_5_1.stage_reward == 2 and true or false
		}
	end

	arg_5_0:UpdateAllStageRed()
end

function var_0_0.UpdateStageData(arg_6_0, arg_6_1, arg_6_2)
	if var_0_1[arg_6_1] then
		var_0_1[arg_6_1].letter_reward = arg_6_2
	else
		var_0_1[arg_6_1] = {
			stage_id = arg_6_1,
			letter_reward = arg_6_2 or false
		}
	end

	arg_6_0:UpdateAllStageRed()
end

function var_0_0.CheckStageIsUnLock(arg_7_0, arg_7_1)
	local var_7_0 = ActivityWaterPipeStageCfg[arg_7_1]

	if arg_7_0:IsOpenPreStage(arg_7_1) == false then
		return false
	end

	local var_7_1 = ActivityData:GetActivityData(var_7_0.activity_id)

	if not var_7_1 or not var_7_1:IsActivitying() then
		return false
	end

	return true
end

function var_0_0.IsOpenPreStage(arg_8_0, arg_8_1)
	local var_8_0 = ActivityWaterPipeStageCfg[arg_8_1].pre_id

	if var_8_0 > 0 and not var_0_1[var_8_0] then
		return false
	else
		return true
	end
end

function var_0_0.IsTimeOpenStage(arg_9_0, arg_9_1)
	local var_9_0 = ActivityWaterPipeStageCfg[arg_9_1]
	local var_9_1 = ActivityData:GetActivityData(var_9_0.activity_id)

	if (var_9_1 and var_9_1.startTime or 0) > manager.time:GetServerTime() then
		return false
	else
		return true
	end
end

function var_0_0.GetStageOpenTimeTxt(arg_10_0, arg_10_1)
	local var_10_0 = ActivityWaterPipeStageCfg[arg_10_1]
	local var_10_1 = ActivityData:GetActivityData(var_10_0.activity_id)

	if not var_10_1 or not var_10_1.startTime then
		local var_10_2 = 0
	end

	if not arg_10_0:IsOpenPreStage(arg_10_1) then
		return GetTips("ACTIVITY_MONSTER_COSPLAY_STAGE_CONDITION")
	else
		local var_10_3 = GetTips("OPEN_TIME")

		return string.format(var_10_3, manager.time:GetLostTimeStr(var_10_1.startTime, false, true))
	end

	return nil, nil
end

function var_0_0.GetStageInfoByStageID(arg_11_0, arg_11_1)
	return var_0_1[arg_11_1]
end

function var_0_0.GetPipePolaroidImg(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = ActivityWaterPipeStageCfg[arg_12_1]

	if arg_12_2 then
		return getSpriteWithoutAtlas("TextureConfig/VersionUI/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipe/pic/" .. var_12_0.date_picture)
	else
		return getSpriteWithoutAtlas("TextureConfig/VersionUI/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipe/pic/" .. var_12_0.preheat_picture)
	end
end

function var_0_0.GetCategoryImg(arg_13_0, arg_13_1)
	local var_13_0 = ActivityWaterPipeStageCfg[arg_13_1]

	return getSpriteWithoutAtlas("TextureConfig/VersionUI/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipe/" .. var_13_0.item_icon)
end

function var_0_0.GetOrderImg(arg_14_0, arg_14_1)
	return getSpriteWithoutAtlas("TextureConfig/VersionUI/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipe/BaichaoUI_3_9_order_" .. arg_14_1)
end

return var_0_0
