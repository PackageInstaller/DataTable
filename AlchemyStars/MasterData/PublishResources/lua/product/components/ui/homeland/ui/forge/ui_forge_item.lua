_class("UIForgeItem", UICustomWidget)
UIForgeItem = UIForgeItem

function UIForgeItem:OnShow()
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.imgQuality = self:GetUIComponent("Image", "imgQuality")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.forgeable = self:GetGameObject("forgeable")
  self.lock = self:GetGameObject("lock")
  self.red = self:GetGameObject("red")
  self.exp = self:GetGameObject("exp")
  self.forgeCount = self:GetUIComponent("UILocalizationText", "forgeCount")
  self.forgeCountParent = self:GetGameObject("forgeCountParent")
  self.data = self:GetModule(HomelandModule):GetForgeData()
end

function UIForgeItem:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIForgeItem:Flush(id)
  self.id = id
  local item = self.data:GetForgeInfoItemById(id)
  self.imgIcon:LoadImage(item.icon)
  self.txtName:SetText(item.name)
  self.imgQuality.color = UIForgeData.qualityColors[item.quality]
  if item.unlocked then
    self.lock:SetActive(false)
    if self.data:IsForgeable(item) then
      self.forgeable:SetActive(true)
    else
      self.forgeable:SetActive(false)
    end
    self.exp:SetActive(self.data:IsUnforged(id))
  else
    self.exp:SetActive(false)
    self.lock:SetActive(true)
    self.forgeable:SetActive(false)
  end
  self.forgeCount:SetText("×" .. item.forgeCount)
  self.forgeCountParent:SetActive(item.forgeCount > 1)
  self:FlushRed()
end

function UIForgeItem:FlushRed()
  local isShowRed = false
  local item = self.data:GetForgeInfoItemById(self.id)
  if not item.unlocked and item:IsUnlockCostsEnough() then
    isShowRed = true
  end
  self.red:SetActive(isShowRed)
end

function UIForgeItem:bgOnClick(go)
  self:ShowDialog("UIForgeDetail", self.id)
end
