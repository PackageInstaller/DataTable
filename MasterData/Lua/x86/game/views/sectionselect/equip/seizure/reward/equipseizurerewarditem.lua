local EquipSeizureRewardItem = class("EquipSeizureRewardItem", ReduxView)

function EquipSeizureRewardItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.rewardItemList_ = {}
	self.controller_ = self.controlExCo_:GetController("status")
end

function EquipSeizureRewardItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		self:ClickItem()
	end)
end

function EquipSeizureRewardItem:ClickItem()
	EquipSeizureAction.SendReceiveReward({
		self.rewardID_
	}, function(arg_5_0)
		if isSuccess(arg_5_0.result) then
			manager.notify:Invoke(EQUIP_SEIZURE_REWARD)
		end
	end)
end

function EquipSeizureRewardItem:Dispose()
	EquipSeizureRewardItem.super.Dispose(self)

	for iter_6_0, iter_6_1 in ipairs(self.rewardItemList_) do
		iter_6_1:Dispose()
	end

	self.rewardItemList_ = nil
end

function EquipSeizureRewardItem:SetData(arg_7_1)
	self.rewardList_ = EquipSeizurePointRewardCfg[arg_7_1].reward_item_list
	self.descText_.text = string.format(GetTips("EQUIP_SEIZURE_POINT_REWARD_DESC"), EquipSeizurePointRewardCfg[arg_7_1].need)
	self.rewardID_ = arg_7_1

	self:RefreshBtn()
	self:RefreshRewardItem()
end

function EquipSeizureRewardItem:RefreshRewardItem()
	for iter_8_0, iter_8_1 in ipairs(self.rewardList_) do
		local var_8_0 = clone(ItemTemplateData)

		var_8_0.id = iter_8_1[1]
		var_8_0.number = iter_8_1[2]

		function var_8_0:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		if self.rewardItemList_[iter_8_0] then
			self.rewardItemList_[iter_8_0]:SetData(var_8_0)
		else
			self.rewardItemList_[iter_8_0] = CommonItemPool.New(self.rewardParent_, var_8_0)
		end
	end

	for iter_8_2 = #self.rewardList_ + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_8_2]:Show(false)
	end
end

function EquipSeizureRewardItem:RefreshBtn()
	if table.keyof(EquipSeizureData:GetReceiveList(), self.rewardID_) then
		self.controller_:SetSelectedState("haveGet")
	elseif table.keyof(EquipSeizureData:GetCanReceiveList(), self.rewardID_) then
		self.controller_:SetSelectedState("canGet")
	else
		self.controller_:SetSelectedState("cannotGet")
	end
end

return EquipSeizureRewardItem
