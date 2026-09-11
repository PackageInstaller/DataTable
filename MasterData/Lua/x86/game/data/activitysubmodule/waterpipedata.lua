local var_0_0 = singletonClass("WaterPipeData")
local var_0_1

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0:UpdateAllStageRed()
	for iter_2_0, iter_2_1 in ipairs(ActivityWaterPipeStageCfg.all) do
		self:UpdateTargetStageRed(iter_2_1)
	end
end

function var_0_0:UpdateTargetStageRed(arg_3_1)
	local var_3_0 = false

	if self:CheckStageIsUnLock(arg_3_1) then
		local var_3_1 = self:GetStageInfoByStageID(arg_3_1)

		if not var_3_1 then
			var_3_0 = true
		elseif var_3_1 and var_3_1.letter_reward == false then
			var_3_0 = true
		end
	end

	if var_3_0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_WATER_PIPE_STAGE, arg_3_1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_WATER_PIPE_STAGE, arg_3_1), 0)
	end
end

function var_0_0.GetMainActivityID(arg_4_0)
	return ActivityConst.ACTIVITY_WATER_PIPE
end

function var_0_0:InitData(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1.stage_info_list) do
		var_0_1[iter_5_1.finish_stage_id] = {
			stage_id = iter_5_1.finish_stage_id,
			letter_reward = iter_5_1.stage_reward == 2 and true or false
		}
	end

	self:UpdateAllStageRed()
end

function var_0_0:UpdateStageData(arg_6_1, arg_6_2)
	if var_0_1[arg_6_1] then
		var_0_1[arg_6_1].letter_reward = arg_6_2
	else
		var_0_1[arg_6_1] = {
			stage_id = arg_6_1,
			letter_reward = arg_6_2 or false
		}
	end

	self:UpdateAllStageRed()
end

function var_0_0:CheckStageIsUnLock(arg_7_1)
	if self:IsOpenPreStage(arg_7_1) == false then
		return false
	end

	local var_7_0 = ActivityData:GetActivityData(ActivityWaterPipeStageCfg[arg_7_1].activity_id)

	if not var_7_0 or not var_7_0:IsActivitying() then
		return false
	end

	return true
end

function var_0_0.IsOpenPreStage(arg_8_0, arg_8_1)
	if ActivityWaterPipeStageCfg[arg_8_1].pre_id > 0 and not var_0_1[ActivityWaterPipeStageCfg[arg_8_1].pre_id] then
		return false
	else
		return true
	end
end

function var_0_0.IsTimeOpenStage(arg_9_0, arg_9_1)
	local var_9_0 = ActivityData:GetActivityData(ActivityWaterPipeStageCfg[arg_9_1].activity_id)

	if var_9_0 then
		if (var_9_0.startTime or 0) > manager.time:GetServerTime() then
			do return false end

			goto label_9_0
		end
	end

	do return true end

	::label_9_0::
end

function var_0_0:GetStageOpenTimeTxt(arg_10_1)
	local var_10_0 = ActivityData:GetActivityData(ActivityWaterPipeStageCfg[arg_10_1].activity_id)

	if not var_10_0 or not var_10_0.startTime then
		-- block empty
	end

	if not self:IsOpenPreStage(arg_10_1) then
		return GetTips("ACTIVITY_MONSTER_COSPLAY_STAGE_CONDITION")
	else
		return string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_10_0.startTime, false, true))
	end

	return nil, nil
end

function var_0_0.GetStageInfoByStageID(arg_11_0, arg_11_1)
	return var_0_1[arg_11_1]
end

function var_0_0.GetPipePolaroidImg(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 then
		return getSpriteWithoutAtlas("TextureConfig/VersionUI/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipe/pic/" .. ActivityWaterPipeStageCfg[arg_12_1].date_picture)
	else
		return getSpriteWithoutAtlas("TextureConfig/VersionUI/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipe/pic/" .. ActivityWaterPipeStageCfg[arg_12_1].preheat_picture)
	end
end

function var_0_0.GetCategoryImg(arg_13_0, arg_13_1)
	return getSpriteWithoutAtlas("TextureConfig/VersionUI/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipe/" .. ActivityWaterPipeStageCfg[arg_13_1].item_icon)
end

function var_0_0.GetOrderImg(arg_14_0, arg_14_1)
	return getSpriteWithoutAtlas("TextureConfig/VersionUI/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipe/BaichaoUI_3_9_order_" .. arg_14_1)
end

return var_0_0
