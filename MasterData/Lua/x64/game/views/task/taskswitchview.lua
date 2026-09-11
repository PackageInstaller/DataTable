local TaskSwitchView = class("TaskSwitchView", ReduxView)
local TaskTools = import("game.tools.TaskTools")
local TaskConst = import("game.const.TaskConst")

function TaskSwitchView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.btnType_ = arg_1_2

	self:InitUI()
	self:AddListeners()
end

function TaskSwitchView:InitUI()
	self:BindCfgUI()

	self.btnController_ = ControllerUtil.GetController(self.gameObject_.transform, "name")
end

function TaskSwitchView:OnEnter()
	if self.btnType_ == TaskConst.TASK_TYPE.PLOT then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.TASK_PLOT)
	elseif self.btnType_ == TaskConst.TASK_TYPE.DAILY then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.TASK_DAILY)
	elseif self.btnType_ == TaskConst.TASK_TYPE.WEEK then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.TASK_WEEK)
	end

	self.refreshLockHandler_ = handler(self, self.RefreshLock)

	manager.notify:RegistListener(PLAYER_LEVEL_UP, self.refreshLockHandler_)
	self:RefreshLock()
end

function TaskSwitchView:OnExit()
	manager.notify:RemoveListener(PLAYER_LEVEL_UP, self.refreshLockHandler_)

	self.refreshLockHandler_ = nil

	manager.redPoint:unbindUIandKey(self.transform_)
end

function TaskSwitchView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if not self:GetOpen() then
			local var_6_0, var_6_1 = JumpTools.GetSystemLockedText({
				(self:GetSystemID(self.btnType_))
			})

			if var_6_0 then
				ShowTips(var_6_1)
			end
		else
			self.BtnFunc_(self.btnType_)
			OperationRecorder.Record(self.class.__cname, self.btnType_)
		end
	end)
end

function TaskSwitchView:SetBtnFunc(arg_7_1)
	self.BtnFunc_ = arg_7_1
end

function TaskSwitchView:RemoveListeners()
	self.btn_.onClick:RemoveAllListeners()
end

function TaskSwitchView:SwitchButton(arg_9_1)
	if self.lastBtnType_ == arg_9_1 then
		return
	end

	if self.btnType_ == arg_9_1 then
		self.btnController_:SetSelectedState("false")
	else
		self.btnController_:SetSelectedState("true")
	end

	self.lastBtnType_ = arg_9_1
end

function TaskSwitchView:Dispose()
	self:RemoveListeners()
	TaskSwitchView.super.Dispose(self)
end

function TaskSwitchView:GetOpen()
	return not JumpTools.IsSystemLocked((self:GetSystemID(self.btnType_)))
end

function TaskSwitchView:GetSystemID(arg_12_1)
	local var_12_0

	if arg_12_1 == TaskConst.TASK_TYPE.PLOT then
		var_12_0 = ViewConst.SYSTEM_ID.TASK_PLOT
	elseif arg_12_1 == TaskConst.TASK_TYPE.DAILY then
		var_12_0 = ViewConst.SYSTEM_ID.TASK_DAILY
	elseif arg_12_1 == TaskConst.TASK_TYPE.WEEK then
		var_12_0 = ViewConst.SYSTEM_ID.TASK_WEEK
	else
		print("未知的任务类型")
	end

	return var_12_0
end

function TaskSwitchView:RefreshLock()
	return
end

return TaskSwitchView
