local BattleMultipleResultView = class("BattleMultipleResultView", ReduxView)

function BattleMultipleResultView:UIName()
	return "UI/BattleResult/MultipletUI"
end

function BattleMultipleResultView:UIParent()
	return manager.ui.uiMain.transform
end

function BattleMultipleResultView:OnCtor()
	self.tweens_ = {}
end

function BattleMultipleResultView:Init()
	self:InitUI()
	self:AddListener()

	self.heroItemView_ = {}
	self.rewardList_ = LuaList.New(handler(self, self.RewardRenderer), self.uiList_, BattleMultipleResultReward)
end

function BattleMultipleResultView:OnEnter()
	self.stageData = self.params_.stageData
	self.stageId = self.stageData:GetStageId()
	self.stageType = self.stageData:GetType()

	BattleInstance.hideBattlePanel()
	self:RefreshUI()
	self.rewardList_:StartScroll(#self.params_.rewardList, 1)

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

function BattleMultipleResultView:SetBtnOnceMore()
	if self.stageType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT then
		SetActive(self.btnOnceMore_.gameObject, false)
	else
		SetActive(self.btnOnceMore_.gameObject, self:NeedOnceMore())
	end
end

function BattleMultipleResultView:NeedOnceMore()
	if self.params_.notOnceMore then
		return false
	end

	return true
end

function BattleMultipleResultView:OnTop()
	SetActive(self.gameObject_, true)

	self.toStat_ = false
end

function BattleMultipleResultView:OnBehind()
	if self.toStat_ then
		SetActive(self.gameObject_, false)
	end
end

function BattleMultipleResultView:OnExit()
	return
end

function BattleMultipleResultView:Dispose()
	if self.rewardList_ then
		self.rewardList_:Dispose()

		self.rewardList_ = nil
	end

	for iter_12_0, iter_12_1 in ipairs(self.heroItemView_) do
		iter_12_1:Dispose()
	end

	self.heroItemView_ = nil

	self:RemoveTween()
	self:RemoveTweens()

	self.rewardItemGos_ = nil
	self.heroLv_ = nil
	self.heroGo_ = nil
	self.heroImg_ = nil
	self.missionGo_ = nil
	self.missionAchieve_ = nil
	self.heroAddExp = nil
	self.missionNoAchieve_ = nil
	self.heroProgress_ = nil
	self.missionText_ = nil
	self.rewardList_ = nil
	self.addExp_ = nil
	self.stareText_ = nil
	self.lvText_ = nil
	self.bg_screen_ = nil
	self.rewardListTrs_ = nil
	self.mask_ = nil
	self.playerLv_ = nil
	self.btnBack_ = nil
	self.btnBattleCount_ = nil
	self.missionTipGo_ = nil
	self.progress_ = nil

	BattleMultipleResultView.super.Dispose(self)
end

function BattleMultipleResultView:InitUI()
	self:BindCfgUI()
	LeanTween.alphaCanvas(self.mask_, 0, 0.1)
end

function BattleMultipleResultView:GetRewardData()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self.params_.rewardList) do
		for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
			table.insert(var_14_0, iter_14_3)
		end
	end

	return var_14_0
end

function BattleMultipleResultView:ShowVitalityBox(arg_15_1)
	if needShowVitalityFullBox(self:GetRewardData()) then
		showVitalitySendMail(arg_15_1)
	else
		arg_15_1()
	end
end

function BattleMultipleResultView:ShowEquipBox(arg_16_1)
	if needShowBagFullBox(self:GetRewardData()) then
		showEquipSendMail(arg_16_1)
	else
		arg_16_1()
	end
end

function BattleMultipleResultView:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			BattleInstance.QuitBattle(self.stageData)
		end)
	end)
end

function BattleMultipleResultView:AddListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.btnClose_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.buttonMask_, nil, function()
		self:EndAnimator()
	end)
	self:AddBtnListener(self.btnOnceMore_, nil, function()
		local var_24_2 = self.stageData:GetCost()
		local var_24_3 = self.stageData:GetMultiple()
		local var_24_4 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		local var_24_5 = CurrencyConst.CURRENCY_TYPE_VITALITY

		if self.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE then
			local var_24_6 = ActivityPt2Cfg[self.stageData:GetDest()]

			var_24_2 = var_24_6.cost[1][2]
			var_24_5 = var_24_6.cost[1][1]
			var_24_4 = ItemTools.getItemNum(var_24_6.cost[1][1])
		elseif self.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL then
			local var_24_7 = ActivityPtRouletteStageCfg[self.stageData:GetDest()]

			var_24_2 = var_24_7.cost[2]
			var_24_5 = var_24_7.cost[1]
			var_24_4 = ItemTools.getItemNum(var_24_7.cost[1])
		end

		if var_24_4 < var_24_2 * var_24_3 then
			if var_24_5 ~= CurrencyConst.CURRENCY_TYPE_VITALITY then
				ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(var_24_5)))
			elseif CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
				JumpTools.OpenPopUp("currencyBuyFatigue", {}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		else
			BattleInstance.OnceMoreBattle(self.stageData)
		end
	end)
	self:AddBtnListener(self.btnBattleCount_, nil, function()
		self.toStat_ = true

		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = self.stageData,
			battleTime = self:GetBattleTime()
		})
	end)
end

function BattleMultipleResultView:RemoveListener()
	self.btnBack_.onClick:RemoveAllListeners()
	self.btnClose_.onClick:RemoveAllListeners()
	self.btnOnceMore_.onClick:RemoveAllListeners()
	self.btnBattleCount_.onClick:RemoveAllListeners()
end

function BattleMultipleResultView:RefreshUI()
	self:SetLevelTitle()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RefreshCommonUI()
	self:SetBtnOnceMore()
	self:RefreshBattleTime()
end

function BattleMultipleResultView:SetLevelTitle()
	local var_28_0, var_28_1 = BattleStageTools.GetChapterSectionIndex(self.stageType, self.stageId)

	self.stareText_.text = var_28_0 ~= "" and string.format("%s-%s", GetI18NText(var_28_0), GetI18NText(var_28_1)) or ""
	self.lvText_.text = BattleStageTools.GetStageName(self.stageType, self.stageId)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.titleTransform_)
end

function BattleMultipleResultView:RefreshHeroS()
	local var_29_0, var_29_1 = self.stageData:GetHeroTeam()
	local var_29_2 = self.stageData:GetSystemHeroTeam()

	for iter_29_0 = 1, 3 do
		local var_29_3 = self[string.format("hero%s_", iter_29_0)]

		if not var_29_0[iter_29_0] or var_29_0[iter_29_0] == 0 then
			SetActive(var_29_3, false)
		else
			SetActive(var_29_3, true)
			table.insert(self.heroItemView_, BattleMultipleResultHeroItem.New(var_29_3, self.stageData:GetHeroDataByPos(iter_29_0), self.stageData, var_29_2[iter_29_0] or var_29_1[iter_29_0] ~= 0))
		end
	end
end

function BattleMultipleResultView:CheckLevelUp()
	local var_30_0 = self:GetLevelUpInfoList()

	if #var_30_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_30_0
		})
	end
end

function BattleMultipleResultView:RefreshMyExpS()
	local var_31_0 = self.stageData:GetAddUserExp() * self.stageData:GetMultiple()
	local var_31_1 = math.min(var_31_0, LvTools.GetMaxTotalExp("user_level_exp") - self.params_.battleResult.oldPlayerEXPInfo.total_exp)

	if var_31_1 < 0 then
		var_31_1 = 0
	end

	local var_31_2, var_31_3 = LvTools.CheckExp(self.params_.battleResult.oldPlayerEXPInfo.userLevel, self.params_.battleResult.oldPlayerEXPInfo.remain_exp + var_31_1, "user_level_exp")

	if self.params_.battleResult.oldPlayerEXPInfo.userLevel > 30 and var_31_2 - self.params_.battleResult.oldPlayerEXPInfo.userLevel > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(self.params_.battleResult.oldPlayerEXPInfo.remain_exp), tostring(var_31_1), tostring(self.params_.battleResult.oldPlayerEXPInfo.userLevel), tostring(var_31_2)))
	end

	self.newPlayerExp_ = var_31_1
	self.addExp_.text = string.format("+%d", var_31_1)

	local var_31_4 = math.floor(self.params_.battleResult.oldPlayerEXPInfo.remain_exp / GameLevelSetting[self.params_.battleResult.oldPlayerEXPInfo.userLevel].user_level_exp * 1000) / 1000
	local var_31_5 = math.floor(var_31_3 / GameLevelSetting[var_31_2].user_level_exp * 1000) / 1000

	var_31_4 = var_31_4 > 0.99 and 0.99 or var_31_4
	var_31_5 = var_31_5 > 0.99 and 0.99 or var_31_5

	self:RemoveTween()

	self.userExp_ = var_31_2 + var_31_5

	if var_31_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	local var_31_6 = -1

	self.tween_ = LeanTween.value(self.progress_.gameObject, self.params_.battleResult.oldPlayerEXPInfo.userLevel + var_31_4, var_31_2 + var_31_5, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
		local var_32_0 = math.modf(arg_32_0)

		if var_31_6 == -1 then
			var_31_6 = var_32_0
		end

		if var_32_0 ~= var_31_6 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_31_6 = var_32_0
		end

		self:UpdateUserData(arg_32_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self.mask_.blocksRaycasts = false

		self:CheckLevelUp()
		self:RemoveTween()
	end))
end

function BattleMultipleResultView:UpdateUserData(arg_34_1)
	local var_34_0, var_34_1 = math.modf(arg_34_1)

	self.playerLv_.text = string.format("%d", var_34_0)
	self.progress_.value = LvTools.GetIsMaxLv(var_34_0, "user") and 1 or var_34_1
end

function BattleMultipleResultView:HeroAnimator(arg_35_1, arg_35_2)
	local var_35_0, var_35_1 = math.modf(arg_35_2)

	self.heroLv_[arg_35_1].text = string.format("%d", var_35_0)
	self.heroProgress_[arg_35_1].value = LvTools.GetIsMaxLv(var_35_0, "hero") and 1 or var_35_1
end

function BattleMultipleResultView:EndAnimator()
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

function BattleMultipleResultView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function BattleMultipleResultView:RemoveTweenAt(arg_38_1)
	if self.tweens_[arg_38_1] then
		self.tweens_[arg_38_1]:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tweens_[arg_38_1].id)
	end
end

function BattleMultipleResultView:RemoveTweens()
	if self.tweens_ then
		for iter_39_0, iter_39_1 in pairs(self.tweens_) do
			self:RemoveTweenAt(iter_39_0)
		end

		self.tweens_ = nil
	end
end

function BattleMultipleResultView:RefreshCommonUI()
	SetActive(self.btnBattleCount_.gameObject, not (BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == self.stageType and BattleConst.BATTLE_TAG.STORY == BattleChapterStageCfg[self.stageId].tag))

	local var_40_1 = self:NeedOnceMore() or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == self.stageType

	SetActive(self.onceMoreGo_, var_40_1)
	SetActive(self.closeBtnGo_, var_40_1)
	SetActive(self.closePanel_, not var_40_1)
end

function BattleMultipleResultView:RefreshBattleTime()
	self.battleTimeText_.text = self:GetBattleTime()
end

function BattleMultipleResultView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function BattleMultipleResultView:RewardRenderer(arg_43_1, arg_43_2)
	arg_43_2:SetRewardList(arg_43_1, clone(self.params_.rewardList[arg_43_1]))
end

function BattleMultipleResultView:GetLevelUpInfoList()
	return PlayerData:GetlevelUpInfos()
end

return BattleMultipleResultView
