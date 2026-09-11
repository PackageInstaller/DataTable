local SkuldSystemTaskScheduleItem = class("SkuldSystemTaskScheduleItem", ReduxView)

function SkuldSystemTaskScheduleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SkuldSystemTaskScheduleItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SkuldSystemTaskScheduleItem:InitUI()
	self:BindCfgUI()

	self.item_ = CommonItemView.New(self.itemGo_)
	self.controller_ = self.controllerEx_:GetController("state")
end

function SkuldSystemTaskScheduleItem:SetData(arg_4_1, arg_4_2)
	self.taskID_ = arg_4_1
	self.nextTaskID_ = arg_4_2

	if self.nextTaskID_ == nil then
		self.isLast_ = true
	end

	self:UpdateView()
end

function SkuldSystemTaskScheduleItem:AddUIListener()
	return
end

function SkuldSystemTaskScheduleItem:UpdateView()
	local var_6_0, var_6_1 = SkuldSystemData:GetCurTaskScheduleInfo()
	local var_6_2 = AssignmentCfg[self.taskID_]

	self.needText_.text = AssignmentCfg[self.taskID_].need

	if self.isLast_ then
		SetActive(self.processGo_, false)
	else
		SetActive(self.processGo_, true)

		self.fillImage_.fillAmount = var_6_0 >= AssignmentCfg[self.nextTaskID_].need and 1 or var_6_0 < var_6_2.need and 0 or (var_6_0 - var_6_2.need) / (AssignmentCfg[self.nextTaskID_].need - var_6_2.need)
	end

	local var_6_3 = clone(ItemTemplateData)

	var_6_3.id = var_6_2.reward[1][1]
	var_6_3.number = var_6_2.reward[1][2]

	function var_6_3:clickFun()
		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
			if TaskData2:GetTaskComplete(self.taskID_) then
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			elseif var_6_0 >= var_6_2.need then
				local var_7_0 = {}

				for iter_7_0, iter_7_1 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_SCHEDULE_TASK]) do
					if TaskData2:GetTaskComplete(iter_7_1) then
						-- block empty
					elseif var_6_0 >= AssignmentCfg[iter_7_1].need then
						table.insert(var_7_0, iter_7_1)
					end
				end

				TaskAction:SubmitTaskList(var_7_0)
			else
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		else
			ShowTips("TIME_OUT")
		end
	end

	if TaskData2:GetTaskComplete(self.taskID_) then
		var_6_3.grayFlag = true
		var_6_3.highLight = false

		self.controller_:SetSelectedState("alreadyget")
	elseif var_6_0 >= var_6_2.need then
		var_6_3.grayFlag = false
		var_6_3.highLight = true

		self.controller_:SetSelectedState("canget")
	else
		var_6_3.grayFlag = false
		var_6_3.highLight = false

		self.controller_:SetSelectedState("notyet")
	end

	self.item_:SetData(var_6_3)
end

function SkuldSystemTaskScheduleItem:OnEnter()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.SKULD_SYSTEM_TASK_ITEM .. self.taskID_)
end

function SkuldSystemTaskScheduleItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.SKULD_SYSTEM_TASK_ITEM .. self.taskID_)
end

function SkuldSystemTaskScheduleItem:Dispose()
	SkuldSystemTaskScheduleItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return SkuldSystemTaskScheduleItem
