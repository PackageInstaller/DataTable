local CopyLinkageActivityView, Super = NewClass("CopyLinkageActivityView", CopySpecialBranchView)
CopyLinkageActivityView.uiResCls = UI_Chapter_Special_ViewResource

function CopyLinkageActivityView:SetItemComp()
  self.itemComp = CopyLinkageBranchItem
end

function CopyLinkageActivityView:PlayEnterAnim(callback)
  self:HideListComp()
  self:_PlayUIAnim("UI_Chapter_Special_View_Open", callback)
  self:PlayListAnim()
end

function CopyLinkageActivityView:PlayLoopingAnim(callback)
  self:_PlayUIAnim("UI_Chapter_Special_View_Loop", callback, true)
end

function CopyLinkageActivityView:SetCloseAnim()
  self.closeAnim = "UI_Chapter_Special_View_Close"
end

function CopyLinkageActivityView:InitCurrencyGroup()
  self:BindCurrency(self.ui.Guoup_SmallBranch, DT.Constant.LinkageActivityCurrencies.Data)
end

return CopyLinkageActivityView
