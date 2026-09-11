local SectionInfoBaseView = class("SectionInfoBaseView", ReduxView)

function SectionInfoBaseView:UIName()
	return "UI/Stage/ChapterSectionInfoUI"
end

function SectionInfoBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function SectionInfoBaseView:Init()
	self.rewardItems_ = {}
	self.rewardGos_ = {}

	self:InitUI()
	self:AddListeners()

	self.multiple_ = 1
end

function SectionInfoBaseView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.chapterID_ = self.params_.chapterID

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)

	self.stageID_ = self.params_.section
	self.stageType_ = self.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	self:RefreshData()
	self:RefreshUI()
end

function SectionInfoBaseView:OnUpdate()
	if self.stageID_ == self.params_.section then
		return
	end

	self.stageID_ = self.params_.section

	self:RefreshData()
	self:RefreshUI()
end

function SectionInfoBaseView:OnExit()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	for iter_6_0, iter_6_1 in pairs(self.rewardItems_) do
		iter_6_1:Dispose()
	end

	self.rewardItems_ = {}
end

function SectionInfoBaseView:InitUI()
	self:BindCfgUI()

	self.sectionImage_.immediate = true

	SetActive(self.multiplePanel_, false)
	SetActive(self.tipsPanel_, false)
	SetActive(self.targetPanel_, false)
	SetActive(self.targetPanel_, true)

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")

	self.controller_:SetSelectedState("skadi")

	if self.readyTxt_ then
		self.readyTxt_.text = GetTips("BATTLE_READY_1")
	end

	self.sectionTargets_ = {}

	for iter_7_0 = 1, 3 do
		self.sectionTargets_[iter_7_0] = SectionTargetItem.New(self[string.format("targetItem%s_", iter_7_0)], iter_7_0)
	end
end

function SectionInfoBaseView:AddListeners()
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
			BattleController.GetInstance():LaunchBattle((BattleSkadiLittleGameTemplate.New(self.chapterID_, self.activityID_)))
		end
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function SectionInfoBaseView:RemoveListeners()
	self.battleBtn_.onClick:RemoveAllListeners()
end

function SectionInfoBaseView:RefreshData()
	self.lock_ = false
	self.lockTips_ = ""
	self.cost = 0
	self.isFirstClear_ = false
	self.drop_lib_id = 0

	local var_12_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	self.lock_ = false
	self.lockTips_ = ""
	self.cost = var_12_0.cost or 0
	self.drop_lib_id = var_12_0.drop_lib_id
	self.isFirstClear_ = false
end

function SectionInfoBaseView:RefreshUI()
	self:RefreshStageInfo()
	self:RefreshReward()
	self:RefreshCost()
	SetActive(self.unlockGo_, self.lock_)
	SetActive(self.battleBtnGo_, not self.lock_)

	self.lockText_.text = GetI18NText(self.lockTips_)
	self.rewardView_.horizontalNormalizedPosition = 0

	for iter_13_0, iter_13_1 in pairs(self.sectionTargets_) do
		local var_13_0, var_13_1 = self:GetThreeStar(iter_13_0)

		iter_13_1:Refresh(var_13_0, var_13_1)
	end
end

function SectionInfoBaseView:RefreshStageInfo()
	local var_14_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	if self.oldCfgID_ ~= var_14_0.id then
		self.sectionName_.text = GetI18NText(var_14_0.name)
		self.sectionImage_.spriteSync = string.format("%s%s", SpritePathCfg.Stage.path, var_14_0.background_1)
		self.textStory_.text = GetI18NText(var_14_0.tips)
		self.oldCfgID_ = var_14_0.id
	end
end

function SectionInfoBaseView:RefreshReward()
	self:RefreshRewardPanel(self.drop_lib_id)
end

function SectionInfoBaseView:RefreshRewardPanel(arg_16_1)
	local var_16_0 = getRewardFromDropCfg(arg_16_1, self.isFirstClear_)

	self.rewardTitleText_.text = self.isFirstClear_ and DropCfg[arg_16_1] and #DropCfg[arg_16_1].base_drop >= 1 and GetTips("FIRST_DROP") or GetTips("MAYBE_DROP")

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		if self.rewardItems_[iter_16_0] then
			self.rewardItems_[iter_16_0]:SetData(iter_16_1, true)
		else
			self.rewardGos_[iter_16_0] = self.rewardGos_[iter_16_0] or Object.Instantiate(self.rewardItem_, self.rewardParent_.transform)
			self.rewardItems_[iter_16_0] = RewardPoolItem.New(self.rewardGos_[iter_16_0], iter_16_1, true)
		end

		SetActive(self.rewardGos_[iter_16_0], true)

		if not self.isFirstClear_ or #DropCfg[arg_16_1].base_drop < 1 then
			self.rewardItems_[iter_16_0]:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
			self.rewardItems_[iter_16_0]:HideNum()
		else
			self.rewardItems_[iter_16_0]:ShowFloor(ItemConst.ITEM_FLOOR.LONG)
		end
	end

	for iter_16_2 = #var_16_0 + 1, #self.rewardItems_ do
		SetActive(self.rewardGos_[iter_16_2], false)
	end
end

function SectionInfoBaseView:GetThreeStar(arg_17_1)
	return table.indexof(SummerLittleGameData:GetSkadiStars(self.chapterID_), arg_17_1), BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).three_star_need[arg_17_1]
end

function SectionInfoBaseView:Dispose()
	for iter_18_0, iter_18_1 in pairs(self.sectionTargets_) do
		iter_18_1:Dispose()
	end

	self.sectionTargets_ = {}

	self:RemoveListeners()

	for iter_18_2, iter_18_3 in pairs(self.rewardGos_) do
		Object.Destroy(iter_18_3)
	end

	self.rewardGos_ = nil

	for iter_18_4, iter_18_5 in pairs(self.rewardItems_) do
		iter_18_5:Dispose()
	end

	self.rewardItems_ = nil

	SectionInfoBaseView.super.Dispose(self)
end

return SectionInfoBaseView
