local PopCostItemView = class("PopCostItemView", ReduxView)

function PopCostItemView:UIName()
	return "Widget/Common/Pop/PopupCostConfirmationUI"
end

function PopCostItemView:UIParent()
	return manager.ui.uiPop.transform
end

function PopCostItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PopCostItemView:InitUI()
	self:BindCfgUI()

	self.tipsController_ = self.controllerEx_:GetController("tips")
end

function PopCostItemView:AddUIListener()
	self:AddBtnListener(self.m_cancelBtn, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.m_maskBtn, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.m_okBtn, nil, function()
		self:Back()

		if self.params_.ToggleCallback then
			self.params_.ToggleCallback(self.tipsFlag_)
		end

		if self.params_.popCostCallBack then
			self.params_.popCostCallBack()
		end
	end)
	self:AddBtnListener(self.m_tipsBtn_, nil, function()
		self.tipsFlag_ = not self.tipsFlag_

		self.tipsController_:SetSelectedState(tostring(self.tipsFlag_))
	end)
end

function PopCostItemView:OnEnter()
	self.m_costCountText.text = self.params_.content

	SetActive(self.m_tips, self.params_.ToggleCallback ~= nil)

	self.tipsTxt_.text = self.params_.ToggleText or GetTips("LOGIN_MUTE_TIP")
	self.tipsFlag_ = false

	self.tipsController_:SetSelectedState(tostring(self.tipsFlag_))
end

function PopCostItemView:OnTop()
	self.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	self.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	self.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()

	local var_11_0 = self.params_.costId or 0

	manager.windowBar:SwitchBar({
		var_11_0
	})
	manager.windowBar:SetBarCanAdd(var_11_0, self:IsItemCanAdd(var_11_0))
	manager.windowBar:SetBarCanClick(var_11_0, true)
	manager.windowBar:SetAsLastSibling()
end

function PopCostItemView:OnExit()
	if self.lastBarList_ then
		manager.windowBar:SwitchBar(self.lastBarList_)
	end

	if self.lastAddBarList_ then
		for iter_12_0, iter_12_1 in ipairs(self.lastAddBarList_) do
			manager.windowBar:SetBarCanAdd(iter_12_1, true)
		end
	end

	if self.lastCanClickBarList_ then
		for iter_12_2, iter_12_3 in ipairs(self.lastCanClickBarList_) do
			manager.windowBar:SetBarCanClick(iter_12_3, true)
		end
	end
end

function PopCostItemView:IsItemCanAdd(arg_13_1)
	if arg_13_1 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
		return true
	end

	return false
end

return PopCostItemView
