local DormLinkGameActivityItem = class("DormLinkGameActivityItem", ReduxView)

function DormLinkGameActivityItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormLinkGameActivityItem:Init()
	self:InitUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.count = 0
end

function DormLinkGameActivityItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function DormLinkGameActivityItem:AddUIListener()
	self:AddBtnListenerScale(self.rewardBtn_, nil, function()
		self.getAward(self.ID)
	end)
end

function DormLinkGameActivityItem:RefreshUI(arg_6_1)
	self.ID = arg_6_1

	if not ConditionCfg[ActivityLinkGameRewardCfg[arg_6_1].condition] then
		return
	end

	self.text_.text = DormLinkGameTools:GetAwardDesc(arg_6_1)

	local var_6_0 = DormLinkGameData:CheckLevelRewardState(arg_6_1)

	if var_6_0 == DormLinkGameConst.RewardItemState.unComplete then
		self.stateController:SetSelectedState("uncomplete")
	elseif var_6_0 == DormLinkGameConst.RewardItemState.complete then
		self.stateController:SetSelectedState("complete")
	elseif var_6_0 == DormLinkGameConst.RewardItemState.received then
		self.stateController:SetSelectedState("received")
	end

	self:UpdataReward()
end

local function var_0_1(arg_7_0)
	ShowPopItem(POP_ITEM, arg_7_0)
end

function DormLinkGameActivityItem:UpdataReward()
	self.rewardList = self.rewardList or {}

	for iter_8_0, iter_8_1 in ipairs(ActivityLinkGameRewardCfg[self.ID].item_list) do
		local var_8_0 = rewardToItemTemplate((formatReward(iter_8_1)))

		var_8_0.clickFun = var_0_1

		if self.rewardList[iter_8_0] then
			self.rewardList[iter_8_0]:SetData(var_8_0)
		else
			self.rewardList[iter_8_0] = CommonItemPool.New(self.rewardParent_, var_8_0)
		end
	end

	for iter_8_2, iter_8_3 in pairs(self.rewardList) do
		self.rewardList[iter_8_2]:Show(true)
	end
end

function DormLinkGameActivityItem:GetLevelAward(arg_9_1)
	if arg_9_1 then
		self.getAward = arg_9_1
	end
end

function DormLinkGameActivityItem:Dispose()
	if self.rewardList then
		for iter_10_0, iter_10_1 in pairs(self.rewardList) do
			self.rewardList[iter_10_0]:Dispose()
		end
	end

	DormLinkGameActivityItem.super.Dispose(self)
end

return DormLinkGameActivityItem
