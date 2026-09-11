local NewServerTaskPage = class("NewServerTaskPage", ReduxView)

function NewServerTaskPage:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/NewServer/NewServerQuestListUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function NewServerTaskPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewServerTaskPage:InitUI()
	self:BindCfgUI()

	self.taskTypeList_ = {
		TaskConst.TASK_TYPE.NEW_SERVER_DAILY,
		TaskConst.TASK_TYPE.NEW_SERVER_WEEK,
		TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE
	}
	self.clickItemHandler_ = handler(self, self.SwitchPage)
	self.switchItemList_ = {}

	for iter_3_0 = 1, self.switchPanelTrans_.childCount do
		self.switchItemList_[iter_3_0] = NewServerTaskSwitchItem.New(self.switchPanelTrans_:GetChild(iter_3_0 - 1).gameObject, self.taskTypeList_[iter_3_0])

		self.switchItemList_[iter_3_0]:SetClickCallBack(self.clickItemHandler_)
	end

	self.itemList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, NewServerTaskItem)
	self.allReceiveBtnState_ = self.controllerEx_:GetController("allReceive")
end

function NewServerTaskPage:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function NewServerTaskPage:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self.activityID_) then
			return
		end

		TaskAction:SubmitTaskList(TaskTools:GetFinishTaskIds(self.taskType_), self.taskType_)
	end)
end

function NewServerTaskPage:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function NewServerTaskPage:OnEnter()
	manager.redPoint:bindUIandKey(self.switchItemList_[1].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_DAILY))
	manager.redPoint:bindUIandKey(self.switchItemList_[2].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_WEEK))
	manager.redPoint:bindUIandKey(self.switchItemList_[3].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE))
end

function NewServerTaskPage:OnExit()
	manager.redPoint:unbindUIandKey(self.switchItemList_[1].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_DAILY))
	manager.redPoint:unbindUIandKey(self.switchItemList_[2].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_WEEK))
	manager.redPoint:unbindUIandKey(self.switchItemList_[3].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE))
	ActivityNewServerTools.SetLastTaskScrollPos(self.itemList_:GetScrolledPosition())

	self.taskType_ = nil
end

function NewServerTaskPage:SetIsBack(arg_10_1)
	self.isBack_ = arg_10_1
end

function NewServerTaskPage:SetData(arg_11_1)
	self.activityID_ = arg_11_1

	if not self.isBack_ then
		self:SwitchPage(self.taskTypeList_[1])
	else
		self.isBack_ = false
		self.targetScrollPos_ = ActivityNewServerTools.GetLastTaskScrollPos()

		self:SwitchPage(ActivityNewServerTools.GetLastSelectTaskType())
	end
end

function NewServerTaskPage:SwitchPage(arg_12_1)
	if self.taskType_ == arg_12_1 then
		return
	end

	self.taskType_ = arg_12_1

	ActivityNewServerTools.SetLastSelectTaskType(self.taskType_)

	self.taskIDList_ = TaskData2:GetTypedTaskSortListCommonFilter(self.taskType_)
	self.finishList_ = TaskTools:GetFinishTaskIds(self.taskType_)
	self.maxRewardNum_ = 0

	for iter_12_0, iter_12_1 in ipairs(self.taskIDList_) do
		local var_12_0 = iter_12_1.id

		if not AssignmentCfg[iter_12_1.id] then
			print(var_12_0)
		else
			self.maxRewardNum_ = #AssignmentCfg[var_12_0].reward > self.maxRewardNum_ and #AssignmentCfg[var_12_0].reward or self.maxRewardNum_
		end
	end

	if self.targetScrollPos_ then
		self.itemList_:StartScrollByPosition(#self.taskIDList_, self.targetScrollPos_)

		self.targetScrollPos_ = nil
	else
		self.itemList_:StartScroll(#self.taskIDList_)
	end

	self:RefreshRecivedAll()
	self:RefreshSelect()
end

function NewServerTaskPage:Refresh()
	self.taskIDList_ = TaskData2:GetTypedTaskSortListCommonFilter(self.taskType_)
	self.finishList_ = TaskTools:GetFinishTaskIds(self.taskType_)

	self.itemList_:Refresh()
	self:RefreshRecivedAll()
end

function NewServerTaskPage:RefreshRecivedAll()
	self.allReceiveBtnState_:SetSelectedState(#self.finishList_ > 0 and "true" or "false")
end

function NewServerTaskPage:RefreshSelect()
	for iter_15_0, iter_15_1 in ipairs(self.switchItemList_) do
		iter_15_1:RefreshSelect(self.taskType_)
	end
end

function NewServerTaskPage:indexItem(arg_16_1, arg_16_2)
	arg_16_2:SetData(self.taskIDList_[arg_16_1].id, self.maxRewardNum_)
end

function NewServerTaskPage:Dispose()
	self.itemList_:Dispose()

	self.itemList_ = nil

	for iter_17_0, iter_17_1 in ipairs(self.switchItemList_) do
		iter_17_1:Dispose()
	end

	self.switchItemList_ = nil

	NewServerTaskPage.super.Dispose(self)
end

function NewServerTaskPage:RefreshScroll()
	self.taskIDList_ = TaskData2:GetTypedTaskSortListCommonFilter(self.taskType_)

	self.itemList_:StartScrollWithoutAnimator(#self.taskIDList_, (self.itemList_:GetScrolledPosition()))
end

function NewServerTaskPage:OnTaskListChange()
	self:RefreshScroll()

	self.finishList_ = TaskTools:GetFinishTaskIds(self.taskType_)

	self:RefreshRecivedAll()
end

return NewServerTaskPage
