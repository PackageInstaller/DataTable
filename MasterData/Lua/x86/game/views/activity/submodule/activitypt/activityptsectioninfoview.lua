SectionBaseView = import("game.views.sectionInfo.SectionInfoMultipleBaseView")

local ActivityPtSectionInfoView = class("ActivityPtSectionInfoView", SectionBaseView)

function ActivityPtSectionInfoView:UIName()
	return "UI/Stage/PTSectionInfoUI"
end

function ActivityPtSectionInfoView:Init()
	ActivityPtSectionInfoView.super.Init(self)
end

function ActivityPtSectionInfoView:InitUI()
	ActivityPtSectionInfoView.super.InitUI(self)

	self.affixGoList_ = {}

	for iter_3_0 = 1, self.affixContentTrans_.childCount do
		self.affixGoList_[iter_3_0] = self.affixContentTrans_:GetChild(iter_3_0 - 1).gameObject
	end
end

function ActivityPtSectionInfoView:UpdateBar()
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
end

function ActivityPtSectionInfoView:RefreshData()
	self.cfg_ = BattleStageTools.GetStageCfg(self.params_.sectionType, self.params_.section)
	self.cost = self.cfg_.cost or 0

	ActivityPtSectionInfoView.super.RefreshData(self)

	self.lock_ = false
	self.lockTips_ = ""
	self.isFirstClear_ = SummerActivityPtData:GetLevelChallengeCount(self.params_.repeat_id) == 0
	self.drop_lib_id = self.cfg_.drop_lib_id
end

function ActivityPtSectionInfoView:RefreshStageInfo()
	self.cfg_ = BattleStageTools.GetStageCfg(self.params_.sectionType, self.params_.section)

	if self.oldCfgID_ ~= self.cfg_.id then
		self.sectionName_.text = GetI18NText(self.cfg_.name)
		self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, self.cfg_.background_1))
		self.textStory_.text = GetI18NText(self.cfg_.tips)
		self.oldCfgID_ = self.cfg_.id
		self.tipsText_.text = GetI18NText(self.cfg_.tips)
		self.titleCanvasGroup_.alpha = 0
		self.multiple_ = 1

		self:RefreshAffix()
	end
end

function ActivityPtSectionInfoView:RefreshAffix()
	if type(self.cfg_.affix_type) ~= "table" then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(self.cfg_.affix_type) do
		self["affixName_" .. iter_7_0].text = GetI18NText(getAffixName(iter_7_1))
		self["affixDesc_" .. iter_7_0].text = GetI18NText(getAffixDesc(iter_7_1))
		self["affixIcon_" .. iter_7_0].sprite = getAffixSprite(iter_7_1)

		if self.affixGoList_[iter_7_0] then
			SetActive(self.affixGoList_[iter_7_0], true)
		end
	end

	for iter_7_2 = #self.cfg_.affix_type + 1, #self.affixGoList_ do
		if self.affixGoList_[iter_7_2] then
			SetActive(self.affixGoList_[iter_7_2], false)
		end
	end
end

function ActivityPtSectionInfoView:OnClickBtn()
	self:Go("/sectionSelectHero", {
		section = self.params_.section,
		sectionType = self.params_.sectionType,
		activityID = self.params_.activityID,
		multiple = self.multiple_
	})
end

function ActivityPtSectionInfoView:OnTop()
	self:UpdateBar()
end

function ActivityPtSectionInfoView:OnBehind()
	manager.windowBar:HideBar()
end

function ActivityPtSectionInfoView:GetUnlockChallengeCnt()
	if SummerActivityPtData:GetLevelChallengeCount(self.params_.repeat_id) > 0 then
		return ActivityPtSectionInfoView.super.GetUnlockChallengeCnt(self)
	end

	return SummerActivityPtData:GetLevelChallengeCount(self.params_.repeat_id)
end

function ActivityPtSectionInfoView:GetChallengeCntMaxTip()
	if SummerActivityPtData:GetLevelChallengeCount(self.params_.repeat_id) > 0 then
		return ActivityPtSectionInfoView.super.GetChallengeCntMaxTip(self)
	end

	return GetTips("ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK")
end

function ActivityPtSectionInfoView:Dispose()
	self.affixGoList_ = nil

	ActivityPtSectionInfoView.super.Dispose(self)
end

return ActivityPtSectionInfoView
