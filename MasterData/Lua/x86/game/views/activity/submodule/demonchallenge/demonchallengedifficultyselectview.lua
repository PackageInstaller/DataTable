local DemonChallengeDifficultySelectView = class("DemonChallengeDifficultySelectView", ReduxView)

function DemonChallengeDifficultySelectView:UIName()
	return nil
end

function DemonChallengeDifficultySelectView:UIParent()
	return manager.ui.uiMain.transform
end

function DemonChallengeDifficultySelectView:InitGo(arg_3_1)
	if self.gameObject_ then
		self:Dispose()
		Object.Destroy(self.gameObject_)
	end

	self.gameObject_ = Object.Instantiate(Asset.Load(arg_3_1), self:UIParent())
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddUIListener()
end

local var_0_1 = 3

function DemonChallengeDifficultySelectView:InitUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "selectDifficulty")
	self.completedUIControllerS_ = {}

	for iter_4_0 = 1, var_0_1 do
		self.completedUIControllerS_[iter_4_0] = ControllerUtil.GetController(self[string.format("Level%dBtn_", iter_4_0)].transform, "completed")
	end

	self.startImg_ = self.startBtn_.gameObject:GetComponent(typeof(Image))
	self.affixItemList_ = {}
end

function DemonChallengeDifficultySelectView:AddUIListener()
	self:AddBtnListener(self.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityId_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_6_0

		if self.difficultyIndex_ == nil then
			ShowTips("SELECT_CURRENT")

			do return end

			var_6_0 = {
				section = DemonChallengeTools.GetStageId(self.activityId_, self.difficultyIndex_),
				sectionType = BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON
			}
		end

		var_6_0.activityID = DemonChallengeTools.GetChildId(self.activityId_, self.difficultyIndex_)

		self:Go("/sectionSelectHero", var_6_0)
	end)

	for iter_5_0 = 1, var_0_1 do
		self:AddBtnListener(self[string.format("Level%dBtn_", iter_5_0)], nil, function()
			if not ActivityData:GetActivityIsOpen(self.activityId_) then
				ShowTips("TIME_OVER")

				return
			end

			self:RefreshDifficult(iter_5_0)
		end)
	end
end

function DemonChallengeDifficultySelectView:OnEnter()
	if not self.activityId_ or self.params_.selectId ~= self.activityId_ then
		if self.activityId_ ~= self.params_.selectId then
			self.difficultyIndex_ = nil
		end

		self.activityId_ = self.params_.selectId

		if not self.mainActivityId_ or self.params_.activityId ~= self.mainActivityId_ then
			self.mainActivityId_ = self.params_.activityId

			self:InitGo(DemonChallengeTools.GetDifficultyUIName(self.params_.activityId))
		end
	end

	self:RefreshCompletedUI()
	self:RefreshUI()
end

function DemonChallengeDifficultySelectView:RefreshUI()
	self:RefreshSelectedUI()
	self:RefreshDesc()
	self:RefreshAffix()
end

function DemonChallengeDifficultySelectView:RefreshCompletedUI()
	local var_10_0 = SubDemonChallengeData:GetChallengeInfo(self.activityId_)

	for iter_10_0 = 1, var_0_1 do
		if var_10_0.challengeInfo and var_10_0.challengeInfo[iter_10_0].challenge_state ~= ActivityConst.DEMON_CHALLENGE_STATE.FINISHED then
			self.completedUIControllerS_[iter_10_0]:SetSelectedState("false")
		else
			self.completedUIControllerS_[iter_10_0]:SetSelectedState("true")
		end
	end
end

function DemonChallengeDifficultySelectView:RefreshDesc()
	local var_11_0 = ""

	if self.difficultyIndex_ ~= nil then
		local var_11_1 = DemonChallengeTools.GetChildId(self.activityId_, self.difficultyIndex_)

		if var_11_1 then
			var_11_0 = DemonChallengeCfg[var_11_1].difficulty_desc
		end
	end

	if self.descText_ then
		self.descText_.text = GetI18NText(var_11_0)
	end
end

function DemonChallengeDifficultySelectView:RefreshSelectedUI()
	if not self.difficultyIndex_ then
		self:RefreshDefalutDifficult()
	else
		self.selectController_:SetSelectedState(tostring(self.difficultyIndex_))

		if self.startImg_ then
			manager.effect:SetGrey(self.startImg_, false)
		end
	end
end

function DemonChallengeDifficultySelectView:RefreshDifficult(arg_13_1)
	self.difficultyIndex_ = arg_13_1

	self:RefreshUI()
end

function DemonChallengeDifficultySelectView:RefreshDefalutDifficult()
	if self.difficultyIndex_ == nil then
		self.difficultyIndex_ = 1

		self.selectController_:SetSelectedState(1)

		for iter_14_0 = 1, var_0_1 - 1 do
			local var_14_0 = SubDemonChallengeData:GetChallengeInfo(self.activityId_)

			if var_14_0.challengeInfo and var_14_0.challengeInfo[iter_14_0].challenge_state == ActivityConst.DEMON_CHALLENGE_STATE.FINISHED then
				self.selectController_:SetSelectedState(iter_14_0 + 1)

				self.difficultyIndex_ = iter_14_0 + 1
			else
				break
			end
		end
	end
end

function DemonChallengeDifficultySelectView:RefreshAffix()
	local var_15_0 = {}

	if self.difficultyIndex_ ~= nil then
		local var_15_1 = BattleHeartDemonStageCfg[DemonChallengeTools.GetStageId(self.activityId_, self.difficultyIndex_)].affix_type

		if type(var_15_1) == "table" then
			var_15_0 = getMosterAffix(var_15_1)
		end
	end

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if self.affixItemList_[iter_15_0] then
			self.affixItemList_[iter_15_0]:SetData(iter_15_1)
		else
			self.affixItemList_[iter_15_0] = AffixItemView.New(self.affixItem_, self.affixPanel_, iter_15_1)
		end
	end

	for iter_15_2 = #self.affixItemList_, #var_15_0 + 1, -1 do
		self.affixItemList_[iter_15_2]:Show(false)
	end
end

function DemonChallengeDifficultySelectView:OnExit()
	return
end

function DemonChallengeDifficultySelectView:Dispose()
	for iter_17_0, iter_17_1 in pairs(self.affixItemList_) do
		iter_17_1:Dispose()
	end

	self.affixItemList_ = nil

	DemonChallengeDifficultySelectView.super.Dispose(self)
end

return DemonChallengeDifficultySelectView
