local ActivityReforgeWaveTaskItem = class("ActivityReforgeWaveTaskItem", ReduxView)

function ActivityReforgeWaveTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityReforgeWaveTaskItem:Init()
	self:InitUI()
end

function ActivityReforgeWaveTaskItem:InitUI()
	self:BindCfgUI()
end

function ActivityReforgeWaveTaskItem:SetData(arg_4_1)
	self.taskCfg_ = arg_4_1

	self:UpdateView()
end

function ActivityReforgeWaveTaskItem:UpdateView()
	self.taskDes_.text = GetTips(self.taskCfg_[1])
	self.taskRewardNum_.text = self.taskCfg_[2]
end

function ActivityReforgeWaveTaskItem:Dispose()
	ActivityReforgeWaveTaskItem.super.Dispose(self)
end

return ActivityReforgeWaveTaskItem
