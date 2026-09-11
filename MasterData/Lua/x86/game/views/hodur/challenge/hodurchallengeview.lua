local HodurChallengeView = class("HodurChallengeView", ReduxView)

function HodurChallengeView:UIName()
	return "Widget/System/Activity_Hodur/Activity_Hodur_BossCheckpointMainUI"
end

function HodurChallengeView:UIParent()
	return manager.ui.uiMain.transform
end

function HodurChallengeView:Init()
	self:InitUI()
	self:AddUIListener()

	self.affixModule_ = HodurChallengeAffixModule.New(self.affixPageGo_)
	self.heroModule_ = HodurChallengeHeroModule.New(self.heroPageGo_)
	self.baceController_ = self.mainControllerEx_:GetController("bace")
	self.scoreController_ = self.mainControllerEx_:GetController("Score")
	self.tipsPosController_ = self.mainControllerEx_:GetController("tipsPos")
	self.difficultyController_ = self.mainControllerEx_:GetController("difficulty")
	self.bossList_ = {}

	for iter_3_0 = 1, 4 do
		local var_3_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_3_0, self["bossItem_" .. iter_3_0])

		var_3_0.gameObject_ = self["affixItem_" .. iter_3_0]
		var_3_0.index = iter_3_0
		var_3_0.selectController_ = var_3_0.mainControllerEx_:GetController("select")
		var_3_0.lockController_ = var_3_0.mainControllerEx_:GetController("lock")
		var_3_0.numController_ = var_3_0.mainControllerEx_:GetController("num")

		var_3_0.selectController_:SetSelectedState("off")
		self:AddBtnListener(var_3_0.clickBtn_, nil, function()
			self:OnClickBossItem(var_3_0, iter_3_0)
		end)

		self.bossList_[iter_3_0] = var_3_0
	end

	self.efficiencyText_ = self.mainGo_:GetComponent("RollingNumberText")
	self.scoreEfficiency = 100
end

function HodurChallengeView:InitUI()
	self:BindCfgUI()
end

function HodurChallengeView:AddUIListener()
	self:AddBtnListener(self.startBtn_, nil, function()
		HodurSystemData:CacheAffixList(self.affixModule_:GetSelectedAffix())
		HodurTools.GotoChallengeBattle(self.chapterID_, ActivityConst.ACTIVITY_HODUR_MAIN)
	end)
	self:AddBtnListener(self.continueBtn_, nil, function()
		HodurTools.GotoChallengeBattle(self.chapterID_, ActivityConst.ACTIVITY_HODUR_MAIN)
	end)
	self:AddBtnListener(self.giveupBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("HODUR_SETTLE_CHALLENGE_TIP"),
			OkCallback = function()
				HodurTools.GotoChallengeSettle(self.chapterID_)
				HodurTools.SettleChallenge()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/hodurRankView", {
			activityID = ActivityConst.ACTIVITY_HODUR_MAIN
		})
	end)
end

function HodurChallengeView:OnEnter()
	self.chapterID_ = self.params_.chapter_id

	self:RefreshUI()
	HodurSystemData:ClearAffixCache()
end

function HodurChallengeView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HodurChallengeView:OnBehind()
	manager.windowBar:HideBar()
end

function HodurChallengeView:OnExit()
	self.affixModule_:ShowTips(false)
end

function HodurChallengeView:RefreshUI()
	self.affixModule_:SetData(self.chapterID_)
	self.heroModule_:SetData(self.chapterID_)
	self:RefreshPage()
	self:RefreshAffixInfo()
	self:RefreshChapterState()
	self:RefreshBossItem()
end

function HodurChallengeView:RefreshPage()
	local var_18_0 = HodurTools.GetChallengeHero()

	if var_18_0 and #var_18_0 > 0 then
		self.baceController_:SetSelectedState("bace02")
		self.scoreController_:SetSelectedState("Points")
		self:ShowBossInfo(true, HodurTools.GetChallengeCurIndex())
	else
		self.baceController_:SetSelectedState("bace01")
		self.scoreController_:SetSelectedState("Efficiency")
		self:ShowBossInfo(true, 1)
	end
end

function HodurChallengeView:RefreshAffixInfo()
	local var_19_0 = {}
	local var_19_1 = HodurTools.GetChallengeAffix()

	if var_19_1 and #var_19_1 > 0 then
		var_19_0 = var_19_1

		self.affixModule_:SetSelectedAffix(var_19_1)
	else
		var_19_0 = self.affixModule_:GetSelectedAffix()
	end

	local var_19_2 = #var_19_0

	if #var_19_0 == nil then
		var_19_2 = 0
	end

	local var_19_3 = self.scoreEfficiency
	local var_19_4 = 100

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if PublicBuffCfg[iter_19_1] then
			var_19_4 = var_19_4 + ActivityAffixPoolCfg[PublicBuffCfg[iter_19_1].buff_class_id].point
		end
	end

	self.scoreEfficiency = var_19_4

	local var_19_5 = string.format("%d%%", var_19_4)

	self.efficiencyText_:Change(var_19_3, self.scoreEfficiency)

	if var_19_2 < 3 then
		self.difficultyController_:SetSelectedState("num0")
	elseif var_19_2 >= 3 and var_19_2 < 6 then
		self.difficultyController_:SetSelectedState("num3")
	else
		self.difficultyController_:SetSelectedState("num6")
	end
end

function HodurChallengeView:RefreshChapterState()
	self.curScoreText_.text = tostring((HodurTools.GetChallengeCurScore()))
	self.maxScoreText_.text = tostring((HodurTools.GetChallengeMaxScore()))
end

function HodurChallengeView:RefreshBossItem()
	for iter_21_0, iter_21_1 in ipairs(self.bossList_) do
		if HodurTools.GetChallengeStageUnlock(iter_21_1.index) then
			iter_21_1.lockController_:SetSelectedState("unlock")
		else
			iter_21_1.lockController_:SetSelectedState("lock")
		end

		if HodurTools.GetChallengeStageFinish(iter_21_1.index) then
			iter_21_1.numController_:SetSelectedState("on")

			iter_21_1.scoreText_.text = tostring((HodurTools.GetChallengeStageCurScore(iter_21_1.index)))
		else
			iter_21_1.numController_:SetSelectedState("off")
		end
	end
end

function HodurChallengeView:OnClickBossItem(arg_22_1, arg_22_2)
	for iter_22_0, iter_22_1 in ipairs(self.bossList_) do
		if iter_22_1.index == arg_22_2 then
			iter_22_1.selectController_:SetSelectedState("on")
			self:ShowBossInfo(true, arg_22_2)
		else
			iter_22_1.selectController_:SetSelectedState("off")
		end
	end
end

function HodurChallengeView:ShowBossInfo(arg_23_1, arg_23_2)
	self.isShowBossInfo_ = arg_23_1

	if self.selectIndex_ ~= arg_23_2 then
		self.bossAnimator_:Play("UI_BOSS_cx", -1, 0)
	end

	self.selectIndex_ = arg_23_2

	SetActive(self.tipsGo_, arg_23_1)

	for iter_23_0, iter_23_1 in ipairs(self.bossList_) do
		iter_23_1.selectController_:SetSelectedState("off")
	end

	local var_23_0

	if arg_23_1 then
		self.bossList_[arg_23_2].selectController_:SetSelectedState("on")

		self.bossNameText_.text = BattleHodurStageCfg[ActivityHodurChapterCfg[self.chapterID_].stage_list[arg_23_2][1]].name
		self.bossDescText_.text = BattleHodurStageCfg[ActivityHodurChapterCfg[self.chapterID_].stage_list[arg_23_2][1]].description
		self.bossMaxScoreText_.text = HodurTools.GetChallengeStageMaxScore(arg_23_2)
		var_23_0 = tostring(arg_23_2) or "1"
	end

	self.tipsPosController_:SetSelectedState(var_23_0)

	for iter_23_2 = 1, 4 do
		self["bossImg_" .. iter_23_2].sprite = getSpriteWithoutAtlas("TextureConfig/Activity_Hodur/Boss/" .. ActivityHodurCfg[ActivityHodurChapterCfg[self.chapterID_].stage_list[arg_23_2][1]].boss_img) or nil
	end
end

function HodurChallengeView:OnHodurResetChapter()
	self:RefreshUI()
end

function HodurChallengeView:OnHodurChallengeSelectAffix()
	self:RefreshAffixInfo()
end

function HodurChallengeView:Dispose()
	self.affixModule_:Dispose()
	self.heroModule_:Dispose()
	HodurChallengeView.super.Dispose(self)
	self:RemoveAllListeners()
end

return HodurChallengeView
