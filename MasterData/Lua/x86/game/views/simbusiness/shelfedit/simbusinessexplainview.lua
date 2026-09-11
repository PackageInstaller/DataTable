local SimBusinessExplainView = class("SimBusinessExplainView", ReduxView)

function SimBusinessExplainView:GetTabToggleCtrl(arg_1_1)
	return self[string.format("tabltem%02dTgl_", arg_1_1)]
end

function SimBusinessExplainView:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SimBusinessDetailsPopUI"
end

function SimBusinessExplainView:OnCtor()
	return
end

function SimBusinessExplainView:UIParent()
	return manager.ui.uiMain.transform
end

function SimBusinessExplainView:Init()
	self:InitUI()
	self:AddUIListener()

	self.pageList = {
		SimBusinessShelfInfoView.New(self.shelfcontentGo_),
		SimBusinessGoodsInfoView.New(self.goodscontentGo_),
		(SimBusinessClientInfoView.New(self.guestcontentGo_))
	}
	self.pageController = self.controllerCom:GetController("category")
end

function SimBusinessExplainView:InitUI()
	self:BindCfgUI()
end

function SimBusinessExplainView:OnEnter()
	self.index = self.params_.pageIndex or self.index or 1
	self:GetTabToggleCtrl(self.index).isOn = true

	self:SwitchPage(self.index, true)
	self:BindRedPoint()
end

function SimBusinessExplainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self:GetTabToggleCtrl(1).transform, RedPointConst.ACTIVITY_SIM_BUSINESS_SHELF_LEVEL_UP)
	manager.redPoint:bindUIandKey(self:GetTabToggleCtrl(2).transform, RedPointConst.ACTIVITY_SIM_BUSINESS_UNLOCK_GOOD)
end

function SimBusinessExplainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self:GetTabToggleCtrl(1).transform, RedPointConst.ACTIVITY_SIM_BUSINESS_SHELF_LEVEL_UP)
	manager.redPoint:unbindUIandKey(self:GetTabToggleCtrl(2).transform, RedPointConst.ACTIVITY_SIM_BUSINESS_UNLOCK_GOOD)
end

function SimBusinessExplainView:RegisterEvents()
	return
end

function SimBusinessExplainView:AddUIListener()
	for iter_11_0 = 1, 3 do
		self:AddToggleListener(self:GetTabToggleCtrl(iter_11_0), function(arg_12_0)
			self:SwitchPage(iter_11_0, false)
		end)
	end

	self:AddBtnListener(self.backBtn, nil, function()
		self:Back()
	end)
end

function SimBusinessExplainView:SwitchPage(arg_14_1, arg_14_2)
	if arg_14_1 == self.index and not arg_14_2 then
		return
	end

	if self.index then
		self.pageList[self.index]:OnExit()
	end

	self.index = arg_14_1

	self.pageController:SetSelectedIndex(arg_14_1 - 1)
	self.pageList[self.index]:OnEnter()
end

function SimBusinessExplainView:OnEventRefreshView()
	if self.pageList and self.index then
		self.pageList[self.index]:OnEventRefreshView()
	end
end

function SimBusinessExplainView:OnExit()
	self:UnbindRedPoint()
end

function SimBusinessExplainView:Dispose()
	for iter_17_0, iter_17_1 in pairs(self.pageList) do
		iter_17_1:Dispose()
	end

	SimBusinessExplainView.super.Dispose(self)
end

function SimBusinessExplainView:OnTop()
	SimBusinessTools.SwitchBarWithFund({
		BACK_BAR
	}, true)
end

function SimBusinessExplainView:OnBehind()
	manager.windowBar:HideBar()
end

return SimBusinessExplainView
