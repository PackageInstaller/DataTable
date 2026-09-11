local RechargeFirstMonthlyCardPageView = class("RechargeFirstMonthlyCardPageView", (import("game.views.recharge.pages.RechargePageBase")))

function RechargeFirstMonthlyCardPageView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.btnPanelTrans_, "status")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")

	local var_1_0 = ActivityNewbieTools.GetFirstRechargeStatus()
end

function RechargeFirstMonthlyCardPageView:Dispose()
	if self.commonItem_ then
		manager.redPoint:unbindUIandKey(self.commonItem_.transform_, RedPointConst.FIRST_GEAR)
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	RechargeFirstMonthlyCardPageView.super.Dispose(self)
end

function RechargeFirstMonthlyCardPageView:AddUIListener()
	self:AddBtnListener(self.sourceBtn_, nil, function()
		JumpTools.JumpToPage2(GameSetting.newbie_first_monthly_card_reward.value[2])
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		ActivityNewbieTools.ReceiveRechargeReward(2, 0, function(arg_6_0)
			self:RefreshStatus()
		end)
	end)
	self:AddBtnListener(self.signRewardBtn_, nil, function()
		ShowPopItem(POP_ITEM, GameSetting.newbie_first_monthly_card_cumulative.value[2])
	end)
end

function RechargeFirstMonthlyCardPageView:OnEnter()
	self:RefreshUI()
end

function RechargeFirstMonthlyCardPageView:RefreshUI()
	self.rewardCfg_ = GameSetting.newbie_first_monthly_card_reward.value[1]

	if not self.commonItem_ then
		local var_9_0 = clone(ItemTemplateData)

		var_9_0.id = self.rewardCfg_[1]
		var_9_0.number = self.rewardCfg_[2]

		function var_9_0.clickFun(arg_10_0)
			if self.status_ == 1 then
				self:ReceiveReward()
			else
				ShowPopItem(POP_ITEM, self.rewardCfg_)
			end

			saveData("FirstGear", "hasView", true)
			manager.redPoint:setTip(RedPointConst.FIRST_GEAR, 0)
		end

		self.commonItem_ = CommonItemView.New(self.commonGo_)

		self.commonItem_:SetData(var_9_0)
		manager.redPoint:bindUIandKey(self.commonItem_.transform_, RedPointConst.FIRST_GEAR)
	end

	self:RefreshStatus()
	self.typeController_:SetSelectedIndex(1)
	ActivityNewbieTools.SetSelectMonthlyRecharge()

	self.rewardDesc_.text = GetTips("FIRST_RECHARGE_MONTH_CARD_DESC")
end

function RechargeFirstMonthlyCardPageView:Show()
	SetActive(self.gameObject_, true)
	self:RefreshUI()
end

function RechargeFirstMonthlyCardPageView:RefreshStatus()
	local var_12_0 = ActivityNewbieTools.GetFirstMonthlyCardStatus()

	self.status_ = var_12_0.isRecharged == false and 0 or var_12_0.heroRewardFlag == false and 1 or 2

	self.statusController_:SetSelectedIndex(self.status_)
end

function RechargeFirstMonthlyCardPageView:ReceiveReward()
	ActivityNewbieTools.ReceiveRechargeReward(2, 0, function(arg_14_0)
		self:RefreshStatus()
	end)
end

function RechargeFirstMonthlyCardPageView:OnExit()
	saveData("FirstGear", "hasView", true)
	manager.redPoint:setTip(RedPointConst.FIRST_GEAR, 0)
end

return RechargeFirstMonthlyCardPageView
