local XH3rdWaterSelfContributeItemView = class("XH3rdWaterSelfContributeItemView", ReduxView)

function XH3rdWaterSelfContributeItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function XH3rdWaterSelfContributeItemView:Init()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListeners()
end

function XH3rdWaterSelfContributeItemView:InitUI()
	self:BindCfgUI()

	self.haveGetController_ = ControllerUtil.GetController(self.gameObject_.transform, "haveGet")
	self.commonItem_ = CommonItem.New(self.commonItemGo_)
end

function XH3rdWaterSelfContributeItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		local var_5_0, var_5_1 = ActivityWaterData:GetCurrentContributeCfg(self.activityId_)

		if not var_5_1 and ActivityWaterData:GetCurrentSelfProgress(self.activityId_) >= ActivityPointRewardCfg[var_5_0].need then
			ActivityWaterAction.GetSelfAssistantReward(self.activityId_, {
				var_5_0
			}, ActivityPointRewardCfg[var_5_0].reward_item_list)
		else
			JumpTools.OpenPageByJump("xH3rdWaterExchange", {})
		end
	end)
	self.commonItem_:RegistCallBack(function(arg_6_0)
		local var_6_0, var_6_1 = ActivityWaterData:GetCurrentContributeCfg(self.activityId_)

		if not var_6_1 and ActivityWaterData:GetCurrentSelfProgress(self.activityId_) >= ActivityPointRewardCfg[var_6_0].need then
			ActivityWaterAction.GetSelfAssistantReward(self.activityId_, {
				var_6_0
			}, ActivityPointRewardCfg[var_6_0].reward_item_list)
		else
			ShowPopItem(POP_ITEM, {
				arg_6_0.id,
				arg_6_0.number
			})
		end
	end)
end

function XH3rdWaterSelfContributeItemView:AddEventListeners()
	self:RegistEventListener(ACTIVITY_WATER_SELF_ASSISTANT_REWARD_UPDATE, function()
		self:UpdateView()
	end)
end

function XH3rdWaterSelfContributeItemView:SetData(arg_9_1)
	self.activityId_ = arg_9_1

	self:UpdateView()
end

function XH3rdWaterSelfContributeItemView:UpdateView()
	local var_10_0, var_10_1 = ActivityWaterData:GetCurrentContributeCfg(self.activityId_)
	local var_10_2 = ActivityWaterData:GetCurrentSelfProgress(self.activityId_)

	if var_10_1 then
		self.haveGetController_:SetSelectedState("true")
	elseif var_10_2 >= ActivityPointRewardCfg[var_10_0].need then
		self.haveGetController_:SetSelectedState("canGet")
	else
		self.haveGetController_:SetSelectedState("false")
	end

	self.contributeValueText_.text = var_10_2 .. "/" .. ActivityPointRewardCfg[var_10_0].need

	self.commonItem_:RefreshData((rewardToItemTemplate((formatReward(ActivityPointRewardCfg[var_10_0].reward_item_list[1])))))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.gameObject_.transform)
end

function XH3rdWaterSelfContributeItemView:OnEnter()
	self:AddEventListeners()
end

function XH3rdWaterSelfContributeItemView:OnExit()
	self:RemoveAllEventListener()
end

function XH3rdWaterSelfContributeItemView:OnMainHomeViewTop()
	return
end

function XH3rdWaterSelfContributeItemView:Dispose()
	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	self:RemoveAllEventListener()
	XH3rdWaterSelfContributeItemView.super.Dispose(self)
end

return XH3rdWaterSelfContributeItemView
