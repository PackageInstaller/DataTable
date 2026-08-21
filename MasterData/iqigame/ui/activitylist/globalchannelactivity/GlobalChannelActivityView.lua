-- chunkname: @IQIGame\\UI\\ActivityList\\GlobalChannelActivity\\GlobalChannelActivityView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local ItemCell = require("IQIGame/UI/ActivityList/GlobalChannelActivity/GlobalChannelActivityViewItem")
local m = Clone(ActivityViewBase)

function m:__Init()
	self.signItemList = {}

	ForTransformChild(self.noviceSignContent.transform, function(_trans, _index)
		table.insert(self.signItemList, ItemCell.New(_trans.gameObject))
	end)

	function self.DelegateOnTaskNotifyFinish()
		self:OnTaskNotifyFinish()
	end
end

function m:__SetData(activityListcfg)
	self.activityListcfg = activityListcfg
	self.activityCfg = CfgActivityTable[activityListcfg.ActivityID[1]]

	local subTypes = {}

	for i = 2, #self.activityCfg.ExtraParam do
		table.insert(subTypes, self.activityCfg.ExtraParam[i])
	end

	self.signTaskList = TaskSystemModule.GetTaskListByConfig(self.activityCfg.ExtraParam[1], subTypes)

	table.sort(self.signTaskList, function(a, b)
		return a.cid < b.cid
	end)

	local isFinishAll = true

	for i = 1, table.len(self.signTaskList) do
		self.signItemList[i]:SetData(self.signTaskList[i])

		if self.signTaskList[i].status ~= Constant.TaskStatus.hadGot then
			isFinishAll = false
		end
	end

	self.finishState.gameObject:SetActive(isFinishAll)
end

function m:__AddListeners()
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyFinish)
end

function m:__RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyFinish)
end

function m:OnTaskNotifyFinish()
	self:__SetData(self.activityListcfg)
end

function m:HasRewardsToClaim(activityId)
	local activityCfg = CfgActivityTable[activityId]

	if not activityCfg then
		return false
	end

	local subTypes = {}

	for i = 2, #activityCfg.ExtraParam do
		table.insert(subTypes, activityCfg.ExtraParam[i])
	end

	local signTaskList = TaskSystemModule.GetTaskListByConfig(activityCfg.ExtraParam[1], subTypes)

	if not signTaskList then
		return false
	end

	for _, task in ipairs(signTaskList) do
		if task.status == Constant.TaskStatus.hasDone then
			return true
		end
	end

	return false
end

function m:__Dispose()
	for k, v in pairs(self.signItemList) do
		v:Dispose()
	end
end

return m
