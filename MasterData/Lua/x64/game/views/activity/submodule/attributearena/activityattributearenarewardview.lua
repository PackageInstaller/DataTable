local ActivityAttributeArenaRewardView = class("ActivityAttributeArenaRewardView", ReduxView)

function ActivityAttributeArenaRewardView:UIName()
	return AttributeArenaTools.GetRewardUI(self.params_.task_activity_id)
end

function ActivityAttributeArenaRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityAttributeArenaRewardView:Init()
	self:InitUI()
	self:AddUIListener()

	self.taskUpdateHandler_ = handler(self, self.RefreshScroll)
end

function ActivityAttributeArenaRewardView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.indexItem), self.m_list, ActivityAttributeArenaRewardItem)
	self.recevieAllController = ControllerUtil.GetController(self.transform_, "recevieAll")
end

function ActivityAttributeArenaRewardView:AddUIListener()
	self:AddBtnListener(self.m_mask, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.m_recevieBtn, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(self._taskIDList) do
			if iter_7_1.progress < AssignmentCfg[iter_7_1.id].need or iter_7_1.complete_flag >= 1 then
				break
			end

			var_7_0[#var_7_0 + 1] = iter_7_1.id
		end

		TaskAction:SubmitTaskList(var_7_0)
	end)
end

function ActivityAttributeArenaRewardView:OnTop()
	manager.windowBar:SwitchBar({})
end

function ActivityAttributeArenaRewardView:OnEnter()
	self.activity_id = self.params_.task_activity_id
	self._taskIDList = TaskData2:GetActivityTaskSortList(self.activity_id)

	self.list:StartScroll(#self._taskIDList)
	self:RegistEventListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
	self:RefreshReceiveBtn()
end

function ActivityAttributeArenaRewardView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function ActivityAttributeArenaRewardView:RefreshScroll()
	self._taskIDList = TaskData2:GetActivityTaskSortList(self.activity_id)

	self.list:StartScrollWithoutAnimator(#self._taskIDList, (self.list:GetScrolledPosition()))
	self:RefreshReceiveBtn()
end

function ActivityAttributeArenaRewardView:RefreshReceiveBtn()
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(self._taskIDList) do
		if iter_12_1.progress >= AssignmentCfg[iter_12_1.id].need and iter_12_1.complete_flag < 1 then
			var_12_0 = 1

			break
		end
	end

	self.recevieAllController:SetSelectedIndex(var_12_0 == 1 and 1 or 0)
end

function ActivityAttributeArenaRewardView:indexItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(self._taskIDList[arg_13_1], arg_13_1)
end

function ActivityAttributeArenaRewardView:Dispose()
	self.list:Dispose()

	self.taskUpdateHandler_ = nil

	ActivityAttributeArenaRewardView.super.Dispose(self)
end

function ActivityAttributeArenaRewardView:OnTaskListChange()
	self:RefreshScroll()
end

return ActivityAttributeArenaRewardView
