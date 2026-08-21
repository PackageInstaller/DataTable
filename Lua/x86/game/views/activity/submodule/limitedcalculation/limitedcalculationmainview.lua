local var_0_0 = class("LimitedCalculationMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return LimitedCalculationTools.GetMainUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.difficultyCon_ = ControllerUtil.GetController(arg_4_0.transform_, "difficulty")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		local var_6_0 = manager.time:GetServerTime()

		if arg_5_0.openState_ == 0 and var_6_0 < arg_5_0.startTime_ or var_6_0 >= arg_5_0.stopTime_ then
			ShowTips("ERROR_ACTIVITY_NOT_OPEN")

			return
		end

		local var_6_1 = ActivityLimitCalculationCfg[arg_5_0.curDifficulty_].stage_id

		arg_5_0:Go("/sectionSelectHero", {
			section = var_6_1,
			sectionType = BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION,
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("limitedCalculationReward", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.difficultBtn_, nil, function()
		JumpTools.OpenPageByJump("limitedCalculationDifficulty", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/limitedCalculationRank", {
			activityID = arg_5_0.rank_id
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.debuffBtn_, nil, function()
		JumpTools.OpenPageByJump("buffDescription", {
			type = "debuff",
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.buffBtn_, nil, function()
		JumpTools.OpenPageByJump("buffDescription", {
			type = "buff",
			activityID = arg_5_0.activityID_
		})
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:GetActivityData()
	arg_12_0:RefreshUI()
	arg_12_0:BindRedPointUI()
	RankAction.QueryActivityRank(arg_12_0.rank_id)

	local var_12_0 = GuildData:GetGuildInfo()

	if var_12_0 and var_12_0.id ~= nil and var_12_0.id ~= 0 then
		RankAction.QueryGuildActivityRank(arg_12_0.rank_id)
	end
end

function var_0_0.GetRankId(arg_13_0, arg_13_1)
	local var_13_0 = ActivityCfg[arg_13_1]

	if not var_13_0 then
		return 0
	end

	for iter_13_0, iter_13_1 in ipairs(var_13_0.sub_activity_list) do
		local var_13_1 = ActivityCfg[iter_13_1]

		if var_13_1 and var_13_1.activity_template == ActivityTemplateConst.LIMITED_RANK then
			return iter_13_1
		end
	end

	return 0
end

function var_0_0.GetActivityData(arg_14_0)
	arg_14_0.activityID_ = arg_14_0.params_.activityID
	arg_14_0.activityData_ = ActivityData:GetActivityData(arg_14_0.activityID_)
	arg_14_0.startTime_ = arg_14_0.activityData_.startTime
	arg_14_0.stopTime_ = arg_14_0.activityData_.stopTime
	arg_14_0.openState_ = arg_14_0.activityData_.state
	arg_14_0.rank_id = arg_14_0:GetRankId(arg_14_0.activityID_)
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0:RefreshDifficultDes()
	arg_15_0:RefreshLock()
	arg_15_0:RefreshScore()
	arg_15_0:RefreshTime()
	arg_15_0:RefreshRank()
end

function var_0_0.RefreshDifficultDes(arg_16_0)
	arg_16_0.curDifficulty_ = LimitedCalculationData:GetCurDifficulty(arg_16_0.activityID_)

	local var_16_0 = ActivityLimitCalculationCfg[arg_16_0.curDifficulty_]

	arg_16_0.debuffLv_ = var_16_0.enemy_level
	arg_16_0.buffLv_ = var_16_0.player_level
	arg_16_0.oddsDes_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_RANK"), var_16_0.reward_point / 100)
	arg_16_0.debuffDes_.text = arg_16_0.debuffLv_
	arg_16_0.buffDes_.text = arg_16_0.buffLv_

	arg_16_0.difficultyCon_:SetSelectedState(var_16_0.difficulty)
end

function var_0_0.RefreshLock(arg_17_0)
	SetActive(arg_17_0.debuffLock_, arg_17_0.debuffLv_ <= 0)
	SetActive(arg_17_0.buffLock_, arg_17_0.buffLv_ <= 0)
end

function var_0_0.RefreshScore(arg_18_0)
	local var_18_0 = LimitedCalculationData:GetScore(arg_18_0.activityID_)

	arg_18_0.score_.text = var_18_0 > 0 and var_18_0 or GetTips("MATRIX_RANK_NO_INFO")
end

function var_0_0.RefreshTime(arg_19_0)
	local var_19_0
	local var_19_1 = manager.time:GetServerTime()

	arg_19_0:StopTimer()

	if var_19_1 < arg_19_0.startTime_ and arg_19_0.openState_ == 0 then
		arg_19_0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		arg_19_0.timer_ = Timer.New(function()
			var_19_0 = arg_19_0.startTime_ - manager.time:GetServerTime()

			if var_19_0 <= 0 then
				arg_19_0:StopTimer()
				arg_19_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_19_0.timer_:Start()
	elseif var_19_1 >= arg_19_0.startTime_ and arg_19_0.openState_ == 0 then
		arg_19_0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		arg_19_0.timer_ = Timer.New(function()
			arg_19_0:StopTimer()
			arg_19_0:RefreshTime()
		end, 10, 1)

		arg_19_0.timer_:Start()
	elseif var_19_1 < arg_19_0.stopTime_ then
		arg_19_0.timeTxt_.text = manager.time:GetLostTimeStr2(arg_19_0.stopTime_, nil, true)
		arg_19_0.timer_ = Timer.New(function()
			var_19_0 = arg_19_0.stopTime_ - manager.time:GetServerTime()

			if var_19_0 <= 0 then
				arg_19_0:StopTimer()
				arg_19_0:RefreshTime()

				return
			end

			arg_19_0.timeTxt_.text = manager.time:GetLostTimeStr2(arg_19_0.stopTime_, nil, true)
		end, 1, -1)

		arg_19_0.timer_:Start()
	else
		arg_19_0.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.RefreshRank(arg_23_0)
	SetActive(arg_23_0.rankBtn_.gameObject, ActivityData:GetActivityIsOpen(arg_23_0.rank_id))
end

function var_0_0.StopTimer(arg_24_0)
	if arg_24_0.timer_ then
		arg_24_0.timer_:Stop()

		arg_24_0.timer_ = nil
	end
end

function var_0_0.BindRedPointUI(arg_25_0)
	LimitedCalculationData:SetIsNeed(arg_25_0.activityID_, false)
	manager.redPoint:bindUIandKey(arg_25_0.rewardBtn_.transform, RedPointConst.LIMITED_CALCULATION_REWARD .. arg_25_0.activityID_)
end

function var_0_0.UnBindRedPointUI(arg_26_0)
	manager.redPoint:unbindUIandKey(arg_26_0.rewardBtn_.transform, RedPointConst.LIMITED_CALCULATION_REWARD .. arg_26_0.activityID_)
end

function var_0_0.OnLimitedDifficultyChange(arg_27_0)
	arg_27_0:RefreshDifficultDes()
	arg_27_0:RefreshLock()
end

function var_0_0.OnTop(arg_28_0)
	local var_28_0 = LimitedCalculationTools.GetGameHelpKey(arg_28_0.activityID_)

	if var_28_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_28_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function var_0_0.OnExit(arg_29_0)
	arg_29_0:StopTimer()
	arg_29_0:UnBindRedPointUI()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_30_0)
	arg_30_0:RemoveAllListeners()
	arg_30_0:StopTimer()
	var_0_0.super.Dispose(arg_30_0)
end

return var_0_0
