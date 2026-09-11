local ChallengeRogueTeamIllustratedEventView = class("ChallengeRogueTeamIllustratedEventView", ReduxView)

function ChallengeRogueTeamIllustratedEventView:UIName()
	return "Widget/System/Activity_Roulike/Illustrated/IllustratedEventUI"
end

function ChallengeRogueTeamIllustratedEventView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamIllustratedEventView:Init()
	self:BindCfgUI()

	self.eventItemList_ = {}
	self.lockController_ = self.controller_:GetController("lock")
	self.rewardController_ = self.btnController_:GetController("rewards")

	self:AddListeners()
end

function ChallengeRogueTeamIllustratedEventView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.templateID_ = self.params_.templateID or ChallengeRogueTeamData:GetCacheTemplateID()
	self.eventList_ = {}
	self.eventList_ = RogueTeamEventCfg.get_id_list_by_event_group[1]
	self.unlockEventList_ = ChallengeRogueTeamData:GetIllustratedDataByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.EVENT)

	manager.redPoint:bindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.EVENT))))
	self:RefreshSelect(self.eventList_[1])
	self:RefreshUI()
end

function ChallengeRogueTeamIllustratedEventView:AddListeners()
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("challengeRogueTeamIllustratedTaskPop", {
			activityIDList = self.rewardTaskList_,
			type = ChallengeRogueTeamConst.COLLECTION_TYPE.EVENT
		})
	end)
end

function ChallengeRogueTeamIllustratedEventView:RefreshUI()
	for iter_7_0, iter_7_1 in ipairs(self.eventItemList_) do
		SetActive(iter_7_1.gameObject_, false)
	end

	for iter_7_2, iter_7_3 in ipairs(self.eventList_) do
		if not self.eventItemList_[iter_7_2] then
			local var_7_0 = ChallengeRogueTeamIllustratedEventItem.New((GameObject.Instantiate(self.itemGo_, self.itemContent_)))

			var_7_0:SetClickCallBack(function(arg_8_0)
				for iter_8_0, iter_8_1 in ipairs(self.eventItemList_) do
					iter_8_1:RefreshSelect(arg_8_0)
				end

				self:RefreshSelect(arg_8_0)
			end)

			self.eventItemList_[iter_7_2] = var_7_0
		end

		self.eventItemList_[iter_7_2]:SetData(iter_7_2, self.eventList_[iter_7_2])
		self.eventItemList_[iter_7_2]:RefreshSelect(self.selectID_)
		self.eventItemList_[iter_7_2]:RefreshUnlock(tostring(not ChallengeRogueTeamData:IsIllustratedObtained(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.EVENT, iter_7_3)))
		SetActive(self.eventItemList_[iter_7_2].gameObject_, true)
	end

	self.rewardTaskList_ = ChallengeRogueTeamData:GetAllCollectionTaskByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.EVENT)

	self.rewardController_:SetSelectedState(tostring(#ChallengeRogueTeamTools.GetCanRewardTask(self.rewardTaskList_) > 0))

	self.progressText_.text = #self.unlockEventList_ .. "/" .. #self.eventList_
end

function ChallengeRogueTeamIllustratedEventView:RefreshSelect(arg_9_1)
	self.selectID_ = arg_9_1
	self.eventImg_.sprite = pureGetSpriteWithoutAtlas(RogueTeamEventCfg[arg_9_1].image)
	self.eventTitleText_.text = RogueTeamEventCfg[arg_9_1].title
	self.descText_.text = RogueTeamEventCfg[arg_9_1].brief_desc

	self.lockController_:SetSelectedState(tostring(not ChallengeRogueTeamData:IsIllustratedObtained(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.EVENT, arg_9_1)))
end

function ChallengeRogueTeamIllustratedEventView:OnExit()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.EVENT))))
	manager.windowBar:HideBar()
end

function ChallengeRogueTeamIllustratedEventView:Dispose()
	if self.eventItemList_ then
		for iter_11_0, iter_11_1 in ipairs(self.eventItemList_) do
			iter_11_1:Dispose()
		end

		self.eventItemList_ = nil
	end

	ChallengeRogueTeamIllustratedEventView.super.Dispose(self)
end

function ChallengeRogueTeamIllustratedEventView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshUI()
end

return ChallengeRogueTeamIllustratedEventView
