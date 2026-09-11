local XH3rdWaterMainRewardItemView = class("XH3rdWaterMainRewardItemView", ReduxView)

function XH3rdWaterMainRewardItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function XH3rdWaterMainRewardItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH3rdWaterMainRewardItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.commonItem_ = CommonItem.New(self.commonItemGo_)
end

function XH3rdWaterMainRewardItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.statusController_:GetSelectedState() == "finish" then
			ActivityWaterAction.GetTotalAssistantReward(ActivityWaterData:GetCurrentSchedule(self.activityId_).schedule_id, ActivityWaterData:GetCurrentAssistantRole(self.activityId_), {
				self.rewardData_[1]
			}, {
				{
					self.rewardData_[2],
					self.rewardData_[3]
				}
			})
		end
	end)
	self.commonItem_:RegistCallBack(function(arg_6_0)
		if self.statusController_:GetSelectedState() == "finish" then
			ActivityWaterAction.GetTotalAssistantReward(ActivityWaterData:GetCurrentSchedule(self.activityId_).schedule_id, ActivityWaterData:GetCurrentAssistantRole(self.activityId_), {
				self.rewardData_[1]
			}, {
				{
					self.rewardData_[2],
					self.rewardData_[3]
				}
			})
		else
			ShowPopItem(POP_ITEM, {
				arg_6_0.id,
				arg_6_0.number
			})
		end
	end)
end

function XH3rdWaterMainRewardItemView:AddEventListeners()
	self:RegistEventListener(ACTIVITY_WATER_TOTAL_ASSISTANT_REWARD_UPDATE, function()
		self:UpdateView()
	end)
end

function XH3rdWaterMainRewardItemView:SetData(arg_9_1, arg_9_2, arg_9_3)
	self.index_ = arg_9_1
	self.activityId_ = arg_9_2
	self.rewardData_ = arg_9_3

	self:UpdateView()
end

function XH3rdWaterMainRewardItemView:UpdateView()
	if ActivityWaterData:GetCurrentAssistantRoleProcess(self.activityId_) < self.rewardData_[1] then
		self.statusController_:SetSelectedState("notFinish")
	elseif ActivityWaterData:HaveGetTotalProgressReward(self.activityId_, self.rewardData_[1]) then
		self.statusController_:SetSelectedState("haveGet")
	else
		self.statusController_:SetSelectedState("finish")
	end

	self.valueText_.text = NumberTools.FormatNumberWithThousandsSeparator(self.rewardData_[1])

	self.commonItem_:RefreshData({
		id = self.rewardData_[2],
		number = self.rewardData_[3]
	})
end

function XH3rdWaterMainRewardItemView:OnEnter()
	self:AddEventListeners()
end

function XH3rdWaterMainRewardItemView:OnExit()
	self:RemoveAllEventListener()
end

function XH3rdWaterMainRewardItemView:OnMainHomeViewTop()
	return
end

function XH3rdWaterMainRewardItemView:Dispose()
	self.data_ = nil

	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	XH3rdWaterMainRewardItemView.super.Dispose(self)
end

return XH3rdWaterMainRewardItemView
