local ActivityNoobBpRechargeView = class("ActivityNoobBpRechargeView", (import("game.views.recharge.pages.RechargePageBase")))

function ActivityNoobBpRechargeView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
	self.rewardItemList_ = {}
	self.itemDataList_ = {}
	self.rewardCfgList_ = {}
end

function ActivityNoobBpRechargeView:Dispose()
	ActivityNoobBpRechargeView.super.Dispose(self)

	for iter_2_0, iter_2_1 in ipairs(self.rewardItemList_) do
		iter_2_1:Dispose()
	end

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ActivityNoobBpRechargeView:AddUIListener()
	self:AddBtnListener(self.sourceBtn_, nil, function()
		if TimeMgr.GetInstance():GetServerTime() < PassportData:GetStartTimestamp() then
			ShowTips("SYSTEM_LOCK")

			return
		end

		if TimeMgr.GetInstance():GetServerTime() >= PassportData:GetEndTimestamp() then
			ShowTips("NO_ACTIVE_BATTLEPASS")

			return
		end

		JumpTools.JumpToPage2(GameSetting.first_battle_pass_reward.value[3])
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		ActivityNewbieTools.ReceiveRechargeReward(3, 0, function(arg_6_0)
			self:RefreshStatus()
		end)
	end)
end

function ActivityNoobBpRechargeView:OnEnter()
	self:RefreshUI()
end

function ActivityNoobBpRechargeView:RefreshUI()
	self.rewardCfgList_ = {}

	for iter_8_0 = 1, #GameSetting.first_battle_pass_reward.value - 1 do
		self.rewardCfgList_[#self.rewardCfgList_ + 1] = GameSetting.first_battle_pass_reward.value[iter_8_0]
	end

	for iter_8_1, iter_8_2 in ipairs(self.rewardCfgList_) do
		if not self.rewardItemList_[iter_8_1] then
			self.rewardItemList_[iter_8_1] = CommonItemView.New(self.rewardPanelTrans_:GetChild(iter_8_1 - 1).gameObject, true)
			self.itemDataList_[iter_8_1] = clone(ItemTemplateData)
			self.itemDataList_[iter_8_1].clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		self.itemDataList_[iter_8_1].id = iter_8_2[1]
		self.itemDataList_[iter_8_1].number = iter_8_2[2]

		self.rewardItemList_[iter_8_1]:Show(true)
		self.rewardItemList_[iter_8_1]:SetData(self.itemDataList_[iter_8_1])
	end

	self:RefreshStatus()
	self.typeController_:SetSelectedIndex(1)
	ActivityNewbieTools.SetSelectBpRecharge()
end

function ActivityNoobBpRechargeView:Show()
	SetActive(self.gameObject_, true)
	self:RefreshUI()
end

function ActivityNoobBpRechargeView:RefreshStatus()
	self.status_ = ActivityNewbieTools.GetBpRewardStatus()

	self.statusController_:SetSelectedIndex(self.status_)
end

return ActivityNoobBpRechargeView
