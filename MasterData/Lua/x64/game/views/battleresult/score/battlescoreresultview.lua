local BattleScoreResultView = class("BattleScoreResultView", ReduxView)

function BattleScoreResultView:UIName()
	return "UI/BattleResult/OsirisMultipletUI"
end

function BattleScoreResultView:UIParent()
	return manager.ui.uiMain.transform
end

function BattleScoreResultView:OnCtor()
	self.tweens_ = {}
end

function BattleScoreResultView:Init()
	self:InitUI()
	self:AddListener()

	self.heroItemView_ = {}
end

function BattleScoreResultView:InitUI()
	self:BindCfgUI()

	self.resultTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "resultType")
	self.scoreTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "scoreType")

	LeanTween.alphaCanvas(self.mask_, 0, 0.1)
	SetActive(self.closePanel_, self.params_.noOnceMore)
	SetActive(self.onceMoreGo_, not self.params_.noOnceMore)
	SetActive(self.closeBtnGo_, not self.params_.noOnceMore)
end

function BattleScoreResultView:AddListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.btnClose_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.buttonMask_, nil, function()
		self:EndAnimator()
	end)
	self:AddBtnListener(self.btnBattleCount_, nil, function()
		self.toStat_ = true

		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = self.stageData,
			battleTime = self:GetBattleTime()
		})
	end)
	self:AddBtnListener(self.btnOk_, nil, function()
		if self.params_.okHandler then
			self.params_.okHandler()
		end

		self:CloseFunc()
	end)
	self:AddBtnListener(self.btnGiveUp_, nil, function()
		if self.params_.giveUpHandler then
			self.params_.giveUpHandler()
		end

		self:CloseFunc()
	end)
	self:AddBtnListener(self.btnOnceMore_, nil, function()
		self:OnClickRestart()
	end)
end

function BattleScoreResultView:OnEnter()
	self.stageData = self.params_.stageData
	self.stageId = self.stageData:GetStageId()
	self.stageType = self.stageData:GetType()

	BattleInstance.hideBattlePanel()
	self:RefreshUI()

	if self.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				self:CloseFunc()
			end
		})
	end
end

function BattleScoreResultView:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	BattleInstance.QuitBattle(self.stageData)
end

function BattleScoreResultView:ShowVitalityBox(arg_17_1)
	if needShowVitalityFullBox(self:GetRewardData()) then
		showVitalitySendMail(arg_17_1)
	else
		arg_17_1()
	end
end

function BattleScoreResultView:RefreshUI()
	if self.params_.resultType == "choose" then
		self.resultTypeController_:SetSelectedState("choose")
	else
		self.resultTypeController_:SetSelectedState("score")
	end

	self:SetLevelTitle()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RefreshCommonUI()

	if self.params_.scoreType == "hp" then
		self.scoreTypeController_:SetSelectedState("hp")
		self:RefreshHp()
	else
		self.scoreTypeController_:SetSelectedState("score")
		self:RefreshScore()
	end

	self:RefreshBattleTime()
end

function BattleScoreResultView:SetLevelTitle()
	local var_19_0, var_19_1 = BattleStageTools.GetChapterSectionIndex(self.stageType, self.stageId)

	self.stareText_.text = var_19_0 ~= "" and string.format("%s-%s", GetI18NText(var_19_0), GetI18NText(var_19_1)) or ""
	self.lvText_.text = BattleStageTools.GetStageName(self.stageType, self.stageId)

	if self.params_.scoreType == "hp" then
		if self.params_.title ~= nil and self.params_.title ~= "" then
			self.hpTitleText_.text = self.params_.title
		end
	elseif self.params_.title ~= nil and self.params_.title ~= "" then
		self.titleText_.text = GetI18NText(self.params_.title)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.titleTransform_)
end

function BattleScoreResultView:RefreshMyExpS()
	local var_20_0 = self.stageData:GetAddUserExp() * self.stageData:GetMultiple()
	local var_20_1 = math.min(var_20_0, LvTools.GetMaxTotalExp("user_level_exp") - self.params_.battleResult.oldPlayerEXPInfo.total_exp)

	if var_20_1 < 0 then
		var_20_1 = 0
	end

	local var_20_2, var_20_3 = LvTools.CheckExp(self.params_.battleResult.oldPlayerEXPInfo.userLevel, self.params_.battleResult.oldPlayerEXPInfo.remain_exp + var_20_1, "user_level_exp")

	if self.params_.battleResult.oldPlayerEXPInfo.userLevel > 30 and var_20_2 - self.params_.battleResult.oldPlayerEXPInfo.userLevel > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(self.params_.battleResult.oldPlayerEXPInfo.remain_exp), tostring(var_20_1), tostring(self.params_.battleResult.oldPlayerEXPInfo.userLevel), tostring(var_20_2)))
	end

	self.newPlayerExp_ = var_20_1
	self.addExp_.text = string.format("+%d", var_20_1)

	local var_20_4 = math.floor(self.params_.battleResult.oldPlayerEXPInfo.remain_exp / GameLevelSetting[self.params_.battleResult.oldPlayerEXPInfo.userLevel].user_level_exp * 1000) / 1000
	local var_20_5 = math.floor(var_20_3 / GameLevelSetting[var_20_2].user_level_exp * 1000) / 1000

	var_20_4 = var_20_4 > 0.99 and 0.99 or var_20_4
	var_20_5 = var_20_5 > 0.99 and 0.99 or var_20_5

	self:RemoveTween()

	self.userExp_ = var_20_2 + var_20_5

	if var_20_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	local var_20_6 = -1

	self.tween_ = LeanTween.value(self.progress_.gameObject, self.params_.battleResult.oldPlayerEXPInfo.userLevel + var_20_4, var_20_2 + var_20_5, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
		local var_21_0 = math.modf(arg_21_0)

		if var_20_6 == -1 then
			var_20_6 = var_21_0
		end

		if var_21_0 ~= var_20_6 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_20_6 = var_21_0
		end

		self:UpdateUserData(arg_21_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self.mask_.blocksRaycasts = false

		self:CheckLevelUp()
		self:RemoveTween()
	end))
end

function BattleScoreResultView:UpdateUserData(arg_23_1)
	local var_23_0, var_23_1 = math.modf(arg_23_1)

	self.playerLv_.text = string.format("%d", var_23_0)
	self.progress_.value = LvTools.GetIsMaxLv(var_23_0, "user") and 1 or var_23_1
end

function BattleScoreResultView:CheckLevelUp()
	local var_24_0 = self:GetLevelUpInfoList()

	if #var_24_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_24_0
		})
	end
end

function BattleScoreResultView:GetLevelUpInfoList()
	return PlayerData:GetlevelUpInfos()
end

function BattleScoreResultView:RefreshHeroS()
	local var_26_0, var_26_1 = self.stageData:GetHeroTeam()
	local var_26_2 = self.stageData:GetSystemHeroTeam()

	for iter_26_0 = 1, 3 do
		local var_26_3 = self[string.format("hero%s_", iter_26_0)]

		if not var_26_0[iter_26_0] or var_26_0[iter_26_0] == 0 then
			SetActive(var_26_3, false)
		else
			SetActive(var_26_3, true)
			table.insert(self.heroItemView_, BattleMultipleResultHeroItem.New(var_26_3, self.stageData:GetHeroDataByPos(iter_26_0), self.stageData, var_26_2[iter_26_0] or var_26_1[iter_26_0] ~= 0, self.params_.battleResult.heroDataCollect[iter_26_0]))
		end
	end
end

function BattleScoreResultView:RefreshCommonUI()
	SetActive(self.btnBattleCount_.gameObject, not (BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == self.stageType and BattleConst.BATTLE_TAG.STORY == BattleChapterStageCfg[self.stageId].tag))
end

function BattleScoreResultView:RefreshHp()
	local var_28_0 = 100

	if self.params_.hp and self.params_.totalHp then
		var_28_0 = math.ceil(100 * self.params_.hp / self.params_.totalHp)
	end

	self.hpProgressBar_.fillAmount = var_28_0 / 100
	self.hpValueText_.text = var_28_0 .. "%"
end

function BattleScoreResultView:RefreshScore()
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == self.stageType then
		self:RefreshBossAdvanceScore()

		return
	end

	if BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA == self.stageType then
		self.scoreText_.text = ActivityAttributeArenaData:GetArenaScore(self.stageData:GetActivityID(), self.stageData:GetDest())

		return
	end

	if self.params_.score then
		self.scoreText_.text = self.params_.score
	else
		local var_29_0 = self.stageData:GetActivityID()
		local var_29_1 = ActivityTools.GetActivityTheme(var_29_0)

		if var_29_1 == ActivityConst.THEME.SUMMER or var_29_0 == ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION then
			local var_29_2 = 0
			local var_29_3 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)

			var_29_2 = var_29_3 < GameSetting.limit_calculation_time_score_args.value[3] and GameSetting.limit_calculation_time_score_args.value[1] * GameSetting.limit_calculation_time_score_args.value[3] + GameSetting.limit_calculation_time_score_args.value[2] or var_29_3 < GameSetting.limit_calculation_time_score_args.value[4] and GameSetting.limit_calculation_time_score_args.value[1] * var_29_3 + GameSetting.limit_calculation_time_score_args.value[2] or GameSetting.limit_calculation_time_score_args.value[1] * GameSetting.limit_calculation_time_score_args.value[4] + GameSetting.limit_calculation_time_score_args.value[2]

			local var_29_4 = 0
			local var_29_6, var_29_7, var_29_8 = BattleTools.GetBattleStatisticsData()
			local var_29_9 = tonumber(tostring(var_29_6[1].hurt))

			if var_29_9 >= GameSetting.limit_calculation_injured_score_args.value[#GameSetting.limit_calculation_injured_score_args.value][1] then
				var_29_9 = GameSetting.limit_calculation_injured_score_args.value[#GameSetting.limit_calculation_injured_score_args.value][1]
			end

			for iter_29_0, iter_29_1 in ipairs(GameSetting.limit_calculation_injured_score_args.value) do
				if var_29_9 <= iter_29_1[1] then
					var_29_4 = iter_29_1[2]

					break
				end
			end

			self.scoreText_.text = math.ceil((math.floor((var_29_2 + var_29_4) * ActivityLimitCalculationCfg[self.stageData:GetDest()].reward_point / 100)))
		elseif var_29_1 ~= ActivityConst.THEME.FACTORY then
			if ActivityConst.THEME.TYR then
				self.scoreText_.text = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime) .. "s"
			end
		end
	end
end

function BattleScoreResultView:RefreshBossAdvanceScore()
	local var_30_0 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
	local var_30_1 = BattleBossChallengeAdvanceData:GetBossList()[self.stageData:GetBossIndex()]
	local var_30_3 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].difficult_point[var_30_1.multipleIndex]
	local var_30_4 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua

	for iter_30_0, iter_30_1 in pairs(var_30_1.condition[BossConst.TYPE_STAGE]) do
		if BattleInstance.CaculateStar(self.stageData, StageChallengeConditionPoolCfg[iter_30_1].condition, var_30_4).isComplete then
			var_30_3 = var_30_3 + StageChallengeConditionPoolCfg[iter_30_1].point
		end
	end

	for iter_30_2, iter_30_3 in pairs(var_30_1.condition[BossConst.TYPE_AFFIX]) do
		var_30_3 = var_30_3 + ActivityAffixPoolCfg[iter_30_3].point
	end

	self.scoreText_.text = var_30_3
end

function BattleScoreResultView:RefreshBattleTime()
	self.battleTimeText_.text = self:GetBattleTime()

	SetActive(self.battleTimeText_.gameObject, ActivityTools.GetActivityTheme((self.stageData:GetActivityID())) ~= ActivityConst.THEME.FACTORY)
end

function BattleScoreResultView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function BattleScoreResultView:HeroAnimator(arg_33_1, arg_33_2)
	local var_33_0, var_33_1 = math.modf(arg_33_2)

	self.heroLv_[arg_33_1].text = string.format("%d", var_33_0)
	self.heroProgress_[arg_33_1].value = LvTools.GetIsMaxLv(var_33_0, "hero") and 1 or var_33_1
end

function BattleScoreResultView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function BattleScoreResultView:RemoveTweens()
	if self.tweens_ then
		for iter_35_0, iter_35_1 in pairs(self.tweens_) do
			self:RemoveTweenAt(iter_35_0)
		end

		self.tweens_ = nil
	end
end

function BattleScoreResultView:RemoveTweenAt(arg_36_1)
	if self.tweens_[arg_36_1] then
		self.tweens_[arg_36_1]:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tweens_[arg_36_1].id)
	end
end

function BattleScoreResultView:EndAnimator()
	self:RemoveTween()
	self:RemoveTweens()
	manager.audio:StopEffect()

	if self.stageData:GetAddUserExp() > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add_skip", "")
	end

	self:UpdateUserData(self.userExp_)
	self:CheckLevelUp()

	for iter_37_0, iter_37_1 in ipairs(self.heroItemView_) do
		iter_37_1:EndAnimator()
	end

	self.mask_.blocksRaycasts = false
end

function BattleScoreResultView:OnClickRestart()
	if self.params_.condition then
		local var_38_0, var_38_1 = self.params_.condition()

		if var_38_0 then
			BattleController.GetInstance():LaunchBattle(self.params_.stageData)
		else
			ShowTips(var_38_1)
		end
	else
		BattleController.GetInstance():LaunchBattle(self.params_.stageData)
	end
end

function BattleScoreResultView:OnTop()
	SetActive(self.gameObject_, true)

	self.toStat_ = false
end

function BattleScoreResultView:OnBehind()
	if self.toStat_ then
		SetActive(self.gameObject_, false)
	end
end

function BattleScoreResultView:OnExit()
	return
end

function BattleScoreResultView:Dispose()
	for iter_42_0, iter_42_1 in ipairs(self.heroItemView_) do
		iter_42_1:Dispose()
	end

	self.heroItemView_ = nil

	self:RemoveTween()
	self:RemoveTweens()
	BattleScoreResultView.super.Dispose(self)
end

return BattleScoreResultView
