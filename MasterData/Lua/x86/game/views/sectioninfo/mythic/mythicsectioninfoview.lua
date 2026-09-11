local MythicSectionInfoView = class("MythicSectionInfoView", import("..SectionInfoBaseView"))

function MythicSectionInfoView:Init()
	MythicSectionInfoView.super.Init(self)
	self.hideStageNumController_:SetSelectedState("true")

	self.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(self.threeStarGo_)
	self.sectionInfoAffixBar_ = SectionInfoAffixBar.New(self.affixGo_)
end

function MythicSectionInfoView:RefreshData()
	self.lock_ = false
	self.lockTips_ = ""
	self.cost_ = 0
	self.dropLibID_ = {}
	self.isFirstClear_ = MythicData:GetIsFirstClear(self.partition_)

	self:RefreshThreeStarData()
end

function MythicSectionInfoView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.partition_ = self.params_.partition
	self.stageID_ = self.params_.stageID

	self:RefreshData()
	self:RefreshUI()

	self.stageType_ = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC

	self:RefreshTitleDesc()
end

function MythicSectionInfoView:OnExit()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RemoveListener(CURRENCY_UPDATE, self.currencyUpdateHandle_)
	SetActive(self.debuffAffixBtn_.gameObject, true)
end

function MythicSectionInfoView:OnUpdate()
	if self.partition_ == self.params_.partition and self.stageID_ == self.params_.stageID then
		return
	end

	self.partition_ = self.params_.partition
	self.stageID_ = self.params_.stageID

	self:RefreshData()
	self:RefreshUI()
end

function MythicSectionInfoView:RefreshThreeStarData()
	self.threeStarDataList_ = {}

	local var_6_0 = BattleMythicStageCfg[self.stageID_]
	local var_6_1 = MythicData:GetStarOpen(self.stageID_)

	for iter_6_0 = 1, 3 do
		self.threeStarDataList_[iter_6_0] = {
			var_6_1 and var_6_1.stars[iter_6_0] == 1 or false,
			var_6_0.three_star_need[iter_6_0]
		}
	end
end

function MythicSectionInfoView:RefreshUI()
	self:RefreshStageInfo()
	self.hideFatigueController_:SetSelectedState("close")
	self.hideBattleAffixController_:SetSelectedState("true")
	self.hideAffixController_:SetSelectedState("false")

	if self.params_.isMain then
		self.hideStageDescController_:SetSelectedState("true")
		self.sectionInfoAffixBar_:SetData(self.params_.isMain, self.params_.affix, GetTips("MYTHIC_CUR_AFFIX"))
		self.hideThreeStarController_:SetSelectedState("false")
		self.sectionInfoThreeStarBar_:SetData(self.threeStarDataList_)
	else
		self.hideStageDescController_:SetSelectedState("false")
		self.sectionInfoAffixBar_:SetData(self.params_.isMain, self.params_.affix, GetTips("MYTHIC_LEVEL_UNLOCK_AFFIX"))
		self.hideThreeStarController_:SetSelectedState("true")
	end
end

function MythicSectionInfoView:RefreshStageInfo()
	self.sectionName_.text = GetI18NText(BattleMythicStageCfg[self.stageID_].name)
	self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleMythicStageCfg[self.stageID_].background_1))
	self.storyText_.text = GetI18NText(BattleMythicStageCfg[self.stageID_].tips)
end

function MythicSectionInfoView:OnClickBtn()
	self:Go("/sectionSelectHero", {
		section = self.stageID_,
		partition = self.partition_,
		difficulty = self.params_.difficulty,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC
	})
end

function MythicSectionInfoView:Dispose()
	self.sectionInfoThreeStarBar_:Dispose()

	self.sectionInfoThreeStarBar_ = nil

	self.sectionInfoAffixBar_:Dispose()

	self.sectionInfoAffixBar_ = nil

	MythicSectionInfoView.super.Dispose(self)
end

return MythicSectionInfoView
