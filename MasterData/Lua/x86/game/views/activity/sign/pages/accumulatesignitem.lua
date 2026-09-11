local AccumulateSignItem = class("AccumulateSignItem", ReduxView)

function AccumulateSignItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AccumulateSignItem:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.statusController_ = self.mainControllerEx_:GetController("status")
	self.itemController_ = self.mainControllerEx_:GetController("quantity")
	self.commonItem1_ = CommonItemView.New(self.commonItemGo_1)
	self.commonItem2_ = CommonItemView.New(self.commonItemGo_2)
end

function AccumulateSignItem:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		if self.state_ == 0 then
			self.onclick_(self.accumulateID_)
		end
	end)
end

function AccumulateSignItem:SetData(arg_5_1, arg_5_2)
	self.accumulateID_ = arg_5_1
	self.onclick_ = arg_5_2
	self.cfg_ = AccumulateLoginCfg[self.accumulateID_]
	self.rewards_ = self.cfg_.reward
	self.state_ = AccumulateSignData:GetRewardState(self.accumulateID_)

	self:UpdateView()
end

function AccumulateSignItem:UpdateView()
	if #self.rewards_ == 1 then
		self.itemController_:SetSelectedIndex(0)
		self.commonItem1_:SetData({
			id = self.rewards_[1][1],
			number = self.rewards_[1][2],
			clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id
				})
			end
		})
	else
		self.itemController_:SetSelectedIndex(1)
		self.commonItem1_:SetData({
			id = self.rewards_[1][1],
			number = self.rewards_[1][2],
			clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id
				})
			end
		})
		self.commonItem2_:SetData({
			id = self.rewards_[2][1],
			number = self.rewards_[2][2],
			clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id
				})
			end
		})
	end

	self.statusController_:SetSelectedIndex(self.state_)

	self.mainText_.text = string.format(GetTips("CUMULATIVE_LOGIN_TARGET"), self.cfg_.num)
	self.sliderImg_.fillAmount = AccumulateSignData:GetProgress(self.accumulateID_)
end

function AccumulateSignItem:OnExit()
	return
end

function AccumulateSignItem:Dispose()
	self:RemoveAllListeners()

	if self.commonItem1_ then
		self.commonItem1_:Dispose()

		self.commonItem1_ = nil
	end

	if self.commonItem2_ then
		self.commonItem2_:Dispose()

		self.commonItem2_ = nil
	end

	self.super.Dispose(self)
end

return AccumulateSignItem
