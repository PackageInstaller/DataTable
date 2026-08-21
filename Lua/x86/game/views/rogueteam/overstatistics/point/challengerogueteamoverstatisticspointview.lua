local var_0_0 = class("ChallengeRogueTeamOverStatisticsPointView", ReduxView)

var_0_0.POINT = {
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.PASS_FLOOR] = ChallengeRogueTeamConst.SETTING_VALUE.PASS_FLOOR_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.PASS_NODE] = ChallengeRogueTeamConst.SETTING_VALUE.PASS_NODE_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.OBTAIN_TREASURE_CNT] = ChallengeRogueTeamConst.SETTING_VALUE.OBTAIN_TREASURE_CNT_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.OBTAIN_RELIC_CNT] = ChallengeRogueTeamConst.SETTING_VALUE.OBTAIN_RELIC_CNT_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.OBTAIN_MECHANISM_CNT] = ChallengeRogueTeamConst.SETTING_VALUE.OBTAIN_MECHANISM_CNT_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.BATTLE_NORMAL] = ChallengeRogueTeamConst.SETTING_VALUE.BATTLE_NORMAL_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.BATTLE_ELITE] = ChallengeRogueTeamConst.SETTING_VALUE.BATTLE_ELITE_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.BATTLE_BOSS] = ChallengeRogueTeamConst.SETTING_VALUE.BATTLE_BOSS_POINT
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.pointController_ = arg_1_0.controllerEx_:GetController("points")
	arg_1_0.mutiController_ = arg_1_0.controllerEx_:GetController("muti")
	arg_1_0.diffController_ = arg_1_0.controllerEx_:GetController("difficulty")

	arg_1_0:RefreshUI()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = ChallengeRogueTeamData:GetOverStatisticsData() or {}
	local var_4_1 = ChallengeRogueTeamData:GetCacheTemplateID()
	local var_4_2 = RogueTeamCfg[var_4_1]

	for iter_4_0 = 1, 8 do
		local var_4_3 = var_0_0.POINT[iter_4_0]
		local var_4_4 = ChallengeRogueTeamTools.GetRougeTeamSettingValue(var_4_3, var_4_1)

		arg_4_0[string.format("text%s_", iter_4_0)].text = string.format("+%s", (var_4_0[iter_4_0] or 0) * var_4_4)
		arg_4_0[string.format("cntText%s_", iter_4_0)].text = var_4_0[iter_4_0] or 0
	end

	local var_4_5 = ChallengeRogueTeamData:PlotGetEndingID()
	local var_4_6 = var_4_2.ending_temp
	local var_4_7

	if not ChallengeRogueTeamData:GetGuideStatisticsFlag() then
		local var_4_8 = RogueTeamEndingCfg.get_id_list_by_temp_id_ending_state[var_4_6][99][1]

		var_4_7 = RogueTeamEndingCfg[var_4_8]
	elseif ChallengeRogueTeamData:PathGetFloorState() == ChallengeRogueTeamConst.FLOOR_STATE.FAIL or var_4_5 == 0 then
		local var_4_9 = RogueTeamEndingCfg.get_id_list_by_temp_id_ending_state[var_4_6][0][1]

		var_4_7 = RogueTeamEndingCfg[var_4_9]
	else
		var_4_7 = RogueTeamEndingCfg[var_4_5]
	end

	arg_4_0.titleText_1.text = var_4_7.story_name
	arg_4_0.titleText_2.text = var_4_7.story_name

	local var_4_10 = ChallengeRogueTeamData:GetLastDifficultyID(var_4_1) or 1
	local var_4_11 = RogueTeamDifficultyCfg[var_4_10]

	arg_4_0.mutiText_.text = "x" .. GameSetting.rogue_team_multi_reward.value[1]

	local var_4_12 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ROGUE_DOUBLE_REWARD_4_4)

	arg_4_0.mutiController_:SetSelectedState(tostring(var_4_12:IsActivitying()))

	if #var_4_11.affix_pool > 0 then
		arg_4_0.diffController_:SetSelectedState("true")

		local var_4_13, var_4_14 = ChallengeRogueTeamData:GetOptionalAffix()

		arg_4_0.difficultLevel_.text = var_4_13

		local var_4_15 = var_4_11.score + var_4_13 * ChallengeRogueTeamConst.OPTIONAL_AFFIX_MULTIPLE
		local var_4_16 = ChallengeRogueTeamConst.OPTIONAL_AFFIX_MAX_MULTIPLE

		arg_4_0.difficultMultiple_.text = math.min(var_4_15, var_4_16) .. "%"
	else
		arg_4_0.diffController_:SetSelectedState("false")

		arg_4_0.difficultMultiple_.text = var_4_11.score .. "%"
	end

	arg_4_0.gradeText_.text = NumberTools.IntToRomam(table.keyof(RogueTeamDifficultyCfg.get_id_list_by_template_id[var_4_11.template_id], var_4_10))

	local var_4_17 = var_4_0[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.TOTAL_POINT]

	arg_4_0.originPointText_.text = string.format("+%s", var_4_0[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.ORIGIN_POINT])
	arg_4_0.totalPointText_.text = string.format("+%s", math.floor(var_4_17 * ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_TIMES) / 1000))
	arg_4_0.skillPointText_.text = string.format("+%s", math.floor(var_4_17 * ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.SKILL_POINT_TIMES) / 1000))
end

return var_0_0
