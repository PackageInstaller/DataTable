local BlisterTaskItem = class("BlisterTaskItem", ReduxView)

function BlisterTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BlisterTaskItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function BlisterTaskItem:InitUI()
	self:BindCfgUI()
	self:InitRewardItem()

	self.stausController_ = self.allBtnController_:GetController("all")
end

function BlisterTaskItem:InitRewardItem()
	self.rewardItemList_ = {}

	for iter_4_0 = 1, 3 do
		self.rewardItemList_[iter_4_0] = CommonItemView.New(self["awardItem" .. iter_4_0 .. "Obj_"])
	end
end

function BlisterTaskItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskId_)
	end)
end

function BlisterTaskItem:SetData(arg_7_1)
	self.taskStatus_ = arg_7_1
	self.taskId_ = arg_7_1.id
	self.taskCfg_ = AssignmentCfg[self.taskId_]

	self:UpdateView()
end

function BlisterTaskItem:UpdateView()
	self.stausController_:SetSelectedIndex((self.taskStatus_.progress >= self.taskCfg_.need or nil) and (self.taskStatus_.complete_flag < 1 and 1 or 2))

	self.titleText_.text = self.taskCfg_.desc

	local var_8_1 = math.min(self.taskStatus_.progress, self.taskCfg_.need)

	self.progressBar_.value = var_8_1 / self.taskCfg_.need
	self.progressText_.text = string.format("%s/%s", var_8_1, self.taskCfg_.need)

	self:UpdateRewardItem()
end

function BlisterTaskItem:UpdateRewardItem()
	for iter_9_0 = 1, 3 do
		if self.taskCfg_.reward[iter_9_0] then
			local var_9_0 = clone(ItemTemplateData)

			var_9_0.id = self.taskCfg_.reward[iter_9_0][1]
			var_9_0.number = self.taskCfg_.reward[iter_9_0][2]

			function var_9_0:clickFun()
				ShowPopItem(POP_ITEM, {
					self.id
				})
			end

			self.rewardItemList_[iter_9_0]:SetData(var_9_0)
		else
			self.rewardItemList_[iter_9_0]:SetData(nil)
		end
	end
end

function BlisterTaskItem:Dispose()
	BlisterTaskItem.super.Dispose(self)

	for iter_11_0, iter_11_1 in pairs(self.rewardItemList_) do
		iter_11_1:Dispose()
	end

	self.rewardItemList_ = nil
end

return BlisterTaskItem
