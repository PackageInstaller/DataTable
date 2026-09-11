local ChallengeRogueTeamOverStatisticsPointView = class("ChallengeRogueTeamOverStatisticsPointView", ReduxView)

ChallengeRogueTeamOverStatisticsPointView.POINT = {
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.PASS_FLOOR] = ChallengeRogueTeamConst.SETTING_VALUE.PASS_FLOOR_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.PASS_NODE] = ChallengeRogueTeamConst.SETTING_VALUE.PASS_NODE_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.OBTAIN_TREASURE_CNT] = ChallengeRogueTeamConst.SETTING_VALUE.OBTAIN_TREASURE_CNT_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.OBTAIN_RELIC_CNT] = ChallengeRogueTeamConst.SETTING_VALUE.OBTAIN_RELIC_CNT_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.OBTAIN_MECHANISM_CNT] = ChallengeRogueTeamConst.SETTING_VALUE.OBTAIN_MECHANISM_CNT_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.BATTLE_NORMAL] = ChallengeRogueTeamConst.SETTING_VALUE.BATTLE_NORMAL_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.BATTLE_ELITE] = ChallengeRogueTeamConst.SETTING_VALUE.BATTLE_ELITE_POINT,
	[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.BATTLE_BOSS] = ChallengeRogueTeamConst.SETTING_VALUE.BATTLE_BOSS_POINT
}

function ChallengeRogueTeamOverStatisticsPointView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.pointController_ = self.controllerEx_:GetController("points")
	self.mutiController_ = self.controllerEx_:GetController("muti")
	self.diffController_ = self.controllerEx_:GetController("difficulty")

	self:RefreshUI()
end

function ChallengeRogueTeamOverStatisticsPointView:Dispose()
	ChallengeRogueTeamOverStatisticsPointView.super.Dispose(self)
end

function ChallengeRogueTeamOverStatisticsPointView:AddListeners()
	return
end

function ChallengeRogueTeamOverStatisticsPointView:RefreshUI()
	local var_4_0 = ChallengeRogueTeamData:GetOverStatisticsData() or {}
	local var_4_1 = ChallengeRogueTeamData:GetCacheTemplateID()

	for iter_4_0 = 1, 8 do
		self[string.format("text%s_", iter_4_0)].text = string.format("+%s", (var_4_0[iter_4_0] or 0) * ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamOverStatisticsPointView.POINT[iter_4_0], var_4_1))
		self[string.format("cntText%s_", iter_4_0)].text = var_4_0[iter_4_0] or 0
	end

	local var_4_3 = ChallengeRogueTeamData:PlotGetEndingID()
	local var_4_4 = not ChallengeRogueTeamData:GetGuideStatisticsFlag() and RogueTeamEndingCfg[RogueTeamEndingCfg.get_id_list_by_temp_id_ending_state[RogueTeamCfg[var_4_1].ending_temp][99][1]] or (ChallengeRogueTeamData:PathGetFloorState() == ChallengeRogueTeamConst.FLOOR_STATE.FAIL or var_4_3 == 0) and RogueTeamEndingCfg[RogueTeamEndingCfg.get_id_list_by_temp_id_ending_state[RogueTeamCfg[var_4_1].ending_temp][0][1]] or RogueTeamEndingCfg[var_4_3]

	self.titleText_1.text = var_4_4.story_name
	self.titleText_2.text = var_4_4.story_name

	local var_4_5 = ChallengeRogueTeamData:GetLastDifficultyID(var_4_1) or 1
	local var_4_6 = RogueTeamDifficultyCfg[var_4_5]

	self.mutiText_.text = "x" .. GameSetting.rogue_team_multi_reward.value[1]

	self.mutiController_:SetSelectedState(tostring(ActivityData:GetActivityData(ActivityConst.ACTIVITY_ROGUE_DOUBLE_REWARD_4_4):IsActivitying()))

	if #var_4_6.affix_pool > 0 then
		self.diffController_:SetSelectedState("true")

		local var_4_7, var_4_8 = ChallengeRogueTeamData:GetOptionalAffix()

		self.difficultLevel_.text = var_4_7
		self.difficultMultiple_.text = math.min(var_4_6.score + var_4_7 * ChallengeRogueTeamConst.OPTIONAL_AFFIX_MULTIPLE, ChallengeRogueTeamConst.OPTIONAL_AFFIX_MAX_MULTIPLE) .. "%"
	else
		self.diffController_:SetSelectedState("false")

		self.difficultMultiple_.text = var_4_6.score .. "%"
	end

	self.gradeText_.text = NumberTools.IntToRomam(table.keyof(RogueTeamDifficultyCfg.get_id_list_by_template_id[var_4_6.template_id], var_4_5))
	self.originPointText_.text = string.format("+%s", var_4_0[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.ORIGIN_POINT])
	self.totalPointText_.text = string.format("+%s", math.floor(var_4_0[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.TOTAL_POINT] * ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_TIMES) / 1000))
	self.skillPointText_.text = string.format("+%s", math.floor(var_4_0[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.TOTAL_POINT] * ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.SKILL_POINT_TIMES) / 1000))
end

return ChallengeRogueTeamOverStatisticsPointView
