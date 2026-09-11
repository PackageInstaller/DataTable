local BattleScoreResultView = class("BattleScoreResultView", ReduxView)

function BattleScoreResultView:UIName()
	return "UI/BattleResult/WorldBossScoreResultUI"
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
	LeanTween.alphaCanvas(self.mask_, 0, 0.1)

	self.rewardList = LuaList.New(handler(self, self.IndexItem), self.m_list, CommonItem)
end

function BattleScoreResultView:IndexItem(arg_6_1, arg_6_2)
	local var_6_0 = self.rewardDatas[arg_6_1]

	arg_6_2:RefreshData(formatReward(self.rewardDatas[arg_6_1]))
	arg_6_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_6_0)
	end)
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
	self:AddBtnListener(self.btnOnceMore_, nil, function()
		local var_13_0 = self.stageData:GetActivityID()

		if not ActivityTools.GetActivityIsOpenWithTip(var_13_0) then
			return
		end

		ActivityWorldBossAction.QueryBossData(var_13_0, function()
			local var_14_0 = ActivityWorldBossData:GetStageId(var_13_0)

			self.stageData.id = var_14_0
			self.stageData.cfg = BattleActivityWorldBossCfg[var_14_0]

			BattleController.GetInstance():LaunchBattle(self.stageData)
		end)
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

function BattleScoreResultView:ShowVitalityBox(arg_18_1)
	if needShowVitalityFullBox(self:GetRewardData()) then
		showVitalitySendMail(arg_18_1)
	else
		arg_18_1()
	end
end

function BattleScoreResultView:RefreshUI()
	self:SetLevelTitle()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RefreshCommonUI()
	self:RefreshScore()
	self:RefreshBattleTime()
	self:RefreshReward()
end

function BattleScoreResultView:RefreshReward()
	self.rewardDatas = self.params_.rewardList or {}

	self.rewardList:StartScroll(#self.rewardDatas)

	local var_20_0 = self.stageData:GetActivityID()

	self.m_coinMax.text = "/" .. ActivityWorldBossData:GetMaxCoinNum(var_20_0)
	self.m_coinCount.text = ActivityWorldBossData:GetCointCount(var_20_0)
end

function BattleScoreResultView:SetLevelTitle()
	local var_21_0, var_21_1 = BattleStageTools.GetChapterSectionIndex(self.stageType, self.stageId)

	self.stareText_.text = var_21_0 ~= "" and string.format("%s-%s", GetI18NText(var_21_0), GetI18NText(var_21_1)) or ""
	self.lvText_.text = BattleStageTools.GetStageName(self.stageType, self.stageId)

	if self.params_.title ~= nil and self.params_.title ~= "" then
		self.titleText_.text = GetI18NText(self.params_.title)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.titleTransform_)
end

function BattleScoreResultView:RefreshMyExpS()
	local var_22_0 = self.stageData:GetAddUserExp() * self.stageData:GetMultiple()
	local var_22_1 = math.min(var_22_0, LvTools.GetMaxTotalExp("user_level_exp") - self:GetPlayerInfo().total_exp)

	if var_22_1 < 0 then
		var_22_1 = 0
	end

	local var_22_2, var_22_3 = LvTools.CheckExp(self.params_.battleResult.oldPlayerEXPInfo.userLevel, self.params_.battleResult.oldPlayerEXPInfo.remain_exp + var_22_1, "user_level_exp")

	if self.params_.battleResult.oldPlayerEXPInfo.userLevel > 30 and var_22_2 - self.params_.battleResult.oldPlayerEXPInfo.userLevel > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(self.params_.battleResult.oldPlayerEXPInfo.remain_exp), tostring(var_22_1), tostring(self.params_.battleResult.oldPlayerEXPInfo.userLevel), tostring(var_22_2)))
	end

	self.newPlayerExp_ = var_22_1
	self.addExp_.text = string.format("+%d", var_22_1)

	local var_22_4 = math.floor(self.params_.battleResult.oldPlayerEXPInfo.remain_exp / GameLevelSetting[self.params_.battleResult.oldPlayerEXPInfo.userLevel].user_level_exp * 1000) / 1000
	local var_22_5 = math.floor(var_22_3 / GameLevelSetting[var_22_2].user_level_exp * 1000) / 1000

	var_22_4 = var_22_4 > 0.99 and 0.99 or var_22_4
	var_22_5 = var_22_5 > 0.99 and 0.99 or var_22_5

	self:RemoveTween()

	self.userExp_ = var_22_2 + var_22_5

	if var_22_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	local var_22_6 = -1

	self.tween_ = LeanTween.value(self.progress_.gameObject, self.params_.battleResult.oldPlayerEXPInfo.userLevel + var_22_4, var_22_2 + var_22_5, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_23_0)
		local var_23_0 = math.modf(arg_23_0)

		if var_22_6 == -1 then
			var_22_6 = var_23_0
		end

		if var_23_0 ~= var_22_6 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_22_6 = var_23_0
		end

		self:UpdateUserData(arg_23_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self.mask_.blocksRaycasts = false

		self:CheckLevelUp()
		self:RemoveTween()
	end))
end

function BattleScoreResultView:GetPlayerInfo()
	return PlayerData:GetPlayerInfo()
end

function BattleScoreResultView:UpdateUserData(arg_26_1)
	local var_26_0, var_26_1 = math.modf(arg_26_1)

	self.playerLv_.text = string.format("%d", var_26_0)
	self.progress_.value = LvTools.GetIsMaxLv(var_26_0, "user") and 1 or var_26_1
end

function BattleScoreResultView:CheckLevelUp()
	local var_27_0 = self:GetLevelUpInfoList()

	if #var_27_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_27_0
		})
	end
end

function BattleScoreResultView:GetLevelUpInfoList()
	return PlayerData:GetlevelUpInfos()
end

function BattleScoreResultView:RefreshHeroS()
	local var_29_0, var_29_1 = self.stageData:GetHeroTeam()
	local var_29_2 = self.stageData:GetSystemHeroTeam()

	for iter_29_0 = 1, 3 do
		local var_29_3 = self[string.format("hero%s_", iter_29_0)]

		if not var_29_0[iter_29_0] or var_29_0[iter_29_0] == 0 then
			SetActive(var_29_3, false)
		else
			SetActive(var_29_3, true)
			table.insert(self.heroItemView_, BattleMultipleResultHeroItem.New(var_29_3, self.stageData:GetHeroDataByPos(iter_29_0), self.stageData, var_29_2[iter_29_0] or var_29_1[iter_29_0] ~= 0, self.params_.battleResult.heroDataCollect[iter_29_0]))
		end
	end
end

function BattleScoreResultView:RefreshCommonUI()
	SetActive(self.btnBattleCount_.gameObject, not (BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == self.stageType and BattleConst.BATTLE_TAG.STORY == BattleChapterStageCfg[self.stageId].tag))
end

function BattleScoreResultView:RefreshScore()
	self.scoreText_.text = ActivityWorldBossData:GetBossScore((self.stageData:GetActivityID()))
end

function BattleScoreResultView:RefreshBattleTime()
	self.battleTimeText_.text = self:GetBattleTime()

	SetActive(self.battleTimeText_.gameObject, ActivityTools.GetActivityTheme((self.stageData:GetActivityID())) ~= ActivityConst.THEME.FACTORY)
end

function BattleScoreResultView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function BattleScoreResultView:HeroAnimator(arg_34_1, arg_34_2)
	local var_34_0, var_34_1 = math.modf(arg_34_2)

	self.heroLv_[arg_34_1].text = string.format("%d", var_34_0)
	self.heroProgress_[arg_34_1].value = LvTools.GetIsMaxLv(var_34_0, "hero") and 1 or var_34_1
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
		for iter_36_0, iter_36_1 in pairs(self.tweens_) do
			self:RemoveTweenAt(iter_36_0)
		end

		self.tweens_ = nil
	end
end

function BattleScoreResultView:RemoveTweenAt(arg_37_1)
	if self.tweens_[arg_37_1] then
		self.tweens_[arg_37_1]:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tweens_[arg_37_1].id)
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

	for iter_38_0, iter_38_1 in ipairs(self.heroItemView_) do
		iter_38_1:EndAnimator()
	end

	self.mask_.blocksRaycasts = false
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
