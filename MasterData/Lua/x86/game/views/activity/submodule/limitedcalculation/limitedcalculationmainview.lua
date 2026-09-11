local LimitedCalculationMainView = class("LimitedCalculationMainView", ReduxView)

function LimitedCalculationMainView:UIName()
	return LimitedCalculationTools.GetMainUIName(self.params_.activityID)
end

function LimitedCalculationMainView:UIParent()
	return manager.ui.uiMain.transform
end

function LimitedCalculationMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function LimitedCalculationMainView:InitUI()
	self:BindCfgUI()

	self.difficultyCon_ = ControllerUtil.GetController(self.transform_, "difficulty")
end

function LimitedCalculationMainView:AddUIListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_6_0 = manager.time:GetServerTime()
		local var_6_1

		if self.openState_ == 0 and var_6_0 < self.startTime_ or var_6_0 >= self.stopTime_ then
			ShowTips("ERROR_ACTIVITY_NOT_OPEN")

			do return end

			var_6_1 = {}
		end

		var_6_1.section = ActivityLimitCalculationCfg[self.curDifficulty_].stage_id
		var_6_1.sectionType = BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION
		var_6_1.activityID = self.activityID_

		self:Go("/sectionSelectHero", var_6_1)
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("limitedCalculationReward", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.difficultBtn_, nil, function()
		JumpTools.OpenPageByJump("limitedCalculationDifficulty", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/limitedCalculationRank", {
			activityID = self.rank_id
		})
	end)
	self:AddBtnListener(self.debuffBtn_, nil, function()
		JumpTools.OpenPageByJump("buffDescription", {
			type = "debuff",
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.buffBtn_, nil, function()
		JumpTools.OpenPageByJump("buffDescription", {
			type = "buff",
			activityID = self.activityID_
		})
	end)
end

function LimitedCalculationMainView:OnEnter()
	self:GetActivityData()
	self:RefreshUI()
	self:BindRedPointUI()
	RankAction.QueryActivityRank(self.rank_id)

	local var_12_0 = GuildData:GetGuildInfo()

	if var_12_0 and var_12_0.id ~= nil and var_12_0.id ~= 0 then
		RankAction.QueryGuildActivityRank(self.rank_id)
	end
end

function LimitedCalculationMainView:GetRankId(arg_13_1)
	if not ActivityCfg[arg_13_1] then
		return 0
	end

	for iter_13_0, iter_13_1 in ipairs(ActivityCfg[arg_13_1].sub_activity_list) do
		if ActivityCfg[iter_13_1] and ActivityCfg[iter_13_1].activity_template == ActivityTemplateConst.LIMITED_RANK then
			return iter_13_1
		end
	end

	return 0
end

function LimitedCalculationMainView:GetActivityData()
	self.activityID_ = self.params_.activityID
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
	self.openState_ = self.activityData_.state
	self.rank_id = self:GetRankId(self.activityID_)
end

function LimitedCalculationMainView:RefreshUI()
	self:RefreshDifficultDes()
	self:RefreshLock()
	self:RefreshScore()
	self:RefreshTime()
	self:RefreshRank()
end

function LimitedCalculationMainView:RefreshDifficultDes()
	self.curDifficulty_ = LimitedCalculationData:GetCurDifficulty(self.activityID_)
	self.debuffLv_ = ActivityLimitCalculationCfg[self.curDifficulty_].enemy_level
	self.buffLv_ = ActivityLimitCalculationCfg[self.curDifficulty_].player_level
	self.oddsDes_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_RANK"), ActivityLimitCalculationCfg[self.curDifficulty_].reward_point / 100)
	self.debuffDes_.text = self.debuffLv_
	self.buffDes_.text = self.buffLv_

	self.difficultyCon_:SetSelectedState(ActivityLimitCalculationCfg[self.curDifficulty_].difficulty)
end

function LimitedCalculationMainView:RefreshLock()
	SetActive(self.debuffLock_, self.debuffLv_ <= 0)
	SetActive(self.buffLock_, self.buffLv_ <= 0)
end

function LimitedCalculationMainView:RefreshScore()
	local var_18_0 = LimitedCalculationData:GetScore(self.activityID_)

	self.score_.text = var_18_0 > 0 and var_18_0 or GetTips("MATRIX_RANK_NO_INFO")
end

function LimitedCalculationMainView:RefreshTime()
	local var_19_0
	local var_19_1 = manager.time:GetServerTime()

	self:StopTimer()

	if var_19_1 < self.startTime_ and self.openState_ == 0 then
		self.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			var_19_0 = self.startTime_ - manager.time:GetServerTime()

			if var_19_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_19_1 >= self.startTime_ and self.openState_ == 0 then
		self.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			self:StopTimer()
			self:RefreshTime()
		end, 10, 1)

		self.timer_:Start()
	elseif var_19_1 < self.stopTime_ then
		self.timeTxt_.text = manager.time:GetLostTimeStr2(self.stopTime_, nil, true)
		self.timer_ = Timer.New(function()
			var_19_0 = self.stopTime_ - manager.time:GetServerTime()

			if var_19_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			self.timeTxt_.text = manager.time:GetLostTimeStr2(self.stopTime_, nil, true)
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function LimitedCalculationMainView:RefreshRank()
	SetActive(self.rankBtn_.gameObject, ActivityData:GetActivityIsOpen(self.rank_id))
end

function LimitedCalculationMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function LimitedCalculationMainView:BindRedPointUI()
	LimitedCalculationData:SetIsNeed(self.activityID_, false)
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.LIMITED_CALCULATION_REWARD .. self.activityID_)
end

function LimitedCalculationMainView:UnBindRedPointUI()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.LIMITED_CALCULATION_REWARD .. self.activityID_)
end

function LimitedCalculationMainView:OnLimitedDifficultyChange()
	self:RefreshDifficultDes()
	self:RefreshLock()
end

function LimitedCalculationMainView:OnTop()
	local var_28_0 = LimitedCalculationTools.GetGameHelpKey(self.activityID_)

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

function LimitedCalculationMainView:OnExit()
	self:StopTimer()
	self:UnBindRedPointUI()
	manager.windowBar:HideBar()
end

function LimitedCalculationMainView:Dispose()
	self:RemoveAllListeners()
	self:StopTimer()
	LimitedCalculationMainView.super.Dispose(self)
end

return LimitedCalculationMainView
