local ChallengeRogueTeamIllustratedTreasureView = class("ChallengeRogueTeamIllustratedTreasureView", ReduxView)

function ChallengeRogueTeamIllustratedTreasureView:UIName()
	return "Widget/System/Activity_Roulike/Illustrated/IllustratedTreasureUI"
end

function ChallengeRogueTeamIllustratedTreasureView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamIllustratedTreasureView:Init()
	self:BindCfgUI()

	self.treasureItemList_ = {}

	self:AddListeners()

	self.rewardController_ = self.taskController_:GetController("rewards")
end

function ChallengeRogueTeamIllustratedTreasureView:AddListeners()
	self:AddBtnListener(self.forwardBtn_, nil, function()
		self:UnBindRedPoint()

		self.index_ = self.index_ - 1

		self:RefreshUI()
		self:BindRedPoint()
	end)
	self:AddBtnListener(self.nextBtn_, nil, function()
		self:UnBindRedPoint()

		self.index_ = self.index_ + 1

		self:RefreshUI()
		self:BindRedPoint()
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("challengeRogueTeamIllustratedTaskPop", {
			activityIDList = ChallengeRogueTeamData:GetTreasureCollectionTaskByCamp(self.templateID_, self.campID_),
			type = ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP,
			campID = self.campID_
		})
	end)
	TerminologyTools.AddTerminologyHandler(self, self.campSkillDescText_, nil, nil)
end

function ChallengeRogueTeamIllustratedTreasureView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetTreasureCollectionActivityIDByCamp(self.templateID_, self.campID_))))
end

function ChallengeRogueTeamIllustratedTreasureView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetTreasureCollectionActivityIDByCamp(self.templateID_, self.campID_))))
end

function ChallengeRogueTeamIllustratedTreasureView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.campID_ = self.params_.id or 1
	self.templateID_ = self.params_.templateID or ChallengeRogueTeamData:GetCacheTemplateID()
	self.itemTempID_ = RogueTeamCfg[self.templateID_].item_temp
	self.treasureID_, self.schoolIDList_ = ChallengeRogueTeamData:GetAllCampTreasureIDListByTemp(self.itemTempID_)
	self.treasureUnlockDataList_ = ChallengeRogueTeamData:GetIllustratedDataByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP)
	self.index_ = table.indexof(self.schoolIDList_, self.campID_)

	self:RefreshUI()
	self:BindRedPoint()
end

function ChallengeRogueTeamIllustratedTreasureView:RefreshUI()
	self.campID_ = self.schoolIDList_[self.index_]
	self.campIcon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.CAMP_BIG_ICON_PATH_LIST, ChallengeRogueTeamData:GetCacheTemplateID())[self.index_])
	self.campTitleText_.text = GetTips("ROGUE_TEAM_SCHOOL_NAME_" .. self.campID_)
	self.campDataList_ = ChallengeRogueTeamData:GetIllustratedDataByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP)
	self.campSkllID_ = ChallengeRogueTeamData:GetCampUltimateByCamp(self.itemTempID_, self.campID_)
	self.treasureIDList_ = ChallengeRogueTeamData:GetAllCampTreasureIDByCamp(self.itemTempID_, self.campID_)
	self.campSkillCfg_ = RogueTeamItemCfg[self.campSkllID_]
	self.campSkillIcon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(self.campSkllID_))
	self.campSkillTitleText_.text = self.campSkillCfg_.name
	self.campSkillDescText_.text = ChallengeRogueTeamTools.GetItemDesc(self.campSkllID_, nil, self.campSkillDescText_.color)
	self.unlockTresureList_ = ChallengeRogueTeamData:GetUnlockIllustratedTreasureDataByCamp(self.templateID_, self.campID_)

	self.rewardController_:SetSelectedState(tostring(#ChallengeRogueTeamTools.GetCanRewardTask((ChallengeRogueTeamData:GetTreasureCollectionTaskByCamp(self.templateID_, self.campID_))) > 0))

	self.taskProgressText_.text = #self.unlockTresureList_ .. "/" .. #self.treasureIDList_

	table.sort(self.treasureIDList_, function(arg_12_0, arg_12_1)
		local var_12_0 = ChallengeRogueTeamData:IsIllustratedObtained(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP, arg_12_0)
		local var_12_1 = ChallengeRogueTeamData:IsIllustratedObtained(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP, arg_12_1)

		if var_12_0 ~= var_12_1 then
			if var_12_0 and not var_12_1 then
				return true
			elseif not var_12_0 and var_12_1 then
				return false
			end
		elseif arg_12_0 ~= arg_12_1 then
			return arg_12_1 < arg_12_0
		else
			return false
		end
	end)

	for iter_11_0, iter_11_1 in ipairs(self.treasureItemList_) do
		SetActive(iter_11_1.gameObject_, false)
	end

	for iter_11_2, iter_11_3 in ipairs(self.treasureIDList_) do
		if not self.treasureItemList_[iter_11_2] then
			table.insert(self.treasureItemList_, (ChallengeRogueTeamIllustratedTreasureItem.New((GameObject.Instantiate(self.treasureItem_, self.treasureContent_)))))
		end

		self.treasureItemList_[iter_11_2]:SetData(iter_11_2, iter_11_3, (ChallengeRogueTeamData:IsIllustratedObtained(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP, iter_11_3)))
		SetActive(self.treasureItemList_[iter_11_2].gameObject_, true)
	end

	SetActive(self.forwardBtn_.gameObject, self.index_ > 1)
	SetActive(self.nextBtn_.gameObject, self.index_ < #self.schoolIDList_)

	self.slidetText_.text = self.index_ .. "/" .. #self.schoolIDList_
end

function ChallengeRogueTeamIllustratedTreasureView:OnExit()
	self:UnBindRedPoint()
	manager.windowBar:HideBar()
end

function ChallengeRogueTeamIllustratedTreasureView:OnTop()
	self:RefreshUI()
end

function ChallengeRogueTeamIllustratedTreasureView:Dispose()
	if self.treasureItemList_ then
		for iter_15_0, iter_15_1 in ipairs(self.treasureItemList_) do
			iter_15_1:Dispose()
		end
	end

	self.treasureItemList_ = nil

	ChallengeRogueTeamIllustratedTreasureView.super.Dispose(self)
end

return ChallengeRogueTeamIllustratedTreasureView
