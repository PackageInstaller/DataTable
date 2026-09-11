local ActivityNewbieRebateIllustrateView = class("ActivityNewbieRebateIllustrateView", ReduxView)

function ActivityNewbieRebateIllustrateView:UIName()
	return "Widget/System/Activitynewbie/NewbieRechargeIllustrateUI"
end

function ActivityNewbieRebateIllustrateView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityNewbieRebateIllustrateView:OnEnter()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_7)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_6)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_5)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_4)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_1)
end

function ActivityNewbieRebateIllustrateView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityNewbieRebateIllustrateView:InitUI()
	self:BindCfgUI()
end

function ActivityNewbieRebateIllustrateView:AddUIListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:Back()
	end)
end

function ActivityNewbieRebateIllustrateView:Dispose()
	ActivityNewbieRebateIllustrateView.super.Dispose(self)
end

return ActivityNewbieRebateIllustrateView
