local ActivityAttributeArenaRewardItem = class("ActivityAttributeArenaRewardItem", ReduxView)

function ActivityAttributeArenaRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityAttributeArenaRewardItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityAttributeArenaRewardItem:InitUI()
	self:BindCfgUI()

	self.awardList_ = {}
	self.buttonController = self.allBtnController_:GetController("all")

	for iter_3_0 = 1, 3 do
		table.insert(self.awardList_, (CommonItemView.New(self["awardItem" .. iter_3_0 .. "Obj_"])))
	end
end

function ActivityAttributeArenaRewardItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function ActivityAttributeArenaRewardItem:SetData(arg_6_1, arg_6_2)
	self.taskID_ = arg_6_1.id
	self.taskProgress = arg_6_1.progress
	self.taskComplete_ = arg_6_1.complete_flag >= 1

	self:RefreshUI()
end

function ActivityAttributeArenaRewardItem:RefreshUI()
	self:RefreshProgress()
	self:RefreshItems()
end

function ActivityAttributeArenaRewardItem:RefreshProgress()
	local var_8_0 = self.taskProgress

	if self.taskProgress > AssignmentCfg[self.taskID_].need then
		var_8_0 = AssignmentCfg[self.taskID_].need
	end

	local var_8_1 = AssignmentCfg[self.taskID_]

	self.titleText_.text = AssignmentCfg[self.taskID_].desc
	self.progressBar_.value = var_8_0 / var_8_1.need
	self.progressText_.text = string.format("%s/%s", var_8_0, var_8_1.need)

	local var_8_2 = self.taskProgress >= var_8_1.need

	if self.taskComplete_ then
		self.buttonController:SetSelectedIndex("2")
	elseif var_8_2 then
		self.buttonController:SetSelectedIndex("1")
	else
		self.buttonController:SetSelectedIndex("3")
	end
end

function ActivityAttributeArenaRewardItem:RefreshItems()
	self.rewards = AssignmentCfg[self.taskID_].reward or {}

	for iter_9_0, iter_9_1 in ipairs(self.awardList_) do
		if self.rewards[iter_9_0] then
			local var_9_0 = clone(ItemTemplateData)

			var_9_0.id = self.rewards[iter_9_0][1]
			var_9_0.number = self.rewards[iter_9_0][2]

			function var_9_0:clickFun()
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end

			iter_9_1:SetData(var_9_0)
			iter_9_1:RefreshGray(self.taskComplete_)
		else
			iter_9_1:SetData(nil)
		end
	end
end

function ActivityAttributeArenaRewardItem:Dispose()
	if self.awardList_ then
		for iter_11_0, iter_11_1 in ipairs(self.awardList_) do
			iter_11_1:Dispose()

			iter_11_1 = nil
		end

		self.awardList_ = nil
	end

	ActivityAttributeArenaRewardItem.super.Dispose(self)
end

return ActivityAttributeArenaRewardItem
