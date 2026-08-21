_class("UIPetIntimacyStumbles", UIController)
UIPetIntimacyStumbles = UIPetIntimacyStumbles

function UIPetIntimacyStumbles:Constructor()
end

function UIPetIntimacyStumbles:OnShow(uiParams)
  self._pet = uiParams[1]
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self:Flush()
end

function UIPetIntimacyStumbles:OnHide()
end

function UIPetIntimacyStumbles:Flush()
  local level = self._pet:GetPetAffinityLevel()
  local maxLevel = self._pet:GetPetAffinityMaxLevel()
  local cfg = Cfg.cfg_pet_affinity({
    PetID = self._pet:GetTemplateID()
  })
  if cfg then
    local len = table.count(cfg)
    self._content:SpawnObjects("UIPetIntimacyStumblesItem", len)
    local arr = self._content:GetAllSpawnList()
    for lv, item in ipairs(arr) do
      item:Flush(lv, self._pet)
    end
  end
end

function UIPetIntimacyStumbles:bgOnClick(go)
  self:CloseDialog()
end
