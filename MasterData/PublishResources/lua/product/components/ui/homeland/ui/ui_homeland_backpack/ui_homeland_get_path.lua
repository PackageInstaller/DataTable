_class("UIHomelandGetPath", UIController)
UIHomelandGetPath = UIHomelandGetPath

function UIHomelandGetPath:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetHomelandBackpackData()
  self.mItem = GameGlobal.GetModule(ItemModule)
end

function UIHomelandGetPath:OnShow(uiParams)
  self.tplId = uiParams[1]
  self.content = self:GetGameObject("content")
  self.empty = self:GetGameObject("empty")
  self.Content = self:GetUIComponent("UISelectObjectPath", "Content")
  local cfg = Cfg.cfg_item[self.tplId]
  if cfg == nil then
    Log.fatal("[item] error --> cfg_item is nil ! id --> " .. self.tplId)
    return
  end
  self:AttachEvent(GameEventType.CloseUIBackPackBox, self.Flush)
  self:Flush()
end

function UIHomelandGetPath:OnHide()
  self:DetachEvent(GameEventType.CloseUIBackPackBox, self.Flush)
end

function UIHomelandGetPath:Flush()
  self.itemGetWays = self.data:GetHomelandPathItemDataListByTplId(self.tplId)
  local len = table.count(self.itemGetWays)
  if 0 < len then
    self.empty:SetActive(false)
    self.content:SetActive(true)
    self.Content:SpawnObjects("UIHomelandGetPathItem", len)
    local uis = self.Content:GetAllSpawnList()
    for index, ui in ipairs(uis) do
      local way = self.itemGetWays[index]
      ui:Flush(way, self.tplId)
    end
  else
    self.empty:SetActive(true)
    self.content:SetActive(false)
  end
end

function UIHomelandGetPath:bgOnClick(go)
  self:CloseDialog()
end
