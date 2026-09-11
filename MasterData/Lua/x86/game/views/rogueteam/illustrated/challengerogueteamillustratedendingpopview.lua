local ChallengeRogueTeamIllustratedEndingPopView = class("ChallengeRogueTeamIllustratedEndingPopView", ReduxView)

function ChallengeRogueTeamIllustratedEndingPopView:UIName()
	return "Widget/System/Activity_Roulike/Illustrated/illustratedendingPopUI"
end

function ChallengeRogueTeamIllustratedEndingPopView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamIllustratedEndingPopView:Init()
	self:BindCfgUI()
	self:AddListener()

	self.lockController_ = self.controller_:GetController("lock")
	self.btnList_ = {}
	self.btnController_ = self.taskBtnController_:GetController("rewards")
end

function ChallengeRogueTeamIllustratedEndingPopView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.templateID_ = self.params_.templateID or ChallengeRogueTeamData:GetCacheTemplateID()
	self.index_ = self.params_.index
	self.id_ = self.params_.id

	self:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		self:RefreshTask()
	end)
	self:RefreshUI()
	self:RefreshPlot(1)

	for iter_4_0, iter_4_1 in ipairs(self.btnList_) do
		iter_4_1:RefreshSelect(1)
	end
end

function ChallengeRogueTeamIllustratedEndingPopView:AddListener()
	self:AddBtnListener(self.btn_, nil, function()
		if not ChallengeRogueTeamData:IsIllustratedObtained(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.END, self.id_) then
			ShowTips("ERROR_NO_UNLOCK_PLOT")

			return
		end

		manager.story:StartStoryById(self.cfg_.story_id, function()
			return
		end)
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		if TaskData2:GetTaskProgress(self.taskID_) >= self.taskCfg_.need and not TaskData2:GetTaskComplete(self.taskID_) then
			TaskAction:SubmitTask(self.taskID_)
		end
	end)
	self:AddBtnListener(self.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamPortraitFull", {
			image = self.cfg_.full_image
		})
	end)
end

function ChallengeRogueTeamIllustratedEndingPopView:RefreshUI()
	self.cfg_ = RogueTeamEndingCfg[self.id_]
	self.plotList_ = self.cfg_.text_id_list

	for iter_11_0, iter_11_1 in ipairs(self.btnList_) do
		SetActive(iter_11_1.gameObject_, false)
	end

	for iter_11_2, iter_11_3 in ipairs(self.plotList_) do
		self.btnList_[iter_11_2] = self.btnList_[iter_11_2] or ChallengeRogueTeamEndingBtnItem.New((GameObject.Instantiate(self.paragrapGo_, self.paragrapContent_)))

		local var_11_0 = ChallengeRogueTeamData:GetHistoryEndingPassCnt(self.templateID_, self.id_)

		self.btnList_[iter_11_2]:SetData(iter_11_2, self.plotList_[iter_11_2])
		self.btnList_[iter_11_2].lockController_:SetSelectedState(tostring(iter_11_2 <= var_11_0))
		self.btnList_[iter_11_2]:SetClickCallBack(function(arg_12_0)
			for iter_12_0, iter_12_1 in ipairs(self.btnList_) do
				iter_12_1:RefreshSelect(arg_12_0)
			end

			self:RefreshPlot(arg_12_0)
			self.btnList_[arg_12_0].lockController_:SetSelectedState(tostring(ChallengeRogueTeamData:GetHistoryEndingPassCnt(self.templateID_, self.id_) >= self.selelctPlotIndex_))
		end)
		SetActive(self.btnList_[iter_11_2].gameObject_, true)
	end

	if self.index_ >= 10 then
		self.numText_.text = self.index_ or "0" .. self.index_
	end

	self.image_.sprite = pureGetSpriteWithoutAtlas(self.cfg_.image)
	self.topTitleText_.text = self.cfg_.story_name

	self:RefreshTask()
end

function ChallengeRogueTeamIllustratedEndingPopView:RefreshTask()
	self.taskList_ = ChallengeRogueTeamData:GetAllCollectionTaskByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.END)

	if self.taskList_ then
		self.taskID_ = self.taskList_[self.index_]
	end

	self.taskCfg_ = AssignmentCfg[self.taskID_]

	local var_13_0 = TaskData2:GetTaskProgress(self.taskID_) >= self.taskCfg_.need

	if TaskData2:GetTaskComplete(self.taskID_) then
		self.btnController_:SetSelectedState("received")
	elseif var_13_0 then
		self.btnController_:SetSelectedState("true")
	else
		self.btnController_:SetSelectedState("false")
	end

	manager.redPoint:bindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.taskID_)))
end

function ChallengeRogueTeamIllustratedEndingPopView:RefreshPlot(arg_14_1)
	self.selelctPlotIndex_ = arg_14_1
	self.plotID_ = self.plotList_[self.selelctPlotIndex_]
	self.plotCfg_ = RogueTeamEndingPlotCfg[self.plotID_]
	self.titleText_.text = self.plotCfg_.name
	self.descText_.text = self.plotCfg_.desc
	self.lockText_.text = self.plotCfg_.lock_desc
	self.lineImg_.fillAmount = (#self.plotList_ - 1) / 5

	self.lockController_:SetSelectedState(tostring(ChallengeRogueTeamData:GetHistoryEndingPassCnt(self.templateID_, self.id_) >= self.selelctPlotIndex_))
end

function ChallengeRogueTeamIllustratedEndingPopView:OnExit()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.taskID_)))
	self:RemoveAllEventListener()
end

function ChallengeRogueTeamIllustratedEndingPopView:Dispose()
	ChallengeRogueTeamIllustratedEndingPopView.super.Dispose(self)
end

function ChallengeRogueTeamIllustratedEndingPopView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshUI()
end

return ChallengeRogueTeamIllustratedEndingPopView
