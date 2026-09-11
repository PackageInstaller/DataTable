local IdolCompetitionRewardView = class("IdolCompetitionRewardView", ReduxView)

function IdolCompetitionRewardView:UIName()
	return "Widget/BackHouseUI/Competition/IdolCompetitionRewardUI"
end

function IdolCompetitionRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function IdolCompetitionRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolCompetitionRewardView:InitUI()
	self:BindCfgUI()

	self.taskLuaList_ = LuaList.New(handler(self, self.indexItem), self.taskUIList_, IdolCompetitionRewardItem)
	self.recevieAllController_ = ControllerUtil.GetController(self.transform_, "recevieAll")
end

function IdolCompetitionRewardView:AddUIListener()
	self:AddBtnListener(self.retBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.recAllBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(self.taskList_) do
			if iter_7_1.progress < AssignmentCfg[iter_7_1.id].need or iter_7_1.complete_flag >= 1 then
				break
			end

			var_7_0[#var_7_0 + 1] = iter_7_1.id
		end

		TaskAction:SubmitTaskList(var_7_0)
	end)
end

function IdolCompetitionRewardView:OnEnter()
	manager.windowBar:SwitchBar({})

	self.mainActivityID_ = self.params_.activity

	self:UpdateView()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.UpdateView))
end

function IdolCompetitionRewardView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function IdolCompetitionRewardView:UpdateView()
	self.taskList_ = TaskData2:GetActivityTaskSortList(self.mainActivityID_)

	self.taskLuaList_:StartScroll(#self.taskList_)

	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(self.taskList_) do
		if iter_10_1.progress >= AssignmentCfg[iter_10_1.id].need and iter_10_1.complete_flag < 1 then
			var_10_0 = 1

			break
		end
	end

	self.recevieAllController_:SetSelectedIndex(var_10_0 == 1 and 1 or 0)
end

function IdolCompetitionRewardView:indexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self.taskList_[arg_11_1], arg_11_1)
end

function IdolCompetitionRewardView:Dispose()
	IdolCompetitionRewardView.super.Dispose(self)

	if self.taskLuaList_ then
		self.taskLuaList_:Dispose()

		self.taskLuaList_ = nil
	end
end

function IdolCompetitionRewardView:OnTaskListChange()
	self:UpdateView()
end

return IdolCompetitionRewardView
