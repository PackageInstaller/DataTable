local ActivityNewbieDailyView = class("ActivityNewbieDailyView", ReduxView)

function ActivityNewbieDailyView:Ctor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:GetUIName()), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, ActivityNewbieDailyItem)
	self.itemList_ = {}

	self:AddListeners()

	self.newbieDailyUpdateHandler_ = handler(self, self.NewbieDailyUpdate)

	manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, self.newbieDailyUpdateHandler_)

	self.newbieDailySubmitHandler_ = handler(self, self.RefreshUI)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.newbieDailySubmitHandler_)
end

function ActivityNewbieDailyView:GetUIName()
	return "Widget/System/Activitynewbie/NewbieDailyUI"
end

function ActivityNewbieDailyView:Dispose()
	manager.notify:RemoveListener(TASK_LIST_CHANGE_NOTIFY, self.newbieDailyUpdateHandler_)

	self.newbieDailyUpdateHandler_ = nil

	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.newbieDailySubmitHandler_)

	self.newbieDailySubmitHandler_ = nil

	ActivityNewbieDailyView.super.Dispose(self)
	self.scrollView_.onValueChanged:RemoveAllListeners()

	self.scrollView_ = nil
	self.itemList_ = nil

	self.scrollHelper_:Dispose()

	self.scrollHelper_ = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityNewbieDailyView:AddListeners()
	self.scrollHelper_:SetPageChangeHandler(handler(self, self.OnPageChange))
	self:AddBtnListener(self.buttonPrev_, nil, function()
		self.scrollHelper_:SwitchToPage(self.pageIndex_ - 1)
	end)
	self:AddBtnListener(self.buttonNext_, nil, function()
		self.scrollHelper_:SwitchToPage(self.pageIndex_ + 1)
	end)
	self.scrollView_.onValueChanged:AddListener(function()
		self:RefreshItemAlpha()
	end)
end

function ActivityNewbieDailyView:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function ActivityNewbieDailyView:SetData()
	self:NewbieDailyUpdate()
end

function ActivityNewbieDailyView:RefreshItem(arg_10_1, arg_10_2)
	if not table.keyof(self.itemList, arg_10_2) then
		table.insert(self.itemList_, arg_10_2)
	end

	arg_10_2:RefreshUI(arg_10_1)
	arg_10_2:RegistListener(function()
		self.scrollHelper_:Refresh()
	end)
end

function ActivityNewbieDailyView:OnPageChange(arg_12_1)
	if arg_12_1 == 0 then
		arg_12_1 = 1
	end

	self.pageIndex_ = arg_12_1

	SetActive(self.goPrev_, arg_12_1 > 1)
	SetActive(self.goNext_, arg_12_1 < #AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER])
end

function ActivityNewbieDailyView:RefreshItemAlpha()
	for iter_13_0, iter_13_1 in pairs(self.itemList_) do
		iter_13_1:RefreshAlpha()
	end
end

function ActivityNewbieDailyView:RefreshUI()
	local var_14_0 = TaskTools:GetNewbieDailyTaskFinishCnt()

	self.slider_.value = var_14_0 / #AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER]
	self.textCurCnt_.text = string.format("%s<size=30>/%s</size>", var_14_0, #AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER])
end

function ActivityNewbieDailyView:NewbieDailyUpdate(arg_15_1)
	local var_15_0 = false

	if not arg_15_1 then
		var_15_0 = true
	else
		for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
			if AssignmentCfg[iter_15_1.id] and AssignmentCfg[iter_15_1.id].type == TaskConst.TASK_TYPE.DAILY_OFFER then
				var_15_0 = true

				break
			end
		end
	end

	if var_15_0 then
		local var_15_1 = TaskTools:GetTaskCountByType(TaskConst.TASK_TYPE.DAILY_OFFER)

		self.scrollHelper_:StartScroll(#AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER], var_15_1, true, false)
		self:OnPageChange(var_15_1)
		self:RefreshUI()
		self:RefreshItemAlpha()
	end
end

return ActivityNewbieDailyView
