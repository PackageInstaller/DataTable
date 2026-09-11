local DodgeBarrageTaskItem = class("DodgeBarrageTaskItem", ReduxView)

function DodgeBarrageTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DodgeBarrageTaskItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function DodgeBarrageTaskItem:InitUI()
	self:BindCfgUI()
	self:InitRewardItem()

	self.stausController_ = self.itemCon_:GetController("status")
end

function DodgeBarrageTaskItem:InitRewardItem()
	self.rewardItemList_ = {}

	for iter_4_0 = 1, 3 do
		self.rewardItemList_[iter_4_0] = CommonItemView.New(self["rewardItem_" .. iter_4_0])
	end
end

function DodgeBarrageTaskItem:AddUIListener()
	self:AddBtnListener(self.btnReceive_, nil, function()
		TaskAction:SubmitTask(self.taskId_)
	end)
end

function DodgeBarrageTaskItem:SetData(arg_7_1)
	self.taskStatus_ = arg_7_1
	self.taskId_ = arg_7_1.id
	self.taskCfg_ = AssignmentCfg[self.taskId_]

	self:UpdateView()
end

function DodgeBarrageTaskItem:UpdateView()
	local var_8_0 = 1

	if self.taskStatus_.progress >= self.taskCfg_.need then
		var_8_0 = self.taskStatus_.complete_flag < 1 and 0 or 2
	end

	self.descText_.text = self.taskCfg_.desc

	self.stausController_:SetSelectedIndex(var_8_0)
	self:UpdateRewardItem()
end

function DodgeBarrageTaskItem:UpdateRewardItem()
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

function DodgeBarrageTaskItem:Dispose()
	DodgeBarrageTaskItem.super.Dispose(self)

	for iter_11_0, iter_11_1 in pairs(self.rewardItemList_) do
		iter_11_1:Dispose()
	end

	self.rewardItemList_ = nil
end

return DodgeBarrageTaskItem
