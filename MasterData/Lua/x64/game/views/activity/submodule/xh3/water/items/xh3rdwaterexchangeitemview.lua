local XH3rdWaterExchangeItemView = class("XH3rdWaterExchangeItemView", ReduxView)

function XH3rdWaterExchangeItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function XH3rdWaterExchangeItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH3rdWaterExchangeItemView:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.commonItem_ = CommonItem.New(self.rewardItem_)
end

function XH3rdWaterExchangeItemView:AddUIListener()
	self.commonItem_:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, arg_5_0)
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if self.stateController_:GetSelectedState() == "complete" then
			ActivityWaterAction.GetSelfAssistantReward(self.activityId_, {
				self.taskId_
			}, ActivityPointRewardCfg[self.taskId_].reward_item_list)
		end
	end)
end

function XH3rdWaterExchangeItemView:AddEventListeners()
	return
end

function XH3rdWaterExchangeItemView:SetData(arg_8_1, arg_8_2)
	self.taskId_ = arg_8_1
	self.activityId_ = arg_8_2
	self.rewardCfg_ = ActivityPointRewardCfg[self.taskId_].reward_item_list[1]

	self:UpdateView()
end

function XH3rdWaterExchangeItemView:UpdateView()
	self.commonItem_:RefreshData(rewardToItemTemplate((formatReward(self.rewardCfg_))))

	self.text_.text = string.format(GetTips("ACTIVITY_WATER_SELF_PROGRESS"), ActivityPointRewardCfg[self.taskId_].need)

	if ActivityWaterData:GetCurrentSelfProgress(self.activityId_) < ActivityPointRewardCfg[self.taskId_].need then
		self.stateController_:SetSelectedState("uncomplete")
	elseif ActivityWaterData:HaveGetSelfProgressReward(self.activityId_, self.taskId_) then
		self.stateController_:SetSelectedState("received")
	else
		self.stateController_:SetSelectedState("complete")
	end
end

function XH3rdWaterExchangeItemView:OnEnter()
	self:AddEventListeners()
end

function XH3rdWaterExchangeItemView:OnExit()
	self:RemoveAllEventListener()
end

function XH3rdWaterExchangeItemView:OnMainHomeViewTop()
	return
end

function XH3rdWaterExchangeItemView:Dispose()
	self.data_ = nil

	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	XH3rdWaterExchangeItemView.super.Dispose(self)
end

return XH3rdWaterExchangeItemView
