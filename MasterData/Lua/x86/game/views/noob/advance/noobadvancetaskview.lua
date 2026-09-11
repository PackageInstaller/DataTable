local NoobAdvanceTaskView = class("NoobAdvanceTaskView", ReduxView)

function NoobAdvanceTaskView:UIName()
	return "Widget/System/Activitynewbie/NewbieAdvanceTaskUI_old"
end

function NoobAdvanceTaskView:UIParent()
	return manager.ui.uiMain.transform
end

function NoobAdvanceTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NoobAdvanceTaskView:InitUI()
	self:BindCfgUI()

	self.tree_ = LuaTree.New(self.uiTreeGo_)
	self.taskList_ = LuaList.New(handler(self, self.IndexTaskItem), self.uiListGo_, NoobAdvanceTaskItem)
	self.taskType_ = NoobVersionCfg[ActivityNewbieTools.GetVersionID()].noob_advance_task_type[1]

	self:GreatTree()

	self.noobTaskUpdateHandler_ = handler(self, self.OnTaskUpdate)
	self.allReceiveBtnState_ = ControllerUtil.GetController(self.transform_, "allReceive")
end

function NoobAdvanceTaskView:AddUIListener()
	self:AddBtnListener(self.receiveAllBtn_, nil, function()
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(self.taskDataList_) do
			if iter_6_1.progress >= AssignmentCfg[iter_6_1.id].need and iter_6_1.complete_flag < 1 then
				var_6_0[#var_6_0 + 1] = iter_6_1.id
			else
				break
			end
		end

		TaskAction:SubmitTaskList(var_6_0, TaskConst.TASK_TYPE.NOOB_ADVANCE)
	end)
end

function NoobAdvanceTaskView:onSubmitTaskResponse()
	self:OnTaskUpdate()
end

function NoobAdvanceTaskView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if self.params_.isEnter == true then
		local var_8_0, var_8_1 = self:GetSelectIndex()

		self.tree_:SelectItem(var_8_0, var_8_1)

		self.params_.isEnter = false
	elseif self.params_.groupIndex and self.params_.itemIndex then
		self.tree_:SelectItem(self.params_.groupIndex, self.params_.itemIndex)
	else
		self.tree_:SelectItem(1, 1)
	end

	manager.notify:RegistListener(NEWBIE_TASK_UPDATE, self.noobTaskUpdateHandler_)

	self.onSubmitTaskResponseHandle_ = handler(self, self.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskResponseHandle_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)
	self:BindRedPoint()
end

function NoobAdvanceTaskView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(NEWBIE_TASK_UPDATE, self.noobTaskUpdateHandler_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskResponseHandle_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)

	self.params_.groupIndex = self.curSelectedGroupIndex_
	self.params_.itemIndex = self.curSelectedItemIndex_
	self.curSlectedItemID_ = nil

	self:UnbindRedPoint()
end

function NoobAdvanceTaskView:IndexTaskItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.taskDataList_[arg_10_1].id, self.maxRewardNum_)
end

function NoobAdvanceTaskView:OnGroupSelect(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self.curSelectedGroupIndex_ = arg_11_1
end

function NoobAdvanceTaskView:OnItemSelect(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if self.curSlectedItemID_ == arg_12_2 then
		return
	end

	self.curSelectedItemIndex_ = arg_12_1
	self.curSlectedItemID_ = arg_12_2
	self.taskDataList_ = TaskTools:GetNoobAdvanceTaskSortList(self.taskType_, arg_12_2)
	self.maxRewardNum_ = 0

	for iter_12_0, iter_12_1 in ipairs(self.taskDataList_) do
		self.maxRewardNum_ = #AssignmentCfg[iter_12_1.id].reward > self.maxRewardNum_ and #AssignmentCfg[iter_12_1.id].reward or self.maxRewardNum_
	end

	self.taskList_:StartScroll(#self.taskDataList_)
	self:RefreshReceiveBtn()
end

function NoobAdvanceTaskView:RefreshReceiveBtn()
	for iter_13_0, iter_13_1 in ipairs(self.taskDataList_) do
		if iter_13_1.progress >= AssignmentCfg[iter_13_1.id].need and iter_13_1.complete_flag < 1 then
			self.allReceiveBtnState_:SetSelectedState("true")

			return
		end
	end

	self.allReceiveBtnState_:SetSelectedState("false")
end

function NoobAdvanceTaskView:Dispose()
	self.tree_:Dispose()

	self.tree_ = nil

	self.taskList_:Dispose()

	self.taskList_ = nil

	NoobAdvanceTaskView.super.Dispose(self)
end

function NoobAdvanceTaskView:GreatTree()
	self.tree_:SetSelectedHandler(nil, nil)

	local var_15_0 = UITreeData.New()

	self.groupCfgList_ = NoobAdvanceTaskPhaseListCfg[NoobVersionCfg[ActivityNewbieTools.GetVersionID()].noob_advance_task_phase[ActivityNewbieTools.GetAdvanceTaskCfg(self.taskType_).index]].phase_list

	for iter_15_0, iter_15_1 in ipairs(self.groupCfgList_) do
		local var_15_1 = UITreeGroupData.New()

		var_15_1.id = iter_15_0
		var_15_1.text = GetTips(iter_15_1[1])

		for iter_15_2, iter_15_3 in ipairs(iter_15_1[2]) do
			local var_15_2 = iter_15_3[3] or 0

			if var_15_2 == 0 or not SystemCfg[var_15_2] or SystemCfg[var_15_2].system_hide == 0 then
				local var_15_3 = UITreeItemData.New()

				var_15_3.id = iter_15_3[1]
				var_15_3.text = GetTips(iter_15_3[2])

				var_15_1.itemDatas:Add(var_15_3)
			end
		end

		var_15_0.groupDatas:Add(var_15_1)
	end

	self.tree_:SetData(var_15_0)
	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect), handler(self, self.OnItemSelect))
end

function NoobAdvanceTaskView:GetSelectIndex()
	local var_16_0 = 1
	local var_16_1 = 1

	for iter_16_0, iter_16_1 in ipairs(self.groupCfgList_) do
		var_16_0 = iter_16_0

		for iter_16_2, iter_16_3 in ipairs(iter_16_1[2]) do
			var_16_1 = iter_16_2

			for iter_16_4, iter_16_5 in pairs((TaskTools:GetNoobAdvanceTaskSortList(self.taskType_, iter_16_3[1]))) do
				if AssignmentCfg[iter_16_5.id].need > iter_16_5.progress or iter_16_5.complete_flag == 0 then
					return var_16_0, var_16_1
				end
			end
		end
	end

	return var_16_0, var_16_1
end

function NoobAdvanceTaskView:OnTaskUpdate()
	self.taskDataList_ = TaskTools:GetNoobAdvanceTaskSortList(self.taskType_, self.curSlectedItemID_)

	self.taskList_:StartScroll(#self.taskDataList_)
	self:RefreshReceiveBtn()
end

function NoobAdvanceTaskView:BindRedPoint()
	for iter_18_0, iter_18_1 in ipairs(self.groupCfgList_) do
		manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(iter_18_0), string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, self.taskType_, iter_18_0))

		for iter_18_2, iter_18_3 in ipairs(iter_18_1[2]) do
			local var_18_0 = iter_18_3[3] or 0

			if var_18_0 == 0 or not SystemCfg[var_18_0] or SystemCfg[var_18_0].system_hide == 0 then
				manager.redPoint:bindUIandKey(self.tree_:GetItemRedPointContainerById(iter_18_0, iter_18_3[1]), string.format("%s_%d_%d_%d", RedPointConst.NOOB_ADVANCE, self.taskType_, iter_18_0, iter_18_3[1]))
			end
		end
	end
end

function NoobAdvanceTaskView:UnbindRedPoint()
	for iter_19_0, iter_19_1 in ipairs(self.groupCfgList_) do
		manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(iter_19_0), string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, self.taskType_, iter_19_0))

		for iter_19_2, iter_19_3 in ipairs(iter_19_1[2]) do
			local var_19_0 = iter_19_3[3] or 0

			if var_19_0 == 0 or not SystemCfg[var_19_0] or SystemCfg[var_19_0].system_hide == 0 then
				manager.redPoint:unbindUIandKey(self.tree_:GetItemRedPointContainerById(iter_19_0, iter_19_3[1]), string.format("%s_%d_%d_%d", RedPointConst.NOOB_ADVANCE, self.taskType_, iter_19_0, iter_19_3[1]))
			end
		end
	end
end

return NoobAdvanceTaskView
