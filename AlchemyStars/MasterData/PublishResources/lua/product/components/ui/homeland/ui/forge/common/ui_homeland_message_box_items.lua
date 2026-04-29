_class("UIHomelandMessageBox_Items", UIController)
UIHomelandMessageBox_Items = UIHomelandMessageBox_Items

function UIHomelandMessageBox_Items:Constructor()
end

function UIHomelandMessageBox_Items:OnShow(uiParams)
  self.txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.poolItems = self:GetUIComponent("UISelectObjectPath", "items")
  self.strTitle = uiParams[1]
  self.strDesc = uiParams[2]
  self.items = uiParams[3]
  self.funcConfirm = uiParams[4]
  self:Flush()
end

function UIHomelandMessageBox_Items:OnHide()
end

function UIHomelandMessageBox_Items:Flush()
  self.txtTitle:SetText(self.strTitle)
  self.txtDesc:SetText(self.strDesc)
  local len = table.count(self.items)
  self.poolItems:SpawnObjects("UIItemHomeland", len)
  local uis = self.poolItems:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    ui:Flush(self.items[i], nil)
  end
end

function UIHomelandMessageBox_Items:btnCloseOnClick(go)
  self:CloseDialog()
end

function UIHomelandMessageBox_Items:btnConfirmOnClick(go)
  if self.funcConfirm then
    self.funcConfirm()
  end
  self:CloseDialog()
end
