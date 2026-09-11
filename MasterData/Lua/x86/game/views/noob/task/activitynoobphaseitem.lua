local ActivityNoobPhaseItem = class("ActivityNoobPhaseItem", ReduxView)
local var_0_1 = {
	"normal",
	"lock",
	"finish"
}

function ActivityNoobPhaseItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function ActivityNoobPhaseItem:Dispose()
	self.clickHandler_ = nil

	self:UnbindRedPoint()
	ActivityNoobPhaseItem.super.Dispose(self)
end

function ActivityNoobPhaseItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.isLock_ == true then
			ShowTips(string.format(GetTips("ACTIVITY_FIRST_UNLOCK_PROMPT"), self.unLockDay_))
		end

		if self.clickHandler_ then
			self.clickHandler_(self.phase_)
		end
	end)
end

function ActivityNoobPhaseItem:SetData(arg_5_1, arg_5_2)
	self:BindRedPoint(arg_5_2)

	self.taskType_ = arg_5_1
	self.phase_ = arg_5_2
	self.titleText_.text = "0" .. arg_5_2
	self.titleText2_.text = string.format(GetTips("ACTIVITY_GREENHORN_TASK_STAGE"), arg_5_2)

	self:RefreshState()
end

function ActivityNoobPhaseItem:BindRedPoint(arg_6_1)
	if self.phase_ == nil then
		manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%d", RedPointConst.NEWBIE_TASK, arg_6_1))
	elseif self.phase_ ~= arg_6_1 then
		manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%d", RedPointConst.NEWBIE_TASK, self.phase_))
		manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%d", RedPointConst.NEWBIE_TASK, arg_6_1))
	end
end

function ActivityNoobPhaseItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%d", RedPointConst.NEWBIE_TASK, self.phase_))
end

function ActivityNoobPhaseItem:RefreshState()
	self.stateCon_:SetSelectedState((self:GetItemState()))
end

function ActivityNoobPhaseItem:SetSelect(arg_9_1)
	self.selectController_:SetSelectedIndex(self.phase_ == arg_9_1 and 1 or 0)
end

function ActivityNoobPhaseItem:GetItemState()
	local var_10_0 = ActivityNoobData:GetUnlockPhase()

	self.isLock_ = false

	if var_10_0 < self.phase_ then
		self.unLockDay_ = self.phase_ - var_10_0
		self.isLock_ = true

		return var_0_1[2]
	else
		for iter_10_0, iter_10_1 in ipairs((TaskTools:GetNoobTaskSortList(self.taskType_, self.phase_))) do
			if iter_10_1.complete_flag < 1 then
				return var_0_1[1]
			end
		end
	end

	return var_0_1[3]
end

function ActivityNoobPhaseItem:SetClickHandler(arg_11_1)
	self.clickHandler_ = arg_11_1
end

return ActivityNoobPhaseItem
