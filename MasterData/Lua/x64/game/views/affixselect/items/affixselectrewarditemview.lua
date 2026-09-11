local AffixSelectRewardItemView = class("AffixSelectRewardItemView", ReduxView)

function AffixSelectRewardItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AffixSelectRewardItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AffixSelectRewardItemView:InitUI()
	self:BindCfgUI()
	self:InitRewardItem()

	self.stausController_ = self.itemCon_:GetController("status")
end

function AffixSelectRewardItemView:InitRewardItem()
	self.rewardItemList_ = {}

	for iter_4_0 = 1, 3 do
		self.rewardItemList_[iter_4_0] = CommonItemView.New(self["item_" .. iter_4_0])
	end
end

function AffixSelectRewardItemView:AddUIListener()
	self:AddBtnListener(self.btnReceive_, nil, function()
		if self.isFirstReward_ then
			ActivityAffixSelectAction.GetAllFirsrtRewards({
				self.activityId_
			})
		else
			ActivityAction.ReceivePointReward({
				self.rewardId_
			})
		end
	end)
end

function AffixSelectRewardItemView:SetData(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self.index_ = arg_7_1
	self.rewardId_ = arg_7_2

	if arg_7_4 then
		self.cfg_ = ActivityAffixSelectCfg[arg_7_3] or ActivityPointRewardCfg[arg_7_2]
	end

	self.activityId_ = arg_7_3
	self.isFirstReward_ = arg_7_4

	self:UpdateView()
end

function AffixSelectRewardItemView:UpdateView()
	local var_8_0

	if self.isFirstReward_ then
		self.textTask_.text = string.format("[%s]", BattleActivityAffixSelectCfg[self.cfg_.stage_id].name)

		local var_8_1 = ActivityAffixSelectData:GetSubActivityData(self.activityId_)

		var_8_0 = var_8_1 and var_8_1.clearState or 1
	else
		self.textTask_.text = GetTips("CURRENT_TOTAL_SCORE") .. self.cfg_.need
		var_8_0 = ActivityAffixSelectData:GetRewardStatus(self.activityId_, self.rewardId_)
	end

	self:UpdateRewardItem()

	if var_8_0 == 3 then
		self.stausController_:SetSelectedState("rewarded")
	elseif var_8_0 == 1 then
		self.stausController_:SetSelectedState("unfinished")
	else
		self.stausController_:SetSelectedState("complete")
	end
end

function AffixSelectRewardItemView:UpdateRewardItem()
	for iter_9_0 = 1, 3 do
		if self.cfg_.reward_item_list[iter_9_0] then
			local var_9_0 = clone(ItemTemplateData)

			var_9_0.id = self.cfg_.reward_item_list[iter_9_0][1]
			var_9_0.number = self.cfg_.reward_item_list[iter_9_0][2]

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

function AffixSelectRewardItemView:OnEnter()
	return
end

function AffixSelectRewardItemView:OnExit()
	return
end

function AffixSelectRewardItemView:Dispose()
	AffixSelectRewardItemView.super.Dispose(self)

	for iter_13_0, iter_13_1 in pairs(self.rewardItemList_) do
		iter_13_1:Dispose()
	end

	self.rewardItemList_ = nil
end

return AffixSelectRewardItemView
