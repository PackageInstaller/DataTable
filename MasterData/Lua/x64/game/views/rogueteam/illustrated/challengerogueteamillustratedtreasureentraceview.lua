local ChallengeRogueTeamIllustratedTreasureEntraceView = class("ChallengeRogueTeamIllustratedTreasureEntraceView", ReduxView)

function ChallengeRogueTeamIllustratedTreasureEntraceView:UIName()
	return "Widget/System/Activity_Roulike/Illustrated/IllustratedTreasureEnterUI"
end

function ChallengeRogueTeamIllustratedTreasureEntraceView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamIllustratedTreasureEntraceView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.schoolItemList_ = {}
end

function ChallengeRogueTeamIllustratedTreasureEntraceView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.templateID_ = self.params_.templateID or ChallengeRogueTeamData:GetCacheTemplateID()

	self:RefreshUI()

	for iter_4_0, iter_4_1 in ipairs(self.schoolIDList_) do
		manager.redPoint:bindUIandKey(self.schoolItemList_[iter_4_0].redpointTrs_, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetTreasureCollectionActivityIDByCamp(self.templateID_, iter_4_1))))
	end
end

function ChallengeRogueTeamIllustratedTreasureEntraceView:AddListeners()
	return
end

function ChallengeRogueTeamIllustratedTreasureEntraceView:RefreshUI()
	self.treasureID_, self.schoolIDList_ = ChallengeRogueTeamData:GetAllCampTreasureIDListByTemp(RogueTeamCfg[self.templateID_].item_temp)

	for iter_6_0, iter_6_1 in ipairs(self.schoolItemList_) do
		SetActive(iter_6_1.gameObject_, false)
	end

	for iter_6_2, iter_6_3 in ipairs(self.schoolIDList_) do
		self.schoolItemList_[iter_6_2] = self.schoolItemList_[iter_6_2] or ChallengeRogueTeamIllustratedSchoolItem.New((GameObject.Instantiate(self.schoolItem_, self.schoolContent_)))

		self.schoolItemList_[iter_6_2]:SetData(iter_6_2, iter_6_3, RogueTeamCfg[self.templateID_].item_temp)
		SetActive(self.schoolItemList_[iter_6_2].gameObject_, true)
	end
end

function ChallengeRogueTeamIllustratedTreasureEntraceView:OnExit()
	for iter_7_0, iter_7_1 in ipairs(self.schoolIDList_) do
		manager.redPoint:unbindUIandKey(self.schoolItemList_[iter_7_0].redpointTrs_, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetTreasureCollectionActivityIDByCamp(self.templateID_, iter_7_1))))
	end

	manager.windowBar:HideBar()
end

function ChallengeRogueTeamIllustratedTreasureEntraceView:Dispose()
	ChallengeRogueTeamIllustratedTreasureEntraceView.super.Dispose(self)

	if self.schoolItemList_ then
		for iter_8_0, iter_8_1 in ipairs(self.schoolItemList_) do
			iter_8_1:Dispose()
		end

		self.schoolItemList_ = nil
	end
end

function ChallengeRogueTeamIllustratedTreasureEntraceView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshUI()
end

return ChallengeRogueTeamIllustratedTreasureEntraceView
