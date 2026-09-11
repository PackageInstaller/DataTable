local SummerPopSkinPopTaskView = class("SummerPopSkinPopTaskView", ReduxView)

function SummerPopSkinPopTaskView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.taskid_ = arg_1_2

	self:Init()
end

function SummerPopSkinPopTaskView:Init()
	self:InitUI()
	self:AddUIListeners()
	self:InitReward()
end

function SummerPopSkinPopTaskView:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.exController_:GetController("all")
end

function SummerPopSkinPopTaskView:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		self:GetTaskReward(self.taskid_)
	end)
end

function SummerPopSkinPopTaskView:InitReward()
	self.rewardItemList_ = {}
	self.itemDataList_ = {}

	for iter_6_0, iter_6_1 in ipairs(AssignmentCfg[self.taskid_].reward) do
		self.rewardItemList_[iter_6_0] = CommonItemView.New(self.rewardPanelTrans_:GetChild(iter_6_0 - 1).transform:GetChild(0).gameObject, true)

		local var_6_0 = clone(ItemTemplateData)

		var_6_0.id = iter_6_1[1]
		var_6_0.number = iter_6_1[2]

		function var_6_0:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		var_6_0.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.NULL
		self.itemDataList_[iter_6_0] = var_6_0

		self.rewardItemList_[iter_6_0]:SetData(var_6_0)
	end
end

function SummerPopSkinPopTaskView:RefreshUI()
	self.taskTitle_.text = GetI18NText(AssignmentCfg[self.taskid_].desc)

	if TaskData2:GetTaskComplete(self.taskid_) then
		for iter_8_0 = 1, #self.rewardItemList_ do
			self.rewardItemList_[iter_8_0]:SetData(self.itemDataList_[iter_8_0])

			self.itemDataList_[iter_8_0] = self.itemDataList_[iter_8_0]
		end

		self.stateController_:SetSelectedState("complete")
	elseif TaskData2:GetTaskProgress(self.taskid_) >= AssignmentCfg[self.taskid_].need then
		self.stateController_:SetSelectedState("receive")
	else
		self.stateController_:SetSelectedState("lock")
	end
end

function SummerPopSkinPopTaskView:GetTaskReward(arg_9_1)
	local var_9_0 = false

	for iter_9_0, iter_9_1 in ipairs(AssignmentCfg[arg_9_1].reward) do
		if ItemCfg[iter_9_1[1]].type == ItemConst.ITEM_TYPE.SCENE then
			TaskAction:SubmitTask(arg_9_1, function()
				self:RefreshUI()
				ActivityAction.UpdateRedPointDLC_5_2(ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC)
				manager.notify:Invoke(SUMMER_RACE_SKIN_UPDATE_5_2)
			end)

			var_9_0 = true

			break
		end
	end

	if not var_9_0 then
		TaskAction:SubmitTask(arg_9_1, function()
			self:RefreshUI()
			ActivityAction.UpdateRedPointDLC_5_2(ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC)
			manager.notify:Invoke(SUMMER_RACE_SKIN_UPDATE_5_2)
		end)
	end
end

function SummerPopSkinPopTaskView:Dispose()
	for iter_12_0 = 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_12_0]:Dispose()
	end

	self.rewardItemList_ = nil
	self.itemDataList_ = nil

	SummerPopSkinPopTaskView.super.Dispose(self)
end

return SummerPopSkinPopTaskView
