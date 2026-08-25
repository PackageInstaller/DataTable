local CompAwakerPotencyItem, Super = NewViewComponent("CompAwakerPotencyItem")

function CompAwakerPotencyItem:ctor(uiNode, view, viewData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Item_PotencyResource(uiNode)
  self._awakerTid = viewData.awakerTid
  self._potencyTid = viewData.potency
  self._potencyLevel = viewData.potencyLevel
  if not self._potencyLevel then
    self._potencyLevel = AwakerDataUtils.GetAwakerPotencyIndex(self._awakerTid, self._potencyTid)
  end
end

function CompAwakerPotencyItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_RefreshText()
  self:_RefreshVisible()
end

function CompAwakerPotencyItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function CompAwakerPotencyItem:_RefreshText()
  local attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(self._awakerTid)
  self:SetText(self.ui.Text_Potency, self._potencyLevel - attrPotencyStartIndex + 1)
end

function CompAwakerPotencyItem:_RefreshVisible()
  local attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(self._awakerTid)
  local maxPassivePotencyNum = AwakerDataUtils.GetAwakerPassivePotencyMaxNum(self._awakerTid)
  for i = 1, maxPassivePotencyNum do
    local obj = self.ui["Image_Potency_" .. i]
    if obj then
      self:SetActive(obj, i <= self._potencyLevel)
    end
  end
  self:SetActive(self.ui.Potency_4, attrPotencyStartIndex <= self._potencyLevel)
  local maxPotencyIndex = AwakerDataUtils.GetMaxPotencyIndex(self._awakerTid)
  local maxPotencyTid = AwakerPotencyCfgUtils.GetAwakerMaxPotencyTid(self._awakerTid)
  self.ui.Image_Max:SetActive(maxPotencyIndex <= self._potencyLevel and maxPotencyTid)
  self.ui.Text_Potency:SetActive(maxPotencyIndex > self._potencyLevel or not maxPotencyTid)
end

return CompAwakerPotencyItem
