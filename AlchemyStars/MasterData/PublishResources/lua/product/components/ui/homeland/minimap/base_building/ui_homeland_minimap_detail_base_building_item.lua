_class("UIHomelandMinimapDetailBaseBuildingItem", UICustomWidget)
UIHomelandMinimapDetailBaseBuildingItem = UIHomelandMinimapDetailBaseBuildingItem

function UIHomelandMinimapDetailBaseBuildingItem:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetForgeData()
end

function UIHomelandMinimapDetailBaseBuildingItem:OnShow()
  self.unlock = self:GetGameObject("unlock")
  self.forging = self:GetGameObject("forging")
  self.getable = self:GetGameObject("getable")
  self.lock = self:GetGameObject("lock")
  self.idle = self:GetGameObject("idle")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCD = self:GetUIComponent("UILocalizationText", "txtCD")
end

function UIHomelandMinimapDetailBaseBuildingItem:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIHomelandMinimapDetailBaseBuildingItem:Flush(index)
  self.index = index
  local s = self.data:GetForgeSequenceByIndex(index)
  if s.state == ForgeSequenceState.Locked then
    self.unlock:SetActive(false)
    self.lock:SetActive(true)
    self.idle:SetActive(false)
  elseif s.state == ForgeSequenceState.Idle then
    self.unlock:SetActive(false)
    self.lock:SetActive(false)
    self.idle:SetActive(true)
  else
    self.unlock:SetActive(true)
    self.lock:SetActive(false)
    self.idle:SetActive(false)
    local item = self.data:GetForgeInfoItemById(s.forgeItemId)
    self.imgIcon:LoadImage(item.icon)
    if s.state == ForgeSequenceState.Forging then
      self.forging:SetActive(true)
      self.getable:SetActive(false)
      UIForge.FlushCDText(self.txtCD, s.doneTimestamp, self.data.strsWillGetable, true)
    elseif s.state == ForgeSequenceState.Getable then
      self.forging:SetActive(false)
      self.getable:SetActive(true)
    else
      Log.fatal("### invalid state. state=", s.state)
    end
  end
end

function UIHomelandMinimapDetailBaseBuildingItem:bgOnClick(go)
  local s = self.data:GetForgeSequenceByIndex(self.index)
  local item = self.data:GetForgeInfoItemById(s.forgeItemId)
  if item then
    self:ShowDialog("UIItemTipsHomeland", item.id, go)
  end
end
