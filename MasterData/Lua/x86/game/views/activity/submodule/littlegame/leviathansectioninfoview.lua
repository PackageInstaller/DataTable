local LeviathanSectionInfoView = class("LeviathanSectionInfoView", ReduxView)

function LeviathanSectionInfoView:UIName()
	return "UI/Stage/ChapterSectionInfoUI"
end

function LeviathanSectionInfoView:RefreshData()
	self.lock_ = false
	self.lockTips_ = ""
	self.cost = 0
	self.isFirstClear_ = false
	self.drop_lib_id = 0
end

function LeviathanSectionInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function LeviathanSectionInfoView:Init()
	self:InitUI()
	self:AddListeners()

	self.multiple_ = 1
end

function LeviathanSectionInfoView:OnEnter()
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

	self.activityID_ = self.params_.activityID
	self.chapterID_ = self.params_.chapterID
	self.stageID_ = self.params_.section
	self.stageType_ = self.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	self:RefreshData()
	self:RefreshUI()
end

function LeviathanSectionInfoView:OnUpdate()
	if self.stageID_ == self.params_.section then
		return
	end

	self.stageID_ = self.params_.section

	self:RefreshData()
	self:RefreshUI()
end

function LeviathanSectionInfoView:OnExit()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function LeviathanSectionInfoView:InitUI()
	self:BindCfgUI()

	self.sectionImage_.immediate = true

	SetActive(self.multiplePanel_, false)
	SetActive(self.tipsPanel_, false)
	SetActive(self.targetPanel_, false)

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")

	self.controller_:SetSelectedState("leviathan")

	if self.readyTxt_ then
		self.readyTxt_.text = GetTips("BATTLE_READY_1")
	end
end

function LeviathanSectionInfoView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		BattleController.GetInstance():LaunchBattle((BattleLeviathanLittleGameTemplate.New(self.chapterID_, self.activityID_)))
	end)
end

function LeviathanSectionInfoView:RemoveListeners()
	self.battleBtn_.onClick:RemoveAllListeners()
end

function LeviathanSectionInfoView:RefreshUI()
	self:RefreshStageInfo()
	self:RefreshCost()
	SetActive(self.unlockGo_, self.lock_)
	SetActive(self.battleBtnGo_, not self.lock_)

	self.lockText_.text = GetI18NText(self.lockTips_)
	self.rewardView_.horizontalNormalizedPosition = 0
end

function LeviathanSectionInfoView:RefreshStageInfo()
	local var_13_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	if self.oldCfgID_ ~= var_13_0.id then
		self.sectionName_.text = GetI18NText(var_13_0.name)
		self.sectionImage_.spriteSync = string.format("%s%s", SpritePathCfg.Stage.path, var_13_0.background_1)
		self.textStory_.text = GetI18NText(var_13_0.tips)
		self.oldCfgID_ = var_13_0.id
	end
end

function LeviathanSectionInfoView:Dispose()
	self:RemoveListeners()
	LeviathanSectionInfoView.super.Dispose(self)
end

return LeviathanSectionInfoView
