local ActivityTaskLevelCommonItem = class("ActivityTaskLevelCommonItem", ReduxView)

function ActivityTaskLevelCommonItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.activityID = arg_1_2

	self:Init()
end

function ActivityTaskLevelCommonItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityTaskLevelCommonItem:GetLevelInfo()
	local var_3_0, var_3_1 = SummerPubTool:GetTaskInfo()

	return var_3_0, var_3_1
end

function ActivityTaskLevelCommonItem:InitUI()
	self:BindCfgUI()
end

function ActivityTaskLevelCommonItem:Refresh(arg_5_1)
	self.curLv_, self.maxLv_ = self:GetLevelInfo()
	self.levelText_.text = arg_5_1.type == 1 and "<size=45><color=\"#F4D179\">" .. self.curLv_ .. "</color></size><color=\"#93847D\">/" .. self.maxLv_ .. "</color>" or "<size=90><color=\"#F4D179\">" .. self.curLv_ .. "</color></size><color=\"#93847D\">/" .. self.maxLv_ .. "</color>"
end

function ActivityTaskLevelCommonItem:AddUIListener()
	self:AddBtnListener(self.taskLevelBtn_, nil, function()
		JumpTools.OpenPageByJump("/summerPubRecordTaskView")
	end)
end

function ActivityTaskLevelCommonItem:Dispose()
	ActivityTaskLevelCommonItem.super.Dispose(self)
end

return ActivityTaskLevelCommonItem
