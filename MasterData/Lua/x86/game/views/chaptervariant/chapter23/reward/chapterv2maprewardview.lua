local ChapterV2MapRewardView = class("ChapterV2MapRewardView", ReduxView)

function ChapterV2MapRewardView:UIName()
	return "Widget/System/Xuheng_PlotMap/XuhengStarExchangepopUI"
end

function ChapterV2MapRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function ChapterV2MapRewardView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ChapterV2MapRewardPanel)
	self.OnSubmitTaskHandler_ = handler(self, self.OnSubmitTask)
end

function ChapterV2MapRewardView:OnEnter()
	self.chapterClientID_ = tonumber(self.params_.chapterClientID)
	self.taskIDList_ = AssignmentCfg.get_id_list_by_type[ChapterV2MapTools.GetChapterTaskType(self.chapterClientID_)] or {}

	self.uiList_:StartScroll(#self.taskIDList_, (self:GetSortIndex()))
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.OnSubmitTaskHandler_)
end

function ChapterV2MapRewardView:OnExit()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.OnSubmitTaskHandler_)
end

function ChapterV2MapRewardView:Dispose()
	self.OnSubmitTaskHandler_ = nil

	ChapterV2MapRewardView.super.Dispose(self)
	self.uiList_:Dispose()

	self.uiList_ = nil
end

function ChapterV2MapRewardView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
	end)
end

function ChapterV2MapRewardView:OnExitInput()
	JumpTools.Back()

	return true
end

function ChapterV2MapRewardView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, self.taskIDList_[arg_10_1])
end

function ChapterV2MapRewardView:OnSubmitTask()
	TaskRedPoint:UpdateChapterV2TaskRedTip()
	self.uiList_:Refresh()
end

function ChapterV2MapRewardView:GetSortIndex()
	for iter_12_0, iter_12_1 in ipairs(self.taskIDList_) do
		if TaskData2:GetTaskProgress(iter_12_1) >= AssignmentCfg[iter_12_1].need and not TaskData2:GetTaskComplete(iter_12_1) then
			return iter_12_0
		end
	end

	for iter_12_2, iter_12_3 in ipairs(self.taskIDList_) do
		if TaskData2:GetTaskProgress(iter_12_3) < AssignmentCfg[iter_12_3].need then
			return iter_12_2
		end
	end

	return 1
end

return ChapterV2MapRewardView
