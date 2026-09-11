local CanteenProDesView = class("CanteenProDesView", ReduxView)

function CanteenProDesView:UIName()
	return "Widget/BackHouseUI/canteen/EmptyDreamFoodDetailsPop"
end

function CanteenProDesView:UIParent()
	return manager.ui.uiPop.transform
end

function CanteenProDesView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function CanteenProDesView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
end

function CanteenProDesView:OnExit()
	return
end

function CanteenProDesView:Dispose()
	CanteenProDesView.super.Dispose(self)
end

return CanteenProDesView
