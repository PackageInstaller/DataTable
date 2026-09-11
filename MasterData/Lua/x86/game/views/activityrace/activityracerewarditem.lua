local ActivityRaceRewardItem = class("ActivityRaceRewardItem", ReduxView)

function ActivityRaceRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityRaceRewardItem:Init()
	self:InitUI()
end

function ActivityRaceRewardItem:InitUI()
	self:BindCfgUI()

	self.taskItemList_ = {}
end

function ActivityRaceRewardItem:SetData(arg_4_1)
	self.activityID_ = arg_4_1
	self.accumulateTaskIDList_ = ActivityRaceCfg[arg_4_1].task_list_id
	self.taskIDList_ = ActivityRaceCfg[arg_4_1].task_list
	self.title_.text = GetI18NText(ActivityRaceCfg[arg_4_1].map_name)

	local var_4_0 = 1

	for iter_4_0, iter_4_1 in ipairs(self.accumulateTaskIDList_) do
		if self.taskItemList_[var_4_0] == nil then
			self.taskItemList_[var_4_0] = ActivityRaceTaskItem.New(self.taskItemTemplate_, self.taskPanel_)
		end

		self.taskItemList_[var_4_0]:SetData(iter_4_1, self.activityID_, true)

		var_4_0 = var_4_0 + 1
	end

	for iter_4_2, iter_4_3 in ipairs(self.taskIDList_) do
		if self.taskItemList_[var_4_0] == nil then
			self.taskItemList_[var_4_0] = ActivityRaceTaskItem.New(self.taskItemTemplate_, self.taskPanel_)
		end

		self.taskItemList_[var_4_0]:SetData(iter_4_3, self.activityID_, false)

		var_4_0 = var_4_0 + 1
	end
end

function ActivityRaceRewardItem:Dispose()
	for iter_5_0, iter_5_1 in ipairs(self.taskItemList_) do
		iter_5_1:Dispose()
	end

	self.taskItemList_ = nil

	ActivityRaceRewardItem.super.Dispose(self)
end

function ActivityRaceRewardItem:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

return ActivityRaceRewardItem
