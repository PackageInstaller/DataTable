local var_0_0 = {
	CheckRoleUnlocked = function(arg_1_0)
		local var_1_0 = nullable(PinballPlayerCfg, arg_1_0, "activity_id") or 0

		if var_1_0 ~= 0 then
			local var_1_1, var_1_2 = ActivityTools.GetActivityStatusWithTips(var_1_0)

			return var_1_1 == 1, var_1_2
		end

		return true
	end
}

function var_0_0.FindFirstAvailableRole()
	for iter_2_0, iter_2_1 in ipairs(PinballPlayerCfg.get_id_list_by_type[1]) do
		if var_0_0.CheckRoleUnlocked(iter_2_1) then
			return iter_2_1
		end
	end
end

function var_0_0.CheckRoleCanUpgrade(arg_3_0, arg_3_1)
	local var_3_0 = PinballData:GetRoleLevel(arg_3_0)

	if var_3_0 then
		local var_3_1 = PinballPlayerCfg[arg_3_0]

		if var_3_0 >= var_3_1.max_grade then
			return false
		end

		if arg_3_1 then
			return true
		end

		local var_3_2 = var_3_1.upgrade_cost_list[var_3_0]
		local var_3_3 = var_3_2[1]

		return var_3_2[2] <= ItemTools.getItemNum(var_3_3)
	end

	return false
end

function var_0_0.GetBossIconPath(arg_4_0)
	return nullable(PinballPlayerCfg, arg_4_0, "little_icon")
end

var_0_0.GetRoleIconPath = var_0_0.GetBossIconPath

function var_0_0.GetBossFullImgPath(arg_5_0)
	return nullable(PinballPlayerCfg, arg_5_0, "icon")
end

var_0_0.GetRoleFullImgPath = var_0_0.GetBossFullImgPath

function var_0_0.GetSkillDesc(arg_6_0)
	local var_6_0 = PinballSkillCfg[arg_6_0]

	if var_6_0 then
		local var_6_1 = var_6_0.description
		local var_6_2 = var_6_0.effect

		return LuaExchangeHelper.GetDescription(var_6_1, var_6_2)
	end

	return ""
end

function var_0_0.GetSkillIconPath(arg_7_0)
	local var_7_0 = PinballSkillCfg[arg_7_0]

	if var_7_0 then
		return var_7_0.icon
	end

	return nil
end

function var_0_0.CalcRoleProp(arg_8_0, arg_8_1)
	local var_8_0 = PinballPlayerCfg[arg_8_0]
	local var_8_1 = nullable(var_8_0, "base_attributes", arg_8_1) or 0
	local var_8_2 = nullable(var_8_0, "growth_attributes", arg_8_1) or 0
	local var_8_3 = PinballData:GetRoleLevel(arg_8_0)

	if var_8_3 then
		return var_8_1 + var_8_2 * (var_8_3 - 1)
	else
		return 0
	end
end

function var_0_0.GetRoleNextLevelGrowthProp(arg_9_0, arg_9_1)
	local var_9_0 = PinballPlayerCfg[arg_9_0]

	if PinballTools.CheckRoleCanUpgrade(arg_9_0, true) then
		return nullable(var_9_0, "growth_attributes", arg_9_1)
	end
end

function var_0_0.GetCurrentSceneBgPrefabPath(arg_10_0, arg_10_1)
	local var_10_0 = PinballStageCfg[arg_10_0]
	local var_10_1 = PinballData:HasPassAllStage()
	local var_10_2 = nullable(var_10_0, "scene_picture")

	if var_10_1 and not arg_10_1 then
		var_10_2 = var_10_2 .. "_end"
	end

	return var_10_2
end

function var_0_0.GetTaskActivityID()
	return ActivityTools.GetAllTaskSubActivityID(PinballData.activityID)[1]
end

function var_0_0.RedPointKey(arg_12_0)
	return ActivityTools.GetRedPointKey(arg_12_0) .. arg_12_0
end

function var_0_0.StageRedPoint(arg_13_0)
	return string.format("%s_%d_%d", RedPointConst.ACTIVITY_PINBALL_STAGE, PinballData.activityID, arg_13_0)
end

function var_0_0.StageCatRedPoint(arg_14_0)
	return string.format("%s_%d_%d", RedPointConst.ACTIVITY_PINBALL_STAGE_CATEGORY, PinballData.activityID, arg_14_0)
end

function var_0_0.UpgradeRedPoint(arg_15_0)
	return string.format("%s_%d_%d", RedPointConst.ACTIVITY_PINBALL_UPGRADE, PinballData.activityID, arg_15_0)
end

function var_0_0.IsActivityCoin(arg_16_0)
	return nullable(GameSetting, "activity_play_marbles_token_num_limited", "value", 1) == arg_16_0
end

function var_0_0.ActivityCoin()
	return nullable(GameSetting, "activity_play_marbles_token_num_limited", "value", 1)
end

function var_0_0.MarkStageRedPointViewed(arg_18_0)
	local var_18_0 = PinballTools.StageRedPoint(arg_18_0)

	manager.redPoint:setTip(var_18_0, 0)

	PinballData.viewedUnlockedLevel[arg_18_0] = true
end

var_0_0.CONDITOIN_CNT = 3

function var_0_0.InitDetailConditionCom(arg_19_0, arg_19_1)
	local var_19_0 = {}
	local var_19_1 = {}

	arg_19_0:BindCfgUI(arg_19_1, var_19_0)

	for iter_19_0 = 1, var_0_0.CONDITOIN_CNT do
		local var_19_2 = string.format("targetItem%d_", iter_19_0)
		local var_19_3 = {}

		arg_19_0:BindCfgUI(var_19_0[var_19_2], var_19_3)

		local var_19_4 = var_19_3.controllers_ or var_19_3.controllerEx_ or var_19_0[var_19_2]:GetComponent("ControllerExCollection")

		var_19_1[iter_19_0] = {
			targetText_ = var_19_3.targetText_,
			rewardCnt_ = var_19_3.rewardCnt_,
			rewardIcon_ = var_19_3.rewardIcon_,
			clearController = var_19_4:GetController("clear")
		}
	end

	return var_19_1
end

function var_0_0.RefreshDetailConditionCom(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = PinballStageCfg[arg_20_1]
	local var_20_1 = var_20_0.target_list[arg_20_2]
	local var_20_2 = nullable(ConditionCfg, var_20_1)

	if var_20_2 and not isNil(arg_20_0.targetText_) then
		arg_20_0.targetText_.text = var_20_2.desc
	end

	local var_20_3 = var_20_0.condition_reward[arg_20_2]

	if not isNil(arg_20_0.rewardIcon_) then
		arg_20_0.rewardIcon_.sprite = ItemTools.getItemLittleSprite(var_20_3[1])
	end

	if not isNil(arg_20_0.rewardCnt_) then
		arg_20_0.rewardCnt_.text = var_20_3[2]
	end
end

return var_0_0
