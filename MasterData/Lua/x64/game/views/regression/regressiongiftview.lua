local RegressionGiftView = class("RegressionGiftView", ReduxView)

function RegressionGiftView:UIName()
	return "UI/ReturnUI/RegressionGiftUI"
end

function RegressionGiftView:UIParent()
	return manager.ui.uiPop.transform
end

function RegressionGiftView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionGiftView:InitUI()
	self:BindCfgUI()

	self.receivedController = ControllerUtil.GetController(self.transform_, "received")
	self.rewardList = LuaList.New(handler(self, self.IndexItem), self.m_list, CommonItem)
end

function RegressionGiftView:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		RegressionAction.QueryRegressionGift()
	end)
	self:AddBtnListener(self.m_maskBtn, nil, function()
		if RegressionData:GetRegressionGiftReceive() then
			self:Back()
		end
	end)
end

function RegressionGiftView:OnEnter()
	local var_8_0 = RegressionData:GetRegressionVersion()

	if RegressionCfg[var_8_0] then
		self.gifts = RegressionCfg[var_8_0].gift or {}
	end

	self.rewardList:StartScroll(#self.gifts)
	self:Refresh()
end

function RegressionGiftView:Refresh()
	self.receivedController:SetSelectedIndex(RegressionData:GetRegressionGiftReceive() and 1 or 0)
end

function RegressionGiftView:OnExit()
	manager.windowBar:HideBar()
end

function RegressionGiftView:IndexItem(arg_11_1, arg_11_2)
	local var_11_0 = self.gifts[arg_11_1]

	arg_11_2:RefreshData(formatReward(self.gifts[arg_11_1]))
	arg_11_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_11_0)
	end)
end

function RegressionGiftView:Dispose()
	self.rewardList:Dispose()
	RegressionGiftView.super.Dispose(self)
end

function RegressionGiftView:OnRegressionGiftReward()
	self:Refresh()
end

return RegressionGiftView
