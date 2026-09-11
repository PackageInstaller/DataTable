local BattleHodurResultChallengeView = class("BattleHodurResultChallengeView", NewBattleSettlementView)

function BattleHodurResultChallengeView:UIName()
	return "Widget/System/Activity_Hodur/BattleResultWinUI_Hodur_Challenge"
end

function BattleHodurResultChallengeView:Init()
	self.hasSnapshot_ = GetBattleResultSnapShot()

	self:InitUI()

	self.btnController = self.btnController_:GetController("btn")
	self.adaptComp = self:FindCom("AdaptImage", nil, self.commonMaskBg_.transform)
	self.mainCon = self.mainControllerEx_:GetController("state01")

	self:AddListener()
end

function BattleHodurResultChallengeView:RenderView()
	self:RenderTitleView()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RenderCommonUI()
	self:RefreshBattleTime()
	self:RefreshBottomBtn()
	self:RenderChapterInfo()
	self:RenderScoreInfo()
end

function BattleHodurResultChallengeView:RenderChapterInfo()
	local var_4_0 = self.btnControllerEx_:GetController("default0")
	local var_4_1 = HodurTools.GetChallengeCurIndex() - 1
	local var_4_2 = #ActivityHodurChapterCfg[self.params_.chapterID].stage_list

	if HodurTools.GetChallengeComplete() then
		var_4_1 = var_4_2

		var_4_0:SetSelectedState("state1")
	else
		var_4_0:SetSelectedState("state0")
	end

	self.chapterText_.text = string.format("%d/%d", var_4_1, var_4_2)
	self.scoreText_.text = string.format("%d", HodurTools.GetChallengeStageCurScore(var_4_1))

	local var_4_3 = HodurTools.GetChallengeScoreList()

	self.timeScoreText_.text = tostring(var_4_3[1] or 0)
	self.bloodScoreText_.text = tostring(var_4_3[2] or 0)
	self.comboScoreText_.text = tostring(var_4_3[3] or 0)
	self.skillScoreText_.text = tostring(var_4_3[4] or 0)
	self.allScoreText_.text = tostring(var_4_3[1] + var_4_3[2] + var_4_3[3] + var_4_3[4] or 0)

	local var_4_4 = 100

	for iter_4_0, iter_4_1 in ipairs((HodurTools.GetChallengeAffix())) do
		if PublicBuffCfg[iter_4_1] then
			var_4_4 = var_4_4 + ActivityAffixPoolCfg[PublicBuffCfg[iter_4_1].buff_class_id].point
		end
	end

	self.scoreEfficiency = var_4_4
	self.effScoreText_.text = string.format("%d%%", var_4_4)
end

function BattleHodurResultChallengeView:RefreshHeroS()
	local var_5_0, var_5_1 = self.stageData:GetHeroTeam()
	local var_5_2 = self.stageData:GetSystemHeroTeam()

	if var_5_0[2] == 0 then
		table.remove(var_5_0, 2)
		table.remove(var_5_1, 2)
		table.insert(var_5_0, 0)
		table.insert(var_5_1, 0)
	end

	local var_5_3 = self.params_.battleResult.heroDataCollect

	for iter_5_0 = 1, 3 do
		if not var_5_0[iter_5_0] or var_5_0[iter_5_0] == 0 then
			self.heroModule[iter_5_0]:SetHeroData(nil)
			self.heroModule[iter_5_0]:ShowCaptain(false)
		else
			self.heroModule[iter_5_0]:ShowCaptain(iter_5_0 == 1)

			local var_5_4 = self.stageData:GetHeroDataByPos(iter_5_0)
			local var_5_5 = {
				id = var_5_4.id,
				using_skin = var_5_4.using_skin
			}

			var_5_5.star = var_5_4.star or 0

			self.heroModule[iter_5_0]:SetHeroData(var_5_5)

			if var_5_3[iter_5_0] and self:NeedAddExp() then
				self.heroModule[iter_5_0]:PlayLevelUpTween(var_5_3[iter_5_0].oldLv, var_5_3[iter_5_0].newLv, var_5_3[iter_5_0].oldPersent, var_5_3[iter_5_0].newPersent, 2)
			else
				self.heroModule[iter_5_0]:ShowLevel(var_5_4.level, 1)
			end

			local var_5_6 = var_5_4.tempID

			if not var_5_4.tempID or var_5_6 == 0 then
				var_5_6 = var_5_4.id
			end

			local var_5_7, var_5_8 = HodurTools.GetChallengeHeroHP(var_5_6)

			self.heroModule[iter_5_0].hpNum_.text = var_5_7 == 0 and string.format("%s%%", 0) or string.format("%s%%", math.max(1, math.floor(var_5_7 / var_5_8 * 100)))
			self.heroModule[iter_5_0].hpImg_.fillAmount = var_5_7 / var_5_8
		end
	end
end

function BattleHodurResultChallengeView:RenderScoreInfo()
	self.scoreAni_:Play("UI_scoreicon_cx", -1, 0)
	self.mainCon:SetSelectedIndex(1)
	manager.ui:UIEventEnabledByUI(false, true)

	self.aniTimer_ = Timer.New(function()
		self.mainCon:SetSelectedIndex(0)
		manager.ui:UIEventEnabledByUI(true, false)
	end, 1.5, 1)

	self.aniTimer_:Start()
end

function BattleHodurResultChallengeView:OnAddListner()
	self:AddBtnListener(self.exitBtn_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.restartBtn_, nil, function()
		if HodurSystemData:GetCachedStageData() then
			BattleController.GetInstance():LaunchBattle(HodurSystemData:GetCachedStageData())
		else
			BattleInstance.OnceMoreBattle(self.stageData)
		end
	end)
	self:AddBtnListener(self.confirm2Btn_, nil, function()
		BattleController.GetInstance():LaunchBattle(self.stageData:GetNextStage())
	end)
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		self.mainCon:SetSelectedIndex(0)
	end)
	self:AddBtnListener(self.detailBtn_, nil, function()
		self.mainCon:SetSelectedIndex(1)
	end)
end

function BattleHodurResultChallengeView:OnExit()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end
end

return BattleHodurResultChallengeView
