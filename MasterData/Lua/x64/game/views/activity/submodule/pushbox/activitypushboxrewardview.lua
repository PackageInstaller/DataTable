local ActivityPushBoxRewardView = class("ActivityPushBoxRewardView", ReduxView)

function ActivityPushBoxRewardView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryQuestPopup"
end

function ActivityPushBoxRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityPushBoxRewardView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPushBoxRewardView:InitUI()
	self:BindCfgUI()

	self.clearCon_ = ControllerUtil.GetController(self.transform_, "clear")
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivityPushBoxRewardItem)
end

function ActivityPushBoxRewardView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:Refresh(self.list_[arg_5_1])
end

function ActivityPushBoxRewardView:AddUIListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(self.list_) do
			if iter_8_1.complete_flag == 0 and AssignmentCfg[iter_8_1.id].need <= iter_8_1.progress then
				table.insert(var_8_0, iter_8_1.id)
			end
		end

		TaskAction:SubmitTaskList(var_8_0)
	end)
end

function ActivityPushBoxRewardView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.taskActivityID_ = ActivityConst.ACTIVITY_2_10_PUSH_BOX_TASK

	self:RefreshTask()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.RefreshTask))
end

function ActivityPushBoxRewardView:RefreshTask()
	self.list_ = TaskData2:GetActivityTaskSortList(self.taskActivityID_)

	self.scrollHelper_:StartScroll(#self.list_)

	if self.list_[1] then
		if self.list_[1].complete_flag == 0 and AssignmentCfg[self.list_[1].id].need <= self.list_[1].progress then
			self.clearCon_:SetSelectedState("true")
		else
			self.clearCon_:SetSelectedState("false")
		end
	else
		self.clearCon_:SetSelectedState("false")
	end
end

function ActivityPushBoxRewardView:OnExit()
	manager.windowBar:HideBar()

	for iter_11_0, iter_11_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_11_1:OnExit()
	end
end

function ActivityPushBoxRewardView:Dispose()
	self:RemoveAllListeners()

	for iter_12_0, iter_12_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_12_1:Dispose()
	end

	self.scrollHelper_:Dispose()
	self.super.Dispose(self)
end

return ActivityPushBoxRewardView
