_class("UIN25IdolMemoryDetails", UICustomWidget)
UIN25IdolMemoryDetails = UIN25IdolMemoryDetails

function UIN25IdolMemoryDetails:Constructor()
  self._parent = nil
  self._cfg = nil
  self._reddot = nil
end

function UIN25IdolMemoryDetails:OnShow(uiParams)
  self._imgBg = self:GetUIComponent("RawImage", "imgBg")
  self._imgBgLoader = self:GetUIComponent("RawImageLoader", "imgBg")
  self._imgIcon = self:GetUIComponent("RawImage", "imgIcon")
  self._imgIconLoader = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtDescription = self:GetUIComponent("UILocalizationText", "txtDescription")
  self._redDot = self:View():GetUIComponent("UISelectObjectPath", "redDot")
  self._redDotSpawn = nil
end

function UIN25IdolMemoryDetails:OnHide()
end

function UIN25IdolMemoryDetails:BtnOnClick(go)
  self._parent:OnMemoryDetails(self._cfg)
end

function UIN25IdolMemoryDetails:SetRedDot(showRedDot)
  self._redDot.gameObject:SetActive(showRedDot)
  if showRedDot and self._redDotSpawn == nil then
    self._redDotSpawn = self._redDot:SpawnOneObject("ManualLoad0")
  end
end

function UIN25IdolMemoryDetails:ID()
  return self._cfg.ID
end

function UIN25IdolMemoryDetails:SetData(parent, cfg)
  self._parent = parent
  self._cfg = cfg
  self._reddot = parent:GetRedDot()
  local cfgPet = Cfg.cfg_pet[self._cfg.PetId]
  self._txtName:SetText(StringTable.Get(cfgPet.Name))
  self._txtDescription:SetText(StringTable.Get(cfg.Name))
  self._imgIconLoader:LoadImage(cfg.PetHead)
  local unlocked = self._reddot:GetMemoryUnlocked()
  if unlocked[cfg.ID] == nil then
    self._imgBgLoader:LoadImage("n25_ychsj_di11")
  else
    self._imgBgLoader:LoadImage("n25_ychsj_di10")
  end
end
