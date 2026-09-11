local RegressionNewGiftView = class("RegressionNewGiftView", ReduxView)

function RegressionNewGiftView:UIName()
	return "Widget/System/ReturnTwo/RT2stGift2UI"
end

function RegressionNewGiftView:UIParent()
	return manager.ui.uiPop.transform
end

function RegressionNewGiftView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionNewGiftView:InitUI()
	self:BindCfgUI()

	self.receivedController = ControllerUtil.GetController(self.transform_, "received")
	self.rewardItems_ = {}
end

function RegressionNewGiftView:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		RegressionAction.QueryRegressionGift()
	end)
	self:AddBtnListener(self.m_maskBtn, nil, function()
		if RegressionData:GetRegressionGiftReceive() then
			self:Back()
		end
	end)
end

function RegressionNewGiftView:OnEnter()
	local var_8_0 = RegressionData:GetRegressionVersion()

	if RegressionCfg[var_8_0] then
		self.gifts = RegressionCfg[var_8_0].gift or {}
	end

	self:Refresh()
end

function RegressionNewGiftView:Refresh()
	self.receivedController:SetSelectedIndex(RegressionData:GetRegressionGiftReceive() and 1 or 0)
	self:RefreshReward()
	self:RefreshTime()
end

function RegressionNewGiftView:RefreshReward()
	for iter_10_0, iter_10_1 in ipairs(self.gifts) do
		local var_10_0 = clone(ItemTemplateData)

		var_10_0.id = iter_10_1[1]
		var_10_0.number = iter_10_1[2]

		function var_10_0:clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				self.id,
				self.number
			})
		end

		if self.rewardItems_[iter_10_0] == nil then
			self.rewardItems_[iter_10_0] = CommonItemPool.New(self.rewardParent_, var_10_0, true)
		else
			self.rewardItems_[iter_10_0]:SetData(var_10_0)
		end

		self.rewardItems_[iter_10_0]:Show(true)
	end

	for iter_10_2 = #self.gifts + 1, #self.rewardItems_ do
		self.rewardItems_[iter_10_2]:Show(false)
	end
end

function RegressionNewGiftView:OnExit()
	manager.windowBar:HideBar()
end

function RegressionNewGiftView:Dispose()
	for iter_13_0, iter_13_1 in pairs(self.rewardItems_) do
		iter_13_1:Dispose()
	end

	self.rewardItems_ = nil

	RegressionNewGiftView.super.Dispose(self)
end

function RegressionNewGiftView:OnRegressionGiftReward()
	self:Refresh()
end

function RegressionNewGiftView:RefreshTime()
	local var_15_0 = RegressionData:GetLastOfflineTime()

	self.descText_.text = string.format(GetTips("REGRESSION_GIFT_DESCRIPE"), manager.time:STimeDescS(var_15_0, "!%Y/%m/%d"), (manager.time:DiffDay2(var_15_0, (RegressionData:GetRegressionLoginTime()))))
end

return RegressionNewGiftView
