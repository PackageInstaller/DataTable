local ActivityRaceSectionInfoView = class("ActivityRaceSectionInfoView", (import("game.views.sectionInfo.SectionInfoMultipleBaseView")))
local var_0_1 = #GameSetting.challenge_multiple_count_unlock_level.value

function ActivityRaceSectionInfoView:InitUI()
	ActivityRaceSectionInfoView.super.InitUI(self)
end

function ActivityRaceSectionInfoView:OnClickBtn()
	self:Go("/sectionSelectHero", {
		section = self.stageID_,
		multiple = self.multiple_,
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE,
		activityID = self.params_.activityID,
		race = ActivityRaceCfg[self.params_.activityID].race_id
	})
end

function ActivityRaceSectionInfoView:RefreshData()
	self.lock_ = false
	self.cost = BattleActivityRaceStageCfg[self.stageID_].cost
	self.drop_lib_id = BattleActivityRaceStageCfg[self.stageID_].drop_lib_id
	self.isFirstClear_ = ActivityRaceData:GetStateList()[self.params_.activityID].completedStageList[self.stageID_] == nil

	ActivityRaceSectionInfoView.super.RefreshData(self)
end

function ActivityRaceSectionInfoView:RefreshUI()
	ActivityRaceSectionInfoView.super.RefreshUI(self)
	SetActive(self.stageTitleGo_, false)

	if self.stageID_ ~= ActivityRaceCfg[self.params_.activityID].stage_list[#ActivityRaceCfg[self.params_.activityID].stage_list] then
		SetActive(self.rewardPanel_, true)
		SetActive(self.multiplePanel_, true)
	else
		SetActive(self.rewardPanel_, false)
		SetActive(self.multiplePanel_, false)
	end
end

function ActivityRaceSectionInfoView:RefreshRewardPanel(arg_5_1)
	local var_5_0 = getRewardFromDropCfg(arg_5_1, true)

	self.rewardTitleText_.text = self.isFirstClear_ and DropCfg[arg_5_1] and #DropCfg[arg_5_1].base_drop >= 1 and GetTips("FIRST_DROP") or GetTips("MAYBE_DROP")

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if self.rewardItems_[iter_5_0] then
			self.rewardItems_[iter_5_0]:SetData(iter_5_1, true)
		else
			self.rewardGos_[iter_5_0] = self.rewardGos_[iter_5_0] or Object.Instantiate(self.rewardItem_, self.rewardParent_.transform)
			self.rewardItems_[iter_5_0] = RewardPoolItem.New(self.rewardGos_[iter_5_0], iter_5_1, true)
		end

		SetActive(self.rewardGos_[iter_5_0], true)

		if not self.isFirstClear_ or #DropCfg[arg_5_1].base_drop < 1 then
			self.rewardItems_[iter_5_0]:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
			self.rewardItems_[iter_5_0]:HideNum()
		else
			self.rewardItems_[iter_5_0]:ShowFloor(ItemConst.ITEM_FLOOR.LONG)
		end
	end

	for iter_5_2 = #var_5_0 + 1, #self.rewardItems_ do
		SetActive(self.rewardGos_[iter_5_2], false)
	end
end

function ActivityRaceSectionInfoView:RefreshStageInfo()
	if self.oldCfgID_ ~= BattleActivityRaceStageCfg[self.stageID_].id then
		self.sectionName_.text = GetI18NText(BattleActivityRaceStageCfg[self.stageID_].name)
		self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleActivityRaceStageCfg[self.stageID_].background_1))
		self.tipsText_.text = GetI18NText(BattleActivityRaceStageCfg[self.stageID_].tips)

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.tipsTextContentTrans_)

		self.oldCfgID_ = BattleActivityRaceStageCfg[self.stageID_].id
	end
end

function ActivityRaceSectionInfoView:OnExit()
	ActivityRaceSectionInfoView.super.OnExit(self)

	self.multiple_ = 1
end

function ActivityRaceSectionInfoView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function ActivityRaceSectionInfoView:RefreshMultiple()
	self.multipleText_.text = "x" .. self.multiple_

	if self.isFirstClear_ == true then
		self.maxMultipleBtn_.interactable = false
		self.maxMultipleBtnCanvas_.alpha = 0.5
	elseif self.multiple_ >= self.maxMultiple_ or self.multiple_ >= self.challengeCnt_ then
		self.maxMultipleBtn_.interactable = false
		self.maxMultipleBtnCanvas_.alpha = 0.5
		self.minMultipleBtn_.interactable = true
		self.minMultipleCanvas_.alpha = 1
		self.subBtn_.interactable = true
		self.subBtnCanvas_.alpha = 1
	elseif self.multiple_ <= 1 then
		self.maxMultipleBtn_.interactable = true
		self.maxMultipleBtnCanvas_.alpha = 1
		self.minMultipleBtn_.interactable = false
		self.minMultipleCanvas_.alpha = 0.5
		self.subBtn_.interactable = false
		self.subBtnCanvas_.alpha = 0.5
	else
		self.maxMultipleBtn_.interactable = true
		self.maxMultipleBtnCanvas_.alpha = 1
		self.minMultipleBtn_.interactable = true
		self.minMultipleCanvas_.alpha = 1
		self.subBtn_.interactable = true
		self.subBtnCanvas_.alpha = 1
	end

	if self.multiple_ == var_0_1 then
		self.addBtn_.interactable = false
		self.addBtnCanvas_.alpha = 0.5
	else
		self.addBtn_.interactable = true
		self.addBtnCanvas_.alpha = 1
	end

	if self.multiple_ <= 1 then
		self.minMultipleBtn_.interactable = false
		self.minMultipleCanvas_.alpha = 0.5
		self.subBtn_.interactable = false
		self.subBtnCanvas_.alpha = 0.5
	end
end

function ActivityRaceSectionInfoView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		if self.lock_ then
			ShowTips(self.lockTips_)
		elseif ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < self.cost * self.multiple_ then
			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
				JumpTools.OpenPopUp("currencyBuyFatigue", self.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		else
			self:OnClickBtn()
		end
	end)
	self:AddBtnListener(self.minMultipleBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "challenge_multiple")

		self.multiple_ = 1

		self:ChangeMultiple()
	end)
	self:AddBtnListener(self.subBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "single")

		self.multiple_ = self.multiple_ - 1

		self:ChangeMultiple()
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "single")

		if self.isFirstClear_ == true then
			ShowTips("ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK")

			return
		end

		if self.multiple_ >= self.challengeCnt_ then
			ShowTips((self:GetChallengeCntMaxTip()))

			return
		end

		self.multiple_ = self.multiple_ + 1

		self:ChangeMultiple()
	end)
	self:AddBtnListener(self.maxMultipleBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "challenge_multiple")

		if self.challengeCnt_ < self.maxMultiple_ then
			self.multiple_ = self.challengeCnt_
		end

		self:ChangeMultiple()
	end)
end

return ActivityRaceSectionInfoView
