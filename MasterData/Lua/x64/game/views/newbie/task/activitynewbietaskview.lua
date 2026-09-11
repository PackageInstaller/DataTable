local ActivityNewbieTaskView = class("ActivityNewbieTaskView", ReduxView)

function ActivityNewbieTaskView:Ctor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Activitynewbie/NewbieTaskUI"), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.scrollHelper_ = LuaList.New(handler(self, self.RefreshItem), self.taskItemScroll_, ActivityNewbieTaskItem)
	self.phaseView_ = ActivityNewbieTaskPhase.New(self.generalTaskGo_)

	SetActive(self.gameObject_, true)

	self.newbieTaskUpdateHandler_ = handler(self, self.NewbieTaskUpdate)
end

function ActivityNewbieTaskView:SetData()
	self.phaseView_:OnEnter()
end

function ActivityNewbieTaskView:Dispose()
	self.scrollHelper_:Dispose()
	self.phaseView_:Dispose()

	self.phaseView_ = nil
	self.newbieTaskUpdateHandler_ = nil

	Object.Destroy(self.gameObject_)
	ActivityNewbieTaskView.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityNewbieTaskView:AddListeners()
	self:AddBtnListener(self.buttonPrevious_, nil, function()
		if self.selectPhase_ == nil then
			self.selectPhase_ = 1

			print("not self.selectPhase_")
			Debug.LogError(debug.traceback("ActivityNewbieTaskView.buttonPrevious_"))
		end

		self:SwitchPhase(self.selectPhase_ - 1)
	end)
	self:AddBtnListener(self.buttonNext_, nil, function()
		if self.selectPhase_ == nil then
			self.selectPhase_ = 1

			print("not self.selectPhase_")
			Debug.LogError(debug.traceback("ActivityNewbieTaskView.buttonNext_"))
		end

		self:SwitchPhase(self.selectPhase_ + 1)
	end)
end

function ActivityNewbieTaskView:SetActive(arg_7_1)
	if arg_7_1 == true then
		self:SwitchPhase(TaskData2:GetAssignmentPhase())
		manager.notify:RegistListener(NEWBIE_TASK_UPDATE, self.newbieTaskUpdateHandler_)
	else
		manager.notify:RemoveListener(NEWBIE_TASK_UPDATE, self.newbieTaskUpdateHandler_)
	end

	SetActive(self.gameObject_, arg_7_1)
end

function ActivityNewbieTaskView:RefreshItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(TaskTools:GetNewbieTaskSortList(self.selectPhase_)[arg_8_1].id)
end

function ActivityNewbieTaskView:ClearCache()
	self.lastPosition_ = nil
end

function ActivityNewbieTaskView:SwitchPhase(arg_10_1)
	local var_10_0 = TaskTools:GetNewbiePhaseTask()

	if #var_10_0 < arg_10_1 then
		arg_10_1 = #var_10_0
	end

	if arg_10_1 < 1 then
		arg_10_1 = 1
	end

	self.selectPhase_ = arg_10_1

	if var_10_0[arg_10_1].id then
		self.titleText_.text = GetI18NText(AssignmentCfg[var_10_0[arg_10_1].id].desc)

		self.phaseView_:SetData(var_10_0[arg_10_1].id)

		if self.lastPosition_ then
			self.scrollHelper_:StartScrollWithoutAnimator(#TaskTools:GetNewbieTaskSortList(arg_10_1), self.lastPosition_)
		else
			self.scrollHelper_:StartScroll(#TaskTools:GetNewbieTaskSortList(arg_10_1))
		end

		if arg_10_1 > TaskData2:GetAssignmentPhase() then
			ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), GetI18NText(AssignmentCfg[var_10_0[arg_10_1 - 1].id].desc)))
		end
	end

	if arg_10_1 <= 1 then
		SetActive(self.leftBtn_, false)
		SetActive(self.rightBtn_, true)
	elseif #var_10_0 <= arg_10_1 then
		SetActive(self.leftBtn_, true)
		SetActive(self.rightBtn_, false)
	else
		SetActive(self.leftBtn_, true)
		SetActive(self.rightBtn_, true)
	end
end

function ActivityNewbieTaskView:RefreshIcon()
	self.icon_.sprite = ItemCfg[AssignmentCfg[taskID].reward[1][1]].type == ItemConst.ITEM_TYPE.HERO and pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. AssignmentCfg[taskID].reward[1][1]) or pureGetSpriteWithoutAtlas("TextureConfig/Item_l" .. AssignmentCfg[taskID].reward[1][1])
end

function ActivityNewbieTaskView:NewbieTaskUpdate()
	self:SwitchPhase(TaskData2:GetAssignmentPhase())
end

return ActivityNewbieTaskView
