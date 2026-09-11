local GuildActivitySPBoosNodeResultView = class("GuildActivitySPBoosNodeResultView", ReduxView)

function GuildActivitySPBoosNodeResultView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPMultipletUI"
end

function GuildActivitySPBoosNodeResultView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildActivitySPBoosNodeResultView:OnCtor()
	self.tweens_ = {}
end

function GuildActivitySPBoosNodeResultView:Init()
	self:InitUI()
	self:AddListener()

	self.heroItemView_ = {}
end

function GuildActivitySPBoosNodeResultView:InitUI()
	self:BindCfgUI()
	LeanTween.alphaCanvas(self.mask_, 0, 0.1)
	SetActive(self.closePanel_, false)

	self.battleController = ControllerUtil.GetController(self.gameObject_.transform, "battleResult")
end

function GuildActivitySPBoosNodeResultView:AddListener()
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
	self:AddBtnListener(self.oncemoreBtn_, nil, function()
		if GuildActivitySPData:GetNodeData(self.params_.nodeId).health > 0 or self.params_.nodeId == GuildActivitySPData:GetMaxNodeId() then
			self:OnClickRestart(true)
		else
			ShowTips("ACTIVITY_CLUB_SP_BOSS_NODE_PASS")
		end
	end)
	self:AddBtnListener(self.btn_backBtn_, nil, function()
		local var_11_0 = GuildActivitySPData:GetNodeData(self.params_.nodeId)

		if self.params_.okHandler then
			self.params_.okHandler(true)
		end

		self:CloseFunc()
	end)
end

function GuildActivitySPBoosNodeResultView:OnEnter()
	self.stageData = self.params_.stageData
	self.stageId = self.stageData:GetStageId()
	self.stageType = self.stageData:GetType()

	if self.params_.isSuccess then
		self.battleController:SetSelectedState("true")
	else
		self.battleController:SetSelectedState("false")
	end

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

function GuildActivitySPBoosNodeResultView:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	BattleInstance.QuitBattle(self.stageData)
end

function GuildActivitySPBoosNodeResultView:ShowVitalityBox(arg_15_1)
	if needShowVitalityFullBox(self:GetRewardData()) then
		showVitalitySendMail(arg_15_1)
	else
		arg_15_1()
	end
end

function GuildActivitySPBoosNodeResultView:RefreshUI()
	self:SetLevelTitle()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RefreshCommonUI()
	self:RefreshBattleTime()
	self:RefreshScore()
	self:RefreshAward()
end

function GuildActivitySPBoosNodeResultView:SetLevelTitle()
	local var_17_0, var_17_1 = BattleStageTools.GetChapterSectionIndex(self.stageType, self.stageId)

	self.stareText_.text = var_17_0 ~= "" and string.format("%s-%s", var_17_0, var_17_1) or ""
	self.lvText_.text = BattleStageTools.GetStageName(self.stageType, self.stageId)

	if self.params_.scoreType == "hp" then
		if self.params_.title ~= nil and self.params_.title ~= "" then
			self.hpTitleText_.text = self.params_.title
		end
	elseif self.params_.title ~= nil and self.params_.title ~= "" then
		self.titleText_.text = self.params_.title
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.titleTransform_)
end

function GuildActivitySPBoosNodeResultView:RefreshMyExpS()
	local var_18_0 = self.stageData:GetAddUserExp() * self.stageData:GetMultiple()
	local var_18_1 = math.min(var_18_0, LvTools.GetMaxTotalExp("user_level_exp") - self.params_.battleResult.oldPlayerEXPInfo.total_exp)

	if var_18_1 < 0 then
		var_18_1 = 0
	end

	local var_18_2, var_18_3 = LvTools.CheckExp(self.params_.battleResult.oldPlayerEXPInfo.userLevel, self.params_.battleResult.oldPlayerEXPInfo.remain_exp + var_18_1, "user_level_exp")

	if self.params_.battleResult.oldPlayerEXPInfo.userLevel > 30 and var_18_2 - self.params_.battleResult.oldPlayerEXPInfo.userLevel > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(self.params_.battleResult.oldPlayerEXPInfo.remain_exp), tostring(var_18_1), tostring(self.params_.battleResult.oldPlayerEXPInfo.userLevel), tostring(var_18_2)))
	end

	self.newPlayerExp_ = var_18_1
	self.addExp_.text = string.format("+%d", var_18_1)

	local var_18_4 = math.floor(self.params_.battleResult.oldPlayerEXPInfo.remain_exp / GameLevelSetting[self.params_.battleResult.oldPlayerEXPInfo.userLevel].user_level_exp * 1000) / 1000
	local var_18_5 = math.floor(var_18_3 / GameLevelSetting[var_18_2].user_level_exp * 1000) / 1000

	var_18_4 = var_18_4 > 0.99 and 0.99 or var_18_4
	var_18_5 = var_18_5 > 0.99 and 0.99 or var_18_5

	self:RemoveTween()

	self.userExp_ = var_18_2 + var_18_5

	if var_18_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	local var_18_6 = -1

	self.tween_ = LeanTween.value(self.progress_.gameObject, self.params_.battleResult.oldPlayerEXPInfo.userLevel + var_18_4, var_18_2 + var_18_5, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
		local var_19_0 = math.modf(arg_19_0)

		if var_18_6 == -1 then
			var_18_6 = var_19_0
		end

		if var_19_0 ~= var_18_6 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_18_6 = var_19_0
		end

		self:UpdateUserData(arg_19_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self.mask_.blocksRaycasts = false

		self:CheckLevelUp()
		self:RemoveTween()
	end))
end

function GuildActivitySPBoosNodeResultView:UpdateUserData(arg_21_1)
	local var_21_0, var_21_1 = math.modf(arg_21_1)

	self.playerLv_.text = string.format("%d", var_21_0)
	self.progress_.value = LvTools.GetIsMaxLv(var_21_0, "user") and 1 or var_21_1
end

function GuildActivitySPBoosNodeResultView:CheckLevelUp()
	local var_22_0 = self:GetLevelUpInfoList()

	if #var_22_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_22_0
		})
	end
end

function GuildActivitySPBoosNodeResultView:GetLevelUpInfoList()
	return PlayerData:GetlevelUpInfos()
end

function GuildActivitySPBoosNodeResultView:RefreshHeroS()
	local var_24_0, var_24_1 = self.stageData:GetHeroTeam()
	local var_24_2 = self.stageData:GetSystemHeroTeam()

	for iter_24_0 = 1, 3 do
		local var_24_3 = self[string.format("hero%s_", iter_24_0)]

		if not var_24_0[iter_24_0] or var_24_0[iter_24_0] == 0 then
			SetActive(var_24_3, false)
		else
			SetActive(var_24_3, true)
			table.insert(self.heroItemView_, BattleMultipleResultHeroItem.New(var_24_3, self.stageData:GetHeroDataByPos(iter_24_0), self.stageData, var_24_2[iter_24_0] or var_24_1[iter_24_0] ~= 0, self.params_.battleResult.heroDataCollect[iter_24_0]))
		end
	end
end

function GuildActivitySPBoosNodeResultView:RefreshCommonUI()
	SetActive(self.btnBattleCount_.gameObject, not (BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == self.stageType and BattleConst.BATTLE_TAG.STORY == BattleChapterStageCfg[self.stageId].tag))
end

function GuildActivitySPBoosNodeResultView:RefreshScore()
	if self.params_.score then
		self.scoreText_.text = self.params_.score
	else
		local var_26_0 = self.stageData:GetActivityID()
		local var_26_1 = ActivityTools.GetActivityTheme(var_26_0)

		if var_26_1 == ActivityConst.THEME.SUMMER or var_26_0 == ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION then
			local var_26_2 = 0
			local var_26_3 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)

			var_26_2 = var_26_3 < GameSetting.limit_calculation_time_score_args.value[3] and GameSetting.limit_calculation_time_score_args.value[1] * GameSetting.limit_calculation_time_score_args.value[3] + GameSetting.limit_calculation_time_score_args.value[2] or var_26_3 < GameSetting.limit_calculation_time_score_args.value[4] and GameSetting.limit_calculation_time_score_args.value[1] * var_26_3 + GameSetting.limit_calculation_time_score_args.value[2] or GameSetting.limit_calculation_time_score_args.value[1] * GameSetting.limit_calculation_time_score_args.value[4] + GameSetting.limit_calculation_time_score_args.value[2]

			local var_26_4 = 0
			local var_26_6, var_26_7, var_26_8 = BattleTools.GetBattleStatisticsData()
			local var_26_9 = tonumber(tostring(var_26_6[1].hurt))

			if var_26_9 >= GameSetting.limit_calculation_injured_score_args.value[#GameSetting.limit_calculation_injured_score_args.value][1] then
				var_26_9 = GameSetting.limit_calculation_injured_score_args.value[#GameSetting.limit_calculation_injured_score_args.value][1]
			end

			for iter_26_0, iter_26_1 in ipairs(GameSetting.limit_calculation_injured_score_args.value) do
				if var_26_9 <= iter_26_1[1] then
					var_26_4 = iter_26_1[2]

					break
				end
			end

			self.scoreText_.text = math.ceil((math.floor((var_26_2 + var_26_4) * ActivityLimitCalculationCfg[self.stageData:GetDest()].reward_point / 100)))
		elseif var_26_1 ~= ActivityConst.THEME.FACTORY then
			if ActivityConst.THEME.TYR then
				self.scoreText_.text = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime) .. "s"
			end
		end
	end
end

function GuildActivitySPBoosNodeResultView:RefreshAward()
	if self.params_.currencyID then
		self.currencyIcon_.sprite = ItemTools.getItemSprite(self.params_.currencyID)
	end

	if self.params_.awardNum then
		self.currencyNum_.text = self.params_.awardNum
	end
end

function GuildActivitySPBoosNodeResultView:RefreshBattleTime()
	self.battleTimeText_.text = self:GetBattleTime()

	SetActive(self.battleTimeText_.gameObject, ActivityTools.GetActivityTheme((self.stageData:GetActivityID())) ~= ActivityConst.THEME.FACTORY)
end

function GuildActivitySPBoosNodeResultView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function GuildActivitySPBoosNodeResultView:HeroAnimator(arg_30_1, arg_30_2)
	local var_30_0, var_30_1 = math.modf(arg_30_2)

	self.heroLv_[arg_30_1].text = string.format("%d", var_30_0)
	self.heroProgress_[arg_30_1].value = LvTools.GetIsMaxLv(var_30_0, "hero") and 1 or var_30_1
end

function GuildActivitySPBoosNodeResultView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function GuildActivitySPBoosNodeResultView:RemoveTweens()
	if self.tweens_ then
		for iter_32_0, iter_32_1 in pairs(self.tweens_) do
			self:RemoveTweenAt(iter_32_0)
		end

		self.tweens_ = nil
	end
end

function GuildActivitySPBoosNodeResultView:RemoveTweenAt(arg_33_1)
	if self.tweens_[arg_33_1] then
		self.tweens_[arg_33_1]:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tweens_[arg_33_1].id)
	end
end

function GuildActivitySPBoosNodeResultView:EndAnimator()
	self:RemoveTween()
	self:RemoveTweens()
	manager.audio:StopEffect()

	if self.stageData:GetAddUserExp() > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add_skip", "")
	end

	self:UpdateUserData(self.userExp_)
	self:CheckLevelUp()

	for iter_34_0, iter_34_1 in ipairs(self.heroItemView_) do
		iter_34_1:EndAnimator()
	end

	self.mask_.blocksRaycasts = false
end

function GuildActivitySPBoosNodeResultView:OnClickRestart(arg_35_1)
	if self.params_.condition then
		local var_35_0, var_35_1 = self.params_.condition()

		if var_35_0 then
			if self.params_.okHandler then
				self.params_.okHandler(arg_35_1)
			end

			BattleController.GetInstance():LaunchBattle(self.params_.stageData)
		else
			ShowTips(var_35_1)
		end
	else
		if self.params_.okHandler then
			self.params_.okHandler(arg_35_1)
		end

		BattleController.GetInstance():LaunchBattle(self.params_.stageData)
	end
end

function GuildActivitySPBoosNodeResultView:OnTop()
	SetActive(self.gameObject_, true)

	self.toStat_ = false
end

function GuildActivitySPBoosNodeResultView:OnBehind()
	if self.toStat_ then
		SetActive(self.gameObject_, false)
	end
end

function GuildActivitySPBoosNodeResultView:OnExit()
	return
end

function GuildActivitySPBoosNodeResultView:Dispose()
	for iter_39_0, iter_39_1 in ipairs(self.heroItemView_) do
		iter_39_1:Dispose()
	end

	self.heroItemView_ = nil

	self:RemoveTween()
	self:RemoveTweens()
	GuildActivitySPBoosNodeResultView.super.Dispose(self)
end

return GuildActivitySPBoosNodeResultView
