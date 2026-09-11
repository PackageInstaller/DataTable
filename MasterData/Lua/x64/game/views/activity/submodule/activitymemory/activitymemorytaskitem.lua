local ActivityMemoryTaskItem = class("ActivityMemoryTaskItem", ReduxView)

function ActivityMemoryTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityMemoryTaskItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityMemoryTaskItem:InitUI()
	self:BindCfgUI()

	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
end

function ActivityMemoryTaskItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if ActivityData:GetActivityData(self.cfg_.activity_jump_id).startTime > manager.time:GetServerTime() then
			ShowTips("SOLO_NOT_OPEN")

			return
		end

		JumpTools.OpenPageByJump("activityMemoryPop", {
			activityId = self.activityID_,
			id = self.id_
		})
	end)
end

function ActivityMemoryTaskItem:OnEnter()
	return
end

function ActivityMemoryTaskItem:SetData(arg_7_1, arg_7_2)
	self.id_ = arg_7_1
	self.activityID_ = arg_7_2
	self.taskActivityID_ = ActivityMemoryTools.GetTaskActivityID(self.activityID_)
	self.cfg_ = SpringFestivalMemoryCfg[self.id_]
	self.taskID_ = self.cfg_.task_id
end

function ActivityMemoryTaskItem:RefreshUI()
	local var_8_0 = TaskData2:GetTask(self.taskID_)

	if not var_8_0 or var_8_0.progress < AssignmentCfg[self.taskID_].need then
		self.stateCon_:SetSelectedState("lock")
	elseif var_8_0.complete_flag < 1 then
		self.stateCon_:SetSelectedState("get")
	else
		self.stateCon_:SetSelectedState("normal")
	end
end

function ActivityMemoryTaskItem:OnExit()
	self:RemoveAllEventListener()
end

function ActivityMemoryTaskItem:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivityMemoryTaskItem
