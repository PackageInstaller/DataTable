local SpringFestivalZumaTaskItem = class("SpringFestivalZumaTaskItem", ReduxView)

function SpringFestivalZumaTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SpringFestivalZumaTaskItem:Init()
	self:InitUI()
end

function SpringFestivalZumaTaskItem:InitUI()
	self:BindCfgUI()

	self.showStateController = self.allBtnController_:GetController("all")

	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskData.id)
	end)

	self.rewardItemList = {}
end

function SpringFestivalZumaTaskItem:SetData(arg_5_1)
	self.taskData = arg_5_1

	self:Refresh()
end

function SpringFestivalZumaTaskItem:Refresh()
	local var_6_0 = AssignmentCfg[self.taskData.id]

	self.titleText_.text = AssignmentCfg[self.taskData.id].desc

	if self.taskData.complete_flag == 1 then
		self.showStateController:SetSelectedState("complete")
	elseif self.taskData.progress >= var_6_0.need then
		self.showStateController:SetSelectedState("receive")
	else
		self.showStateController:SetSelectedState("lock")
	end

	self.taskData.progress = self.taskData.progress
	self.progressBar_.value = self.taskData.progress / var_6_0.need
	self.progressText_.text = string.format("%s/%s", math.min(self.taskData.progress, var_6_0.need), var_6_0.need)

	self:RefreshRewardList(var_6_0.reward)
end

function SpringFestivalZumaTaskItem:RefreshRewardList(arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		self.rewardItemList[iter_7_0] = self.rewardItemList[iter_7_0] or CommonItemView.New(self[string.format("awardItem%sObj_", iter_7_0)])

		local var_7_0 = clone(ItemTemplateData)

		var_7_0.id = iter_7_1[1]
		var_7_0.number = iter_7_1[2]

		function var_7_0.clickFun()
			ShowPopItem(POP_ITEM, {
				var_7_0.id
			})
		end

		self.rewardItemList[iter_7_0]:SetData(var_7_0)
		self.rewardItemList[iter_7_0]:Show(true)
	end

	for iter_7_2 = #arg_7_1 + 1, #self.rewardItemList do
		self.rewardItemList[iter_7_2]:Show(false)
	end
end

function SpringFestivalZumaTaskItem:Dispose()
	for iter_9_0, iter_9_1 in pairs(self.rewardItemList) do
		iter_9_1:Dispose()

		iter_9_1 = nil
	end

	SpringFestivalZumaTaskItem.super.Dispose(self)
end

return SpringFestivalZumaTaskItem
