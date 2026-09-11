local NoobAdvanceTaskNewView = class("NoobAdvanceTaskNewView", (import("game.views.noob.advance.NoobAdvanceTaskView")))

function NoobAdvanceTaskNewView:UIName()
	return "Widget/System/Activitynewbie/NewbieAdvanceTaskUI_new"
end

function NoobAdvanceTaskNewView:InitUI()
	self:BindCfgUI()

	self.tree_ = LuaTree.New(self.uiTreeGo_)
	self.taskList_ = LuaList.New(handler(self, self.IndexTaskItem), self.uiListGo_, NoobAdvanceTaskItem)
	self.conditionList_ = {}
	self.allReceiveBtnState_ = ControllerUtil.GetController(self.transform_, "allReceive")
	self.progressController_ = self.controllerExcollection_:GetController("progress")
end

function NoobAdvanceTaskNewView:UpdateNextType()
	self.curTaskTypeCfg_ = ActivityNewbieTools.GetAdvanceTaskCfg(self.taskType_)
	self.nextTypeIndex_ = self.curTaskTypeCfg_.index + 1
	self.nextType_ = NoobVersionCfg[self.curTaskTypeCfg_.versionID].noob_advance_task_type[self.nextTypeIndex_]
end

function NoobAdvanceTaskNewView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	local var_4_0, var_4_1 = ActivityNewbieTools.CheckAdvanceTaskOpen()

	if self.taskType_ ~= var_4_1 then
		self.taskType_ = var_4_1

		self:UpdateNextType()

		if getData("noobAdvanceTask", string.format("need_level_enough_tips_%s", self.taskType_)) == 1 == true then
			ShowTips("NOOB_ADVANCE_TASK_LEVEL_ENOUGH")
			saveData("noobAdvanceTask", string.format("need_level_enough_tips_%s", self.taskType_), 0)
		end

		self:GreatTree()
	end

	if self.params_.isEnter == true then
		local var_4_2, var_4_3 = self:GetSelectIndex()

		self.tree_:SelectItem(var_4_2, var_4_3)

		self.params_.isEnter = false
	elseif self.params_.groupIndex and self.params_.itemIndex then
		self.tree_:SelectItem(self.params_.groupIndex, self.params_.itemIndex)
	else
		self.tree_:SelectItem(1, 1)
	end

	self:RefreshUI()

	self.onSubmitTaskResponseHandle_ = handler(self, self.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskResponseHandle_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)
	self:BindRedPoint()
end

function NoobAdvanceTaskNewView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskResponseHandle_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)

	self.params_.groupIndex = self.curSelectedGroupIndex_
	self.params_.itemIndex = self.curSelectedItemIndex_
	self.curSlectedItemID_ = nil

	self:UnbindRedPoint()
end

function NoobAdvanceTaskNewView:OnTop()
	if self.needShowTips_ then
		self.needShowTips_ = false

		ShowTips(self.tipsStr_)
	end
end

function NoobAdvanceTaskNewView:RefreshUI()
	self:RefreshProgress()
end

function NoobAdvanceTaskNewView:RefreshProgress()
	if self.nextType_ then
		self.nextTypeTitle_.text = GetTips(NoobVersionCfg[self.curTaskTypeCfg_.versionID].noob_advance_task_title[self.nextTypeIndex_])

		for iter_8_0 = 1, 2 do
			self.conditionList_[iter_8_0] = self.conditionList_[iter_8_0] or NoobAdvanceConditionItem.New((Object.Instantiate(self.conditionItemGo_, self.conditionContent_)))

			self.conditionList_[iter_8_0]:SetData(iter_8_0, self.taskType_, self.nextTypeIndex_)
		end
	end

	self.curTypeTitle_.text = GetTips(NoobVersionCfg[self.curTaskTypeCfg_.versionID].noob_advance_task_title[self.curTaskTypeCfg_.index])

	self.progressController_:SetSelectedState(tostring(self.curTaskTypeCfg_.index))
end

function NoobAdvanceTaskNewView:Dispose()
	for iter_9_0, iter_9_1 in ipairs(self.conditionList_) do
		iter_9_1:Dispose()
	end

	self.conditionList_ = nil

	NoobAdvanceTaskNewView.super.Dispose(self)
end

function NoobAdvanceTaskNewView:OnTaskUpdate()
	local var_10_0 = false

	if TaskTools:IsCompletedAllNoobAdvanceTask(self.taskType_) then
		local var_10_1 = true

		if self.nextType_ then
			if NoobVersionCfg[self.curTaskTypeCfg_.versionID].noob_advance_task_open[self.nextTypeIndex_] <= PlayerData:GetPlayerInfo().userLevel then
				var_10_0 = true
				var_10_1 = true
			else
				var_10_1 = false

				saveData("noobAdvanceTask", string.format("need_level_enough_tips_%s", self.nextType_), 1)
			end
		end

		if var_10_1 then
			self.needShowTips_ = true
			self.tipsStr_ = string.format(GetTips("NOOB_ADVANCE_TASK_COMPLETE"), (GetTips(NoobVersionCfg[self.curTaskTypeCfg_.versionID].noob_advance_task_title[self.curTaskTypeCfg_.index])))
		else
			self.needShowTips_ = true
			self.tipsStr_ = string.format(GetTips("NOOB_ADVANCE_TASK_LEVEL_NOTENOUGH"), NoobVersionCfg[self.curTaskTypeCfg_.versionID].noob_advance_task_open[self.nextTypeIndex_])
		end
	end

	if not var_10_0 then
		self.taskDataList_ = TaskTools:GetNoobAdvanceTaskSortList(self.taskType_, self.curSlectedItemID_)

		self.taskList_:StartScroll(#self.taskDataList_)
		self:RefreshReceiveBtn()
	else
		self:UnbindRedPoint()

		self.taskType_ = self.nextType_

		self:UpdateNextType()
		self:GreatTree()
		self:BindRedPoint()

		local var_10_2, var_10_3 = self:GetSelectIndex()

		self.curSlectedItemID_ = nil

		self.tree_:SelectItem(var_10_2, var_10_3)
		self:RefreshProgress()
	end
end

return NoobAdvanceTaskNewView
