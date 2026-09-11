local ChallengeRogueTeamIllustratedEndingEntraceView = class("ChallengeRogueTeamIllustratedEndingEntraceView", ReduxView)

function ChallengeRogueTeamIllustratedEndingEntraceView:UIName()
	return "Widget/System/Activity_Roulike/Illustrated/illustratedendingUI"
end

function ChallengeRogueTeamIllustratedEndingEntraceView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamIllustratedEndingEntraceView:Init()
	self:BindCfgUI()

	self.endingItemList_ = {}
end

function ChallengeRogueTeamIllustratedEndingEntraceView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.templateID_ = self.params_.templateID or ChallengeRogueTeamData:GetCacheTemplateID()
	self.endingList_ = RogueTeamEndingCfg.get_id_list_by_temp_id_ending_state[RogueTeamCfg[self.templateID_].item_temp][1]

	self:RefreshUI()
	self:BindRedPoint()
end

function ChallengeRogueTeamIllustratedEndingEntraceView:RefreshUI()
	for iter_5_0, iter_5_1 in ipairs(self.endingItemList_) do
		SetActive(iter_5_1.gameObject_, false)
	end

	for iter_5_2, iter_5_3 in ipairs(self.endingList_) do
		self.endingItemList_[iter_5_2] = self.endingItemList_[iter_5_2] or ChallengeRogueTeamEndingItem.New((GameObject.Instantiate(self.endingItemGo_, self.endingContent_)))

		self.endingItemList_[iter_5_2]:SetData(iter_5_2, self.endingList_[iter_5_2])
		SetActive(self.endingItemList_[iter_5_2].gameObject_, true)
	end
end

function ChallengeRogueTeamIllustratedEndingEntraceView:BindRedPoint()
	self.taskList_ = ChallengeRogueTeamData:GetAllCollectionTaskByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.END)

	for iter_6_0, iter_6_1 in ipairs(self.endingList_) do
		manager.redPoint:bindUIandKey(self.endingItemList_[iter_6_0].transform_, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.taskList_[iter_6_0])))
	end
end

function ChallengeRogueTeamIllustratedEndingEntraceView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ChallengeRogueTeamIllustratedEndingEntraceView:OnExit()
	for iter_8_0, iter_8_1 in ipairs(self.endingList_) do
		manager.redPoint:unbindUIandKey(self.endingItemList_[iter_8_0].transform_, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.taskList_[iter_8_0])))
	end

	manager.windowBar:HideBar()
end

function ChallengeRogueTeamIllustratedEndingEntraceView:Dispose()
	ChallengeRogueTeamIllustratedEndingEntraceView.super.Dispose(self)

	if self.endingItemList_ then
		for iter_9_0, iter_9_1 in ipairs(self.endingItemList_) do
			iter_9_1:Dispose()
		end

		self.endingItemList_ = nil
	end
end

function ChallengeRogueTeamIllustratedEndingEntraceView:OnTop()
	self:RefreshUI()
end

return ChallengeRogueTeamIllustratedEndingEntraceView
