_class("UIActivityNPlusSixEventPanel", UICustomWidget)
UIActivityNPlusSixEventPanel = UIActivityNPlusSixEventPanel

function UIActivityNPlusSixEventPanel:OnShow()
  self._go = self:GetGameObject("Go")
  self._eventItemLoader = self:GetUIComponent("UISelectObjectPath", "Content")
end

function UIActivityNPlusSixEventPanel:OnHide()
end

function UIActivityNPlusSixEventPanel:Init()
  self:HidePanel()
end

function UIActivityNPlusSixEventPanel:HidePanel()
  self._go:SetActive(false)
end

function UIActivityNPlusSixEventPanel:ShowPanel(eventDatas)
  self._eventDatas = eventDatas
  self._go:SetActive(true)
  self._eventItemLoader:SpawnObjects("UIActivityNPlusSixEventInfoItem", #self._eventDatas)
  local items = self._eventItemLoader:GetAllSpawnList()
  for i = 1, #items do
    local item = items[i]
    item:Refresh(self._eventDatas[i])
  end
end

function UIActivityNPlusSixEventPanel:MaskOnClick()
  self:HidePanel()
end
