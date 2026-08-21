_class("UIPetEquipIntrController", UIController)
UIPetEquipIntrController = UIPetEquipIntrController

function UIPetEquipIntrController:Constructor()
end

function UIPetEquipIntrController:OnShow(uiParams)
  self:_GetComponents()
  self._petId = uiParams[1]
  self:_OnValue()
end

function UIPetEquipIntrController:_GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
end

function UIPetEquipIntrController:_OnValue()
  local cfg = Cfg.cfg_pet_equip_view[self._petId]
  if cfg then
    local icon = cfg.Icon
    local name = cfg.Name
    local desc = cfg.Intr
    self._icon:LoadImage(icon)
    self._name:SetText(StringTable.Get(name))
    self._desc:SetText(StringTable.Get(desc))
  else
    Log.error("###[UIPetEquipIntrController]cfg is nil ! id --> ", self._petId)
  end
end

function UIPetEquipIntrController:OnHide()
  self._icon = nil
  self._name = nil
  self._desc = nil
  self._petId = nil
end

function UIPetEquipIntrController:bgOnClick(go)
  self:CloseDialog()
end
