local SurviveSoloSectionInfoView = class("SurviveSoloSectionInfoView", SectionInfoBaseView)

function SurviveSoloSectionInfoView:InitUI()
	self.super.InitUI(self)

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")

	self.controller_:SetSelectedState("surviveSolo")

	if self.readyTxt_ then
		self.readyTxt_.text = GetTips("BATTLE_READY_2")
	end
end

function SurviveSoloSectionInfoView:UpdateBar()
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
	manager.windowBar:RegistBackCallBack(function()
		if self.params_.backFunc then
			self.params_.backFunc()
		end

		self:Back()
	end)
end

function SurviveSoloSectionInfoView:RefreshData()
	self.cfg_ = BattleStageTools.GetStageCfg(self.params_.sectionType, self.params_.section)
	self.cost_ = self.cfg_.cost or 0

	SurviveSoloSectionInfoView.super.RefreshData(self)

	self.isFirstClear_ = false
	self.drop_lib_id = 0
	self.lockTips_ = ""
end

function SurviveSoloSectionInfoView:RefreshStageInfo()
	self.cfg_ = BattleStageTools.GetStageCfg(self.params_.sectionType, self.params_.section)

	if self.oldCfgID_ ~= self.cfg_.id then
		self.sectionName_.text = GetI18NText(self.cfg_.name)
		self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, self.cfg_.background_1))
		self.textStory_.text = GetI18NText(self.cfg_.tips)
		self.oldCfgID_ = self.cfg_.id
		self.tipsText_.text = GetI18NText(self.cfg_.tips)
		self.titleCanvasGroup_.alpha = 0
	end
end

function SurviveSoloSectionInfoView:OnClickBtn()
	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = {}

	if ActivitySoloSlayerCfg[self.params_.activityID].limit_type[1] == 1 then
		table.insert(var_6_0, ActivitySoloSlayerCfg[self.params_.activityID].limit_type[2])
	elseif ActivitySoloSlayerCfg[self.params_.activityID].limit_type[1] == 2 then
		table.insert(var_6_1, ActivitySoloSlayerCfg[self.params_.activityID].limit_type[2])
	elseif ActivitySoloSlayerCfg[self.params_.activityID].limit_type[1] == 3 then
		table.insert(var_6_2, ActivitySoloSlayerCfg[self.params_.activityID].limit_type[2])
	end

	HeroData:SaveSortValue(false, 0, var_6_2, var_6_1, var_6_0)
	self:Go("/sectionSelectHero", {
		isSorted = true,
		isHideEffect = true,
		section = self.params_.section,
		sectionType = self.params_.sectionType,
		activityID = self.params_.activityID
	})
end

function SurviveSoloSectionInfoView:OnTop()
	self:UpdateBar()
end

function SurviveSoloSectionInfoView:Dispose()
	SurviveSoloSectionInfoView.super.Dispose(self)
end

return SurviveSoloSectionInfoView
