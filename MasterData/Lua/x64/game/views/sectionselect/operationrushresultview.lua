local OperationRushResultView = class("OperationRushResultView", ReduxView)

function OperationRushResultView:UIName()
	return "Widget/System/BattleResult/Common/BattleResultRushUI"
end

function OperationRushResultView:UIParent()
	return manager.ui.uiPop.transform
end

function OperationRushResultView:Init()
	self.hasSnapshot_ = GetBattleResultSnapShot()

	self:InitUI()

	self.btnController = self.btnController_:GetController("btn")
	self.multiController = self.multiController_:GetController("double")

	self:AddListener()
end

function OperationRushResultView:OnEnter()
	self.stageData = self.params_.stageData
	self.stageId = self.stageData:GetStageId()
	self.stageType = self.stageData:GetType()
	self.isMultiple = self.params_.multiple ~= nil

	BattleInstance.hideBattlePanel()
	self:CaculateReward()
	self:RenderView()
	manager.notify:CallUpdateFunc(ON_MULTIPLE_REWARD_COUNT_CHANGE)

	if self.params_.chapterID and table.indexof(GameSetting.quick_battle_unique_chapter.value, self.params_.chapterID) then
		SetActive(self.nextStageBtn_.gameObject, false)
	else
		SetActive(self.nextStageBtn_.gameObject, true)
	end
end

function OperationRushResultView:OnExit()
	self.params_.callBack = nil
end

function OperationRushResultView:Dispose()
	self.multiView:Dispose()
	self:RemoveExpTween()

	for iter_6_0 = 1, 3 do
		self.heroModule[iter_6_0]:Dispose()
	end

	if self.missionView then
		self.missionView:Dispose()
	end

	self.spriteRef = nil

	OperationRushResultView.super.Dispose(self)
end

function OperationRushResultView:InitUI()
	self:BindCfgUI()

	self.heroModule = {
		BattleSettlementHeroHeadModule.New(self.heroHead1Obj_),
		BattleSettlementHeroHeadModule.New(self.heroHead2Obj_),
		(BattleSettlementHeroHeadModule.New(self.heroHead3Obj_))
	}
end

function OperationRushResultView:AddListener()
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:CloseFunc()
	end)
	self:OnAddListner()
end

function OperationRushResultView:OnAddListner()
	self:AddBtnListener(self.nextStageBtn_, nil, function()
		self:OnceMoreFunc()
	end)
end

function OperationRushResultView:RenderView()
	self:RenderTitleView()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RefreshBottomBtn()
	self:ShowContent()
end

function OperationRushResultView:ShowContent()
	self:onRenderMultiResultContent()
end

function OperationRushResultView:onRenderMultiResultContent()
	self.multiView = self.multiView or BattleSettlementMultiResultModule.New(self.contentContainer_)

	self.multiView:RenderView({
		stageData = self.stageData,
		rewardList = self.params_.rewardList,
		extraReward = self.params_.extraReward,
		rewardTimes = self.params_.multiple
	})
	self.multiController:SetSelectedState("false")

	if self.params_.extraReward then
		for iter_14_0, iter_14_1 in pairs(self.params_.extraReward) do
			if type(iter_14_1) == "table" and #iter_14_1 > 0 then
				local var_14_0, var_14_1, var_14_2 = ActivityMultiRewardData:GetLastBattleMultiData()
				local var_14_3
				local var_14_4
				local var_14_5

				if RegressionDataNew:IsRegressionOpen() then
					var_14_3, var_14_4, var_14_5 = RegressionDataNew:GetMultipleValue()
				end

				if var_14_0 and var_14_0 > 0 and var_14_1 and var_14_1 > 0 then
					self.multiController:SetSelectedState("true")

					self.multiCountText_.text = var_14_0 .. "/" .. var_14_1
					self.multiRatioText_.text = var_14_2 / 100

					break
				end

				if var_14_3 and var_14_3 > 0 then
					self.multiController:SetSelectedState("true")

					self.multiCountText_.text = var_14_3 .. "/" .. var_14_4
					self.multiRatioText_.text = var_14_5 / 100

					break
				end

				self.multiController:SetSelectedState("false")

				break
			end
		end
	end
end

function OperationRushResultView:RenderTitleView()
	local var_15_0, var_15_1 = BattleStageTools.GetChapterSectionIndex(self.stageType, self.stageId)
	local var_15_2 = GetI18NText(BattleStageTools.GetStageName(self.stageType, self.stageId)) or ""
	local var_15_3 = ""

	var_15_3 = var_15_0 ~= "" and "" .. var_15_2 or "" .. var_15_2

	if var_15_3 and var_15_3 ~= "" then
		SetActive(self.titleObj_, true)

		self.titleTxt_.text = var_15_3
	else
		SetActive(self.titleObj_, false)
	end
end

function OperationRushResultView:RefreshHeroS()
	local var_16_0, var_16_1 = self.stageData:GetHeroTeam()
	local var_16_2 = self.stageData:GetSystemHeroTeam()

	if var_16_0[2] == 0 then
		table.remove(var_16_0, 2)
		table.remove(var_16_1, 2)
		table.insert(var_16_0, 0)
		table.insert(var_16_1, 0)
	end

	local var_16_3 = self.params_.battleResult.heroDataCollect

	for iter_16_0 = 1, 3 do
		if not var_16_0[iter_16_0] or var_16_0[iter_16_0] == 0 then
			self.heroModule[iter_16_0]:SetHeroData(nil)
			self.heroModule[iter_16_0]:ShowCaptain(false)
		else
			self.heroModule[iter_16_0]:ShowCaptain(iter_16_0 == 1)

			local var_16_4 = self.stageData:GetHeroDataByPos(iter_16_0)
			local var_16_5 = {
				id = var_16_4.id,
				using_skin = var_16_4.using_skin
			}

			var_16_5.star = var_16_4.star or 0

			self.heroModule[iter_16_0]:SetHeroData(var_16_5)

			if var_16_3[iter_16_0] and self:NeedAddExp() then
				self.heroModule[iter_16_0]:PlayLevelUpTween(var_16_3[iter_16_0].oldLv, var_16_3[iter_16_0].newLv, var_16_3[iter_16_0].oldPersent, var_16_3[iter_16_0].newPersent, 2)
			else
				self.heroModule[iter_16_0]:ShowLevel(var_16_4.level, 1)
			end
		end
	end
end

function OperationRushResultView:RefreshMyExpS()
	local var_17_0 = self.stageData:GetAddUserExp() * self.stageData:GetMultiple()
	local var_17_1 = self.stageData:GetActivityID()
	local var_17_2 = self.params_.battleResult.oldPlayerEXPInfo.userLevel
	local var_17_3 = self.params_.battleResult.oldPlayerEXPInfo.remain_exp
	local var_17_4 = ActivityData:GetActivityData(var_17_1)

	if var_17_1 ~= 0 and (not var_17_4 or not var_17_4:IsActivitying()) or not self:NeedAddExp() then
		var_17_0 = 0
	end

	local var_17_5 = math.min(var_17_0, LvTools.GetMaxTotalExp("user_level_exp") - self.params_.battleResult.oldPlayerEXPInfo.total_exp)

	if var_17_5 < 0 then
		var_17_5 = 0
	end

	local var_17_6, var_17_7 = LvTools.CheckExp(var_17_2, var_17_3 + var_17_5, "user_level_exp")

	if var_17_2 > 30 and var_17_6 - var_17_2 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_17_3), tostring(var_17_5), tostring(var_17_2), tostring(var_17_6)))
	end

	self.expTxt_.text = string.format("EXP+%d", var_17_5)
	self.lvNumTxt_.text = LvTools.GetIsMaxLv(var_17_6, "user") and "--/--" or table.concat({
		var_17_7,
		"/",
		GameLevelSetting[var_17_6].user_level_exp
	})

	local var_17_8 = math.floor(var_17_3 / GameLevelSetting[var_17_2].user_level_exp * 1000) / 1000
	local var_17_9 = math.floor(var_17_7 / GameLevelSetting[var_17_6].user_level_exp * 1000) / 1000

	var_17_8 = var_17_8 > 0.99 and 0.99 or var_17_8
	var_17_9 = var_17_9 > 0.99 and 0.99 or var_17_9

	if var_17_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	if var_17_2 == var_17_6 and math.abs(var_17_8 - var_17_9) < 0.0001 then
		SetActive(self.maskBtn_.gameObject, false)
		self:SetExpWithoutTween(var_17_6, var_17_9)
	else
		self:StartExpTween(var_17_2, var_17_6, var_17_8, var_17_9)
	end
end

function OperationRushResultView:RenderUserData(arg_18_1)
	local var_18_0, var_18_1 = math.modf(arg_18_1)

	self.levelTxt_.text = string.format("%d", var_18_0)
	self.expSlider_.value = LvTools.GetIsMaxLv(var_18_0, "user") and 1 or var_18_1
end

function OperationRushResultView:RefreshBottomBtn()
	return
end

function OperationRushResultView:RemoveExpTween()
	if self.expTween_ then
		self.expTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.gameObject_)

		self.expTween_ = nil
	end
end

function OperationRushResultView:StartExpTween(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	self:RemoveExpTween()
	SetActive(self.maskBtn_.gameObject, true)

	local var_21_0 = -1

	self.tween_ = LeanTween.value(self.expSlider_.gameObject, arg_21_1 + arg_21_3, arg_21_2 + arg_21_4, 1):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
		local var_22_0 = math.modf(arg_22_0)

		if var_21_0 == -1 then
			var_21_0 = var_22_0
		end

		if var_22_0 ~= var_21_0 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_21_0 = var_22_0
		end

		self:RenderUserData(arg_22_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self:CheckLevelUp()
		SetActive(self.maskBtn_.gameObject, false)
		self:RemoveExpTween()
	end))
end

function OperationRushResultView:SetExpWithoutTween(arg_24_1, arg_24_2)
	self:RenderUserData(arg_24_1 + arg_24_2)
end

function OperationRushResultView:GetPlayerInfo()
	return PlayerData:GetPlayerInfo()
end

function OperationRushResultView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function OperationRushResultView:CheckLevelUp()
	local var_27_0 = self:GetLevelUpInfoList()

	if #var_27_0 > 0 then
		PlayerAction.LevelUpFinish()
		self:Go("levelUp", {
			levelUpInfoList = var_27_0
		})
	end
end

function OperationRushResultView:GetLevelUpInfoList()
	return PlayerData:GetlevelUpInfos()
end

function OperationRushResultView:NeedAddExp()
	return true
end

function OperationRushResultView:GetRewardData()
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(self.params_.rewardList) do
		table.insert(var_30_0, iter_30_1)
	end

	return var_30_0
end

function OperationRushResultView:CheckIsMultipleReward()
	if not self.params_.rewardList then
		return false
	end

	if #self.params_.rewardList == 0 then
		return false
	end

	if self.params_.rewardList[1] and self.params_.rewardList[1].id then
		return false
	end

	return true
end

function OperationRushResultView:CaculateReward()
	if self.isMultiple or self:CheckIsMultipleReward() then
		return
	end

	self.rewardHeroExp_ = 0

	local var_32_0 = 0

	if self.params_.rewardList then
		for iter_32_0, iter_32_1 in ipairs(self.params_.rewardList) do
			if ItemCfg[iter_32_1[1]].type == ItemConst.ITEM_TYPE.CURRENCY and iter_32_1[1] == CurrencyConst.CURRENCY_TYPE_HERO_EXP then
				var_32_0 = iter_32_0
			end
		end
	end

	if var_32_0 ~= 0 then
		self.rewardHeroExp_ = self.params_.rewardList[var_32_0][2]

		table.remove(self.params_.rewardList, var_32_0)
	end
end

function OperationRushResultView:OnTop()
	self.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	self.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	self.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()

	if self.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL then
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			ActivityPtRouletteStageCfg[self.stageData:GetDest()].cost[1],
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
	else
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetAsLastSibling()
	SetActive(self.gameObject_, true)

	self.toStat_ = false
end

function OperationRushResultView:OnBehind()
	manager.windowBar:HideBar()

	if self.lastBarList_ then
		manager.windowBar:SwitchBar(self.lastBarList_)
	end

	if self.lastAddBarList_ then
		for iter_34_0, iter_34_1 in ipairs(self.lastAddBarList_) do
			manager.windowBar:SetBarCanAdd(iter_34_1, true)
		end
	end

	if self.lastCanClickBarList_ then
		for iter_34_2, iter_34_3 in ipairs(self.lastCanClickBarList_) do
			manager.windowBar:SetBarCanClick(iter_34_3, true)
		end
	end

	if self.toStat_ then
		SetActive(self.gameObject_, false)
	end
end

function OperationRushResultView:ShowVitalityBox(arg_35_1)
	if needShowVitalityFullBox() then
		showVitalitySendMail(arg_35_1)
	else
		arg_35_1()
	end
end

function OperationRushResultView:ShowEquipBox(arg_36_1)
	if needShowBagFullBox() then
		showEquipSendMail(arg_36_1)
	else
		arg_36_1()
	end
end

function OperationRushResultView:CloseFunc()
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			JumpTools.Back()
		end)
	end)
end

function OperationRushResultView:OnceMoreFunc()
	local var_40_0 = self.stageData:GetType()
	local var_40_1 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	local var_40_2 = CurrencyConst.CURRENCY_TYPE_VITALITY

	if var_40_0 == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL then
		var_40_1 = CurrencyData:GetCurrencyNum(ActivityPtRouletteStageCfg[self.params_.destID].cost[1])
		var_40_2 = ActivityPtRouletteStageCfg[self.params_.destID].cost[1]
	end

	if var_40_1 < self.stageData:GetCost() * self.stageData:GetMultiple() then
		if var_40_2 ~= CurrencyConst.CURRENCY_TYPE_VITALITY then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(var_40_2)))
		elseif CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
			JumpTools.OpenPopUp("currencyBuyFatigue", {}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
		else
			ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
		end
	else
		BattleStageAction.OperationRush(self.params_.chapterID, self.params_.stageID, var_40_0, self.params_.multiple, self.params_.activityID, function()
			JumpTools.Back()
		end)
	end
end

return OperationRushResultView
