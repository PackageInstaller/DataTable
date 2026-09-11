local PushSnowBallWeeklyTaskItem = class("PushSnowBallWeeklyTaskItem", ReduxView)

function PushSnowBallWeeklyTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PushSnowBallWeeklyTaskItem:Init()
	self:InitUI()

	self.rewardState_ = ControllerUtil.GetController(self.transform_, "status")
end

function PushSnowBallWeeklyTaskItem:SetData(arg_3_1, arg_3_2)
	self.index_ = arg_3_1
	self.data_ = arg_3_2
	self.cfg_ = AssignmentCfg[arg_3_2.id]

	self:RefreshUI()
end

function PushSnowBallWeeklyTaskItem:InitUI()
	self:BindCfgUI()
end

function PushSnowBallWeeklyTaskItem:SetCallBack(arg_5_1)
	self.callback = arg_5_1
end

function PushSnowBallWeeklyTaskItem:SetCheckCallBack(arg_6_1)
	self.checkCallBack_ = arg_6_1
end

function PushSnowBallWeeklyTaskItem:RefreshUI()
	self:RefreshItem()
	self:RefreshState()
end

function PushSnowBallWeeklyTaskItem:RefreshItem()
	self.titleText_.text = self.cfg_.name
	self.descText_.text = self.cfg_.desc
	self.processText_.text = math.min(self.data_.progress, AssignmentCfg[self.cfg_.id].need) .. "/" .. AssignmentCfg[self.cfg_.id].need
end

function PushSnowBallWeeklyTaskItem:RefreshState()
	if self.cfg_.need > self.data_.progress then
		self.rewardState_:SetSelectedState("normal")
	else
		self.rewardState_:SetSelectedState("complete")
	end
end

function PushSnowBallWeeklyTaskItem:Dispose()
	PushSnowBallWeeklyTaskItem.super.Dispose(self)
end

return PushSnowBallWeeklyTaskItem
