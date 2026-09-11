local ChallengeRogueTeamTaskItem = class("ChallengeRogueTeamTaskItem", ReduxView)

function ChallengeRogueTeamTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ChallengeRogueTeamTaskItem:Init()
	self:InitUI()
	self:AddListeners()

	self.rewardItemList_ = {}
	self.itemDataList_ = {}
	self.rewardState_ = self.allBtnController_:GetController("all")
end

function ChallengeRogueTeamTaskItem:InitUI()
	self:BindCfgUI()
end

function ChallengeRogueTeamTaskItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:SubmitTaskList({
			self.taskID_
		}, nil, self.callBack_)
	end)
end

function ChallengeRogueTeamTaskItem:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self.rewardItemList_) do
		iter_6_1:Dispose()
	end

	self.rewardItemList_ = nil
	self.itemDataList_ = nil

	ChallengeRogueTeamTaskItem.super.Dispose(self)
end

function ChallengeRogueTeamTaskItem:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.receiveBtn_.transform, self.taskRedPointStr_)
end

function ChallengeRogueTeamTaskItem:SetData(arg_8_1)
	self.taskID_ = arg_8_1
	self.activityID_ = AssignmentCfg[self.taskID_].activity_id
	self.taskRedPointStr_ = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.taskID_)

	manager.redPoint:bindUIandKey(self.receiveBtn_.transform, self.taskRedPointStr_)
	self:RefreshUI()
end

function ChallengeRogueTeamTaskItem:RefreshUI()
	self:RefreshDesc()
	self:RefreshItem()
	self:RefreshState()
	self:Show(true)
end

function ChallengeRogueTeamTaskItem:RefreshDesc()
	self.titleText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	local var_10_0 = TaskData2:GetTask(self.taskID_)
	local var_10_1 = AssignmentCfg[self.taskID_].need

	if var_10_0 and var_10_0.progress and AssignmentCfg[self.taskID_].need > var_10_0.progress then
		var_10_1 = var_10_0.progress
	end

	var_10_1 = AssignmentCfg[self.taskID_].need < var_10_1 and AssignmentCfg[self.taskID_].need or var_10_1
	self.progressBar_.value = var_10_1 / AssignmentCfg[self.taskID_].need
	self.progressText_.text = string.format("%s/%s", var_10_1, AssignmentCfg[self.taskID_].need)
end

function ChallengeRogueTeamTaskItem:RefreshItem()
	self.rewardCfg_ = AssignmentCfg[self.taskID_].reward

	for iter_11_0 = 1, 3 do
		SetActive(self[string.format("awardItem%sObj_", iter_11_0)], false)
	end

	for iter_11_1 = 1, #self.rewardCfg_ do
		self.rewardItemList_[iter_11_1] = self.rewardItemList_[iter_11_1] or CommonItemView.New(self[string.format("awardItem%sObj_", iter_11_1)])

		self.rewardItemList_[iter_11_1]:Show(true)

		if not self.itemDataList_[iter_11_1] then
			self.itemDataList_[iter_11_1] = clone(ItemTemplateData)
			self.itemDataList_[iter_11_1].clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		local var_11_0 = true

		if self.rewardCfg_[iter_11_1] then
			self.itemDataList_[iter_11_1].id = self.rewardCfg_[iter_11_1][1]
			self.itemDataList_[iter_11_1].number = self.rewardCfg_[iter_11_1][2]
			var_11_0 = false
		end

		if not var_11_0 then
			self.rewardItemList_[iter_11_1]:SetData(self.itemDataList_[iter_11_1])
		else
			self.rewardItemList_[iter_11_1]:SetData(nil)
		end
	end
end

function ChallengeRogueTeamTaskItem:RefreshState()
	local var_13_0 = AssignmentCfg[self.taskID_].need
	local var_13_1 = TaskData2:GetTask(self.taskID_)
	local var_13_2 = AssignmentCfg[self.taskID_].need
	local var_13_3

	if var_13_1 and var_13_1.progress then
		var_13_2 = var_13_1.progress
		var_13_3 = TaskData2:GetTaskComplete(self.taskID_)
	end

	if var_13_0 > var_13_2 then
		self.rewardState_:SetSelectedState("lock")
	elseif not var_13_3 then
		self.rewardState_:SetSelectedState("receive")
	else
		self.rewardState_:SetSelectedState("complete")
	end

	for iter_13_0 = 1, #self.rewardCfg_ do
		self.rewardItemList_[iter_13_0]:RefreshGray(var_13_3)
	end
end

function ChallengeRogueTeamTaskItem:SetReveivedHandler(arg_14_1)
	self.callBack_ = arg_14_1
end

function ChallengeRogueTeamTaskItem:Show(arg_15_1)
	SetActive(self.gameObject_, arg_15_1)
end

return ChallengeRogueTeamTaskItem
