local CompAwakerPotencyItem, Super = NewViewComponent("CompAwakerPotencyItem")

function CompAwakerPotencyItem:ctor(uiNode, view, viewData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Item_PotencyResource(uiNode)
  self.awakerTid = viewData.awakerTid
  self.potencyTid = viewData.potency
  self.potencyLevel = viewData.potencyLevel
  if not self.potencyLevel then
    self.potencyLevel = AwakerDataUtils.GetAwakerPotencyIndex(self.awakerTid, self.potencyTid)
  end
end

function CompAwakerPotencyItem:OnEnterComponent()
  self:_RefreshView()
end

function CompAwakerPotencyItem:_RefreshView()
  local attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(self.awakerTid)
  local maxPassivePotencyNum = AwakerDataUtils.GetAwakerPassivePotencyMaxNum(self.awakerTid)
  for i = 1, maxPassivePotencyNum do
    local obj = self.ui["Image_Potency_" .. i]
    if obj then
      self:SetActive(obj, i <= self.potencyLevel)
    end
  end
  self:SetActive(self.ui.Potency_4, attrPotencyStartIndex <= self.potencyLevel)
  local maxPotencyIndex = AwakerDataUtils.GetMaxPotencyIndex(self.awakerTid)
  local maxPotencyTid = AwakerPotencyCfgUtils.GetAwakerMaxPotencyTid(self.awakerTid)
  self:SetActive(self.ui.Image_Max, maxPotencyIndex <= self.potencyLevel and maxPotencyTid)
  self:SetActive(self.ui.Text_Potency, maxPotencyIndex > self.potencyLevel or not maxPotencyTid)
  self:SetText(self.ui.Text_Potency, self.potencyLevel - attrPotencyStartIndex + 1)
end

return CompAwakerPotencyItem
