local XH3rdFlipCardRewardItem = class("XH3rdFlipCardRewardItem", ReduxView)

function XH3rdFlipCardRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function XH3rdFlipCardRewardItem:Init()
	self:InitUI()
	self:AddListeners()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.rewardListGo_, CommonItemView)
	self.rewardState_ = ControllerUtil.GetController(self.transform_, "state")
end

function XH3rdFlipCardRewardItem:SetData(arg_3_1)
	self.taskID = arg_3_1
	self.cfg = AssignmentCfg[arg_3_1]
	self.rewardCfg = self.cfg.reward
	self.activityID = self.cfg.activity_id

	self:RefreshUI()
end

function XH3rdFlipCardRewardItem:InitUI()
	self:BindCfgUI()
end

function XH3rdFlipCardRewardItem:AddListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:SubmitTask(self.taskID)
	end)

	self.onSubmitTaskResponseHandle_ = handler(self, self.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)
end

function XH3rdFlipCardRewardItem:RefreshUI()
	self:RefreshState()
	self:RefreshItem()
end

function XH3rdFlipCardRewardItem:RefreshState()
	if TaskData2:GetTask(self.taskID).progress < self.cfg.need then
		self.rewardState_:SetSelectedState("uncomplete")
	elseif not TaskData2:GetTaskComplete(self.taskID) then
		self.rewardState_:SetSelectedState("complete")
	else
		self.rewardState_:SetSelectedState("received")
	end
end

function XH3rdFlipCardRewardItem:RefreshItem()
	local var_9_0 = TaskData2:GetTask(self.taskID)

	self.text_.text = self.cfg.desc
	self.slider_.value = var_9_0.progress / self.cfg.need
	self.sliderText_.text = (var_9_0.progress >= self.cfg.need and self.cfg.need or var_9_0.progress) .. "/" .. self.cfg.need

	self.itemList_:StartScroll(#self.rewardCfg)
end

function XH3rdFlipCardRewardItem:IndexItem(arg_10_1, arg_10_2)
	local var_10_0 = clone(ItemTemplateData)

	var_10_0.id = self.rewardCfg[arg_10_1][1]
	var_10_0.number = self.rewardCfg[arg_10_1][2]

	function var_10_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_10_2:SetData(var_10_0)
end

function XH3rdFlipCardRewardItem:Dispose()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)

	if self.itemList_ then
		self.itemList_:Dispose()

		self.itemList_ = nil
	end

	self.onReceived_ = nil

	XH3rdFlipCardRewardItem.super.Dispose(self)
end

function XH3rdFlipCardRewardItem:SetReveivedHandler(arg_13_1)
	self.onReceived_ = arg_13_1
end

function XH3rdFlipCardRewardItem:onSubmitTaskResponse()
	self:RefreshState()

	if self.onReceived_ ~= nil then
		self.onReceived_()
	end
end

return XH3rdFlipCardRewardItem
