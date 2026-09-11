local MythicFinalRewardItem = class("MythicFinalRewardItem", ReduxView)

function MythicFinalRewardItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.rewardPanel_ = {}
	self.rewardList_ = {}
	self.controller_ = self.transform_:GetComponent("ControllerExCollection"):GetController("status")
end

function MythicFinalRewardItem:Init(arg_2_1)
	self.index_ = MythicData:GetRealIndex(arg_2_1)
end

function MythicFinalRewardItem:Dispose()
	MythicFinalRewardItem.super.Dispose(self)

	for iter_3_0, iter_3_1 in pairs(self.rewardList_) do
		iter_3_1:Dispose()
	end

	self.rewardList_ = nil
end

function MythicFinalRewardItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if MythicData:GetFinalIsReward() == 0 then
			ShowMessageBox({
				content = GetTips("MYTHIC_REWARD_LOACK_DIFFICULTY"),
				OkCallback = function()
					MythicAction:GetFinalReward(self.index_)
				end
			})
		else
			MythicAction:GetFinalReward(self.index_)
		end
	end)
end

function MythicFinalRewardItem:SetData(arg_7_1)
	self:Init(arg_7_1)
	self:RefreshData()
	self:RefreshUI()
	self:RefreshState()
	self:RefreshItem()
end

function MythicFinalRewardItem:RefreshData()
	self.rewradCfg_ = MythicFinalCfg[self.index_].reward_list

	for iter_8_0 = 1, 4 do
		if not self.rewardList_[iter_8_0] then
			self.rewardPanel_[iter_8_0] = Object.Instantiate(self.rewardItem, self.contentTrs_)
			self.rewardList_[iter_8_0] = CommonItemView.New(self.rewardPanel_[iter_8_0])
		end
	end

	for iter_8_1 = #self.rewradCfg_ + 1, #self.rewardList_ do
		self.rewardList_[iter_8_1]:SetData()
	end
end

function MythicFinalRewardItem:RefreshUI()
	self.descText_.text = string.format(GetTips("MYTHIC_FINAL_REWARD_TIPS"), self.index_)
end

function MythicFinalRewardItem:RefreshState()
	if MythicData:GetPassHotLevel() < self.index_ then
		self.controller_:SetSelectedState("state2")
	elseif MythicData:GetFinalRewardStateByHotLevel(self.index_) then
		self.controller_:SetSelectedState("state3")
	else
		self.controller_:SetSelectedState("state1")
	end
end

function MythicFinalRewardItem:RefreshItem()
	for iter_11_0, iter_11_1 in pairs(self.rewradCfg_) do
		if iter_11_0 > 6 then
			return
		end

		local var_11_0 = rewardToItemTemplate(formatReward(iter_11_1))

		if MythicData:GetFinalRewardStateByHotLevel(self.index_) then
			var_11_0.grayFlag = true
		end

		function var_11_0.clickFun(arg_12_0)
			ShowPopItem(POP_ITEM, arg_12_0)
		end

		CommonTools.SetCommonData(self.rewardList_[iter_11_0], var_11_0)
	end
end

return MythicFinalRewardItem
