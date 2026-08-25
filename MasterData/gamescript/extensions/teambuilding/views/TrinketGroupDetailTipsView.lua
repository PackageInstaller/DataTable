local TrinketGroupDetailTipsView, Super = NewClass("TrinketGroupDetailTipsView", BaseView)
TrinketGroupDetailTipsView.uiResCls = UI_Team_Item_Secret_PropsResource

function TrinketGroupDetailTipsView:ctor(showTrinketDataMap, boundTrinkets)
  Super.ctor(self)
  self.showTrinketDataMap = showTrinketDataMap
  self.boundTrinkets = boundTrinkets
end

function TrinketGroupDetailTipsView:RegisterNotifications()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function TrinketGroupDetailTipsView:RegisterEvents()
end

function TrinketGroupDetailTipsView:OnEnterView()
  Super.OnEnterView(self)
  local compTrinketGroupDetailData = {
    showTrinketDataMap = self.showTrinketDataMap,
    boundTrinkets = self.boundTrinkets
  }
  self:AddViewComponentOnce(self.ui.UI_Team_Item_Trinket_Detail, CompTrinketGroupDetail, compTrinketGroupDetailData)
end

function TrinketGroupDetailTipsView:RefreshOnRendered()
end

function TrinketGroupDetailTipsView:OnEnterViewFinished()
end

function TrinketGroupDetailTipsView:OnExitView()
  Super.OnExitView(self)
end

return TrinketGroupDetailTipsView
