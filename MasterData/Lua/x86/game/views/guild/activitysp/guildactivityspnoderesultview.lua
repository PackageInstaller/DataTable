local GuildActivitySPNodeResultView = class("GuildActivitySPNodeResultView", ReduxView)

function GuildActivitySPNodeResultView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPEliteMultipletUI"
end

function GuildActivitySPNodeResultView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildActivitySPNodeResultView:OnCtor()
	self.tweens_ = {}
end

function GuildActivitySPNodeResultView:Init()
	self:InitUI()
	self:AddListener()

	self.heroItemView_ = {}
end

function GuildActivitySPNodeResultView:InitUI()
	self:BindCfgUI()
	LeanTween.alphaCanvas(self.mask_, 0, 0.1)

	self.resultTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "resultType")
end

function GuildActivitySPNodeResultView:AddListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self.params_.isSuccess then
			self:CloseFunc()
		end
	end)
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
	self:AddBtnListener(self.okBtn_, nil, function()
		GuildActivitySPAction.SaveEliteCombatResult(1)
		self:CloseFunc()
	end)
	self:AddBtnListener(self.giveupBtn_, nil, function()
		GuildActivitySPAction.SaveEliteCombatResult(0)
		self:CloseFunc()
	end)
end

function GuildActivitySPNodeResultView:OnEnter()
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

function GuildActivitySPNodeResultView:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	BattleInstance.QuitBattle(self.stageData)
end

function GuildActivitySPNodeResultView:ShowVitalityBox(arg_17_1)
	if needShowVitalityFullBox(self:GetRewardData()) then
		showVitalitySendMail(arg_17_1)
	else
		arg_17_1()
	end
end

function GuildActivitySPNodeResultView:RefreshUI()
	self:SetLevelTitle()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RefreshCommonUI()
	self:RefreshBattleTime()
	self:RefreshGuildActivityUI()
end

function GuildActivitySPNodeResultView:RefreshGuildActivityUI()
	if self.params_.isSuccess then
		self.resultTypeController_:SetSelectedState("win")
	else
		self.resultTypeController_:SetSelectedState("attack")

		if ActivityClubSPCfg[self.params_.nodeId].type == 2 then
			local var_19_0 = GuildActivitySPData:GetSelfNodeData(self.params_.nodeId)
			local var_19_1 = var_19_0.elite_health_rate == 0 and 100 or var_19_0.elite_health_rate
			local var_19_3 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas

			self.progressLabel_.text = var_19_3 and (var_19_3:TryGetValue(27, nil) and var_19_1 - math.ceil(var_19_3[27] * var_19_1 / 100) .. "%" or "0%") or "0%"

			local var_19_4 = 100 - math.ceil(var_19_3[27] * var_19_1 / 100)

			if var_19_4 > 99 then
				var_19_4 = 99
			end

			self.totalProgressLabel_.text = var_19_4 .. "%"
		end
	end
end

function GuildActivitySPNodeResultView:SetLevelTitle()
	local var_20_0, var_20_1 = BattleStageTools.GetChapterSectionIndex(self.stageType, self.stageId)

	self.stareText_.text = var_20_0 ~= "" and string.format("%s-%s", var_20_0, var_20_1) or ""
	self.lvText_.text = BattleStageTools.GetStageName(self.stageType, self.stageId)

	if self.params_.title ~= nil and self.params_.title ~= "" then
		self.titleText_.text = self.params_.title
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.titleTransform_)
end

function GuildActivitySPNodeResultView:RefreshMyExpS()
	local var_21_0 = self.stageData:GetAddUserExp() * self.stageData:GetMultiple()
	local var_21_1 = math.min(var_21_0, LvTools.GetMaxTotalExp("user_level_exp") - self.params_.battleResult.oldPlayerEXPInfo.total_exp)

	if var_21_1 < 0 then
		var_21_1 = 0
	end

	local var_21_2, var_21_3 = LvTools.CheckExp(self.params_.battleResult.oldPlayerEXPInfo.userLevel, self.params_.battleResult.oldPlayerEXPInfo.remain_exp + var_21_1, "user_level_exp")

	if self.params_.battleResult.oldPlayerEXPInfo.userLevel > 30 and var_21_2 - self.params_.battleResult.oldPlayerEXPInfo.userLevel > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(self.params_.battleResult.oldPlayerEXPInfo.remain_exp), tostring(var_21_1), tostring(self.params_.battleResult.oldPlayerEXPInfo.userLevel), tostring(var_21_2)))
	end

	self.newPlayerExp_ = var_21_1
	self.addExp_.text = string.format("+%d", var_21_1)

	local var_21_4 = math.floor(self.params_.battleResult.oldPlayerEXPInfo.remain_exp / GameLevelSetting[self.params_.battleResult.oldPlayerEXPInfo.userLevel].user_level_exp * 1000) / 1000
	local var_21_5 = math.floor(var_21_3 / GameLevelSetting[var_21_2].user_level_exp * 1000) / 1000

	var_21_4 = var_21_4 > 0.99 and 0.99 or var_21_4
	var_21_5 = var_21_5 > 0.99 and 0.99 or var_21_5

	self:RemoveTween()

	self.userExp_ = var_21_2 + var_21_5

	if var_21_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	local var_21_6 = -1

	self.tween_ = LeanTween.value(self.progress_.gameObject, self.params_.battleResult.oldPlayerEXPInfo.userLevel + var_21_4, var_21_2 + var_21_5, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
		local var_22_0 = math.modf(arg_22_0)

		if var_21_6 == -1 then
			var_21_6 = var_22_0
		end

		if var_22_0 ~= var_21_6 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_21_6 = var_22_0
		end

		self:UpdateUserData(arg_22_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self.mask_.blocksRaycasts = false

		self:CheckLevelUp()
		self:RemoveTween()
	end))
end

function GuildActivitySPNodeResultView:UpdateUserData(arg_24_1)
	local var_24_0, var_24_1 = math.modf(arg_24_1)

	self.playerLv_.text = string.format("%d", var_24_0)
	self.progress_.value = LvTools.GetIsMaxLv(var_24_0, "user") and 1 or var_24_1
end

function GuildActivitySPNodeResultView:CheckLevelUp()
	local var_25_0 = self:GetLevelUpInfoList()

	if #var_25_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_25_0
		})
	end
end

function GuildActivitySPNodeResultView:GetLevelUpInfoList()
	return PlayerData:GetlevelUpInfos()
end

function GuildActivitySPNodeResultView:RefreshHeroS()
	local var_27_0, var_27_1 = self.stageData:GetHeroTeam()
	local var_27_2 = self.stageData:GetSystemHeroTeam()

	for iter_27_0 = 1, 3 do
		local var_27_3 = self[string.format("hero%s_", iter_27_0)]

		if not var_27_0[iter_27_0] or var_27_0[iter_27_0] == 0 then
			SetActive(var_27_3, false)
		else
			SetActive(var_27_3, true)
			table.insert(self.heroItemView_, BattleMultipleResultHeroItem.New(var_27_3, self.stageData:GetHeroDataByPos(iter_27_0), self.stageData, var_27_2[iter_27_0] or var_27_1[iter_27_0] ~= 0, self.params_.battleResult.heroDataCollect[iter_27_0]))
		end
	end
end

function GuildActivitySPNodeResultView:RefreshCommonUI()
	SetActive(self.btnBattleCount_.gameObject, not (BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == self.stageType and BattleConst.BATTLE_TAG.STORY == BattleChapterStageCfg[self.stageId].tag))
end

function GuildActivitySPNodeResultView:RefreshScore()
	if self.params_.score then
		self.scoreText_.text = self.params_.score
	elseif ActivityTools.GetActivityTheme((self.stageData:GetActivityID())) == ActivityConst.THEME.SUMMER then
		local var_29_0 = 0
		local var_29_1 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)

		var_29_0 = var_29_1 < GameSetting.limit_calculation_time_score_args.value[3] and GameSetting.limit_calculation_time_score_args.value[1] * GameSetting.limit_calculation_time_score_args.value[3] + GameSetting.limit_calculation_time_score_args.value[2] or var_29_1 < GameSetting.limit_calculation_time_score_args.value[4] and GameSetting.limit_calculation_time_score_args.value[1] * var_29_1 + GameSetting.limit_calculation_time_score_args.value[2] or GameSetting.limit_calculation_time_score_args.value[1] * GameSetting.limit_calculation_time_score_args.value[4] + GameSetting.limit_calculation_time_score_args.value[2]

		local var_29_2 = 0
		local var_29_4, var_29_5, var_29_6 = BattleTools.GetBattleStatisticsData()
		local var_29_7 = tonumber(tostring(var_29_5.damage))

		if var_29_7 >= GameSetting.limit_calculation_injured_score_args.value[#GameSetting.limit_calculation_injured_score_args.value][1] then
			var_29_7 = GameSetting.limit_calculation_injured_score_args.value[#GameSetting.limit_calculation_injured_score_args.value][1]
		end

		for iter_29_0, iter_29_1 in ipairs(GameSetting.limit_calculation_injured_score_args.value) do
			if var_29_7 <= iter_29_1[1] then
				var_29_2 = iter_29_1[2]

				break
			end
		end

		self.scoreText_.text = math.ceil((math.floor((var_29_0 + var_29_2) * ActivityLimitCalculationCfg[self.stageData:GetDest()].reward_point / 100)))
	end
end

function GuildActivitySPNodeResultView:RefreshBattleTime()
	self.battleTimeText_.text = self:GetBattleTime()
end

function GuildActivitySPNodeResultView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function GuildActivitySPNodeResultView:HeroAnimator(arg_32_1, arg_32_2)
	local var_32_0, var_32_1 = math.modf(arg_32_2)

	self.heroLv_[arg_32_1].text = string.format("%d", var_32_0)
	self.heroProgress_[arg_32_1].value = LvTools.GetIsMaxLv(var_32_0, "hero") and 1 or var_32_1
end

function GuildActivitySPNodeResultView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function GuildActivitySPNodeResultView:RemoveTweens()
	if self.tweens_ then
		for iter_34_0, iter_34_1 in pairs(self.tweens_) do
			self:RemoveTweenAt(iter_34_0)
		end

		self.tweens_ = nil
	end
end

function GuildActivitySPNodeResultView:RemoveTweenAt(arg_35_1)
	if self.tweens_[arg_35_1] then
		self.tweens_[arg_35_1]:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tweens_[arg_35_1].id)
	end
end

function GuildActivitySPNodeResultView:EndAnimator()
	self:RemoveTween()
	self:RemoveTweens()
	manager.audio:StopEffect()

	if self.stageData:GetAddUserExp() > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add_skip", "")
	end

	self:UpdateUserData(self.userExp_)
	self:CheckLevelUp()

	for iter_36_0, iter_36_1 in ipairs(self.heroItemView_) do
		iter_36_1:EndAnimator()
	end

	self.mask_.blocksRaycasts = false
end

function GuildActivitySPNodeResultView:OnTop()
	SetActive(self.gameObject_, true)

	self.toStat_ = false
end

function GuildActivitySPNodeResultView:OnBehind()
	if self.toStat_ then
		SetActive(self.gameObject_, false)
	end
end

function GuildActivitySPNodeResultView:OnExit()
	return
end

function GuildActivitySPNodeResultView:Dispose()
	for iter_40_0, iter_40_1 in ipairs(self.heroItemView_) do
		iter_40_1:Dispose()
	end

	self.heroItemView_ = nil

	self:RemoveTween()
	self:RemoveTweens()
	GuildActivitySPNodeResultView.super.Dispose(self)
end

return GuildActivitySPNodeResultView
