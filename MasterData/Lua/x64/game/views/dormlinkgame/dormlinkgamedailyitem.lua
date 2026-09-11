local DormLinkGameDailyItem = class("DormLinkGameDailyItem", ReduxView)

function DormLinkGameDailyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormLinkGameDailyItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormLinkGameDailyItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
end

function DormLinkGameDailyItem:AddUIListener()
	self:AddBtnListenerScale(self.btn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function DormLinkGameDailyItem:RefreshUI(arg_6_1, arg_6_2)
	self.taskID_ = arg_6_1
	self.activityID_ = arg_6_2
	self.taskActivityID_ = DormLinkGameTools:GetTaskActivityID(self.activityID_)
	self.info_ = TaskData2:GetTask(self.taskID_)
	self.cfg_ = AssignmentCfg[arg_6_1]

	self:RefreshReward()
	self:RefreshTask()
end

local function var_0_1(arg_7_0)
	ShowPopItem(POP_ITEM, arg_7_0)
end

function DormLinkGameDailyItem:RefreshReward()
	for iter_8_0, iter_8_1 in ipairs(self.cfg_.reward) do
		local var_8_0 = rewardToItemTemplate((formatReward(iter_8_1)))

		var_8_0.clickFun = var_0_1

		if not self.rewardItems_[iter_8_0] then
			self.rewardItems_[iter_8_0] = CommonItemPool.New(self.rewardParent_, var_8_0, true)
		else
			self.rewardItems_[iter_8_0]:SetData(var_8_0)
		end

		self.rewardItems_[iter_8_0]:Show(true)
	end

	for iter_8_2 = #self.cfg_.reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_8_2]:Show(false)
	end
end

function DormLinkGameDailyItem:RefreshTask()
	self.desc_.text = self.cfg_.desc

	local var_9_0 = 0

	var_9_0 = self.info_.progress >= self.cfg_.need and self.cfg_.need or self.info_.progress
	self.progress_.text = var_9_0 .. "/" .. self.cfg_.need
	self.slider_.value = var_9_0 / self.cfg_.need

	if self.info_.complete_flag >= 1 then
		self.stateCon_:SetSelectedState("received")
	elseif var_9_0 >= self.cfg_.need then
		self.stateCon_:SetSelectedState("complete")
	else
		self.stateCon_:SetSelectedState("unfinish")
	end
end

function DormLinkGameDailyItem:Dispose()
	self:RemoveAllListeners()

	for iter_10_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_10_0]:Dispose()
	end

	self.super.Dispose(self)
end

return DormLinkGameDailyItem
