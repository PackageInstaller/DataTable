local SPHeroChallengeBattleToggleView = class("SPHeroChallengeBattleToggleView", ReduxView)

function SPHeroChallengeBattleToggleView:UIName()
	return "Widget/System/SPHeroChallenge/SPHeroChallengeBattleToggleUI"
end

function SPHeroChallengeBattleToggleView:UIParent()
	return manager.ui.uiMain.transform
end

function SPHeroChallengeBattleToggleView:OnCtor()
	return
end

function SPHeroChallengeBattleToggleView:Init()
	self:InitUI()

	self.tree_ = LuaTree.New(self.uitreeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect))
	self:AddUIListener()
end

function SPHeroChallengeBattleToggleView:InitUI()
	self:BindCfgUI()

	local var_5_0 = SPHeroChallengeData:GetActivityID()

	self.viewList = {
		SPHeroChallengeStoryView.New(self.panelTrs_, var_5_0),
		SPHeroChallengeTrainView.New(self.panelTrs_, var_5_0),
		(SPHeroChallengeBossView.New(self.panelTrs_, var_5_0))
	}

	for iter_5_0, iter_5_1 in ipairs(self.viewList) do
		iter_5_1:Show(false)
	end
end

function SPHeroChallengeBattleToggleView:OnEnter()
	self:RegisterEvents()

	self.activityID = SPHeroChallengeData:GetActivityID()

	if SPHeroChallengeData.activityCfg[self.activityID] then
		self.chapterIDList = {
			SPHeroChallengeData.activityCfg[self.activityID].storyChapter,
			SPHeroChallengeData.activityCfg[self.activityID].trainChapter,
			SPHeroChallengeData.activityCfg[self.activityID].bossChapter
		}
	end

	if self.params_.stageID then
		if BattleVerthandiExclusiveCfg[self.params_.stageID].sub_type == SpHeroChallengeConst.BattleSubType.story then
			self.groupIndex = 1
		elseif BattleVerthandiExclusiveCfg[self.params_.stageID].sub_type == SpHeroChallengeConst.BattleSubType.boss then
			self.groupIndex = 3
		else
			self.groupIndex = 2

			JumpTools.OpenPageByJump("/spHeroChallengeTrainStageView", {
				playAnimation = true,
				trainType = BattleVerthandiExclusiveCfg[self.params_.stageID].sub_type
			})

			return
		end
	end

	self.groupIndex = self.params_.groupIndex or self.groupIndex or 1

	if not SPHeroChallengeTools:GetChapterIsOpen(self.chapterIDList[self.groupIndex]) then
		self.groupIndex = 1
	end

	self.tree_:SelectGroup(self.groupIndex)

	if self:IsOpenSectionView() then
		SetActive(self.backBtn_.gameObject, true)
		SetActive(self.uitreeGo_, false)
	else
		SetActive(self.backBtn_.gameObject, false)
		SetActive(self.uitreeGo_, true)
	end

	self:RefreshLockState()
end

function SPHeroChallengeBattleToggleView:RegisterEvents()
	self:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_BOSS, function()
		self:RefreshLockState()
	end)
end

function SPHeroChallengeBattleToggleView:OnTop()
	if self.curView then
		self.curView:OnTop()
	end
end

function SPHeroChallengeBattleToggleView:RefreshLockState()
	for iter_10_0, iter_10_1 in ipairs(self.chapterIDList) do
		local var_10_0 = self.tree_:GetGroupGameObjectById(iter_10_0)

		if var_10_0 then
			local var_10_1 = ControllerUtil.GetController(var_10_0.transform, "lock")

			if SPHeroChallengeTools:GetChapterIsOpen(iter_10_1) then
				var_10_1:SetSelectedState("false")
			else
				var_10_1:SetSelectedState("true")
			end
		end
	end
end

function SPHeroChallengeBattleToggleView:OnUpdate()
	if self.curView then
		self.curView:SetParams(self.params_)
		self.curView:OnUpdate()
		self:RefreshWinBar()
	end

	if self:IsOpenSectionView() then
		SetActive(self.backBtn_.gameObject, true)
		SetActive(self.uitreeGo_, false)
	else
		SetActive(self.backBtn_.gameObject, false)
		SetActive(self.uitreeGo_, true)
	end
end

function SPHeroChallengeBattleToggleView:OnBehind()
	if self.curView then
		self.curView:OnBehind()
	end

	self:RefreshBackBtnState()
end

function SPHeroChallengeBattleToggleView:OnExit()
	if self.curView then
		self.curView:OnExit()
		self.curView:Show(false)
	end

	self.oldIndex = nil
	self.params_.groupIndex = nil

	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function SPHeroChallengeBattleToggleView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		if self:IsOpenSectionView() then
			self:Back()
			self:RefreshBackBtnState()
		end
	end)
end

function SPHeroChallengeBattleToggleView:IsOpenSectionView()
	return self:IsOpenRoute("spHeroChallengeSectionView")
end

function SPHeroChallengeBattleToggleView:RefreshBackBtnState()
	if self.groupIndex == SpHeroChallengeConst.BattleSubType.story then
		return
	end

	if self:IsOpenSectionView() then
		SetActive(self.backBtn_.gameObject, true)
	else
		SetActive(self.backBtn_.gameObject, false)
	end
end

function SPHeroChallengeBattleToggleView:RefreshWinBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_HERO_CHALLENGE_HERO_HELP")
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/spHeroChallengeMainView")
	end)
end

function SPHeroChallengeBattleToggleView:Dispose()
	if self.viewList then
		for iter_20_0, iter_20_1 in pairs(self.viewList) do
			iter_20_1:Dispose()
		end
	end

	if self.tree_ then
		self.tree_:Dispose()
	end

	SPHeroChallengeBattleToggleView.super.Dispose(self)
end

function SPHeroChallengeBattleToggleView:OnGroupSelect(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if self.oldIndex and self.oldIndex == arg_21_1 then
		return
	end

	local var_21_0, var_21_1 = SPHeroChallengeTools:GetChapterIsOpen(self.chapterIDList[arg_21_1])

	if not var_21_0 then
		-- block empty
	end

	self.groupIndex = arg_21_1
	self.oldIndex = self.groupIndex

	self:SwitchPage(var_21_0, var_21_1)
end

function SPHeroChallengeBattleToggleView:IsOpenSectionInfo()
	return self:IsOpenRoute("spHeroChallengeSectionView")
end

function SPHeroChallengeBattleToggleView:SwitchPage(arg_23_1, arg_23_2)
	if self:IsOpenSectionInfo() then
		self:Back()
	end

	if self.curView then
		self.curView:OnExit()
		self.curView:Show(false)
	end

	self.curView = self.viewList[self.groupIndex]

	if self.curView then
		self.curView:Show(true)

		self.params_.showFlag = arg_23_1
		self.params_.reason = arg_23_2

		self.curView:SetParams(self.params_)
		self.curView:OnEnter()
		self.curView:OnTop()
		self:RefreshWinBar()
	end
end

return SPHeroChallengeBattleToggleView
