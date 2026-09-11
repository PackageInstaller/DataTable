local ChapterPlot19RewardView = class("ChapterPlot19RewardView", ReduxView)

function ChapterPlot19RewardView:UIName()
	return "Widget/System/Operation/Chapter19SectionRewardUI"
end

function ChapterPlot19RewardView:UIParent()
	return manager.ui.uiPop.transform
end

function ChapterPlot19RewardView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, ChapterPlot19RewardPanel)
	self.OnSubmitTaskHandler_ = handler(self, self.OnSubmitTask)
end

function ChapterPlot19RewardView:OnEnter()
	self.chapterID_ = tonumber(self.params_.chapterID)
	self.taskIDList_ = AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19]

	self.uiList_:StartScroll(#AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19], (self:GetSortIndex()))
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.OnSubmitTaskHandler_)
end

function ChapterPlot19RewardView:OnExit()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.OnSubmitTaskHandler_)
end

function ChapterPlot19RewardView:Dispose()
	self.OnSubmitTaskHandler_ = nil

	ChapterPlot19RewardView.super.Dispose(self)
	self.uiList_:Dispose()

	self.uiList_ = nil
end

function ChapterPlot19RewardView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function ChapterPlot19RewardView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_1, self.taskIDList_[arg_9_1])
end

function ChapterPlot19RewardView:OnSubmitTask()
	self.uiList_:Refresh()
end

function ChapterPlot19RewardView:GetSortIndex()
	for iter_11_0, iter_11_1 in ipairs(self.taskIDList_) do
		if TaskData2:GetTaskProgress(iter_11_1) >= AssignmentCfg[iter_11_1].need and not TaskData2:GetTaskComplete(iter_11_1) then
			return iter_11_0
		end
	end

	for iter_11_2, iter_11_3 in ipairs(self.taskIDList_) do
		if TaskData2:GetTaskProgress(iter_11_3) < AssignmentCfg[iter_11_3].need then
			return iter_11_2
		end
	end

	return 1
end

return ChapterPlot19RewardView
