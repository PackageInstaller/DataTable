local NoobMonthlyCardRechargeView = class("NoobMonthlyCardRechargeView", ReduxView)

function NoobMonthlyCardRechargeView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:GetUIName(arg_1_2)), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform
	self.type_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.statusController_ = ControllerUtil.GetController(self.btnPanelTrans_, "status")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
end

function NoobMonthlyCardRechargeView:GetUIName(arg_2_1)
	if arg_2_1 == 0 then
		return "Widget/System/Activitynewbie/NewbieMonthlyCardUI"
	else
		return "Widget/System/Activitynewbie/NewbieMonthlyCardUI_old"
	end
end

function NoobMonthlyCardRechargeView:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	NoobMonthlyCardRechargeView.super.Dispose(self)
end

function NoobMonthlyCardRechargeView:AddListeners()
	self:AddBtnListener(self.sourceBtn_, nil, function()
		JumpTools.JumpToPage2(GameSetting.newbie_first_monthly_card_reward.value[2])
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		ActivityNewbieTools.ReceiveRechargeReward(2, 0, function(arg_7_0)
			self:RefreshStatus()
		end)
	end)
	self:AddBtnListener(self.signRewardBtn_, nil, function()
		ShowPopItem(POP_ITEM, GameSetting.newbie_first_monthly_card_cumulative.value[2])
	end)
end

function NoobMonthlyCardRechargeView:SetData()
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
		end

		self.commonItem_ = CommonItemView.New(self.commonGo_)

		self.commonItem_:SetData(var_9_0)
	end

	self:RefreshStatus()

	if self.typeController_ then
		self.typeController_:SetSelectedIndex(self.type_)
	end

	ActivityNewbieTools.SetSelectMonthlyRecharge()

	self.rewardDesc_.text = GetTips("FIRST_RECHARGE_MONTH_CARD_DESC")
end

function NoobMonthlyCardRechargeView:RefreshStatus()
	local var_11_0 = ActivityNewbieTools.GetFirstMonthlyCardStatus()

	self.status_ = var_11_0.isRecharged == false and 0 or var_11_0.heroRewardFlag == false and 1 or 2

	self.statusController_:SetSelectedIndex(self.status_)
end

function NoobMonthlyCardRechargeView:ReceiveReward()
	ActivityNewbieTools.ReceiveRechargeReward(2, 0, function(arg_13_0)
		self:RefreshStatus()
	end)
end

function NoobMonthlyCardRechargeView:SetActive(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)
end

return NoobMonthlyCardRechargeView
